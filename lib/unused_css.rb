require_relative "stylesheet"

class UnusedCSS
  attr_accessor :stylesheets

  def initialize
    @stylesheets = []
  end

  def add_stylesheet uri
    @stylesheets << Stylesheet.new(uri) unless stylesheet_exists? uri
  end

  def stylesheet_exists? uri
    @stylesheets.any? { |stylesheet| stylesheet.uri == uri }
  end

  def add_stylesheets uris
    uris.each { |uri| add_stylesheet uri }
  end

  def stylesheet(stylesheet_uri)
    @stylesheets.find { |stylesheet| stylesheet.uri == stylesheet_uri }
  end

  def styles
    @stylesheets.inject(Set.new) {|styles, stylesheet| styles.merge stylesheet.styles }
  end

  def watch!(watir_browser)
    unused_css_block = Proc.new do |unused_css|
      @unused_css = unused_css
      def goto(uri)
        super(uri)
        stylesheets = elements(tag_name: 'link').map {|stylesheet| stylesheet.attribute_value('href') }
        @unused_css.add_stylesheets stylesheets
        stylesheets.each do |stylesheet|
          @unused_css.stylesheet(stylesheet).styles.each do |style|
            @unused_css.stylesheet(stylesheet).styles.delete(style) if self.element(css: style).exist?
          end
        end
      end
    end
    watir_browser.instance_exec self, &unused_css_block
  end
end