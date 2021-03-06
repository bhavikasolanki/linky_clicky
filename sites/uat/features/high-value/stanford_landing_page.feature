Feature: Stanford Landing Page
  In order to ensure that upgrades do not break existing functionality
  As an administrative user
  I want to ensure the Stanford Landing Page module is working properly

  @api @dev @javascript @destructive
  Scenario: Create Landing Page
    Given the "stanford_landing_page" module is enabled
    And the "stanford_landing_page_fc_link_formatter" module is enabled
    And the "stanford_landing_page_fc_link_heading_formatter" module is enabled
    And the "stanford_landing_page_node_convert" module is enabled
    When I am logged in as a user with the "administrator" role
    And I go to "node/add/stanford-landing-page"
    Then I should see "Create Landing Page" in the "Branding" region
    Then I fill in "edit-title" with "Foo Stanford Landing Page"
    And I select "Blocks" from "Layout"
    Then I fill in "edit-field-landing-page-item-und-0-field-s-lp-item-title-und-0-value" with "LPITEM"
    Then I click on the element with css selector "a.fieldset-title" with javascript
    Then I wait 2 seconds
    Then I fill in "field_landing_page_item[und][0][field_s_lp_item_link][und][0][title]" with "Primary link"
    Then I fill in "field_landing_page_item[und][0][field_s_lp_item_link][und][0][url]" with "https://www.stanford.edu"
    And I press the "Save" button
    Then I should see "Landing Page Foo Stanford Landing Page has been created"
    And I should be on "foo-stanford-landing-page"
    Then I should see 1 or more ".view-mode-stanford_4_col_header" elements
    # The view mode changes change the display.
    Then I click "Edit"
    And I select "List" from "Layout"
    And I press the "Save" button
    Then I should see 1 or more ".view-mode-stanford_medium_square" elements

    Then I click "Edit"
    And I select "Cards" from "Layout"
    And I press the "Save" button
    Then I should see 1 or more ".view-mode-large_landscape" elements

  # Field formatter modules have been enabled
  @api @safe
  Scenario: Field formatter modules have been enabled and are on view modes
    Given I am logged in as a user with the "administrator" role

    And I am on "admin/structure/field-collections/field-landing-page-item/display"
    Then I should see "Title"
    Then I should see "Image"
    Then I should see "Description"
    Then I should see "Primary Link"
    Then I should see "Secondary Links"

    And I am on "admin/structure/field-collections/field-landing-page-item/display/stanford_4_col_header"
    Then I should see "Block Style"
    Then I should see "More Link Style"
    Then I want to validate select field option "edit-fields-field-s-lp-item-title-type" default is "Link Heading - Stanford Landing Page"
    Then I want to validate select field option "edit-fields-field-s-lp-item-image-type" default is "Image - Stanford Landing Page"

    And I am on "admin/structure/field-collections/field-landing-page-item/display/stanford_medium_square"
    Then I should see "Postcard Image"
    Then I should see "Link Style"
    Then I want to validate select field option "edit-fields-field-s-lp-item-title-type" default is "Link Heading - Stanford Landing Page"
    Then I want to validate select field option "edit-fields-field-s-lp-item-image-type" default is "Image - Stanford Landing Page"

    And I am on "admin/structure/field-collections/field-landing-page-item/display/large_landscape"
    Then I should see "Card Link Style"
    Then I should see "Card Style"
    Then I want to validate select field option "edit-fields-field-s-lp-item-title-type" default is "Link Heading - Stanford Landing Page"
    Then I want to validate select field option "edit-fields-field-s-lp-item-image-type" default is "Image - Stanford Landing Page"

  # The correct fields are on the landing page
  @api @safe
  Scenario: The correct fields are on the landing page
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/structure/types/manage/stanford-landing-page/fields"
    Then I should see "Title"
    Then I should see "Layout"
    Then I should see "Banner Image"
    Then I should see "Lead Text"
    Then I should see "Body"
    Then I should see "Landing Page Item"

  # The manage view is available
  @api @safe
  Scenario: The manage view is available
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/manage/landing-page"
    Then I should see the heading "Manage Landing Page"
