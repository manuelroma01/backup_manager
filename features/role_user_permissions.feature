Feature: User management
  In order to manage users
  As an admin user
  I want correct crud operations for users
  
  Background:
    Given exists roles:
      | name |
      | root |
      | user |
      And exists users:
      | username | password  | role_id |
      | root     | porfadmin | 1       |
      | seeduser | porfaplis | 2       |
      And I login as user "seeduser" with password "porfaplis"
      And I am on the home page
      
  Scenario: Equipments - Grant
    Given I am on the home page
    Then I should see "Equipments"
  
  Scenario: Users - Deny
    Given I am on the home page
    Then I should not see "Users"

