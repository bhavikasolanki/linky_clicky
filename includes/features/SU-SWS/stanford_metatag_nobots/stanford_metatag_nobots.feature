@stanford
Feature: Stanford MetaTag NoBots
  In order to ensure that upgrades do not break existing functionality
  As an administrative user
  I want to ensure that the Stanford MetaTag NoBots module is working properly

  @api @dev @safe
  Scenario: Stanford MetaTag NoBots
    And the cache has been cleared
    And I am on the homepage
    Then the response header "X-Robots-Tag" should contain "noindex,nofollow,noarchive"

  @api @prod @safe
  Scenario: Stanford MetaTag NoBots
    And the cache has been cleared
    And I am on the homepage
    Then the response header should not have "X-Robots-Tag"
