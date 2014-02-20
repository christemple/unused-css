Given "I go to the home page" do
  $browser.goto('http://localhost:3000')
  stylesheet = $browser.element(tag_name: 'link').attribute_value('href')

  $unused_css.add_stylesheet stylesheet
  $unused_css.stylesheet(stylesheet).styles.each do |style|
    $unused_css.stylesheet(stylesheet).styles.delete(style) if $browser.element(css: style).exist?
  end
end

Given "I go to a page with 2 stylesheets" do
  $browser.goto('http://localhost:3000/multiple')
  stylesheets = $browser.elements(tag_name: 'link').map {|stylesheet| stylesheet.attribute_value('href') }

  $unused_css.add_stylesheets stylesheets
  stylesheets.each do |stylesheet|
    $unused_css.stylesheet(stylesheet).styles.each do |style|
      $unused_css.stylesheet(stylesheet).styles.delete(style) if $browser.element(css: style).exist?
    end
  end
end
