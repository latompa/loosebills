Given /^I have a positive balance$/ do
  @starting_balance = 200
  @account = @user.create_account :balance => @starting_balance
  @account.save
end

Given /^I have a zero balance$/ do
  @starting_balance = 0
  @account = @user.create_account :balance => @starting_balance
  @account.save
end
