// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
// //
//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui
//= require jquery-ui/core
//= require jquery-ui/position
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/widgets/button
//= require jquery-ui/widgets/menu
//= require moment
//= require tether
//= require popper
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require select2-full
//= require filterrific/filterrific-jquery
//= require bootstrap-sprockets


function createDataArray(arr) {
  arr = arr.split(',')
  var output = []
  for(var i=0; i < arr.length; i++) {
    n = {
      id: `${arr[i]}`,
      value: `${arr[i]}`,
      name: `${arr[i]}`,
      text: `${arr[i]}`,
      selected: 'selected'
    }
    output.push(n)
  }
  return output
}
