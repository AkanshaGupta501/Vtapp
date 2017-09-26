class PaymentEft < SitePrism::Page
	element :select_eft, "label[data-target = '#eft-details']"
	element :payment_done, "div#eft-details > div:nth-child(3) > div > a"
  element :successful_payment, "body > a.btn.btn-success"
  element :cancelled_payment, "body > a.btn.btn-danger"
  element :pending_payment, "body > a.btn.btn-info"
  element :flash_error, "div.alert.alert-danger"
	
  def choose_eft
	 	select_eft.click
		page.execute_script('window.scrollTo(0,75)')
		payment_done.click
	end
end