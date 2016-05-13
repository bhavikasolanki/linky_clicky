Feature: Stanford Private Page
  In order to ensure that the Stanford Private Page as administrator I want to verify I can create a private page.

  @api @dev @destructive
  Scenario: Adminstrator can create and edit Private Page types
    Given I am logged in as a user with the "administrator" role
    When I go to "node/add/stanford-private-page"
    Then I should see "Create Private Page" in the "Branding" region
    Then I fill in "edit-title" with "Bar"
    Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field-s-image-info-und-0-field-s-image-image-und-0-upload"
    Then I press "Upload"
    Then I press "Save"
    Then I should be on "private/bar"
    Then I go to "admin/manage/private-page"
    Then I click on the element with css selector ".views-row-first .views-field-title a"
    Then I click "Edit" in the "Tabs" region
    Then I press "Save"
    And I should see "Bar" in the "Content Head" region

  @api @safe
  Scenario: As a administrator I can see Create Private Page
    Given I am logged in as a user with the "administrator" role
    When I go to "node/add/stanford-private-page"
    Then I should see "Create Private Page" in the "Branding" region