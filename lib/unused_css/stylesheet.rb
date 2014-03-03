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
  include Enumerable
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

  def [](uri)
    @stylesheets.find { |stylesheet| stylesheet.uri == uri }
  end

  def each &block
    @stylesheets.each &block
  end

  def styles
    @stylesheets.inject(Set.new) {|styles, stylesheet| styles.merge stylesheet.styles }
  end
end