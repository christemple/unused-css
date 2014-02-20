require "watir-webdriver"
require_relative "../../lib/unused_css"

system "rake"

Before do
  $browser = Watir::Browser.new
  $unused_css = UnusedCSS.new
  $unused_css.watch! $browser
end

at_exit do
  $browser.close
end
