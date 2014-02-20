require "watir-webdriver"

system "rake"

$browser = Watir::Browser.new

$unused_styles = Set.new

at_exit do
  $browser.close
end
