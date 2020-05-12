window.addEventListener('DOMContentLoaded', function(){
  let submit = document.getElementById("submit-button");
  Payjp.setPublicKey('pk_test_1aa53dbf439ed3e73ee27d98');
    submit.addEventListener('click', function(e){
    e.preventDefault();
    let card = {
        number: document.getElementById("number").value,
        cvc: document.getElementById("cvc").value,
        exp_month: document.getElementById("exp_month").value,
        exp_year: document.getElementById("exp_year").value
    };
    Payjp.createToken(card, function(status, response) {
      if (status === 200) {
        $("#number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name"); 
        $("#charge-form").append(
          $('<input type="hidden" name="payjp_token">').val(response.id)
        ); 
        document.inputForm.submit();
        alert("登録が完了しました");
      } else {
        alert("カード情報が正しくありません。");
      }
    });
  });
});