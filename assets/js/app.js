// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"


let handlebars = require("handlebars");

$(function() {

  if (!$("#likes-template").length > 0) {
    // Wrong page.
    return;
}


  let tt = $($("#likes-template")[0]);
    let code = tt.html();
    let tmpl = handlebars.compile(code);

    let dd = $($("#post-likes")[0]);
    let path = dd.data('path');
    let p_id = dd.data('post_id');
    let u_id = dd.data('current_user_id');

    let bb = $($("#add-like-button")[0]);


    function fetch_likes() {
      function got_likes(data) {
        console.log("DATASTART" + data + "DATAEND");
        let html = tmpl(data);
        dd.html(html);
      }

      $.ajax({
        url: path,
        data: {post_id: p_id},
        contentType: "application/json",
        dataType: "json",
        method: "GET",
        success: got_likes,
      });
    }

    function add_like() {
      let data = {like: {number: 1, post_id: p_id, user_id: u_id}}
      bb.prop("disabled", true);

      console.log(u_id);

    $.ajax({
        url: path,
        data: JSON.stringify(data),
        contentType: "application/json",
        dataType: "json",
        method: "POST",
        success: fetch_likes,
      });
    }

    bb.click(add_like);


    fetch_likes();
});
