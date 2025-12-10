module Jekyll
    module CharFilter
      def remove_chars(input)
        input.gsub! '\\','&#92;'
        input.gsub! /\t/, '    '
        input.strip_control_and_extended_characters
      end
    end

    module AuthorFilter
      def posts_by_author(posts, author_username)
        posts.select do |post|
          author_field = post.data['author']
          next false if author_field.nil?
          
          # Handle both string and array formats
          if author_field.is_a?(Array)
            post_authors = author_field.map(&:to_s).map(&:strip)
          else
            post_authors = author_field.to_s.split(',').map(&:strip)
          end
          
          post_authors.include?(author_username.to_s.strip)
        end
      end

      def first_author(author_field, site_authors)
        return nil if author_field.nil?
        
        # Handle both string and array formats
        if author_field.is_a?(Array)
          first_author_username = author_field.first.to_s.strip
        else
          first_author_username = author_field.to_s.split(',').first.strip
        end
        
        site_authors.find { |author| author['username'] == first_author_username }
      end

      def all_authors(author_field, site_authors)
        return [] if author_field.nil?
        
        # Handle both string and array formats
        if author_field.is_a?(Array)
          author_usernames = author_field.map(&:to_s).map(&:strip)
        else
          author_usernames = author_field.to_s.split(',').map(&:strip)
        end
        
        author_usernames.map do |username|
          site_authors.find { |author| author['username'] == username }
        end.compact
      end

      def author_names_list(author_field, site_authors)
        authors = all_authors(author_field, site_authors)
        case authors.size
        when 0
          ""
        when 1
          authors.first['name']
        when 2
          "#{authors.first['name']} and #{authors.last['name']}"
        else
          names = authors[0...-1].map { |a| a['name'] }.join(', ')
          "#{names}, and #{authors.last['name']}"
        end
      end
    end
  end
  
  Liquid::Template.register_filter(Jekyll::CharFilter)
  Liquid::Template.register_filter(Jekyll::AuthorFilter)
  
  class String
    def strip_control_and_extended_characters()
      chars.each_with_object("") do |char, str|
        str << char if char.ascii_only? and char.ord.between?(32,126)
      end
    end
  end