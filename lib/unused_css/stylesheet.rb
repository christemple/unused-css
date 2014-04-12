require "css_parser"

class Stylesheet
  attr_accessor :uri, :unused_styles, :parser

  def initialize (uri)
    @unused_styles = Set.new
    @uri = uri
    parse_styles!
    remove_css_at_rules!
    remove_pseudo_styles!
  end

  def parse_styles!
    @parser = CssParser::Parser.new
    @parser.load_uri! @uri
    @parser.each_selector { |style| @unused_styles << style }
  end

  def remove_pseudo_styles!
    @unused_styles.delete_if { |style| style.match /::?[\w\-]+/ }
  end

  def remove_css_at_rules!
    @unused_styles.delete_if { |style| style.match /^@/ }
  end

  def eql?(other_stylesheet)
    @uri == other_stylesheet.uri
  end

  def hash
    @uri.hash
  end
end


class Stylesheets
  extend Forwardable
  attr_accessor :stylesheets

  def initialize
    @stylesheets = Set.new
  end

  def add(uris)
    stylesheets = uris.map { |uri| Stylesheet.new(uri) }
    @stylesheets.merge(stylesheets)
  end

  def [](uri)
    @stylesheets.find { |stylesheet| stylesheet.uri == uri }
  end

  def unused_styles
    @stylesheets.inject(Set.new) {|styles, stylesheet| styles.merge stylesheet.unused_styles }
  end

  def_delegators :@stylesheets, :size, :each
end