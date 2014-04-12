Then "I should see '$text'" do |text|
  fail "Can't find #{text}" unless $browser.text.include? text
end

Then "I should see style '$style' was used" do |style|
  fail "#{style} style was not used" if $browser.stylesheets.unused_styles.include? style
end

Then "I should see style '$style' was not used" do |style|
  fail "#{style} style was used" unless $browser.stylesheets.unused_styles.include? style
end

When "I wait for content to be loaded into the DOM via AJAX" do
  $browser.div(id: "ajaxed-content").wait_until_present
end

When "I recheck the styles on the page" do
  $browser.check_for_unused_styles!
end

Then "css rule '$style' should be ignored" do |style|
  fail "#{style} style was not ignored" if $browser.stylesheets.unused_styles.include? style
end

Then "only one stylesheet should be checked for unused styles" do
  fail "More than 1 stylesheet is being checked!" unless $browser.stylesheets.size == 1
end

Then "only one stylesheet should be checked for unused styles again" do
  fail "More than 1 stylesheet is being checked!" unless $browser.stylesheets.size == 1
end
