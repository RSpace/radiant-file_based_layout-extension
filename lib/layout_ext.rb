module FileBasedLayout
  module LayoutExt

    def self.included(base)
      base.class_eval {
        validates_length_of :layout_file, :allow_nil => true, :maximum => 100, :message => '%d-character limit'
        include InstanceMethods
      }
    end

    module InstanceMethods     
      def file_based?
        ! layout_file.nil? && ! layout_file.empty?
      end
    end
    
  end
end