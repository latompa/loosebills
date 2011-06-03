When /^I follow an amount choice$/ do
  click_link("$40")
end

Then /^I should not see any clickable withdrawal choices$/ do
  page.should_not have_link "$40"
  page.should have_content "$40"
end

Then /^I should see the cash$/ do
  steps %Q{
    Then I should see "Please take your cash"
    And I should see "$40"
  }
end

Then /^my account should be debited$/ do
  @account.reload
  @account.balance.should == (@starting_balance - 40)
end
