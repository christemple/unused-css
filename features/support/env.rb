require "watir-webdriver"
require "unused_css/watir"

system "rake"

$browser = Watir::Browser.new

at_exit do
  $browser.close

  puts "==================="
  puts "Unused CSS"
  puts "===================\n\n"
  $browser.stylesheets.each do |stylesheet|
    puts stylesheet.uri
    puts "-------------------------------"
    stylesheet.unused_styles.each do |style|
      puts "\t#{style}"
    end
  end
end
