function Url(options){
  this.submitButton = options.submitButton;
  this.url = options.urlField;
}

Url.prototype.validateURL = function() {  
  var isValid = this.UrlPattern.test(this.url.value);
  isValid == false ? this.displayMessage("Please enter a valid url") : this.extractDomainSubdomain();
  return isValid;
}

Url.prototype.extractDomainSubdomain = function(){
  var hostName = this.url.value.match(this.UrlPattern);
  var domainName = hostName[2];
  var subDomainName = hostName[1];
  this.displayMessage("Domain Name : " + domainName);
  if(subDomainName != ''){
    this.displayMessage("SubDomain Name : " + subDomainName);
  }
  
}

Url.prototype.bindEvent = function() {
  var _this = this;
  this.submitButton.addEventListener("click", function(){
  _this.validateURL() ? this.displayMessage("Form submitted") : event.preventDefault();
  });

  this.url.addEventListener("focus", function(){
    _this.url.value = null;
  }); 
}

Url.prototype.displayMessage = function(message){
  alert(message);
}

Url.prototype.UrlPattern = new RegExp(/^(?:http(?:s)?:\/\/)?(?:www\.)?((?:(?:[\w\-~]+)\.)*)((?:[\w\-~]+)\.[a-z]{2,6})(\/[\w#-~?]*)*$/i);

window.onload = function(){
  var options = {
    urlField : document.querySelector("[data-id = 'url']"),
    submitButton : document.querySelector("[data-id = 'submit']")
  };
  var urlObject = new Url(options);
  urlObject.bindEvent();
}

