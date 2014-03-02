Unused CSS
==========

[![Build Status](https://travis-ci.org/christemple/unused-css.png?branch=master)](https://travis-ci.org/christemple/unused-css)

A Ruby gem, built from a need, to watch a suite of functional tests and gather all of the unused CSS styles.

Limitations
-----------

Unused CSS currently only works with Watir webdriver, I will be adding more webdrivers soon.

How to use
----------

Here's a typical 'features/support/env.rb' file using Unused CSS to watch the Watir webdriver as it runs your functional tests:

```ruby
require "watir-webdriver"
require "unused_css"

$browser = Watir::Browser.new
$unused_css = UnusedCSS::Watcher.new
$unused_css.watch! $browser

at_exit do
  $browser.close
  
  # A list of all stylehseets together with their unused styles
  puts "Unused CSS"
  $unused_css.stylesheets.each do |stylesheet|
    puts stylesheet.uri
    stylesheet.styles.each { |style| puts style }
  end
  
end
```


TODO
----

There are still a few things I am looking to do with this Ruby gem.
- Add support for more web drivers.
- Add ability to create report after watching the tests.
- ...not sure, you tell me :)


Feedback
--------
Please send me a message or an email and let me know what you think.

Chris Temple
