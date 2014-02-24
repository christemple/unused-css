Given(/^I open the report html file$/) do
  $browser.goto "file://#{Dir.pwd}/report/index.html"
end