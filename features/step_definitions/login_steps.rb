# Given -----------------------------------
Given /^exists root:$/ do |table|
  if Role.find_by_name('root').users.count == 0
    table.hashes.each do |hash|
      @admin = Factory(:user_root, hash)
    end
  end
end

Given /^exists users:$/ do |table|
  table.hashes.each do |hash|
    @user = Factory(:user, hash)
  end
end

Given /^I login as user "([^"]*)" with password "([^"]*)"$/ do |username, password|
  And %{I go to the sign_in page}
  And %{I fill in "user_username" with "#{username}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end
