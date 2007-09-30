module Beast
  module Plugins

    class IPhone < Beast::Plugin

      author 'Calvin Yu - blog.codeeg.com'
      version '0001'
      homepage "http://boardista.com"
      notes "iPhone support for Beast"
      
      %w( controllers helpers models ).each do |dir|
        path = File.expand_path(File.join(plugin_path, 'app', dir))
        if File.exist?(path) && !Dependencies.load_paths.include?(path)
          Dependencies.load_paths << path
        end
      end

      def initialize
        super
      end
      
    end

  end
end
