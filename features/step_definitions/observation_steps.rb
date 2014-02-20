Then "I should see '$text'" do |text|
  fail "Can't find #{text}" unless $browser.text.include? text
end

Then "I should see style '$style' was used" do |style|
  fail "#{style} style was not used" if $unused_styles.include? style
end

Then "I should see style '$style' was not used" do |style|
  fail "#{style} style was used" unless $unused_styles.include? style
end