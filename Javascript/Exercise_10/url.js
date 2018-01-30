function Url(options){
  this.submitButton = options.submitButton;
  this.url = options.urlField;
}

Url.prototype.validateURL = function() {  
  return this.UrlPattern.test(this.url.value);
}

Url.prototype.extractDomainSubdomain = function(){
  var host = this.url.value.match(this.UrlPattern),
    domain = host[2],
    subdomain = host[1];
  this.displayMessage("Domain Name : " + domain);
  if(subdomain != ''){
    this.displayMessage("SubDomain Name : " + subdomain);
  }
}

Url.prototype.displayMessage = function(message){
  alert(message);
}

Url.prototype.bindEvents = function() {
  var _this = this;
  this.submitButton.addEventListener("click", function(){
    _this.init();
  });

  this.url.addEventListener("focus", function(){
    _this.url.value = null;
  }); 
}

Url.prototype.init = function(){
  if(!this.validateURL()){
    this.displayMessage("Please enter a valid URL");
    event.preventDefault();
  }
  else{
    this.extractDomainSubdomain();
  }
}

Url.prototype.UrlPattern = new RegExp(/^(?:http(?:s)?:\/\/)?(?:www\.)?((?:(?:[\w\-~]+)\.)*)((?:[\w\-~]+)\.[a-z]{2,6})(\/[\w#-~?]*)*$/i);

window.onload = function(){
  var options = {
    urlField : document.querySelector("[data-id = 'url']"),
    submitButton : document.querySelector("[data-id = 'submit']")
  };
  var urlObject = new Url(options);
  urlObject.bindEvents();
}

