Feature: Homepage
  In order to ensure that the Jumpstart Academic website has the correct content
  As an end user
  I want to check for the existence of content that should appear

  @api
  Scenario: Enable the Palm News and Events homepage layout as administrator
    Given I am logged in as a user with the "administrator" role
    And I am on "admin/stanford-jumpstart/customize-design"
    Then I press the "edit-layouts-stanford-jumpstart-home-palm-news-events-selector" button

  Scenario Outline: Header content
    Given I am on the homepage
    Then I should see the "<Header>" heading in the "<Region>" region

  Examples:
    | Header                | Region |
    | Connect               | Footer |
    | Contact Us            | Footer |
    | Optional Footer Block | Footer |
    | Related Links         | Footer |

  Scenario Outline: Homepage content
    Given I am on the homepage
    Then I should see "<Text>" in the "<Region>" region

  Examples:
    | Text | Region |
    | Feature a tagline or website subtitle here | Main Top |
    | To edit the block and remove this placeholder content | Main Top |
    | Add a video, image, or other featured content to this block. | Main Top |
    | Building Name Room 555 | Footer |
    | This is your Optional Footer Block | Footer   |

  Scenario: Homepage video block
    Given I am on the homepage
    Then I should see an "iframe" element

  Scenario Outline: Homepage links
    Given I am on the homepage
    Then I should see the link "<Link>" in the "<Region>" region

  Examples:
    | Link                 | Region   |
    | About us             | Main Top |
    | Facebook             | Footer   |
    | Twitter              | Footer   |
    | GooglePlus           | Footer   |
    | LinkedIn             | Footer   |
    | YouTube              | Footer   |
    | Vimeo                | Footer   |
    | Tumblr               | Footer   |
    | Pinterest            | Footer   |
    | Flickr               | Footer   |
    | sunetid@stanford.edu | Footer   |
    | Campus Map           | Footer   |
    | Stanford University  | Footer   |
    | Research at Stanford | Footer   |
    | Stanford News        | Footer   |
