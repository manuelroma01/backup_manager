Feature: User manage
  In order to manage users
  As an root user
  I want correct crud operations for users
  
  Background:
    Given exists users:
      | username | password  |
      | root     | porfadmin |
      | seeduser | porfaplis |
      | user2    | password2 |
      And I login as user "user2" with password "password2"
      And I am on the home page
   
  # listar usuarios
  Scenario: list users
    Given I am on the home page
    When I follow "Users"
    Then I should be on the users page
      And I should see the following table rows:
        | root     |
        | seeduser |
        | user2    |

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
      
  # editar usuario
  Scenario: edit user
    Given I am on the "seeduser" show user page
    When I follow "Edit"
    Then I should see "Editar usuario: seeduser" within "h2"

  Scenario: modify user
    Given I am on the "seeduser" edit user page
    When I fill in "user_username" with "cucumber user"
      And I fill in "user_email" with "cucumber@user.com"
      And I fill in "user_password" with "porfaplis"
      And I fill in "user_password_confirmation" with "porfaplis"
      And I press "Aceptar"
    Then I should be on the "cucumber user" show user page
      And I should see "Usuario: cucumber user" within "h2"
      And I should see "Usuario cucumber modificado" within "div"
  
