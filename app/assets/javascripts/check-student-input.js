/**
 * File will run when student types into the enter code screen
 * and validate the code, it will display the details on screen
 * if they are valid
 */

 document.addEventListener("DOMContentLoaded", function() {

  //setup before functions
  var running = false; //Is a search running?
  var inputBox = $("#session_code_session_code")
  var spinnyBoi = $("#loadingIcon")
  var resultsBox = $("#results")
  var submitButton = $("#submitButton")

  //Regex
  var formatRegex = /^[\d\w-]+$/;
  var lengthRegex = /^[\d\w]{8,8}$/;


  //When student starts typing
  inputBox.keyup(function(){
    val = $(this).val()
    if (val.match(formatRegex) && val.match(lengthRegex)){
      //Run check
      doneTyping()
    }else{
      submitButton.prop( "disabled", true );
      resultsBox.empty()
    }
  });

  //Start running ajax request
  function startRunning(){
    spinnyBoi.toggleClass("d-none")
    running=true
  }

  //Stop running ajax request
  function stopRunning(){
    spinnyBoi.toggleClass("d-none")
    running=false
  }

  //Student finished typing, execute
  function doneTyping () {
    if(!running){
      startRunning()
      //Empty the current contents to avoid duplication
      resultsBox.empty()
      var code = inputBox.val()
      //Send an AJAX request to the controller
      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "/student/quick",
        data : JSON.stringify({session_code:code}),
        dataType: "json",
        success: function (result) {
          //If the result isn't false (code valid)
          if(result){
            //HTML to inject (valid code)
            var title = result["session_title"]
            formHtml=`
            <p class="text-success">Code Valid</p>
            <p><b>${title}</b></p>
            `
            resultsBox.append(formHtml);
            submitButton.prop( "disabled", false );
          }else{
            //HTML to inject (invalid code)
            formHtml=`
            <p class="text-danger">Code Invalid</p>
            `
           resultsBox.append(formHtml);
          }
          stopRunning()
        },
        error: function (){
           console.log("Error during ajax request")
           stopRunning()
        }
       });
    }
  }

  //Call when page loads to validate QR codes
  if(inputBox.val()){
    doneTyping();
  }

});