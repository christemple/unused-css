Unused CSS
==========

[![Build Status](https://travis-ci.org/christemple/unused-css.png?branch=master)](https://travis-ci.org/christemple/unused-css)

A Ruby gem that will watch a suite of functional tests running and gather all of the unused CSS styles.

Install
-------

```ruby
gem install unused_css
```


How to use
----------

Here's a typical 'features/support/env.rb' file using Unused CSS to watch the Watir webdriver as it runs your functional tests:

```ruby
require "watir-webdriver"
require "unused_css/watir"

$browser = Watir::Browser.new

at_exit do
  $browser.close
  
  # A list of all stylehseets together with their unused styles
  puts "Unused CSS"
  $browser.stylesheets.each do |stylesheet|
    puts stylesheet.uri
    stylesheet.unused_styles.each { |style| puts style }
  end
  
end
```

How it works
------------

Unused CSS will override the 'goto' method on Watir webdriver.  After going to the specified web page, it will grab any
new stylesheets it may have found and scan all stylesheets it knows about removing any used css found on the page.


Checking for unused css/styles on your terms (AJAX scenario)
----------

I thought it would be nice to also put you in control of when you want to check for used styles on a page.
A page that relies on AJAX to dynamically load content will likely benefit from being able to do so.

In one of your step definitions you can simply call:

```ruby
When(/^I recheck the styles on the page$/) do

    # Where $browser is an instance of Watir webdriver
    $browser.check_for_unused_styles!
end
```

Limitations
-----------

Unused CSS currently only works with Watir webdriver, I will be adding more webdrivers soon.

Feedback
--------
Please send me a message or an email and let me know what you think.

Chris Temple
