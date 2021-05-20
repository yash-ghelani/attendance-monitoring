//= require jquery
//= require jquery_ujs
//= require ajax_setup
//= require ajax_modal
//= require popper
//= require bootstrap
//= require flash_message
//= require visibility_map
//= require modal
//= require select2
//= require select2_init
//= require cocoon
//= require jquery-datetimepicker
//= require moment
//= require local-time


/*
 * The functions for ensuring the datepicker
 * works correctly on each screen
 */
$(document).on('ready', function () {

    //Datepicker class
    $('.datepicker').each(function () {
        if (this.type === 'text') {
            // Native datepicker is not available
            $(this).datetimepicker({timepicker:false, format:'Y-m-d'});
        }else if(this.type === 'date'){
            // Add logic for native datepicker
        }
    })

    //Timepicker class
    $('.timepicker').each(function () {
        if (this.type === 'text') {
            // Native timepicker is not available
            $(this).datetimepicker({datepicker:false, format:'H:i'});
        }else if(this.type === 'time'){
            // Add logic for native timepicker
        }
    })
})