module FileBasedLayout
  module SiteControllerExt
    def self.included(base)
      base.class_eval {
        include InstanceMethods
        alias_method_chain :process_page, :file_based_layout
      }
    end
    
    module InstanceMethods
      
      protected
      
      def process_page_with_file_based_layout(page)
        if @page.layout && @page.layout.file_based?
          render :text => process_with_file_based_layout(@page), :layout => @page.layout.layout_file.gsub(/(\.[a-z]+)?\.[a-z]+$/, '')
        else
          process_page_without_file_based_layout(page)
        end
      end
      
      def process_with_file_based_layout(page)
        [:request, :response].each { |var| page.instance_variable_set("@#{var}", send(var)) }
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
    end
    
  end
end
