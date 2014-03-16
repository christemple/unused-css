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
      @stylesheets.add stylesheets_on_page
      check_for_unused_styles!
    end

    def stylesheets_on_page
      elements(tag_name: 'link').map { |stylesheet| stylesheet.attribute_value('href') }
    end

    def check_for_unused_styles!
      @stylesheets.each do |stylesheet|
        stylesheet.unused_styles.delete_if { |style| self.element(css: style).exist? }
        stylesheet.remove_pseudo_styles!
      end
    end
  end

end