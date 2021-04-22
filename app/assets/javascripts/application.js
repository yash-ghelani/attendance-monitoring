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


$(document).on('ready', function () {
    $('.datetimepicker').each(function () {
        const start = $("#start.datetimepicker");
        const end = $("#end.datetimepicker");
        if (this.type === 'text') {
            // Native datepicker is not available
            start.datetimepicker({
                onShow: function (ct) {
                    this.setOptions({
                        maxDate: end.val() ? end.val() : false
                    })
                },
            });
            end.datetimepicker({
                onShow: function (ct) {
                    this.setOptions({
                        minDate: start.val() ? start.val() : false
                    })
                },
            });
        }else if(this.type === 'datetime-local'){
            // Add logic for native datetimepicker
        }
    })
})