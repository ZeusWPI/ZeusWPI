$(document).ready(
    function(){
        $('input:file').change(
            function(){
                if ($(this).val()) {
                    $('.file-upload .button .icon').removeClass('hidden');
                    $('.file-upload .button').addClass('is-disabled');
                    $('input:submit').removeClass('is-disabled');
                }
            }
        );

        var random_shit_index = 0;
        var random_shit = [
            'a cat picture',
            'a video of a moose',
            'your diary',
            'secret source code'
        ];

        setInterval(function(){
            $('.random-shit').fadeOut();
            $('.random-shit').promise().done(function () {
                $('.random-shit').text(random_shit[random_shit_index++ % random_shit.length]);
                $('.random-shit').fadeIn();
            });
        }, 3000);

        var progress = $('progress');

        $('form').ajaxForm({
            beforeSend: function() {
                $('progress').attr('value', 0);
                $('form').hide();
                $('.title').fadeOut();
                progress.fadeIn();
            },
            uploadProgress: function(event, position, total, percentComplete) {
                $('progress').attr('value', percentComplete);
            },
            complete: function(xhr) {
                $('progress').attr('value', 100);
                $('.title').promise().done(function () {
                    $('.title').text('File uploaded');
                    $('.title').fadeIn();
                });
                progress.fadeOut();

                $('.subtitle').text('http://zeus.ugent.be/zeuswpi/' + xhr.responseText);
            }
        });
    });
