// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require google-code-prettify/prettify
//= require ui
//= require_tree .

$(document).ready(function() {
  prettyPrint();

  var picker = new ui.ColorPicker;

  $('.codify').each(function() {

    var codify = $(this);

    var content = codify.find('.well');
    var code = codify.find('pre');
    var link = codify.find('.show_source');

    var picker = new ui.ColorPicker;

    var card = ui.card(content, code);
    card.el.appendTo(codify);

    link.click(function() {
      card.flip();
    });
  });

});
