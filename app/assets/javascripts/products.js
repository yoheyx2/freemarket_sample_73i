$(function() {

  function buildImg(index, url) {
    let html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  function buildFileField(index) {
    let html = `<div class="sell__product__image__box__data" data-index="${index}">
                <label class="sell__product__image__box__data__upload" for="product_product_images_attributes_${index}_image"><input accept="image/png,image/jpeg" style="display:none" class="sell__product__image__box__data__upload--js-file" type="file" name="product[product_images_attributes][${index}][image]" id="product_product_images_attributes_${index}_image">
                <img height="18" src="/icon_camera.png" width="20">
                <p class="sell__product__image__box__data__upload--js-select">選択</p>
                <span class="sell__product__image__box__data__upload--js-remove" style="visibility:hidden" data-index="${index}">削除</span>
                </label></div>`;
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

    $('.sell__product__image__box').on('change', '.sell__product__image__box__data__upload--js-file', function(e) {
      let targetIndex =  $(this).context.id.replace(/[^0-9]/g, '');
      let file = e.target.files[0];
      let blobUrl = window.URL.createObjectURL(file);
      let index =  $(".sell__product__image--preview").children().length

      if  (index <= 9) { 
        // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
        if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
          img.setAttribute('src', blobUrl);
        } else {  // 新規画像追加の処理
          $('.sell__product__image__box__data__upload--js-remove').attr('style', 'visibility:visible');
          $('.sell__product__image--preview').append(buildImg(targetIndex, blobUrl));
          // fileIndexの先頭の数字を使ってinputを作る
            $('.sell__product__image__box').append(buildFileField(fileIndex[0]));
            fileIndex.shift();
          // 末尾の数に1足した数を追加する
          fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
          console.log(index);
        }
      }
    });



  $('.sell__product__image__box').on('click', '.sell__product__image__box__data__upload--js-remove', function() {
    let targetIndex =  $(this).context.getAttribute("data-index");
    $(this).parent().parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
    if ($('.sell__product__image__box__data__upload--js-file').length == 0) $('.sell__product__image__box').append(buildFileField(fileIndex[0]));
  });


  $('.sell__product__price--input').change(function() {
    let commission = 10; 
    let value = $(this).val();
    let value_commission = Math.round((value * commission) / 100);
    let value_profit = parseInt(value) - parseInt(value_commission);

    if (value == 0) {
      $('.sell__product__fee__commission--js').text("ー");
      $('.sell__product__fee__profit--js').text("ー"); 
    } else {
      $('.sell__product__fee__commission--js').text("¥" + value_commission);
      $('.sell__product__fee__profit--js').text("¥" + value_profit);  
    }
  });

});