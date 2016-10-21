$(function(){

    function pageLoad(){
    	$('.event-image > a').magnificPopup({
            type: 'image'
        });
    	/*두번째 모달을 close, 첫번쨰 scroll 문제 해결*/
        $('.modal').on("hidden.bs.modal", function (e) {
            if($('.modal:visible').length)
            {
                $('.modal-backdrop').first().css('z-index', parseInt($('.modal:visible').last().css('z-index')) - 10);
                $('body').addClass('modal-open');
            }
        }).on("show.bs.modal", function (e) {
            if($('.modal:visible').length)
            {
                $('.modal-backdrop.in').first().css('z-index', parseInt($('.modal:visible').last().css('z-index')) + 10);
                $(this).css('z-index', parseInt($('.modal-backdrop.in').first().css('z-index')) + 10);
            }
        });
    }

    pageLoad();
    SingApp.onPageLoad(pageLoad);
});