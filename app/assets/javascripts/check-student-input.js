/**
 * File will run when student types into the enter code screen
 * and validate the code, it will display the details on screen
 * if they are valid
 */

 document.addEventListener("DOMContentLoaded", function() {

  //Globals
  var running = false; //Is a search running?
  var lastSearch = "" //Store last searched code to prevent duplication
  var inputBox = $(".code-box")
  var qrcodeField =$("#qrcodeValue")

  //States
  var validView = $("#validCode")
  var invalidView = $("#invalidCode")
  var loadingView =  $("#loadingIcon")
  var clearButton = $("#clearButton")
  var pasteButton = $("#pasteButton")

  //Display
  var sessionNameField = $("#SessionNameField")
  var sessionDateField = $("#SessionDateField")
  var sessionTimeField = $("#SessionTimeField")
  var sessionHiddenField =$("#SessionHiddenField")

  //Regex
  var formatRegex = /^[\d\w-]+$/;
  var lengthRegex = /^[\d\w]{8,8}$/;
  var boxRegex = /^[\d\w]{1,1}$/;

  
  //Function will concatonate all input boxes into a single string
  function get_box_content(){
    return inputBox.map(function() { return this.value; }).get().join('')
  }

  //Will insert a string into the input boxes
  function insertBoxContent(data){
    emptyBoxes()
    for (var i = 0; i < data.length; i++) {
      currentLetter = data.charAt(i)
      $(".code-box:eq("+i+")").val(currentLetter)
    }
  }

  //Reset the input boxes
  function emptyBoxes(){
    inputBox.val("")
  }

  //Paste in users clipboard data
  function pasteData(){
    const text = navigator.clipboard.readText()
      //Insert data and run pre checks
      .then(text => {
        insertBoxContent(text)
        preCheck()
      })
      .catch(err => {
        console.error('Failed to read clipboard contents: ', err);
      });
  }

  //Clear data from the screen
  function clearData(){
    emptyBoxes()
    loadView("none")
    $(".code-box:eq(0)").focus()
    lastSearch=""
  }
  

  //Final check before AJAX is sent
  function preCheck(){
    //Check format and send ajax if valid
    val = get_box_content()
    if(val != lastSearch){
      if (val.match(formatRegex) && val.match(lengthRegex)){
        //Run check
        sendRequest(val)
      }else{
        // submitButton.prop( "disabled", true );
        // resultsBox.empty()
      }
    }
  }
  
  //Start running ajax request
  function startRunning(){
    loadingView.toggleClass("d-none")
    loadView("none")
    running=true
  }

  //Stop running ajax request
  function stopRunning(){
    loadingView.toggleClass("d-none")
    running=false
  }

  //Load a specific view (valid or invalid views)
  function loadView(view){
    //Hide all
    validView.hide()
    invalidView.hide()
    //Show the relevant view
    switch (view){
      case "valid":
        validView.show(100)
        break;
      case "invalid":
        invalidView.show(100)
        break;
    }
  }

  //Send the AJAX request
  function sendRequest (code) {
    if(!running){
      startRunning()
      lastSearch=code //Update global
      //Send an AJAX request to the controller
      $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "/student/validate",
        data : JSON.stringify({session_code:code}),
        dataType: "json",

        success: function (result) {
          //If the result isn't false (code valid)
          if(result){
            console.log(result)
            var title = result["session_title"]
            var date = new Date(result["start_time"])

            let day = date.getDate() + "/" + (date.getMonth() + 1) + "/" + date.getFullYear()
            let time = date.getHours() + ":" + date.getMinutes()

            console.log("Session title: "+title)
            console.log("Date: "+date)
            
            sessionNameField.text(title)
            sessionDateField.text(day)
            sessionTimeField.text(time)
            sessionHiddenField.val(code)

            loadView("valid")

          }else{
            //Show the invalid code view
            loadView("invalid")
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

  //When user clicks "Paste"
  pasteButton.click(function(){
    pasteData();
  })


  //When user clicks "Clear"
  clearButton.click(function() {
    clearData()
  });

  //If someone tries to paste code into any text field
  inputBox.bind("paste", function(e){
    e.stopPropagation();
    e.preventDefault();
    var text = e.originalEvent.clipboardData.getData("text/plain");
    insertBoxContent(text)
    preCheck()
  });

  //When student types in code box
  inputBox.keyup(function (event) {
    //Check backspace has been pressed
    if([8,37].includes(event.keyCode)){
      previous = $(this).prev(".code-box")
      previous.focus();
      previous.select();
    }
    //Move to next input box
    else if (this.value.match(boxRegex)) {
      next = $(this).next(".code-box")
      next.focus();
      next.select();
    }
    //Remove any non characters or numbers
    else{
      $(this).val("")
    }

    //Run final checks
    preCheck()
    
  });


  //Call when page loads to validate QR codes
  if(qrcodeField.val()){
    insertBoxContent(qrcodeField.val())
    preCheck()
  }else{
    clearData()
  }

  

});