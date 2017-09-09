class FindLocation < SitePrism::Page
	element :search_bar, "input[name = 'place']"
	element :find_caterer_button, "input[type = 'submit']"

 def fill_google_autocomplete(text)
    sleep 1
    element = find('#place')
    if element
      element.set text
      sleep 1
      element.native.send_keys(:arrow_down)
      element.native.send_keys(:return)
    end
    sleep 1
    find_caterer_button.click
  end
end