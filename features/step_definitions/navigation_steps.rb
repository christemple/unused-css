Given "I go to the home page" do
  $browser.goto('http://localhost:3000')
end

Given "I go to the home page again" do
  $browser.goto('http://localhost:3000')
end

Given "I go to a page with 2 stylesheets" do
  $browser.goto('http://localhost:3000/multiple')
end
