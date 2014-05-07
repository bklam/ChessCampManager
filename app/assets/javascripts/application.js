// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery_nested_form
//= require foundation
//= require fullcalendar.min.js
//= require fullcalendar.js

$(function(){ $(document).foundation(); });

// Datepicker code
$(function() {
  $(".datepicker").datepicker({
    format: 'mm/dd/YYYY'
  });
});

// Calendar code
$('#calendar').fullCalendar({

    eventSources: [

        // your event source
        {
            events: [ // put the array in the `events` property
                {
                    title  : 'event1',
                    start  : '2010-01-01'
                },
                {
                    title  : 'event2',
                    start  : '2010-01-05',
                    end    : '2010-01-07'
                },
                {
                    title  : 'event3',
                    start  : '2010-01-09 12:30:00',
                }
            ],
            color: 'black',     // an option!
            textColor: 'yellow' // an option!
        }

        // any other event sources...

    ]

});

