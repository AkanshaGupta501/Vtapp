//User Class initialization with firstname and lastname as its attribute
function User(options){
  this.firstName = null;
  this.lastName = null;
  this.messageBox = options.messageId;
}

User.prototype.init = function(){
  this.getUserName();
}

User.prototype.validNameRegex = new RegExp(/^[a-zA-Z\s]+$/);

User.prototype.getUserName = function(){
  do {
    this.firstName = prompt("Please enter the first name");
    this.lastName = prompt("Please enter the last name");
    } while(!this.validateUserName());
    this.displayUserName();
}

User.prototype.validateUserName = function(){
  var isValid = (!(this.validateNameNotEmptyNoDigits(this.firstName, 'firstname') && this.validateNameNotEmptyNoDigits(this.lastName, 'lastname'))) ? false : true;
  return isValid;
}

User.prototype.validateNameNotEmptyNoDigits = function(name, nameType){
  var isUserNameValid = true;
  var isEmpty = !isNaN(name) ? false : true;
  var isValidName = this.validNameRegex.test(name) ? true : false;
  if(!isEmpty){
    isUserNameValid = false;
    alert("You must specify " + nameType);
  }
  else if(!isValidName){
    isUserNameValid = false;
    alert("Your " + nameType + " must consist of letters only");
  }
  return isUserNameValid;
}

//If name is valid display it as alert and inside the div
User.prototype.displayUserName = function(){
  var messageText = "Hello " + this.firstName.trim() + " " + this.lastName.trim();
  alert(messageText);
  this.messageBox.innerHTML = messageText;
}

//This event is called when body is loaded and asks user to enter the values
window.onload = function(){
  var options = {
    messageId : document.querySelector("[data-name = 'message']")
      };
  var user = new User(options);
  user.init();
}
