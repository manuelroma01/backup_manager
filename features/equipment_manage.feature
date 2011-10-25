Feature: Equipment management
  In order to manage equipments
  As an authorized user
  I want correct crud operations for equipments
  Background:
    Given exists roles:
      | name |
      | root |
      And exists users:
      | username | password  | role_id |
      | root     | porfadmin | 1       |
      And exists equipments:
      | tag      | equipment_type | equipment_model   | ip_address    | mac_address       | location   | equipment_user |
      | IMW00548 | Desktop PC     | Dell Optiplex 960 | 172.20.32.125 | 01-46-4B-16-54-A5 | 180        | mrodriguez     |
      | IMW00658 | Printer        | HP Laserjet 3030  | 172.20.32.78  | 00-45-6F-E6-54-87 | 183.13A    |                |
      | IMW01010 | Laptop MAC     | Macbook Air       | 172.20.32.215 | 00-11-22-33-44-55 | 190        | MCC-spain      |
      And I login as user "root" with password "porfadmin"
      And I am on the home page

  # listar equipos
  Scenario: list equipments
    Given I am on the home page
    When I follow "Equipments"
    Then I should be on the equipments page
      And I should see the following table rows:
      | IMW00548 | Desktop PC     | Dell Optiplex 960 | 172.20.32.125 | 01-46-4B-16-54-A5 | 180        | mrodriguez     |
      | IMW00658 | Printer        | HP Laserjet 3030  | 172.20.32.78  | 00-45-6F-E6-54-87 | 183.13A    |                |
      | IMW01010 | Laptop MAC     | Macbook Air       | 172.20.32.215 | 00-11-22-33-44-55 | 190        | MCC-spain      |

  # crear nuevo equipo
  Scenario: go to new equipment
    Given I am on the equipments page
    When I follow "New equipment"
    Then I should be on the new equipment page
      And I should see "New equipment" within "h2"
      
  Scenario: create new equipment
    Given I am on the new equipment page
    When I fill in "equipment_tag" with "IMW01090"
      And I fill in "equipment_equipment_type" with "Laptop PC"
      And I fill in "equipment_equipment_model" with "Lenovo 510"
      And I fill in "equipment_ip_address" with "172.20.32.150"
      And I fill in "equipment_mac_address" with "55-66-77-88-99-00"
      And I fill in "equipment_location" with "Postdocs"
      And I fill in "equipment_equipment_user" with "pfigueras"
      And I press "OK"
    Then I should be on the "IMW01090" show equipment page
      And I should see "IMW01090" within "h2"
      And I should see "Equipment IMW01090 created" within "div"
      
  # mostrar equipo
  Scenario: show equipment
    Given I am on the equipments page
    When I follow "IMW00548"
    Then I should be on the "IMW00548" show equipment page
      And I should see "IMW00548" within "h2"
      
  # editar equipo
  Scenario: edit equipment
    Given I am on the "IMW00658" show equipment page
    When I follow "Edit"
    Then I should see "Edit equipment: IMW00658" within "h2"

  Scenario: modify equipment
    Given I am on the "IMW00658" edit equipment page
    When I fill in "equipment_tag" with "IMW01095"
      And I fill in "equipment_equipment_type" with "Laptop PC"
      And I fill in "equipment_equipment_model" with "Lenovo 510"
      And I fill in "equipment_ip_address" with "172.20.32.134"
      And I fill in "equipment_mac_address" with "55-66-77-64-99-00"
      And I fill in "equipment_location" with "Postdocs"
      And I fill in "equipment_equipment_user" with "pfigueras"
      And I press "OK"
    Then I should be on the "IMW01095" show equipment page
      And I should see "IMW01095" within "h2"
      And I should see "Equipment IMW01095 updated" within "div"

  # borrar equipo
  Scenario: destroy equipment
    Given I am on the "IMW00548" show equipment page
    When I follow "Delete"
    Then I should be on the equipments page
      And I should see "Equipment IMW00548 deleted" within "div"
      And I should not see the following table rows:
      | IMW00548 | Desktop PC     | Dell Optiplex 960 | 172.20.32.125 | 01-46-4B-16-54-A5 | 180        | mrodriguez     |

