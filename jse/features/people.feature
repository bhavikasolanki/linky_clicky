Feature: People
  In order to ensure that the Jumpstart Academics website people are viewable
  As an end user
  I want to check for the existence of people content

  @content @live
  Scenario: List of faculty
    Given I am on "people/faculty"
    Then I should see a ".views-row-first" element
    And I should see a ".views-row-lines" element
    And I should see the heading "Why I Teach" in the "First sidebar" region
    And I should see the "People" heading in the "First sidebar" region
    And I should see "This is your Why I Teach block" in the "First sidebar" region

  @content @live
  Scenario: Faculty node
    Given I am on "people/faculty"
    And I click "Jacob Smith" in the "Content Body" region
    Then I should see "Professor of English" in the "Content Body" region

  @content @live
  Scenario: Faculty taxonomy filter
    Given I am on "people/faculty"
    When I select "Professor" from "Filter by faculty status"
    And I press "Go"
    Then I should see "Jacob Smith" in the "Content Body" region
    And I should not see "Jane Doe" in the "Content Body" region

  @content @live
  Scenario: List of staff
    Given I am on "people/staff"
    Then I should see a ".views-row-first" element
    And I should see a ".views-row-lines" element

  @content @live
  Scenario: List of students
    Given I am on "people/students"
    Then I should see a ".views-row-first" element
    And I should see a ".views-row-lines" element

  @content @live
  Scenario: Students layout with faculty
    Given I am on "people/students/faculty"
    Then I should see "Faculty" in the "Content Head" region 
    And I should see "Jacob Smith" in the "Content Body" region

  @content @live
  Scenario: Faculty layout
    Given I am on "people/faculty"
    Then I should see a ".views-exposed-form" element
    And I should see "People" in the "First sidebar" region 
    And I should see "Why I Teach" in the "First sidebar" region

  @content @live
  Scenario: Students layout
    Given I am on "people/students"
    Then I should see a ".views-exposed-form" element
    And I should see "People" in the "First sidebar" region

  @content @live
  Scenario: Staff layout
    Given I am on "people/staff"
    Then I should see a ".views-exposed-form" element
    And I should see "People" in the "First sidebar" region 
    And I should see "Contact and Location" in the "First sidebar" region

  @content @live
  Scenario: Staff layout with faculty
    Given I am on "people/staff/faculty"
    Then I should see "Faculty" in the "Content Head" region 
    And I should see "Jacob Smith" in the "Content Body" region

  @content @live
  Scenario: Faculty layout with staff
    Given I am on "people/faculty/staff"
    Then I should see "Emily Jordan" in the "Content Body" region
    And I should see "Staff" in the "Content Head" region 

  @api
  Scenario: Affiliates column on Manage Person
   Given I am logged in as a user with the "administrator" role
   When I go to "admin/manage/people"
   Then I should see 1 or more ".views-field-field-s-person-affiliation" elements