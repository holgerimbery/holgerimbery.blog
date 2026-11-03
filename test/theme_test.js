const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const { test } = require('node:test');

const root = path.join(__dirname, '..', 'holgerimbery');
const head = fs.readFileSync(path.join(root, '_includes', 'head.html'), 'utf8');
const common = fs.readFileSync(path.join(root, 'js', 'common.js'), 'utf8');
const initialization = head.match(/<script>\s*(const colorScheme[\s\S]*?)\s*<\/script>/)[1];
const switcher = common.slice(common.indexOf('  // Theme Switcher'), common.indexOf('  /* ===', common.indexOf('  // Theme Switcher')));

function visit({ saved, dark = false, query = '', scheme = 'auto', blocked = false } = {}) {
  const classes = new Set();
  const attributes = new Set();
  const storage = new Map(saved === undefined ? [] : [['theme', saved]]);
  const warnings = [];
  let click;
  const html = {
    classList: {
      add: name => classes.add(name),
      remove: name => classes.delete(name),
      contains: name => classes.has(name),
    },
    setAttribute: name => attributes.add(name),
    removeAttribute: name => attributes.delete(name),
  };
  const context = vm.createContext({
    URLSearchParams,
    document: { documentElement: html },
    window: {
      location: { search: query },
      matchMedia: () => ({ matches: dark }),
      localStorage: {
        getItem(name) {
          if (blocked) throw new Error('Storage blocked');
          return storage.get(name) ?? null;
        },
        setItem(name, value) {
          if (blocked) throw new Error('Storage blocked');
          storage.set(name, value);
        },
      },
    },
    console: { warn: (...args) => warnings.push(args) },
    html,
    toggleTheme: { addEventListener: (event, handler) => { click = handler; } },
    requestAnimationFrame: callback => callback(),
  });
  vm.runInContext(initialization.replace('{{ site.data.settings.color_scheme }}', scheme), context);
  vm.runInContext(switcher, context);
  return { classes, attributes, storage, warnings, click };
}

test('auto uses saved valid choices before browser preference', () => {
  for (const dark of [false, true]) {
    for (const saved of [undefined, 'invalid', 'light', 'dark']) {
      const page = visit({ saved, dark });
      const expected = saved === 'light' ? false : saved === 'dark' ? true : dark;
      assert.equal(page.classes.has('dark-mode'), expected);
      assert.equal(page.attributes.has('dark'), expected);
      assert.equal(page.storage.get('theme'), saved);
    }
  }
});

test('manual toggles persist both light and dark across page loads', () => {
  const page = visit({ dark: true });
  for (const theme of ['light', 'dark', 'light']) {
    page.click();
    assert.equal(page.storage.get('theme'), theme);
    const reloaded = visit({ saved: page.storage.get('theme'), dark: theme === 'light' });
    assert.equal(reloaded.classes.has('dark-mode'), theme === 'dark');
    assert.equal(reloaded.attributes.has('dark'), theme === 'dark');
  }
});

test('URL overrides are temporary until a manual toggle saves a choice', () => {
  for (const requested of ['light', 'dark']) {
    const saved = requested === 'light' ? 'dark' : 'light';
    const page = visit({ saved, query: `?scoutTheme=${requested}` });
    assert.equal(page.classes.has('dark-mode'), requested === 'dark');
    assert.equal(page.storage.get('theme'), saved);
    page.click();
    assert.equal(page.storage.get('theme'), saved);
    page.click();
    assert.equal(page.storage.get('theme'), requested);
  }
  assert.equal(visit({ saved: 'dark', query: '?scoutTheme=invalid' }).classes.has('dark-mode'), true);
});

test('fixed site schemes are preserved', () => {
  assert.equal(visit({ saved: 'dark', scheme: 'light' }).classes.has('dark-mode'), false);
  assert.equal(visit({ saved: 'light', scheme: 'dark' }).classes.has('dark-mode'), true);
});

test('unavailable storage is reported without breaking detection or toggling', () => {
  const page = visit({ blocked: true, dark: true });
  assert.equal(page.classes.has('dark-mode'), true);
  assert.equal(page.warnings.length, 1);
  page.click();
  assert.equal(page.classes.has('dark-mode'), false);
  assert.equal(page.attributes.has('dark'), false);
  assert.equal(page.warnings.length, 2);
});
