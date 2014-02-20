require "watir-webdriver"
require "css_parser"

system "rake"

class Stylesheet
  attr_accessor :uri, :styles, :parser

  def initialize (uri)
    @styles = Set.new
    @uri = uri
    parse_styles!
  end

  def parse_styles!
    @parser = CssParser::Parser.new
    @parser.load_uri! @uri
    @parser.each_selector { |styles| @styles << styles }
  end
end

class UnusedCSS
  attr_accessor :stylesheets

  def initialize
    @stylesheets = []
  end

  def add_stylesheet (stylesheet_uri)
    @stylesheets << Stylesheet.new(stylesheet_uri)
  end

  def add_stylesheets (stylesheet_uris)
    stylesheet_uris.each { |uri| add_stylesheet uri }
  end

  def stylesheet(stylesheet_uri)
    @stylesheets.find { |stylesheet| stylesheet.uri == stylesheet_uri }
  end

  def styles
    @stylesheets.inject(Set.new) {|styles, stylesheet| styles.merge stylesheet.styles }
  end
end

Before do
  $browser = Watir::Browser.new
  $unused_css = UnusedCSS.new
end

at_exit do
  $browser.close
end
