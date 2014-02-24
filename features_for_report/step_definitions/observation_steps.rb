Then "I should see '$text'" do |text|
  fail "Can't find #{text}" unless $browser.text.include? text
end

Then "I should not see '$text'" do |text|
  fail "Found #{text}" if $browser.text.include? text
end