require "unused_css/stylesheet"

module Watir

  class Browser
    attr_accessor :stylesheets

    alias_method :original_initialize, :initialize
    def initialize(*args)
      @stylesheets = Stylesheets.new
      original_initialize(*args)
    end

    alias_method :original_goto, :goto
    def goto(*args)
      original_goto(*args)
      stylesheets = elements(tag_name: 'link').map {|stylesheet| stylesheet.attribute_value('href') }
      @stylesheets.add stylesheets
      stylesheets.each do |stylesheet|
        @stylesheets[stylesheet].styles.delete_if {|style| self.element(css: style).exist? }
        @stylesheets[stylesheet].remove_pseudo_styles!
      end
    end

    def check_for_unused_styles!
      @stylesheets.each do |stylesheet|
        stylesheet.styles.delete_if {|style| self.element(css: style).exist? }
        stylesheet.remove_pseudo_styles!
      end
    end
  end

end