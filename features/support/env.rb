require "watir-webdriver"

system "rake"

$browser = Watir::Browser.new

at_exit do
  $browser.close
end
