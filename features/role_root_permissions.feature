Feature: User management
  In order to manage users
  As an admin user
  I want correct crud operations for users
  
  Background:
    Given I login as user "root" with password "porfadmin"
      And I am on the home page
      
  Scenario: Main menu options
    Given I am on the home page
    Then I should see "Equipments"
      And I should see "Users"

