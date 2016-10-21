$(function(){

    $('.widget').widgster();
    
    function pageLoad(){
        $('#tooltip-enabled, #max-length').tooltip();
        $('.selectpicker').selectpicker();
        $(".select2").each(function(){
            $(this).select2($(this).data());
        });

        $("#mask-date").inputmask({mask: "9999-99-99"});

        $('#markdown').markdown();

        $('.js-slider').slider();
        
        $('img[data-src]').each(function(){
            delete this.holder_data;
        });
    }
    pageLoad();
    SingApp.onPageLoad(pageLoad);
});