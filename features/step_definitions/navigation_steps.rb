require "css_parser"

Given "I go to the home page" do
  $browser.goto('http://localhost:3000')
  stylesheet = $browser.element(tag_name: 'link').attribute_value('href')

  parser = CssParser::Parser.new
  parser.load_uri! stylesheet
  parser.each_selector { |selector| $unused_styles << selector }

  parser.each_selector do |selector|
    $unused_styles.delete selector if $browser.element(css: selector).exist?
  end
end
