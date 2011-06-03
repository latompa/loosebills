Given /^I have set up a user$/ do
  @pin = "1234"
  @failed_logins = 0
  @user = Factory(:user, :pin => @pin)
end

Given /^the user has no more failed login attempts remaining$/ do
  @user.failed_logins = 2
  @user.save
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

Then /^I should see a login incorrect message with remaining tries$/ do
  steps %Q{ Then I should see "Invalid PIN, you have 2 attempts left"}
end

Then /^I should see a user locked out message$/ do
  steps %Q{ Then I should see "User is locked out due to too many login attempts"}
end
