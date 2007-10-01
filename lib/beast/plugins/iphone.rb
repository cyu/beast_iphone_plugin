module Beast
  module Plugins

    class Iphone < Beast::Plugin

      author 'Calvin Yu - blog.codeeg.com'
      version '0001'
      homepage "http://boardista.com"
      notes "iPhone support for Beast"
      
      route :iphone, 'iphone/:action/:id', :controller => 'iphone'
      
      %w( controllers helpers models ).each do |dir|
        path = File.expand_path(File.join(plugin_path, 'app', dir))
        if File.exist?(path) && !Dependencies.load_paths.include?(path)
          Dependencies.load_paths << path
        end
      end

      def initialize
        super
        [ ApplicationController, ForumsHelper ].each do |klass|
          klass.send :include, "Beast::Plugins::Iphone::#{klass.name}Extensions".constantize
        end
      end

      def self.install
        FileUtils.cp_r(File.join(plugin_path, 'public', 'iui'), File.join(RAILS_ROOT, 'public'))
        FileUtils.cp(File.join(plugin_path, 'public', 'stylesheets', 'iphone.css'), File.join(RAILS_ROOT, 'public'))
      end
      
      module ApplicationControllerExtensions
        def self.included(base)
          base.helper_method :iphone?
        end

        def iphone?
          request.user_agent.include?("iPhone")
        end
      end
      
      module ForumsHelperExtensions
        def head_extras
          javascript_tag "Event.observe(window, 'load', function(){if(confirm('Hi! You can view these forums in iPhone mode.  Continue?'))document.location.href = '/iphone'})" if iphone?
        end
      end
      
      class Schema
        def self.install;end
        def self.uninstall;end
      end
    end

  end
end
