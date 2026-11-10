require "addressable/uri"
require "fastimage"
require "json"
require "nokogiri"
require "set"

module Jekyll
  class ImageDimensions
    RAW_IMAGE_PREFIX = "/holgerimbery/holgerimbery.blog/main/holgerimbery/".freeze
    attr_reader :used_variants

    def initialize(site)
      @root = File.expand_path(site.source)
      @origin = Addressable::URI.parse(site.config.fetch("url"))
      @baseurl = site.baseurl.to_s.sub(%r{/$}, "")
      @sizes = {}
      @warned = {}
      @used_variants = Set.new
      manifest = File.join(@root, "images", "generated", ".metadata", "manifest.json")
      if site.config["image_optimization"] && !File.file?(manifest)
        raise Jekyll::Errors::FatalException,
              "Generate image variants first: python ../scripts/optimize_images.py --source ."
      end
      @images = if site.config["image_optimization"] && File.file?(manifest)
                  JSON.parse(File.read(manifest)).fetch("images")
                else
                  {}
                end
    end

    def process(document)
      return unless document.output_ext == ".html"

      html = Nokogiri::HTML5.parse(document.output)
      changed = false
      html.css("img").each do |image|
        source = image["data-src"] || image["src"]
        path = image_path(source, document.url)
        entry = path ? @images[local_url(path)] : nil
        unless dimension(image["width"]) && dimension(image["height"])
          size = entry && entry["width"] ? [entry["width"], entry["height"]] : image_size(source, document.url)
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
        screenshot = path && !%w[.jpg .jpeg].include?(File.extname(path).downcase) &&
                     image.ancestors(".post__content, .page__content, .gallery").any?
        if entry && !screenshot && !entry["variants"].empty? && !image["srcset"] && !image.ancestors("picture").any?
          add_responsive_sources(image, entry, path, source)
          changed = true
        end
      end
      document.output = html.to_html if changed
    end

    private

    def dimension(value)
      value.to_i if value.to_s.match?(/\A[1-9]\d*\z/)
    end

    def image_size(source, page_url)
      path = image_path(source, page_url)
      return unless path

      @sizes[path] = FastImage.size(path) unless @sizes.key?(path)
      @sizes[path]
    end

    def image_path(source, page_url)
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

      path
    rescue Addressable::URI::InvalidURIError => error
      Jekyll.logger.warn "Image dimensions:", "#{source.inspect}: #{error.message}"
      nil
    end

    def local_url(path)
      "/" + path.delete_prefix("#{@root}#{File::SEPARATOR}").tr("\\", "/")
    end

    def asset_url(path)
      @baseurl + Addressable::URI.escape(path)
    end

    def add_responsive_sources(image, entry, path, source)
      width = dimension(image["width"])
      avatar = width && width <= 160 && image["width"] == image["height"]
      variants = entry["variants"].select { |variant| avatar ? variant["width"] <= 160 : variant["width"] >= 400 }
      variants = [entry["variants"].last] if variants.empty?
      variants.each do |variant|
        unless File.file?(File.join(@root, variant.fetch("path").delete_prefix("/")))
          raise Jekyll::Errors::FatalException, "Missing image variant #{variant['path']}; rerun optimize_images.py."
        end
        @used_variants.add(variant["path"])
      end

      original = asset_url(local_url(path))
      original += "#wide" if source.end_with?("#wide")
      image["src"] = original
      image["data-src"] = original if image["data-src"]
      image["decoding"] ||= "async"
      image["loading"] ||= "lazy"
      image["data-original-src"] = original
      picture = Nokogiri::XML::Node.new("picture", image.document)
      webp = Nokogiri::XML::Node.new("source", image.document)
      webp["type"] = "image/webp"
      webp["srcset"] = variants.map { |variant| "#{asset_url(variant['path'])} #{variant['width']}w" }.join(", ")
      webp["sizes"] = responsive_sizes(image, avatar)
      webp["data-srcset"] = webp["srcset"] if image["class"].to_s.split.include?("lazy")
      image.add_previous_sibling(picture)
      picture.add_child(webp)
      picture.add_child(image)
    end

    def responsive_sizes(image, avatar)
      return "#{image['width']}px" if avatar
      return "100vw" if image["src"].end_with?("#wide")
      if image.ancestors(".article__image").any?
        gutter = image.ancestors(".featured-post").any? ? 66 : 42
        mobile = "(max-width: 576px) min(calc(100vw - #{gutter}px), 438px), (max-width: 768px) 526px, "
        return mobile + "(max-width: 1024px) 706px, (max-width: 1400px) 483px, 649px" if image.ancestors(".article--big").any?

        column = image.ancestors(".col").first
        classes = column ? column["class"].split : []
        wide = classes.include?("col-3") ? 299 : 410
        desktop = classes.include?("col-w-6") ? 466 : (classes.include?("col-3") ? 216 : 299)
        return mobile + "(max-width: 1024px) 336px, (max-width: 1400px) #{desktop}px, #{wide}px"
      end
      return "(max-width: 576px) min(calc(100vw - 40px), 440px), (max-width: 768px) 528px, " \
             "(max-width: 1024px) 708px, (max-width: 1400px) 484px, 634px" if image.ancestors(".about__image").any?
      if (gallery = image.ancestors(".gallery").first)
        columns = gallery["class"].include?("gallery-column-4") ? 4 : (gallery["class"].include?("gallery-column-3") ? 3 : 2)
        return "(max-width: 1024px) #{100 / columns}vw, #{960 / columns}px"
      end
      return "(max-width: 576px) calc(100vw - 40px), 720px" if image.ancestors(".post, .page").any?

      "(max-width: 576px) calc(100vw - 40px), (max-width: 1024px) 100vw, 720px"
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
  site.static_files.reject! do |file|
    relative = file.relative_path.tr("\\", "/")
    relative.start_with?("/images/generated/") && !dimensions.used_variants.include?(relative)
  end
end
