Feature: special_menu_items administration module
  In order to have an organized menu
  As administrator
  I want to add heading text or a separator

  Background:
    Given I am logged in as a user with the "administrator" role

  @safe @api
  Scenario: Verify special_menu_items module is enabled
    And I am on "admin/modules"
    Then I should see 1 "#edit-modules-context-context-http-header-enable" element
    And the "modules[Context][context_http_header][enable]" checkbox should be checked

  @dev @api @javascript @destructive
  Scenario: Verify that there is a menu
    And the cache has been cleared

  Scenario: Verify that I can add a header that is not clickable
  
  Scenario: Verify that I can add menu items that are clickable below the header
  
  Scenario: Verify that I can add a horizontal rule
  
  Scenario: Verify that I can add menu items that are clickable below the horizontal rule 
