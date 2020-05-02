$(function() {

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

