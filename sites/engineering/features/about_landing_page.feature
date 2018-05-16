Feature: Ensure items on the About landing page appear as expected
  In order to ensure items on the About landing page appear as expected
  As a Site User
  I want to be able to view all the About landing page blocks in their appropriate regions

  @safe
  Scenario: Verify users can view the top banner
    Given I am on "about"
    Then I should see the "img" element in the "Top Full Width" region
    Then I should see 1 or more ".image-style-full-width-banner-short" elements

  @safe
  Scenario: Verify users can view all the blocks
    Given I am on "about"
    Then I should see 3 or more ".bean-stanford-call-to-action" elements
    Then I should see 1 or more ".bean-stanford-postcard-linked" elements
    Then I should see 1 or more ".block-views" elements

  @safe
  Scenario: Verify users can view the WYSIWYG text
    Given I am on "about"
    Then I should see a ".field-name-body" element
    Then I should see the text "Stanford Engineering has been"
    Then I should see the text "More about SoE-Future"

  @safe
  Scenario: Verify users can view the first postcard linked block
    Given I am on "about"
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-bean-about-visit-us-block" element

  @safe
  Scenario: Verify users can view the recent news view
    Given I am on "about"
    Then I should see a "a" element in the "Content Lower" region
    Then I should see a "#block-views-98ef3755ed7cc9ac83eba0d66243ce4c" element
