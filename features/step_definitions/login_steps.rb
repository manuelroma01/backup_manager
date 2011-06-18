# Given -----------------------------------
Given /^I login as:$/ do |table|
  table.hashes.each do |hash|
    @user = Factory(:user, hash)
  end
  
  And %{I go to the sign_in page}
  And %{I fill in "user_username" with "#{@user.username}"}
  And %{I fill in "user_password" with "#{@user.password}"}
  And %{I press "Sign in"}
end
