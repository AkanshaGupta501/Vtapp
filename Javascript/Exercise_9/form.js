function Form(options) {
  this.submitButton = options.submitButton;
  this.inputNumber = options.inputDOM;
  this.result = options.output;
}

Form.prototype.init = function() {
  var _this = this;
  this.submitButton.addEventListener("click", function(){
    if(!_this.validateInputNumber()){
      event.preventDefault();
    }
  });
  this.inputNumber.addEventListener("focus",function(){
    _this.result.value = null;
  });
}

Form.prototype.validateInputNumber = function() { 
  isValid = this.ValidDigitRegex.test(this.inputNumber.value)
  this.displayResult(isValid);
  return isValid;
}

Form.prototype.displayResult = function(value){
  this.result.value = value;
}
  
Form.prototype.ValidDigitRegex = new RegExp(/^-?\d*[\.]?\d+$/);

window.onload = function(){
  var options = {
    submitButton : document.querySelector("[data-name = 'submit']"),
    inputDOM : document.querySelector("[data-name = 'input']"),
    output : document.querySelector("[data-name = 'result']")
  };
  var form = new Form(options);
  form.init();
}
