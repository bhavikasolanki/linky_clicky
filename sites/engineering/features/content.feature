Feature: Content
  In order to ensure that the School of Engineering website has the correct content
  As an end user
  I want to check for the existence of content that should appear

@safe
Scenario Outline: Homepage block and footer content
  Given I am on the homepage
  Then I should see the "<Header>" heading in the "<Region>" region

  Examples:
  | Header               | Region                |
  | Recent News          | Content 3 column flow |
  | Research             | Content 3 column flow |
#  | Department Bookshelf | Main Lower            |
#  | Degrees and Courses  | Footer                |
#  | News & Events        | Footer                |
#  | Affiliated Programs  | Footer                |

#Scenario: About page content
#  Given I am on "about"
#  Then I should see "One of the founding departments of Stanford University in 1891, the English department is the cornerstone of the humanities at Stanford" in the "Content Body" region

#Scenario: People page content
#  Given I am on "people"
#  Then I should see "John Bender" in the "Content Body" region

#Scenario: People page search
#  Given I am on "people"
#  When I fill in "Search faculty by name" with "Cohen"
#  And I press "Go"
#  Then I should see "Margaret Cohen" in the "Content Body" region

#Scenario: Courses page content
#  Given I am on "courses"
#  Then I should see the heading "Current Courses" in the "Content" region

#Scenario: Degree Programs page content
#  Given I am on "degree-programs/overview-degree-programs"
#  Then I should see "Stanford’s English curriculum features a team-taught, yearlong core sequence" in the "Content Body" region

#Scenario: Department Bookshelf page content
#  Given I am on "bookshelf"
#  Then I should see the heading "Faculty Publications" in the "Content Body" region

#Scenario: News page content
#  Given I am on "news"
#  Then I should see the heading "Wilfred Stone, professor emeritus of English passes away at 97" in the "Content" region

#Scenario: Events page content
#  Given I am on "events"
#  Then I should see the heading "Upcoming Events" in the "Content Body" region
#  And I should see "View Past Events" in the "Content Body" region
