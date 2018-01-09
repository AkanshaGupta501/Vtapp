//URL Class
function Url(){
  this.url = null;
}

Url.prototype.init = function(){
  this.getValidUrl();
  this.navigateToUrl();
}

Url.prototype.getValidUrl = function(){
  do {
    this.url = prompt("Please enter a URL address");
  } while(!this.validateUrl()); 
}

Url.prototype.validateUrl = function(){
  return (!this.checkIfNotEmptyAndValid()) ? false : true;
}

Url.prototype.checkIfNotEmptyAndValid = function(){
  var isUrlValid = true;

  if(!isNaN(this.url)){
    isUrlValid = false;
    alert("You must enter the URL to continue");
  }
  else if(!this.ValidUrlRegex.test(this.url)){
    isUrlValid = false;
    alert("Your URL address is invalid.");
  }
  return isUrlValid;
}

Url.prototype.ValidUrlRegex = new RegExp(/(http(s)?:\/\/){1}([\da-z(\.|\-|\@|\:|\#|\_)?]+\.[a-z\.]{2,6}|[\d\.]+)([\/:?=&#%]{1}[[\da-z(\.|\-|\@|\:|\#|\_)?]+)*[\/\?]?/igm);

Url.prototype.navigateToUrl = function(){
  window.open(this.url, "_blank", "width=400, height=450, menubar=0, scrollbars=0, status=0");
}

window.onload = function(){
  var newUrl = new Url();
  newUrl.init();
}
