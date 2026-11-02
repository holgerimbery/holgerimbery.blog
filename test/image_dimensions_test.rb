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
end
