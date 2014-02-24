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
          stylesheet = @unused_css.stylesheets[stylesheet]
          stylesheet.styles.delete_if {|style| self.element(css: style).exist? }
          stylesheet.remove_pseudo_styles!
        end
      end
    end
    watir_browser.instance_exec self, &unused_css_block
  end

  def report!
    Dir.mkdir("report") unless Dir.exist? "report"
    File.open("report/index.html", "w") do |file|
      file.write <<-HTML
        <html><body><h1>Unused CSS</h1>
      HTML

      stylesheets.each do |stylehseet|
        file.write "<h2>#{stylehseet.uri}</h2>"
        stylehseet.styles.each do |style|
          file.write <<-HTML
            <p>#{style}</p>
          HTML
        end
      end

      file.write <<-HTML
        </body></html>
      HTML

      file.close
    end
  end
end