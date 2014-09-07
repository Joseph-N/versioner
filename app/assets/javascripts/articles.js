var ready = function(){
    remove_fields = function(link) {
        $(link).prev("input[type=hidden]").val("1");
        $(link).parent().parent().hide();
    }


    add_fields = function(link, association, content) {
        var new_id = new Date().getTime();
        var regexp = new RegExp("new_" + association, "g")
        $(link).before(content.replace(regexp, new_id));
    }
}

$(document).ready(ready);
$(document).on('page:load', ready);

