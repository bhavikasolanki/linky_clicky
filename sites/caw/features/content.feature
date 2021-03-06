Feature: Content
  In order to ensure that the Cardinal at Work Website has the correct content
  As an end user
  I want to check for the existence of content that should appear

@safe @live @site
Scenario Outline: Homepage block and footer content
  Given I am on the homepage
  Then I should see the "<Header>" heading in the "<Region>" region
  Examples:
  | Header | Region |
  | Explore | Footer |
  | Connect | Footer |
  | Quick Links | Footer |
  | See Also | Footer |

@safe @live @site
Scenario: Benefits subsite
  Given I am on "benefits-rewards"
  Then I should see "My Offerings" in the "Main Navigation" region
  And I should see "Health" in the "Main Navigation" region
  And I should see "Retirement" in the "Main Navigation" region
  And I should see "WorkLife" in the "Main Navigation" region
  And I should see "Compensation" in the "Main Navigation" region
  And I should see "Sweeteners" in the "Main Navigation" region
  And I should see "My Benefits" in the "Main Navigation" region
  And I should see "Contact" in the "Main Navigation" region
  And I should see "Resources" in the "Main Navigation" region

@safe @live @site
Scenario: Learn & Grow subsite
  Given I am on "learn-grow"
  Then I should see "Get Started" in the "Main Navigation" region
  And I should see "Courses & Connections" in the "Main Navigation" region
  And I should see "Career Tools" in the "Main Navigation" region
  And I should see "Career Counseling" in the "Main Navigation" region
  And I should see "Tuition" in the "Main Navigation" region

@safe @live @site
Scenario: Manage & Lead subsite
  Given I am on "manage-lead"
  Then I should see "Recruit" in the "Main Navigation" region
  And I should see "Manage & Develop" in the "Main Navigation" region
  And I should see "Exit" in the "Main Navigation" region
  And I should see "Leadership Skills" in the "Main Navigation" region

@safe @live @site
Scenario: Connect subsite
  Given I am on "connect"
  Then I should see "Search Jobs" in the "Main Navigation" region

@safe @live @site
Scenario: Learn & Grow subsite
  Given I am on "learn-grow"
  Then I should see "Learn &" in the "Header" region
  Then I should see "Grow" in the "Header" region

@safe @live @site
Scenario: View "I want to..." block
  Given I am on "benefits-rewards"
  Then I should see a "#block-bean-i-want-to-block-on-benefits-rew" element
  And I should see a "#block-bean-sweeteners-short-branding-bloc" element
  And I should see a "#block-bean-caw-homepage-sweetener-carousel" element
  And I should see a ".view-cardinal-at-work-stanford-events-list" element

#
# BROKEN AND NEEDS A FIX
#
# @api @javascript @content
# Scenario: Create a News Highlight block
#   Given I am logged in as a user with the "site owner" role
#   And go to "node/add/stanford-page"
#   Then I fill in "edit-title" with "Test News Highlight Block"
#   Then I attach the file "img/ooooaaaahhh.jpg" to "edit-field_s_page_banner_image"
#   Then I press "Upload"
#   Then I fill in "edit-body" with "This is just a title to test div of news hightlight block"
#   Then I highlight in "edit-body" "test div of news hightlight block"
#   Then I click div in the WYSIWYG toolbar
#   Then select "Style" drop-down option "Highlight Block Right"
#   Then I press "OK"
#   Then I press "Save"
#   Then I should see "test div of news hightlight block" in the "Content Body"

