$(function(){
  function appendOption(category) {
    let html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリー表示作成
  function appendChildrenBox(insertHTML) {
    let childrenSelectHtml = '';
    childrenSelectHtml =
      `<div class="item-category__form">
        <select class="select-form__add" id="category-children">
          <option value="" data-category="" >選択してください</option>
        ${insertHTML}</select>
      </div>`;
    $('.item-category').append(childrenSelectHtml);
  }
  // 孫カテゴリー表示作成
  function appendGrandchildrenBox(insertHTML) {
    let grandchildrenSelectHtml = '';
    grandchildrenSelectHtml =
      `<div class="item-category__form">
        <select class="select-form__add" id="category-grandchildren">
          <option value="" data-category="" >選択してください</option>
        ${insertHTML}</select>
      </div>`;
    $('.item-category').append(grandchildrenSelectHtml);
  }
  // 親カテゴリー選択後、イベント発火
  $(document).on("change","#category-parent",function(){
    let parentCategory = $(this).val();
    if (parentCategory != "") {
      $.ajax({
        url: '/items/category_children',
        type: "GET",
        data: {parent_name: parentCategory},
        dataType: 'json'
      })
      .done(function(children){
        $("#category-children").remove();
        $("#category-grandchildren").remove();
        let insertHTML = '';
        children.forEach(function(child) {
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function() {
        alert('error：カテゴリーの取得に失敗しました');
      })
    }
    else{
      $("#category-children").remove();
      $("#category-grandchildren").remove();
    }
  });

  // 子カテゴリー選択後、イベント発火
  $(document).on('change', '#category-children', function(){
    let childrenId = $('#category-children option:selected').data('category');
    if (childrenId != ""){
      $.ajax({
        url: '/items/category_grandchildren',
        type: 'GET',
        data: { children_id: childrenId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#category-grandchildren').remove();
          let insertHTML = '';
          grandchildren.forEach(function(grandchildren){
            insertHTML += appendOption(grandchildren);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#category-grandchildren').remove();
    }
  });
});