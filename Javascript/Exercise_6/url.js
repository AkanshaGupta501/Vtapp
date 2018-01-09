window.onload = function(){
  var newUrl = new Url();
  newUrl.getUrl();
}

function Url(url_address){
  this.url = null;
}

Url.prototype.getUrl = function(){
  do {
    this.url = prompt("Please enter a URL address");
  } while(!this.validateUrl());
  this.navigateToUrl();
}

Url.prototype.validateUrl = function(){
  var isValid = (!this.checkIfNotEmptyAndValid()) ? false : true;
  return isValid;
}

Url.prototype.checkIfNotEmptyAndValid = function(){
  var isUrlValid = true;
  var isEmpty = !isNaN(this.url) ? false : true;
  var isValidName = this.validUrlRegex.test(this.url) ? true : false;
  if(!isEmpty){
    isUrlValid = false;
    alert("You must enter the URL to continue");
  }
  else if(!isValidName){
    isUrlValid = false;
    alert("Your URL address is invalid.");
  }
  return isUrlValid;
}

Url.prototype.validUrlRegex = new RegExp(/(http(s)?:\/\/){1}([\da-z(\.|\-|\@|\:|\#|\_)?]+\.[a-z\.]{2,6}|[\d\.]+)([\/:?=&#%]{1}[[\da-z(\.|\-|\@|\:|\#|\_)?]+)*[\/\?]?/igm);

Url.prototype.navigateToUrl = function(){
  window.open(this.url, "_blank", "width=400, height=450, menubar=0, scrollbars=0, status=0");
}