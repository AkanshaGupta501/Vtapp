// New class initialization for forms
function Form(options){
  this.inputTextFields = options.inputTextFields;
  this.userEmail = options.userEmail;
  this.homeUrl = options.homeUrl;
  this.textBoxField = options.textBoxField;
  this.checkBox = options.checkBox;
}

Form.prototype.init = function() {
  !this.validateForm() ? event.preventDefault() : this.displayMessage("Form submitted successfully");
}
// this functioon validates form based on various params and if OK display success message
Form.prototype.validateForm = function(){
  return this.validateInputForEmpty() && this.validateEmailUrlFormat() && this.validateTextBoxLength() && this.validateCheckbox();
}

// this function checks whether any of the input field must not be left empty
Form.prototype.validateInputForEmpty = function(){
  var isValid = true
  for (i = 0; i < this.inputTextFields.length; i++) {
      if (!isNaN(this.inputTextFields[i].value)) {
        this.displayMessage(this.inputTextFields[i].name + " can not be empty");
        isValid = false;
      }
    }
    if(!isNaN(this.textBoxField.value)){
      this.displayMessage("About us cannot be empty");
      isValid = false;
    }
    return isValid;
}

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

Form.prototype.validateTextBoxLength = function(){
  var isValid = true;
    if (this.textBoxField.value.length < 50) {
      this.displayMessage("We need 50 characters long about me for your information");
      isValid = false;
    }
    return isValid;
}

Form.prototype.validateCheckbox = function(){
  var isValid = true;
    if (!this.checkBox.checked) {
      this.displayMessage(this.checkBox.name + " must be checked ");
      isValid = false;
    }
    return isValid;
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
    inputTextFields : document.querySelectorAll("[data-type = 'text']"),
    textBoxField : document.querySelector("[data-type = 'textbox']"),
    checkBox : document.querySelector("[data-type = 'checkbox']")
  },
  form = document.querySelector("[data-name = 'registration_form']");

  form.addEventListener("submit", function(){
    var new_form = new Form(options);
    new_form.init();
  });
}


