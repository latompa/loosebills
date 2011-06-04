When /^I follow an amount choice$/ do
  click_link("$40")
end

Then /^I should not see any clickable withdrawal choices$/ do
  ["$20","$40", "$80", "$100", "120"].each do |amount|
    page.should_not have_link amount
    page.should have_content amount
  end
end

Then /^I should see the cash$/ do
  steps %Q{
    Then I should see "Please take your cash"
  }
  page.has_selector?("li.bill_20", :count => 2).should be_true
end

Then /^my account should be debited$/ do
  @account.reload
  @account.balance.should == (@starting_balance - 40)
end
