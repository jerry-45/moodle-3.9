@core @core_completion
Feature: Completion with no calendar capabilites
  In order to allow work effectively
  As a teacher
  I need to be able to create activities with completion enabled without calendar capabilities

  Background:
    Given the following "courses" exist:
      | fullname | shortname | category | groupmode | enablecompletion |
      | Course 1 | C1 | 0 | 1 | 1 |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
    And I log in as "admin"
    And I am on "Course 1" course homepage
    And I navigate to "Users > Permissions" in current page administration
    And I override the system permissions of "Teacher" role with:
      | capability | permission |
      | moodle/calendar:manageentries | Prohibit |
    And I log out

  Scenario: Editing completion date
    Given the following "activity" exists:
      | activity   | forum                  |
      | course     | C1                     |
      | name       | Test forum name        |
      | completion | 2                      |
    And I log in as "admin"
    And I am on "Course 1" course homepage with editing mode on
    And I am on the "Test forum name" "forum activity editing" page
    And I set the following fields to these values:
      | id_completionexpected_enabled | 1 |
      | id_completionexpected_day | 1 |
      | id_completionexpected_month | 1 |
      | id_completionexpected_year | 2017 |
    When I am on the "Test forum name" "forum activity editing" page logged in as teacher1
    And I set the following fields to these values:
      | id_completionexpected_year | 2018 |
    And I press "Save and return to course"
    Then I should see "Test forum name"
