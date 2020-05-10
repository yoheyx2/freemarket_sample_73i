$(function(){
  var request = $("#request").attr("action");
  if(request.indexOf("new") != -1 || request.indexOf("edit") != -1){
    $.ajax({
      url: "/products/set_parents"
    }).done(function(data){
      $("#category-select").append(`<select class="sell__product__detail--select select-parent" name="product[category_id]" id="product_category_id"><option value="">選択してください</option></select>`);
      data.parents.forEach(function(parent){
        $(".select-parent").append(`<option value="${parent.id}">${parent.name}</option>`);
      })
      $(".select-parent").on("change", function(){
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
    })
  }
})
















































// $(function(){
//   // カテゴリーセレクトボックスのオプションを作成
//   function appendOption(category){
//     var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
//     return html;
//   }
//   // 子カテゴリーの表示作成
//   function appendChidrenBox(insertHTML){
//     var childSelectHtml = '';
//     childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
//                         <div class='listing-select-wrapper__box'>
//                           <select class="listing-select-wrapper__box--select sell__product__detail--select" id="child_category" name="category_id">
//                             <option value="---" data-category="---">---</option>
//                             ${insertHTML}
//                           <select>
//                         </div>
//                       </div>`;
//     $('.listing-product-detail__category').append(childSelectHtml);
//   }
//   // 孫カテゴリーの表示作成
//   function appendGrandchidrenBox(insertHTML){
//     var grandchildSelectHtml = '';
//     grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
//                               <div class='listing-select-wrapper__box'>
//                                 <select class="listing-select-wrapper__box--select sell__product__detail--select" id="grandchild_category" name="category_id">
//                                   <option value="---" data-category="---">---</option>
//                                   ${insertHTML}
//                                 </select>
//                               </div>
//                             </div>`;
//     $('.listing-product-detail__category').append(grandchildSelectHtml);
//   }
//   // 親カテゴリー選択後のイベント
//   $('#parent_category').on('change', function(){
//     var parentCate = document.getElementById('parent_category')
//     var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
//     var parentCatego = parentCate.parentCategory
//     console.log(parentCate);
//     console.log(parentCategory);
//     console.log(parentCatego);
//     if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
//       $.ajax({
//         url: 'get_category_children',
//         type: 'GET',
//         data: { parent_id: parentCategory },
//         dataType: 'json'
//       })
//       .done(function(children){
//         $('#children_wrapper').remove(); //親が変更された時、子以下を削除するする
//         $('#grandchildren_wrapper').remove();
//         $('#size_wrapper').remove();
//         $('#brand_wrapper').remove();
//         var insertHTML = '';
//         children.forEach(function(child){
//           insertHTML += appendOption(child);
//         });
//         appendChidrenBox(insertHTML);
//       })
//       .fail(function(){
//         alert('カテゴリー取得に失敗しました');
//       })
//     }else{
//       $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
//       $('#grandchildren_wrapper').remove();
//       $('#size_wrapper').remove();
//       $('#brand_wrapper').remove();
//     }
//   });
//   // 子カテゴリー選択後のイベント
//   $('.listing-product-detail__category').on('change', '#child_category', function(){
//     var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
//     if (childId != "---"){ //子カテゴリーが初期値でないことを確認
//       $.ajax({
//         url: 'get_category_grandchildren',
//         type: 'GET',
//         data: { child_id: childId },
//         dataType: 'json'
//       })
//       .done(function(grandchildren){
//         if (grandchildren.length != 0) {
//           $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除するする
//           $('#size_wrapper').remove();
//           $('#brand_wrapper').remove();
//           var insertHTML = '';
//           grandchildren.forEach(function(grandchild){
//             insertHTML += appendOption(grandchild);
//           });
//           appendGrandchidrenBox(insertHTML);
//         }
//       })
//       .fail(function(){
//         alert('カテゴリー取得に失敗しました');
//       })
//     }else{
//       $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
//       $('#size_wrapper').remove();
//       $('#brand_wrapper').remove();
//     }
//   });
// });