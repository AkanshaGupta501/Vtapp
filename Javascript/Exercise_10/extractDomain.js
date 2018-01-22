function extractDomainSubdomain(options){
  this.submitButton = options.submitButton;
  this.url = options.urlField;
}

extractDomainSubdomain.prototype.validateURL = function() {  
  var isValid = this.UrlPattern.test(this.url.value);
  isValid == false ? this.displayMessage("Please enter a valid url") : this.excerptDomainSubdomain();
  return isValid;
}

extractDomainSubdomain.prototype.excerptDomainSubdomain = function(){
  var hostName = this.url.value.match(this.UrlPattern);
  var domain = hostName[2];
  var subdomain = hostName[1];
  this.displayMessage("Domain Name : " + domain);
  if(subdomain != ''){
    this.displayMessage("SubDomain Name : " + subdomain);
  }
  
}

extractDomainSubdomain.prototype.bindEvent = function() {
  var _this = this;
  this.submitButton.addEventListener("click", function(){
  _this.validateURL() ? this.displayMessage("Form submitted") : event.preventDefault();
  });

  this.url.addEventListener("focus", function(){
    _this.url.value = null;
  });
}

extractDomainSubdomain.prototype.displayMessage = function(message){
  alert(message);
}

extractDomainSubdomain.prototype.UrlPattern = new RegExp(/^(?:http(?:s)?:\/\/)?(?:www\.)?((?:(?:[\w\-~]+)\.)*)((?:[\w\-~]+)\.[a-z]{2,6})(\/[\w#-~?]*)*$/i);

window.onload = function(){
  var options = {
    urlField : document.querySelector("[data-id = 'url']"),
    submitButton : document.querySelector("[data-id = 'submit']")
  };
  var urlObject = new extractDomainSubdomain(options);
  urlObject.bindEvent();
}
