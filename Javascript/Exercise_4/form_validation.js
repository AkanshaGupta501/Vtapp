// New class initialization for forms
function Form(options){
  this.inputTextFields = options.inputTextFields;
  this.userEmail = options.userEmail;
  this.homeUrl = options.homeUrl;
  this.textBoxField = options.textBoxField;
  this.checkBox = options.checkBox;
}

//Submit form if validated else throws relevant errors
Form.prototype.init = function() {
  !this.validateForm() ? event.preventDefault() : this.displayMessage("Form submitted successfully");
}

Form.prototype.validateForm = function(){
  return this.validateInputForEmpty() && this.validateEmailUrlFormat() && this.validateTextBoxLength() && this.validateCheckbox();
}

//This function checks if input fields are not left empty or contains any white spaces
Form.prototype.validateInputForEmpty = function(){
  var isValid = true
  for (i = 0; i < this.inputTextFields.length; i++) {
      if (this.checkIfEmpty(this.inputTextFields[i].value)) {
        this.displayMessage(this.inputTextFields[i].name + " can not be empty");
        isValid = false;
      }
    }
    return isValid;
}

//This function validates that user enters valid email and URL
Form.prototype.validateEmailUrlFormat = function(){
  var isValid = true;
  if(!this.EmailRegex.test(this.userEmail.value)){ 
    this.displayMessage("Please enter valid email address"); 
    isValid = false;
  }
  if(!this.UrlRegex.test(this.homeUrl.value)){
    this.displayMessage("Please enter valid URL address");
    isValid = false;
  }
  return isValid;
}

//this function validates the number of characters in the textbox
Form.prototype.validateTextBoxLength = function(){
  var isValid = true;
    if (this.textBoxField.value.length < 50) {
      this.displayMessage("We need 50 characters long about me for your information");
      isValid = false;
    }
    return isValid;
}

//This function validates if checkbox is checked or not
Form.prototype.validateCheckbox = function(){
  var isValid = true;
    if (!this.checkBox.checked) {
      this.displayMessage(this.checkBox.name + " must be checked ");
      isValid = false;
    }
    return isValid;
}

Form.prototype.checkIfEmpty = function(inputValue){
  return (inputValue.length === 0 || !inputValue.trim());
}

Form.prototype.EmailRegex = new RegExp(/([\w\d]+[._%+-]?[\w\d])+@([\w\d]+[.-]?[\w\d])+\.[\w]{2,4}/i);

Form.prototype.UrlRegex = new RegExp(/(http(s)?:\/\/.)?(www\.)?[-\w\d@:.\+~#=\[\]]{2,256}\.[a-z]{2,6}\b([-\w\d@:\+.~#?&\/=]*)/i);

Form.prototype.displayMessage = function(message){
  alert(message);
}

window.onload = function(){
  var options = {
    userEmail : document.querySelector("[data-name = 'user_email']"),
    homeUrl : document.querySelector("[data-name = 'home_url']"),
    textBoxField : document.querySelector("[data-name = 'textbox']"),
    checkBox : document.querySelector("[data-type = 'checkbox']"),
    inputTextFields : document.querySelectorAll("[data-type = 'text']")
  },
  form = document.querySelector("[data-name = 'registration_form']");

  form.addEventListener("submit", function(){
    var new_form = new Form(options);
    new_form.init();
  });
}


