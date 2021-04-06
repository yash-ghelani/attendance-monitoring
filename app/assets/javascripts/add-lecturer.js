
/**
 * File to handle adding new lecturers
 * to the "new sessions" page
 */


$( document ).ready(function() {
  //Store the number of lecturers we add
  counter=0
  active=0

  //When the user clicks "Add lecturer"
  $("#addLecturerField").click(function(){
    counter+=1
    active+=1
    //The HTML to append on the browser
    formHtml=`
    <div class="form-inline mb-3">
      <div class="form-group">
        <label for="lecturerInput${counter}" class="sr-only">Lecturer</label>
        <input name="lecturers[]" type="text" class="form-control" id="lecturerInput${counter}" placeholder="Lecturer ${counter}">
      </div>
      <button type="button" class="btn btn-danger ml-3 removeLecturer">Remove</button>
    </div>
    `
    $( "#addedLecturers" ).append(formHtml);
  }); 


  // Attach a delegated event handler to remove the input when "Remove" is clicked
  $( "#addedLecturers" ).on( "click", ".removeLecturer", function( event ) {
    //Reset counter if all inputs are deleted
    active-=1
    if (active < 1){
      counter=0
    }
    //Remove with animation
    var target=$(this).closest('.form-inline');
    target.hide("fast", function(){ target.remove(); });
  });


});
