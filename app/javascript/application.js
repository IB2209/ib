// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


$(document).ready(function() {
  var beforePos = 0; // beforePos 変数をグローバルスコープで定義

  // メニューボタンがクリックされたときの処理
  $('.openbtn4').click(function() {
    $(".openbtn4").toggleClass("is-active");
    $(".menu").toggleClass("is-active");
    
    // stateをトグルする
    var state = $(this).hasClass('is-active');
    if (state) {
      var pos = $(window).scrollTop(); // posをPageTopAnime関数内に移動
      $('body').addClass('fixed').css({'top': 0});
    } else {
      $('body').removeClass('fixed').css({'top': 0});
      window.scrollTo(0, pos);
    }
  });

  // ヘッダーメニューのリンクがクリックされたときの処理
  $('#header .nav li a').click(function() {
    $('.openbtn4').removeClass('is-active');
    $('.menu').removeClass('is-active');
    $('body').removeClass('fixed');
  });

  // スクロール途中でヘッダーが消え、上にスクロールすると復活する処理
  function ScrollAnime() {
    var elemTop = $('#one, #company, #contact').offset().top;
    var scroll = $(window).scrollTop();
    if (scroll == beforePos) {
      // IE11対策で処理を入れない
    } else if (elemTop > scroll || 0 > scroll - beforePos) {
      $('#header').removeClass('UpMove').addClass('DownMove');
    } else {
      $('#header').removeClass('DownMove').addClass('UpMove');
    }
    beforePos = scroll;
  }

  // 画面をスクロールしたときの処理をまとめる
  function handleScroll() {
    ScrollAnime();
    PageTopAnime();
  }

  // スクロール時の動きやページ読み込み時の処理を登録
  $(window).scroll(handleScroll);
  $(window).on('load', handleScroll);

  // #page-topをクリックしたときの処理
  $('#page-top').click(function() {
    var scroll = $(window).scrollTop();
    if (scroll > 0) {
      $(this).addClass('floatAnime');
      $('body,html').animate({
        scrollTop: 0
      }, 2000, function() {
        $('#page-top').removeClass('floatAnime');
      });
    }
    return false;
  });

  //リンク先のidまでスムーススクロール
  //※ページ内リンクを行わない場合は不必要なので削除してください
  $('#header .nav li a[href^="#"]').click(function() {
    var elmHash = $(this).attr('href');
    var pos = $(elmHash).offset().top - $("#header").outerHeight(true); //header分の高さを引いた高さまでスクロール
    $('body,html').animate({scrollTop: pos}, 1000);
    return false;
});

});
