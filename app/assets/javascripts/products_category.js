$(function(){
  var request = $("#request").attr("action");
  if(request.indexOf("new") != -1 || request.indexOf("edit") != -1){
    $.ajax({
      url: "/products/set_parents"
    }).done(function(data){
      if(request.indexOf("new") != -1){
        $("#category-select").append(`<select class="sell__product__detail--select select-parent" name="product[category_id]" id="product_category_id"><option value="">選択してください</option></select>`);
      }
        data.parents.forEach(function(parent){
          $(".select-parent").append(`<option value="${parent.id}">${parent.name}</option>`);
        })
      $(".select-parent, #parent_category").on("change", function(){
        $(".select-child").remove();
        $(".select-grandchild").remove();
        if($(this).val() == ""){
          $(".select-parent").attr("id"  , "product_category_id");
          $(".select-parent").attr("name", "product[category_id]");
          $(".select-parent").css("margin-bottom", "0");
        }else{
          $.ajax({
            url     : "/products/set_children",
            data    : {parent_id: $(this).val()},
            dataType: "json"
          }).done(function(data){
            if(request.indexOf("edit") != -1){
              $("#child_category ,#grandchild_category").remove();
            }
            $(".select-parent").attr("id"  , "select-parent");
            $(".select-parent").attr("name", "select-parent");
            $(".select-parent").css("margin-bottom", "10px");
            $("#category-select").append(`<select class="sell__product__detail--select select-child" name="product[category_id]" id="product_category_id"><option value="">選択してください</option></select>`);
            data.children.forEach(function(child){
              $(".select-child").append(`<option value="${child.id}">${child.name}</option>`);
            })
          })
        }
      })
      $("#category-select").on("change", ".select-child", function(){
        $(".select-grandchild").remove();
        if($(this).val() == ""){
          $(".select-child").attr("id"  , "product_category_id");
          $(".select-child").attr("name", "product[category_id]");
          $(".select-child").css("margin-bottom", "0");
        }else{
          $.ajax({
            url     : "/products/set_grandchildren",
            data    : {ancestry: `${$(".select-parent").val()}/${$(this).val()}`},
            dataType: "json"
          }).done(function(data){
            $(".select-child").attr("id"  , "select-parent");
            $(".select-child").attr("name", "select-parent");
            $(".select-child").css("margin-bottom", "10px");
            $("#category-select").append(`<select class="sell__product__detail--select select-grandchild" name="product[category_id]" id="product_category_id"><option value="">選択してください</option></select>`);
            data.grandchildren.forEach(function(grandchild){
              $(".select-grandchild").append(`<option value="${grandchild.id}">${grandchild.name}</option>`);
            })
          })
        }
      })
      if(request.indexOf("edit") != -1){
        $("#child_category").on("change", function(){
          $("#grandchild_category, #product_category_id").remove();
          if($(this).val() == ""){
            $("#child_category").attr("id"  , "product_category_id");
            $("#child_category").attr("name", "product[category_id]");
            $("#child_category").css("margin-bottom", "0");
          }else{
            $.ajax({
              url     : "/products/set_grandchildren",
              data    : {ancestry: `${$(".select-parent").val()}/${$(this).val()}`},
              dataType: "json"
            }).done(function(data){
              $("#child_category").attr("id"  , "select-parent");
              $("#child_category").attr("name", "select-parent");
              $("#child_category").css("margin-bottom", "10px");
              $("#category-select").append(`<select class="sell__product__detail--select select-grandchild" name="product[category_id]" id="product_category_id"><option value="">選択してください</option></select>`);
              data.grandchildren.forEach(function(grandchild){
                $(".select-grandchild").append(`<option value="${grandchild.id}">${grandchild.name}</option>`);
              })
            })
          }
        })
      }
    })
  }
})