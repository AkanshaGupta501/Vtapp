Feature: test data with multiple inputs
Scenario Outline: where multiple inputs are provided
Given user is on calculator
When user enters <num1> and <num2> and <operation>
Then result should be <result>

Examples:
|num1|num2|operation|result|
|5|2|add|7|
|8|8|subtract|16|
|9|8|mul|5|
|10|5|div|2|


