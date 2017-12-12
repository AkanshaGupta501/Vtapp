class AdminPlaceOrder < SitePrism::Page
  element :guest_checkout, "body > div.container > div.row > div.col-sm-12 > div.row > div.col-sm-9 > div > div > div.col-sm-3 > a"
  element :pay_button, "body > div.container > div.menu-wrap.white-bg > div > div > div.col-sm-7 > div.row.text-center > div > a"
  element :filter_search, "input[name = 'searchbar']"
  element :order_for_user, "body > div.container > div.row > div.col-sm-12 > div:nth-child(2) > div > table > tbody > tr > td:nth-child(6) > div > a:nth-child(3) > span" 

  def select_user(data)
    filter_search.set(data['email'])
  end
end