Feature: Every page will be checked for the following regions, elements and functions
  In order to ensure that the content on all sites exist,
  As an end user
  I want to check whether the content exists

  @safe
  Scenario: Verify that the logo exists in the header region of the homepage
    Given I am on the homepage
    Then I should see the "img" element in the "Header" region

  @safe
  Scenario: See the nav bar region
    Given I am on the homepage
    Then I should see an "#main-nav" element

  @safe
  Scenario: See the li element in the nav bar region
    Given I am on the homepage
    Then I should see the "li" element in the "Main Navigation" region

  @safe
  Scenario: See the search region
    Given I am on the homepage
    Then I should see an "#nav-search" element

  @safe
  Scenario: See the content body region
    Given I am on the homepage
    Then I should see an "#content-body" element

  @safe
  Scenario: See the footer region
    Given I am on the homepage
    Then I should see an "#footer" element

  @safe
  Scenario: Verify that /user page has the appropriate content
    Given I am on "user"
    Then I should see the text "Login"

  @safe @javascript
  Scenario: Verify that the search field exists on the homepage
    Given I am on the homepage
    Then I should see a "#edit-search-block-form--2" element

  @safe @javascript
  Scenario: Verify that the search element works
    Given I am on "search/node"
    Then I should see "Search" in the "Content Head" region
    And I should see "Enter your keywords"
    When I enter "purple monkey dishwasher" for "edit-keys"
    And I click on the element with css selector "#edit-submit"
    Then I should be on "search/node/purple%20monkey%20dishwasher"
    And I should see "Search" in the "Content Head" region
    And I should see "Remove quotes"
