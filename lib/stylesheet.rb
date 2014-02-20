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
end