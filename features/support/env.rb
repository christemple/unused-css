require "watir-webdriver"
require "unused_css/watir"

system "rake"

$browser = Watir::Browser.new

at_exit do
  $browser.close
end
