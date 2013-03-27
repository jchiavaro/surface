Feature: Register a new user
  As a visitor
  So that I can log in into the site
  I want to use the site features

  Scenario: Register from the home page
    Given I am on the Surface home page
    When I fill in the following:
      | First Name       | Jeff              |
      | Last Name        | Smith             |
      | Email            | jsmith@domain.com |
      | Password         | top_secret        |
      | Confirmation     | top_secret        |
    And I select "2009-02-20" as the "Birthday" date
    And I choose "Male"
    And I press "Sign Up"
    Then I should see "Welcome, Jeff!"
    And I should see "Log out"
    And I should receive a welcome email
