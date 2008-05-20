module FileBasedLayout
  module LayoutControllerExt
    def self.included(base)
      base.class_eval {
        before_filter :get_layout_files, :only => [:new, :edit]
        include InstanceMethods
      }
    end

    module InstanceMethods

      protected

      def get_layout_files
        @layout_files = [['<none>', nil]] + ActionController::Base.view_paths.collect { |path| Dir["#{path}/layouts/*.*"]  }.flatten.sort.collect { |f| [f.gsub(RAILS_ROOT, ''), File.basename(f)] }
      end
    end

  end
end