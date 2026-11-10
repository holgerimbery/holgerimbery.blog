require "minitest/autorun"
require "tmpdir"
require "fileutils"
require "jekyll"
require_relative "../holgerimbery/_plugins/image_dimensions"

class ImageDimensionsTest < Minitest::Test
  Site = Struct.new(:source, :config, :baseurl)
  Document = Struct.new(:output, :url, :output_ext)

  def setup
    @source = Dir.mktmpdir
    FileUtils.mkdir_p(File.join(@source, "images"))
    @image = File.join(@source, "images", "example image.png")
    fixture = "../holgerimbery/images/cllt3vjv5000g09mnfrj04ucn.md/24979867-c793-4e9e-8a90-f6ae6e975036.png"
    FileUtils.cp(File.expand_path(fixture, __dir__), @image)
    @width, @height = FastImage.size(@image)
    @site = Site.new(@source, { "url" => "https://holgerimbery.blog" }, "")
    @processor = Jekyll::ImageDimensions.new(@site)
  end

  def teardown
    FileUtils.remove_entry(@source)
  end

  def render(markup, url: "/article", extension: ".html")
    document = Document.new(markup, url, extension)
    @processor.process(document)
    document
  end

  def assert_dimensions(markup, width = @width, height = @height, **options)
    image = Nokogiri::HTML5.parse(render(markup, **options).output).at_css("img")
    assert_equal width.to_s, image["width"]
    assert_equal height.to_s, image["height"]
  end

  def test_local_absolute_relative_and_raw_github_sources
    sources = [
      "/images/example%20image.png",
      "images/example%20image.png",
      "https://holgerimbery.blog/images/example%20image.png?version=1#wide",
      "//holgerimbery.blog/images/example%20image.png",
      "https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/example%20image.png"
    ]
    sources.each { |source| assert_dimensions(%(<img src="#{source}">)) }
    assert_dimensions('<img src="../images/example%20image.png">', url: "/nested/article")
  end

  def test_baseurl
    @site.baseurl = "/blog"
    @processor = Jekyll::ImageDimensions.new(@site)
    assert_dimensions('<img src="/blog/images/example%20image.png">')
    assert_dimensions('<img src="images/example%20image.png">')
    assert_dimensions('<img src="https://holgerimbery.blog/images/example%20image.png">')
    assert_dimensions('<img src="/images/example%20image.png">')
  end

  def test_existing_dimensions_and_loading_attributes_are_preserved
    markup = '<img src="/images/example%20image.png" width="40" height="40" loading="eager" fetchpriority="high">'
    assert_equal markup, render(markup).output
  end

  def test_partial_dimensions_preserve_the_aspect_ratio
    assert_dimensions('<img src="/images/example%20image.png" width="100">',
                      100, [(100.0 * @height / @width).round, 1].max)
    assert_dimensions('<img src="/images/example%20image.png" height="100">',
                      [(100.0 * @width / @height).round, 1].max, 100)
  end

  def test_lazy_image_uses_the_real_source
    assert_dimensions('<img src="placeholder.gif" data-src="/images/example%20image.png">')
  end

  def test_repository_images_use_local_assets_when_optimization_is_disabled
    source = "https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/example%20image.png?version=1#wide"
    html = Nokogiri::HTML5.parse(render(%(<img class="lazy" src="#{source}" data-src="#{source}">)).output)
    image = html.at_css("img")

    assert_equal "/images/example%20image.png?version=1#wide", image["src"]
    assert_equal image["src"], image["data-src"]
    assert_equal @width.to_s, image["width"]
    assert_equal @height.to_s, image["height"]
  end

  def test_repository_images_in_social_metadata_use_local_assets
    source = "https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/example%20image.png"
    pinterest = "http://pinterest.com/pin/create/button/?url=https://holgerimbery.blog/article&amp;media=https://holgerimbery.blog#{source}&amp;description=Example"
    markup = %(<meta property="og:image" content="#{source}"><a class="share__pinterest" href="#{pinterest}">Share</a>)
    html = Nokogiri::HTML5.parse(render(markup).output)

    assert_equal "https://holgerimbery.blog/images/example%20image.png", html.at_css("meta")["content"]
    link = Addressable::URI.parse(html.at_css("a.share__pinterest")["href"])
    assert_equal "https://holgerimbery.blog/images/example%20image.png", link.query_values["media"]
  end

  def test_invalid_dimensions_are_replaced
    assert_dimensions('<img src="/images/example%20image.png" width="100%" height="0">')
  end

  def test_metadata_is_cached_across_pages_and_url_forms
    reads = 0
    FastImage.stub(:size, ->(*) { reads += 1; [640, 360] }) do
      assert_dimensions('<img src="/images/example%20image.png">', 640, 360)
      assert_dimensions('<img src="images/example%20image.png">', 640, 360)
      assert_dimensions('<img src="/images/example%20image.png#wide">', 640, 360, url: "/another-article")
    end
    assert_equal 1, reads
  end

  def test_missing_and_external_images_are_reported_without_network_requests
    messages = []
    Jekyll.logger.stub(:warn, ->(*message) { messages << message.join(" ") }) do
      [
        "/images/missing.png",
        "https://example.com/image.png",
        "https://raw.githubusercontent.com/other/repository/main/image.png",
        "/images/%2e%2e/%2e%2e/outside.png"
      ].each do |source|
        markup = %(<img src="#{source}">)
        assert_equal markup, render(markup).output
        assert_equal markup, render(markup).output
      end
    end
    assert_equal 4, messages.length
    assert messages.all? { |message| message.include?("add explicit width and height") }
  end

  def test_html_content_and_attributes_survive_serialization
    markup = <<~HTML
      <!DOCTYPE html><html><head><script>if (1 < 2) { window.value = "<img>"; }</script></head>
      <body><p>A &amp; B</p><img src="/images/example%20image.png" alt="A &amp; B" loading="lazy" decoding="async">
      <svg viewBox="0 0 10 10"><path d="M0 0"></path></svg></body></html>
    HTML
    html = Nokogiri::HTML5.parse(render(markup).output)
    assert_equal 'if (1 < 2) { window.value = "<img>"; }', html.at_css("script").content
    assert_equal "A & B", html.at_css("img")["alt"]
    assert_equal "lazy", html.at_css("img")["loading"]
    assert_equal "async", html.at_css("img")["decoding"]
    assert_equal "0 0 10 10", html.at_css("svg")["viewBox"]
    assert_equal "A & B", html.at_css("p").content
  end

  def test_non_html_output_is_unchanged
    markup = '{"image": "<img src=\"/images/example%20image.png\">"}'
    assert_equal markup, render(markup, extension: ".json").output
  end

  def enable_optimization
    directory = File.join(@source, "images", "generated")
    FileUtils.mkdir_p(directory)
    variants = [80, 160, 400, 800].map do |width|
      name = "/images/generated/example-#{width}.webp"
      File.write(File.join(@source, name.delete_prefix("/")), "fixture")
      { "path" => name, "width" => width, "height" => (width.to_f * @height / @width).round, "bytes" => 7 }
    end
    manifest = { "images" => { "/images/example image.png" => {
      "width" => @width, "height" => @height, "variants" => variants
    } } }
    FileUtils.mkdir_p(File.join(directory, ".metadata"))
    File.write(File.join(directory, ".metadata", "manifest.json"), JSON.generate(manifest))
    @site.config["image_optimization"] = true
    @processor = Jekyll::ImageDimensions.new(@site)
  end

  def test_responsive_picture_preserves_loading_and_uses_local_original
    enable_optimization
    raw = "https://raw.githubusercontent.com/holgerimbery/holgerimbery.blog/main/holgerimbery/images/example%20image.png"
    html = Nokogiri::HTML5.parse(render(%(<a class="article__image"><img class="lazy" src="#{raw}" data-src="#{raw}" loading="eager" fetchpriority="high"></a>)).output)
    image = html.at_css("picture img")
    source = html.at_css("picture source")
    assert_equal "/images/example%20image.png", image["src"]
    assert_equal image["src"], image["data-src"]
    assert_equal image["src"], image["data-original-src"]
    assert_equal "eager", image["loading"]
    assert_equal "high", image["fetchpriority"]
    assert_equal "image/webp", source["type"]
    assert_includes source["srcset"], "/images/generated/example-400.webp 400w"
    refute_includes source["srcset"], " 80w"
    assert_equal source["srcset"], source["data-srcset"]
    assert_includes source["sizes"], "410px"
  end

  def test_disabled_optimization_uses_original_asset_even_with_a_stale_manifest
    enable_optimization
    @site.config["image_optimization"] = false
    @processor = Jekyll::ImageDimensions.new(@site)
    html = Nokogiri::HTML5.parse(render('<img src="/images/example%20image.png">').output)
    image = html.at_css("img")

    assert_empty html.css("picture")
    assert_equal "/images/example%20image.png", image["src"]
    assert_equal @width.to_s, image["width"]
    assert_equal @height.to_s, image["height"]
    assert_empty @processor.used_variants
  end

  def test_avatar_variants_and_baseurl
    @site.baseurl = "/blog"
    enable_optimization
    html = Nokogiri::HTML5.parse(render('<img src="/images/example%20image.png" width="40" height="40">').output)
    source = html.at_css("source")
    assert_equal "40px", source["sizes"]
    assert_includes source["srcset"], "/blog/images/generated/example-80.webp 80w"
    assert_includes source["srcset"], "/blog/images/generated/example-160.webp 160w"
    refute_includes source["srcset"], " 400w"
    assert_equal "/blog/images/example%20image.png", html.at_css("img")["src"]
    assert_equal "40", html.at_css("img")["width"]
  end

  def test_content_sizes_and_wide_fragment
    enable_optimization
    html = Nokogiri::HTML5.parse(render('<div class="post"><img src="/images/example%20image.png#wide"></div>').output)
    assert_equal "100vw", html.at_css("source")["sizes"]
    assert html.at_css("img")["src"].end_with?("#wide")
    html = Nokogiri::HTML5.parse(render('<div class="post"><img src="/images/example%20image.png"></div>').output)
    assert_includes html.at_css("source")["sizes"], "720px"
  end

  def test_existing_picture_and_srcset_are_not_replaced
    enable_optimization
    markup = '<picture><source srcset="custom.webp"><img src="/images/example%20image.png" width="40" height="40"></picture>'
    assert_equal markup, render(markup).output
    markup = '<img src="/images/example%20image.png" srcset="custom.png 800w" width="40" height="40">'
    assert_equal markup, render(markup).output
  end

  def test_missing_manifest_and_variant_fail_clearly
    @site.config["image_optimization"] = true
    assert_raises(Jekyll::Errors::FatalException) { Jekyll::ImageDimensions.new(@site) }
    enable_optimization
    File.delete(File.join(@source, "images", "generated", "example-800.webp"))
    assert_raises(Jekyll::Errors::FatalException) { render('<img src="/images/example%20image.png">') }
  end

  def test_external_image_does_not_inherit_the_previous_images_manifest
    enable_optimization
    markup = '<img src="/images/example%20image.png"><img src="https://example.com/image.jpg" width="100" height="100">'
    html = Nokogiri::HTML5.parse(render(markup).output)
    assert_equal 1, html.css("picture").size
    assert_equal "https://example.com/image.jpg", html.css("img").last["src"]
  end

  def test_article_screenshots_keep_originals_but_card_images_are_optimized
    enable_optimization
    markup = '<div class="post__content"><img src="/images/example%20image.png"></div>'
    html = Nokogiri::HTML5.parse(render(markup).output)
    assert_empty html.css("picture")
    assert_equal "/images/example%20image.png", html.at_css("img")["src"]
    assert_equal @width.to_s, html.at_css("img")["width"]
    assert_empty @processor.used_variants
    render('<a class="article__image"><img src="/images/example%20image.png"></a>')
    assert_includes @processor.used_variants, "/images/generated/example-800.webp"
  end
end
