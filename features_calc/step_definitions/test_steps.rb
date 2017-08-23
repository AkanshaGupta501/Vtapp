class Calculator
    def push(num1,num2,op)
        num1=num1.to_i
        num2=num2.to_i
        case op
        when 'add'
             num1+num2
        when 'subtract'
             num1-num2
        when 'mul'
             num1*num2
        when 'div'
             num1/num2
        end
        
    end
end

require 'colorize'
#require 'watir-webdriver'
calc = Calculator.new
 res=0
#browser=Watir::Browser.new:firefox

Given(/^user is on calculator$/) do 
    #browser.goto "http://www.math.com/students/calculators/source/basic.htm"
    
end
When(/^user enters (\d+) and (\d+) and (\w+)$/) do |arg1,arg2,op|
   #browser.text_field(:name,"Input").set(arg1)
   #browser.button(:name,"plus").click
   #browser.text_field(:name,"Input").set(arg2)
   #browser.button(:name,"DoIt").click
   #var res=browser.text_field(:name,"Input").value
  res= calc.push(arg1,arg2,op)
   
end
Then(/^result should be (\d+)$/) do |result|
     if( "#{res}"=="#{result}")
         puts"Successful"
     else
        puts "Failed"
     end
    #puts "#{result}"
end