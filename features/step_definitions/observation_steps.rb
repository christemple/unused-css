Then "I should see '$text'" do |text|
  fail "Can't find #{text}" unless $browser.text.include? text
end
