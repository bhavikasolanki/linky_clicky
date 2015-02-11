Feature: Administration Menu
  In order to ensure that upgrades do not break existing functionality
  As an administrative user
  I want to ensure that the Administration Menu module is working properly

  @api @javascript
  Scenario: Administration Menu
    Given the "admin_menu" module is enabled
    And I am logged in as a user with the "administrator" role
    And I am on the homepage
    Then I should see a "#admin-menu" element
    When I go to "admin/content"
    Then I should see a "#admin-menu" element
    When I go to "admin/config/administration/admin_menu"
    Then I should see "The administration menu module provides a dropdown menu"
    And the "Adjust top margin" checkbox should be checked
    And the "Keep menu at top of page" checkbox should be checked
    And the "Icon menu" checkbox should be checked
    And the "Administration menu" checkbox should be checked
    And the "Search bar" checkbox should be checked
    And the "User counts" checkbox should be checked
    And the "Account links" checkbox should be checked
    And the "Shortcuts" checkbox should not be checked
