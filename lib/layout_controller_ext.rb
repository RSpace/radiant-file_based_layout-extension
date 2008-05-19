module FileBasedLayout
  module LayoutControllerExt

    def new
      @layout_files = get_layout_files
      super
    end

    def edit
      @layout_files = get_layout_files
      super
    end

    private 

    def get_layout_files
      extension_layouts = ActionView::Base.view_paths.collect { |path| Dir["#{path}/layouts/*.rhtml"]  } # Rails Edge supports ActionController::Base.view_paths, however, until then ...
      [['<none>', nil]] + (Dir["#{RAILS_ROOT}/app/views/layouts/*.rhtml"] + extension_layouts.flatten).collect { |f| [File.basename(f), File.basename(f)] }
    end

  end
end