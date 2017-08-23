Feature: Test the cucumber script on staging
Scenario: login with details
Given Goto login page
When Enter valid email and password
Then Login successful