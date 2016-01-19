@contrib
Feature: Feeds XPath Parser
  In order to ensure that upgrades do not break existing functionality
  As an administrative user
  I want to ensure that the Feeds XPath Parser module is working properly

  @api @dev @destructive @javascript
  Scenario: Feeds XPath Parser
    Given the cache has been cleared
    And the "feeds_xpathparser" module is enabled
    And the "feeds_ui" module is enabled
    And the cache has been cleared
    And I am logged in as a user with the "administrator" role
    And I am on "admin/structure/feeds"
    When I click "Add importer"
    And I enter "Foo" for "Name"
    And I press the "Create" button
    And I go to "admin/structure/feeds/foo/settings/FeedsNodeProcessor"
    And I select "Basic page" from "Bundle"
    And I press the "Save" button
    And I go to "admin/structure/feeds/foo/parser"
    And I select the radio button "Select" with the id "edit-plugin-key--7"
    And I press the "Save" button
    And I go to "admin/structure/feeds/foo/settings/FeedsXPathParserXML"
    Then I should see "Settings for XPath XML parser"
    When I go to "admin/structure/feeds/foo/mapping"
    And I select "XPath Expression" from "Source"
    And I select "Body" from "Target"
    And I press the "Save" button
    Then I should see "Mapping has been added"
    And I should see "Your changes have been saved"
    When I go to "admin/structure/feeds/foo/settings/FeedsXPathParserXML"
    And I enter "//foo/bar" for "Context"
    And I enter "baz" for "Body"
    And I press the "Save" button
    Then I should see " Your changes have been saved"
    When I go to "admin/structure/feeds/foo/delete"
    And I press the "Delete" button
    Then I should be on "admin/structure/feeds"
    And I should not see "Foo"
