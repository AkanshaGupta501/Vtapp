class PaymentEft < SitePrism::Page
	element :select_eft, "label[data-target = '#eft-details']"
	element :payment_done, "div#eft-details > div:nth-child(6) > div.col-sm-12.text-center > a"
	
  def choose_eft
	 	select_eft.click
		page.execute_script('window.scrollTo(0,500)')
		payment_done.click
	end
end