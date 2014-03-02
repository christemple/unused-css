require "watir-webdriver"
require "unused_css"

system "rake"

$browser = Watir::Browser.new
$unused_css = UnusedCSS::Watcher.new
$unused_css.watch! $browser

at_exit do
  $browser.close
end
