require_relative "stylesheet"

class UnusedCSS
  attr_accessor :stylesheets

  def initialize
    @stylesheets = Stylesheets.new
  end

  def watch!(watir_browser)
    unused_css_block = Proc.new do |unused_css|
      @unused_css = unused_css
      def goto(uri)
        super(uri)
        stylesheets = elements(tag_name: 'link').map {|stylesheet| stylesheet.attribute_value('href') }
        @unused_css.stylesheets.add stylesheets
        stylesheets.each do |stylesheet|
          @unused_css.stylesheets.stylesheet(stylesheet).styles.each do |style|
            @unused_css.stylesheets.stylesheet(stylesheet).styles.delete(style) if self.element(css: style).exist?
          end
        end
      end
    end
    watir_browser.instance_exec self, &unused_css_block
  end
end