// This is event handler called when form is submitted
var form = document.getElementById("registration_form");
form.addEventListener("submit", function(){
  var new_form = new Form();
  new_form.validateForm();
});

// New class initialization for forms
function Form(){
  this.user_email = document.querySelectorAll("[data-name = 'user_email']");
  this.home_url = document.querySelectorAll("[data-name = 'home_url']");
  this.inputFields = document.querySelectorAll("[data-type = 'text']");
  this.textBoxFields = document.querySelectorAll("[data-type = 'textbox']");
  this.checkBoxFields = document.querySelectorAll("[data-type = 'checkbox']");
}

// this functioon validates form based on various params and if OK display success message
Form.prototype.validateForm = function(){
  var isValid = this.validateInputForEmpty() && this.validateFormat() && this.validateTextBox() && this.validateCheckbox();
  if(isValid){
    alert("Form submitted successfully");
  }
}

// this function checks whether any of the input field must not be left empty
Form.prototype.validateInputForEmpty = function(){
  var isValid = true
  for (i = 0; i < this.inputFields.length; i++) {
      if (this.inputFields[i].value === '') {
        alert(this.inputFields[i].name + " can not be empty");
        isValid = false;
      }
    }
    if(this.textBoxFields[0].value.length == 0){
      alert("About us cannot be empty");
      isValid = false;
    }
    return isValid;
}

// this function validates that textbox must contain atleast 50 characters
Form.prototype.validateTextBox = function(){
  var isValid = true;
    if (this.textBoxFields[0].value.length < 50) {
      alert("We need 50 characters long about me for your information");
      isValid = false;
    }
    return isValid;
}

// this function validates that if tnc checkbox is checked or not
Form.prototype.validateCheckbox = function(){
  var isValid = true;
    if (!this.checkBoxFields[0].checked) {
      alert(this.checkBoxFields[0].name + " must be checked ");
      isValid = false;
    }
    return isValid;
}

//this function validates the proper email and url format entered by user
Form.prototype.validateFormat = function(){
  debugger;
  var isValid = true;
  //Regex for email verification
  var email_regex = new RegExp(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/igm);
  // Regex for URL verification
  var url_regex = new RegExp(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)/g);

      if(!email_regex.test(this.user_email[0].value)){ 
        alert("Please enter valid email address"); 
        isValid = false;
      }
      if(!url_regex.test(this.home_url[0].value)){
        alert("Please enter valid URL address");
        isValid = false;
      }
      return isValid;
}

