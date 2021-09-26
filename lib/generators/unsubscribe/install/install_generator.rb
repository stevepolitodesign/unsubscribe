require "rails/generators"

module Unsubscribe
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("./../../../../../", __FILE__)

      def link_manifest_js
        inject_into_file "app/assets/config/manifest.js" do
          <<~EOF
            \n//= link unsubscribe_manifest.js
          EOF
        end
      end

      def mount_engine
        inject_into_file "config/routes.rb", after: "Rails.application.routes.draw do" do
          <<~EOF
            \n\tmount Unsubscribe::Engine => "/unsubscribe"
          EOF
        end
      end
    end
  end
end
