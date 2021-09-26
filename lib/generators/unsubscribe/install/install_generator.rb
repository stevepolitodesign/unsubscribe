require "rails/generators"

module Unsubscribe
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("./../../../../../", __FILE__)

      def link_manifest_js
        inject_into_file "app/assets/config/manifest.js" do
          <<~EOF
            \n//= link unsubscribe_manifest.js\n
          EOF
        end
      end
    end
  end
end
