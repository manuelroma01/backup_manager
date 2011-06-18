Feature: Login and logout
  In order to access to website
  As an registered user
  I want log in and log out successfully
  
  Scenario: Login
    Given I login as:
    | username | password  |
    | seeduser | porfaplis |
    Then I should be on the home page
      And I should see "Signed in successfully." within "div"
      And I should see "Signed in as seeduser"
  
  Scenario: Logout
    Given I login as:
    | username | password  |
    | seeduser | porfaplis |
    When I follow "Sign out"
    Then I should be on the home page
      And I should see "Signed out successfully." within "div"
      And I should not see "Signed in as" within "nav"
