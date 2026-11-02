require "addressable/uri"
require "fastimage"
require "nokogiri"

module Jekyll
  class ImageDimensions
    RAW_IMAGE_PREFIX = "/holgerimbery/holgerimbery.blog/main/holgerimbery/".freeze

    def initialize(site)
      @root = File.expand_path(site.source)
      @origin = Addressable::URI.parse(site.config.fetch("url"))
      @baseurl = site.baseurl.to_s.sub(%r{/$}, "")
      @sizes = {}
      @warned = {}
    end

    def process(document)
      return unless document.output_ext == ".html"

      html = Nokogiri::HTML5.parse(document.output)
      changed = false
      html.css("img").each do |image|
        next if dimension(image["width"]) && dimension(image["height"])

        source = image["data-src"] || image["src"]
        size = image_size(source, document.url)
        unless size
          warn_once(source, document.url)
          next
        end

        width, height = size
        if (existing_width = dimension(image["width"]))
          height = [(existing_width * height.to_f / width).round, 1].max
          width = existing_width
        elsif (existing_height = dimension(image["height"]))
          width = [(existing_height * width.to_f / height).round, 1].max
          height = existing_height
        end
        image["width"] = width.to_s
        image["height"] = height.to_s
        changed = true
      end
      document.output = html.to_html if changed
    end

    private

    def dimension(value)
      value.to_i if value.to_s.match?(/\A[1-9]\d*\z/)
    end

    def image_size(source, page_url)
      return if source.to_s.empty?

      uri = Addressable::URI.join("#{@origin}#{@baseurl}#{page_url}", source)
      path = if uri.host == "raw.githubusercontent.com" && uri.path.start_with?(RAW_IMAGE_PREFIX)
               uri.path.delete_prefix(RAW_IMAGE_PREFIX)
             elsif uri.host == @origin.host && uri.scheme == @origin.scheme && uri.port == @origin.port
               local_path = uri.path
               local_path = local_path.delete_prefix(@baseurl) if !@baseurl.empty? && local_path.start_with?("#{@baseurl}/")
               local_path.delete_prefix("/")
             else
               return
             end
      path = File.expand_path(Addressable::URI.unencode_component(path), @root)
      return unless path.start_with?("#{@root}#{File::SEPARATOR}") && File.file?(path)

      @sizes[path] = FastImage.size(path) unless @sizes.key?(path)
      @sizes[path]
    rescue Addressable::URI::InvalidURIError => error
      Jekyll.logger.warn "Image dimensions:", "#{source.inspect}: #{error.message}"
      nil
    end

    def warn_once(source, page_url)
      return if @warned[source]

      @warned[source] = true
      Jekyll.logger.warn "Image dimensions:",
                         "Cannot determine dimensions for #{source.inspect} on #{page_url}; add explicit width and height."
    end
  end
end

Jekyll::Hooks.register :site, :post_render do |site|
  dimensions = Jekyll::ImageDimensions.new(site)
  documents = site.pages + site.collections.values.flat_map(&:docs)
  documents.each { |document| dimensions.process(document) }
end
