# Overview
Then /^I should see all of the gadgets that I've created$/ do
  Gadget.all.each do |g|
    assert page.has_content?(g.name)
  end  
end

Given /^I have a gadget called "([^"]*)"(?: that weighs (\d+) (\w+))?$/ do |gadget_name, weight, weight_unit|
  options = {:name => gadget_name}
  weight and weight_unit and options.merge!(:weight => weight, :weight_unit => weight_unit)
  Factory :gadget, options
end

When /^I click "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should be viewing the gadget detail page for "([^"]*)"$/ do |gadget_name|
  @gadget = Gadget.find_by_name(gadget_name)
  steps %Q{Then I should be on the detail page for that gadget}
end

# Detail
Given /^I am viewing the gadget detail page for "([^"]*)"$/ do |gadget_name|
  gadget = Gadget.find_by_name(gadget_name)
  visit(detail_gadget_path(gadget))
end

Then /^I should see that "([^"]*)" weighs (\d+) (\w+)$/ do |gadget_name, weight, weight_unit|
  gadget = Gadget.find_by_name(gadget_name)
  within("##{gadget.verbose_id}") do
    assert page.has_content?(gadget.complete_weight)
  end
end

When /^I add a part called "([^"]*)" to "([^"]*)"$/ do |arg1, arg2|
  steps %Q{
    When I fill in "New Part Name" with "#{arg1}"
    And I press "Add Part"
  } 
end

Then /^I should (receive|see) a notice saying that the part was successfully (added|deleted)/ do |ignore_me, add_delete|
  steps %Q{ 
    Then I should see "The part was successfully #{add_delete}."
  }
end

Then /^I should (not )?see "([^"]*)" within the parts for "([^"]*)"$/ do |non, arg1, arg2|
  steps %Q{
    Then I should #{non}see "#{arg1}" within ".parts"
  }
end

Given /^"([^"]*)" has a part called "([^"]*)"$/ do |arg1, arg2|
  Gadget.find_by_name(arg1).parts.create( { :name => arg2 } )
end

When /^I delete the "([^"]*)" part from "([^"]*)"$/ do |arg1, arg2|
  steps %Q{
    When I follow "Delete #{arg1}"
  }
end




