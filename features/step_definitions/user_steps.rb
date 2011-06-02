Given /^I have set up a user$/ do
  @pin = "1234"
  @user = Factory(:user, :pin => @pin)
end

When /^I fill in login with correct details$/ do
  fill_in("Name", :with => @user.name)
  fill_in("Pin", :with => @pin)
  click_button("Login")
end

When /^I fill in login with incorrect details$/ do
  fill_in("Name", :with => @user.name)
  fill_in("Pin", :with => "4321")
  click_button("Login")
end

Then /^I should see a welcome user message$/ do
  steps %Q{ Then I should see "Welcome #{@user.name}" }
end

Then /^I should see a login incorrect message$/ do
  steps %Q{ Then I should see "Invalid PIN"}
end
