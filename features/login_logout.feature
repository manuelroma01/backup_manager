Feature: Login and logout
  In order to access to website
  As an registered user
  I want log in and log out successfully

  Background:
    Given exists roles:
      | name |
      | root |
      | user |
      And exists users:
      | username | password  | role_id |
      | seeduser | porfaplis | 2       |
  
  Scenario: Login
    Given I login as user "seeduser" with password "porfaplis"
    Then I should be on the home page
      And I should see "Signed in successfully." within "div"
      And I should see "Signed in as seeduser"
  
  Scenario: Logout
    Given I login as user "seeduser" with password "porfaplis"
    When I follow "Sign out"
    Then I should be on the home page
      And I should see "Signed out successfully." within "div"
      And I should not see "Signed in as" within "nav"
      
  Scenario: Lock user after 3 failed attempts
  
  Scenario: Unlock user using administrador rights
