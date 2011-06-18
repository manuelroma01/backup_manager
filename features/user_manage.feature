Feature: User manage
  In order to manage users
  As an registered user
  I want correct crud operations for users
  
  Background:
    Given I login as:
      | username | password  |
      | seeduser | porfaplis |
      And I am on the home page
 
  Scenario: list users
    Given I am on the home page
    When I follow "Users"
    Then I should be on the users page
      And I should see "Usuarios" within "h2"
      And I should see "seeduser" within "td"

  # crear nuevo usuario
  Scenario: go to new user
    Given I am on the users page
    When I follow "Nuevo usuario"
    Then I should be on the new user page
      And I should see "Nuevo usuario" within "h2"
  
  Scenario: create new user
    Given I am on the new user page
    When I fill in "user_username" with "cucumber user"
      And I fill in "user_email" with "cucumber@user.com"
      And I fill in "user_password" with "porfaplis"
      And I fill in "user_password_confirmation" with "porfaplis"
      And I press "Aceptar"
    Then I should be on the "cucumber user" show user page
      And I should see "Usuario: cucumber user" within "h2"
      And I should see "Usuario cucumber user creado" within "div"
  
  # mostrar usuario
  Scenario: show user
    Given I am on the users page
    When I follow "seeduser"
    Then I should be on the "seeduser" show user page
      And I should see "Usuario: seeduser" within "h2"

