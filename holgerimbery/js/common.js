document.addEventListener("DOMContentLoaded", function() {
  'use strict';

  const html = document.querySelector('html'),
    globalWrap = document.querySelector('.global-wrap'),
    body = document.querySelector('body'),
    menuToggle = document.querySelector(".hamburger"),
    menuList = document.querySelector(".main-nav"),
    searchOpenButton = document.querySelectorAll(".search-button, .hero__search"),
    searchCloseIcon = document.querySelector(".search__close"),
    searchOverlay = document.querySelector(".search__overlay"),
    searchInput = document.querySelector(".search__text"),
    search = document.querySelector(".search"),
    toggleTheme = document.querySelector(".toggle-theme"),
    btnScrollToTop = document.querySelector(".top");


  /* =======================================================
  // Menu + Search + Theme Switcher (INP Optimized)
  ======================================================= */
  let menuPending = false;
  let searchPending = false;

  menuToggle.addEventListener("click", () => {
    if (!menuPending) {
      menuPending = true;
      requestAnimationFrame(() => {
        menu();
        menuPending = false;
      });
    }
  });

  searchOpenButton.forEach(button => {
    button.addEventListener("click", searchOpen);
  });

  searchCloseIcon.addEventListener("click", searchClose);
  searchOverlay.addEventListener("click", searchClose);


  // Menu with batched DOM updates
  function menu() {
    menuToggle.classList.toggle("is-open");
    menuList.classList.toggle("is-visible");
  }


  // Search with optimized DOM batching
  function searchOpen() {
    if (!searchPending) {
      searchPending = true;
      requestAnimationFrame(() => {
        search.classList.add("is-visible");
        body.classList.add("search-is-visible");
        globalWrap.classList.add("is-active");
        menuToggle.classList.remove("is-open");
        menuList.classList.remove("is-visible");
        searchPending = false;
      });
      
      setTimeout(() => {
        searchInput.focus();
      }, 250);
    }
  }

  function searchClose() {
    if (!searchPending) {
      searchPending = true;
      requestAnimationFrame(() => {
        search.classList.remove("is-visible");
        body.classList.remove("search-is-visible");
        globalWrap.classList.remove("is-active");
        searchPending = false;
      });
    }
  }

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && search.classList.contains('is-visible')) {
      searchClose();
    }
  }, { passive: true });


  // Theme Switcher
  let themePending = false;
  if (toggleTheme) {
    toggleTheme.addEventListener("click", () => {
      if (!themePending) {
        themePending = true;
        requestAnimationFrame(() => {
          darkMode();
          themePending = false;
        });
      }
    });
  }

  function darkMode() {
    if (html.classList.contains('dark-mode')) {
      html.classList.remove('dark-mode');
      localStorage.removeItem("theme");
      document.documentElement.removeAttribute("dark");
    } else {
      html.classList.add('dark-mode');
      localStorage.setItem("theme", "dark");
      document.documentElement.setAttribute("dark", "");
    }
  }


  /* ================================================================
  // Stop Animations During Window Resizing and Switching Theme Modes
  ================================================================ */
  let disableTransition;
  let resizePending = false;

  window.addEventListener("resize", () => {
    if (!resizePending) {
      resizePending = true;
      requestAnimationFrame(() => {
        stopAnimation();
        resizePending = false;
      });
    }
  }, { passive: true });

  function stopAnimation() {
    document.body.classList.add("disable-animation");
    clearTimeout(disableTransition);
    disableTransition = setTimeout(() => {
      document.body.classList.remove("disable-animation");
    }, 100);
  }



  // =====================
  // Simple Jekyll Search (Debounced + Optimized)
  // =====================
  const searchInputElement = document.getElementById("js-search-input");
  const searchResultsElement = document.getElementById("js-results-container");
  if (window.SimpleJekyllSearch && searchInputElement && searchResultsElement) {
    window.SimpleJekyllSearch({
      searchInput: searchInputElement,
      resultsContainer: searchResultsElement,
      json: "/search.json",
      searchResultTemplate: '<div class="search-results__item"><a href="{url}" class="search-results__image" style="background-image: url({image})"></a> <a href="{url}" class="search-results__link"><time class="search-results-date" datetime="{date}">{date}</time><div class="search-results-title">{title}</div><div class="search-results-description">{content}</div></a></div>',
      noResultsText: '<div class="no-results">No results found...</div>',
      debounceTime: 100
    });
  }



  /* =======================
  // Responsive Videos
  ======================= */
  reframe(".post__content iframe:not(.reframe-off), .page__content iframe:not(.reframe-off)");


  /* =======================
  // LazyLoad Images
  ======================= */
  var lazyLoadInstance = new LazyLoad({
    elements_selector: ".lazy"
  })


  /* =======================
  // Zoom Image
  ======================= */
  const lightense = document.querySelector(".page__content img, .post__content img, .gallery__image img"),
  imageLink = document.querySelectorAll(".page__content a img, .post__content a img, .gallery__image a img");

  if (imageLink) {
    for (const i = 0; i < imageLink.length; i++) imageLink[i].parentNode.classList.add("image-link");
    for (const i = 0; i < imageLink.length; i++) imageLink[i].classList.add("no-lightense");
  };

  if (lightense) {
    Lightense(".page__content img:not(.no-lightense), .post__content img:not(.no-lightense), .gallery__image img:not(.no-lightense)", {
    padding: 60,
    offset: 30
    });
  };


  // =====================
  // Load More Posts (Batched DOM Insertion)
  // =====================
  var load_posts_button = document.querySelector('.load-more-posts');

  if (load_posts_button) {
    load_posts_button.addEventListener("click", function(e) {
      e.preventDefault();
      
      const pagination = document.querySelector(".pagination");
      const url = pagination_next_url.split("/page")[0] + "/page/" + pagination_next_page_number + "/";
      
      fetch(url).then(function(response) {
        if (response.ok) return response.text();
      }).then(function(html) {
        const temp = document.createElement("div");
        temp.innerHTML = html;
        const grid = document.querySelector(".grid");
        const posts = temp.querySelectorAll(".grid__post");
        
        // Batch DOM inserts with requestAnimationFrame to avoid layout thrashing
        requestAnimationFrame(() => {
          const fragment = document.createDocumentFragment();
          for (let i = 0; i < posts.length; i++) {
            fragment.appendChild(posts[i].cloneNode(true));
          }
          grid.appendChild(fragment);
          
          // Re-initialize LazyLoad for new images
          new LazyLoad({ elements_selector: ".lazy" });
          
          pagination_next_page_number++;
          if (pagination_next_page_number > pagination_available_pages_number) {
            pagination.style.display = "none";
          }
        });
      });
    });
  }


  /* =================================
  // Smooth scroll to the tags page (Native scroll, instant fallback)
  ================================= */
  document.querySelectorAll(".tag__link, .top__link").forEach(anchor => {
    anchor.addEventListener("click", function (e) {
      e.preventDefault();
      
      const target = document.querySelector(this.getAttribute("href"));
      if (target) {
        // Use native instant scroll for better responsiveness; smooth is optional enhancement
        requestAnimationFrame(() => {
          target.scrollIntoView({ behavior: "auto" });
        });
      }
    });
  });


  /* =======================
  // Copy Code Button (Non-blocking)
  ======================= */
  document.querySelectorAll('.post__content pre.highlight, .page__content pre.highlight')
  .forEach(function (pre) {
    const button = document.createElement('button');
    const copyText = 'Copy';
    button.type = 'button';
    button.ariaLabel = 'Copy code to clipboard';
    button.innerText = copyText;
    button.addEventListener('click', function (e) {
      e.preventDefault();
      let code = pre.querySelector('code').innerText;
      try {
        code = code.trimEnd();
      } catch (e) {
        code = code.trim();
      }
      // Use async clipboard API with fallback
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(code).then(() => {
          button.innerText = 'Copied!';
          setTimeout(() => {
            button.blur();
            button.innerText = copyText;
          }, 2000);
        }).catch(() => {
          // Fallback if clipboard fails
          fallbackCopy(code, button, copyText);
        });
      } else {
        fallbackCopy(code, button, copyText);
      }
    });
    pre.appendChild(button);
  });

  function fallbackCopy(text, button, originalText) {
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    try {
      document.execCommand('copy');
      button.innerText = 'Copied!';
    } catch (err) {
      console.error('Copy failed:', err);
    }
    document.body.removeChild(textarea);
    setTimeout(() => {
      button.blur();
      button.innerText = originalText;
    }, 2000);
  }


  /* =======================
  // Scroll Top Button (Instant)
  ======================= */
  btnScrollToTop.addEventListener("click", function () {
    if (window.scrollY !== 0) {
      requestAnimationFrame(() => {
        window.scrollTo({
          top: 0,
          left: 0,
          behavior: "auto"
        });
      });
    }
  }, { passive: true });

});