require "css_parser"

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

  def remove_pseudo_styles!
    @styles.delete_if { |style| style.match /::?[\w\-]+/ }
  end
end

class Stylesheets
  attr_accessor :stylesheets

  def initialize
    @stylesheets = []
  end

  def add uris
    uris = Array(uris)
    uris.each { |uri| @stylesheets << Stylesheet.new(uri) unless already_included? uri }
  end

  def already_included? uri
    @stylesheets.any? { |stylesheet| stylesheet.uri == uri }
  end

  def stylesheet(uri)
    @stylesheets.find { |stylesheet| stylesheet.uri == uri }
  end

  def styles
    @stylesheets.inject(Set.new) {|styles, stylesheet| styles.merge stylesheet.styles }
  end
end