Then "I should see '$text'" do |text|
  fail "Can't find #{text}" unless $browser.text.include? text
end

Then "I should see style '$style' was used" do |style|
  fail "#{style} style was not used" if $unused_css.stylesheets.styles.include? style
end

Then "I should see style '$style' was not used" do |style|
  fail "#{style} style was used" unless $unused_css.stylesheets.styles.include? style
end

When(/^I wait for content to be loaded into the DOM via AJAX$/) do
  $browser.div(id: "ajaxed-content").wait_until_present
end

When(/^I recheck the styles on the page$/) do
  $browser.check_for_unused_styles!
end