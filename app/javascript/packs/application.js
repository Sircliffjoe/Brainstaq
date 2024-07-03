var jQuery = require("jquery");


// import jQuery from "jquery";
// global.$ = global.jQuery = jQuery;
// window.$ = window.jQuery = jQuery;

//= require("jquery")
//= require popper
//= require activestorage
//= require local-time
//= require shuffle
//= require turbo
//= require jquery_ujs
//= require bootstrap.min
//= require chartkick
//= require Chart.bundle
//= require trix
//= require_tree .


require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap/dist/js/bootstrap';
import "../trix-editor-overrides"

require("bootstrap")
require("pesky_scrolly_stuff")
require("trix")
require("@rails/actiontext")
require("chartkick")
require("chart.js")
require("@nathanvda/cocoon")
import "youtube"

require("selectize")
require("slick-carousel")

import "@hotwired/turbo-rails";
Turbo.session.drive = false

import "slick-carousel/slick/slick.scss"
import "slick-carousel/slick/slick-theme.scss"

import "controllers"
import "@fortawesome/fontawesome-free/js/all";

import "chartkick/chart.js"


// require('cocoon')
// import "cocoon"

$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip(); 
  });

setTimeout(function() {
    $('.flash-message').fadeOut('fast');
}, 5000);

function validateFiles(inputFile) {
    var maxExceededMessage = "This file exceeds the maximum allowed file size (1 MB)";
    var extErrorMessage = "Only image file with extension: .jpg, .jpeg, .gif or .png is allowed";
    var allowedExtension = ["jpg", "jpeg", "gif", "png", "pdf"];

    var extName;
    var maxFileSize = $(inputFile).data('max-file-size');
    var sizeExceeded = false;
    var extError = false;

    $.each(inputFile.files, function() {
        if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) { sizeExceeded = true; };
        extName = this.name.split('.').pop();
        if ($.inArray(extName, allowedExtension) == -1) { extError = true; };
    });
    if (sizeExceeded) {
        window.alert(maxExceededMessage);
        $(inputFile).val('');
    };

    if (extError) {
        window.alert(extErrorMessage);
        $(inputFile).val('');
    };
}

document.addEventListener("turbo:load", function() {
    $('.scroller').slick()
})



