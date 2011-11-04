Feature: User management
  In order to manage users
  As an admin user
  I want correct crud operations for users
  
  Background:
    Given exists root:
      | username | password  |
      | root     | porfadmin |
      And exists users:
      | username | password  |
      | testuser | porfaplis |
      And I login as user "testuser" with password "porfaplis"
      And I am on the home page
      
  Scenario: Equipments - Grant
    Given I am on the home page
    Then I should see "Equipments"
  
  Scenario: Users - Deny
    Given I am on the home page
    Then I should not see "Users"

