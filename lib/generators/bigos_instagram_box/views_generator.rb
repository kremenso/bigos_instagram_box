module BigosInstagramBox
  module Generators

    module ViewPathTemplates #:nodoc:
      extend ActiveSupport::Concern

      included do
        class_option :markerb

        public_task :copy_views
      end


      module ClassMethods
        def hide!
          Rails::Generators.hide_namespace self.namespace
        end
      end

      def copy_views
        view_directory :module
      end

      protected

      def view_directory(name, _target_path = nil)
        directory name.to_s, _target_path || "#{target_path}/#{name}"
      end

      def target_path
        @target_path ||= "app/views/bigos_instagram_box"
      end
    end

    class ViewsGenerator < Rails::Generators::Base
      include ViewPathTemplates
      desc "Copies BigosInstagramBox views to your application."

      source_root File.expand_path("../../../../app/views/bigos_instagram_box", __FILE__)
      hide!
    end
  end
end
