module BigosInstagramBox
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a BigosInstagramBox initializer."
      def copy_initializer
        template "bigos_instagram_box.rb", "config/initializers/bigos_instagram_box.rb"
      end

    end
  end
end