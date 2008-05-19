module FileBasedLayout
  module SiteControllerExt
    def self.included(base)
      base.class_eval {
        private
      
        def show_uncached_page(url)
          @page = find_page(url)
          unless @page.nil?
            if @page.layout && @page.layout.file_based?
              render :text => process_with_file_based_layout(@page), :layout => File.basename(@page.layout.layout_file, File.extname(@page.layout.layout_file))
            else
              process_page(@page)
              @performed_render = true
            end
            @cache.cache_response(url, response) if live? and @page.cache?
          else
            render :template => 'site/not_found', :status => 404
          end
        rescue Page::MissingRootPageError
          redirect_to welcome_url
        end
      
        def process_with_file_based_layout(page)
          page.instance_variable_set(:@request, request)
          page.instance_variable_set(:@response, response)
          page.instance_variable_set(:@controller, self)
          content_type = page.layout.content_type.to_s.strip
          response.headers['Content-Type'] = content_type unless content_type.empty?
          headers.each { |k,v| response.headers[k] = v }
          render_with_file_based_layout(page)
        end

        def render_with_file_based_layout(page)
          for part in page.parts.reject { |p| p.name == 'body' }
            eval "@content_for_#{part.name} = (@content_for_#{part.name} || '') + \"#{page.render_part(part.name).gsub(/\"/,'\\\"')}\""
          end
          page.render_part(:body)
        end
            
      }
    end
  end
end
