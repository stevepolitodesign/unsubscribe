require "rails/generators"

module Unsubscribe
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path("./../../../../../", __FILE__)

      def copy_views
        directory "app/views/unsubscribe", "app/views/unsubscribe"
      end
    end
  end
end
