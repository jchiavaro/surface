Given /^(?:|I )am on (.+)$/ do |page_name|
  visit "/"
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |value, field|
    fill_in(field, :with => value)
end

When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    fill_in(name, :with => value)
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
    select(value, :from => field)
end

When /^(?:|I )select "([^"]+)" as the "([^"]+)" date$/ do |date, selector|
  select_date(date, :from => selector)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
    choose(field)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  ActionMailer::Base.delivery_method = :test
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.deliveries.clear
  click_button(button)
end

Then /I should see "(.+)"$/ do |text|
  page.should have_content(text)
end

And /I should receive a welcome email/ do
  @email = ActionMailer::Base.deliveries.first
  @email.from.should == ["notifications@surface.com"]
  @email.to.should == ["jsmith@domain.com"]
  @email.encoded.should =~ /jsmith/
end
