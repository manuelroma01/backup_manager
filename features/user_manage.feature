Feature: User management
  In order to manage users
  As an admin user
  I want correct crud operations for users
  
  Background:
    Given exists root:
      | username | name | surnames | password  |
      | root     | root |          | porfadmin |
      And exists users:
      | username | name | surnames | password  |
      | testuser | seed | user     | porfaplis |
      | user2    | user | two      | password2 |
      And I login as user "root" with password "porfadmin"
      And I am on the home page
   
  # listar usuarios
  Scenario: list users
    Given I am on the home page
    When I follow "Users"
    Then I should be on the users page
      And I should see the following table rows:
      | root     | root      | root |
      | testuser | seed user | user |
      | user2    | user two  | user |

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
      And I choose "user_role_id_2"
      And I fill in "user_password_confirmation" with "porfaplis"
      And I press "Aceptar"
    Then I should be on the "cucumber user" show user page
      And I should see "Usuario: cucumber user" within "h2"
      And I should see "Usuario cucumber user creado" within "div"
  
  # mostrar usuario
  Scenario: show user
    Given I am on the users page
    When I follow "testuser"
    Then I should be on the "testuser" show user page
      And I should see "Usuario: testuser" within "h2"
      
  # editar usuario
  Scenario: edit user
    Given I am on the "testuser" show user page
    When I follow "Edit"
    Then I should see "Editar usuario: testuser" within "h2"

  Scenario: modify user
    Given I am on the "testuser" edit user page
    When I fill in "user_username" with "cucumber user"
      And I fill in "user_email" with "cucumber@user.com"
      And I fill in "user_password" with "porfaplis"
      And I fill in "user_password_confirmation" with "porfaplis"
      And I press "Aceptar"
    Then I should be on the "cucumber user" show user page
      And I should see "Usuario: cucumber user" within "h2"
      And I should see "Usuario cucumber user modificado" within "div"
   
  # borrar usuario   
  Scenario: destroy user
    Given I am on the "testuser" show user page
    When I follow "Destroy"
    Then I should be on the users page
      And I should see "Usuario testuser eliminado" within "div"
      And I should not see the following table rows:
        | testuser |
  
  #evituar auto-destrucción de usuarios
  Scenario: avoid self-destroy
    Given I am on the "root" show user page
    When I follow "Destroy"
    Then I should be on the "root" show user page
      And I should see "El usuario no puede auto-destruirse" within "div"

