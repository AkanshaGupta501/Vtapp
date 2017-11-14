class PaymentEft < SitePrism::Page
	element :select_eft, "label[data-target = '#eft-details']"
	element :payment_done, "div#eft-details > div:nth-child(3) > button"
  element :successful_payment, "body > a.btn.btn-success"
  element :cancelled_payment, "body > a.btn.btn-danger"
  element :pending_payment, "body > a.btn.btn-info"
  element :flash_error, "body > div.flash-message-position > div.alert.alert-danger"
	
  def choose_eft
	 	select_eft.click
		page.execute_script('window.scrollTo(0,75)')
		payment_done.click
	end
end

class PaymentExt < SitePrism::Page
  element :select_ext, "label[data-target = '#pay-fast-details']"
  element :payment_done, "div#pay-fast-details > div:nth-child(3) > button"
  element :cancelled_payment, "body > div.wrapper > article > div > div > span#cancel > a.gbutton"
  element :successful_payment, "a#pay-with-wallet" 
  element :flash_error, "body > div.flash-message-position > div.alert.alert-danger"

  def choose_ext
    page.execute_script('window.scrollTo(0,75)')
    payment_done.click
  end
end