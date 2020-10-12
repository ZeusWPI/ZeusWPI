$(document).ready(
    function () {
        $('input:file').change(
            function () {
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
            'secret source code',
            'a copyrighted video'
        ];

        let randomShitDiv = $('.random-shit')

        setInterval(function () {
            randomShitDiv.fadeOut();
            randomShitDiv.promise().done(function () {
                randomShitDiv.text('Upload ' + random_shit[random_shit_index++ % random_shit.length]);
                randomShitDiv.fadeIn();
            });
        }, 3000);

        var progress = $('progress');
        let title = $('.title');
        let form = $('form');
        let feedback = $('.feedback');

        form.ajaxForm({
            beforeSend: function () {
                $('progress').attr('value', 0);
                $('form input').prop("disabled", true);
                title.fadeOut();
                title.promise().done(function () {
                    title.text('File uploading...');
                    title.fadeIn();
                });
                progress.fadeIn();
            },
            uploadProgress: function (event, position, total, percentComplete) {
                $('progress').attr('value', percentComplete);
            },
            complete: function (xhr) {
                $('progress').attr('value', 100);
                progress.fadeOut();
            },
            success: function (responseText, statusText, xhr, form) {
                title.promise().done(function () {
                    title.text('File uploaded');
                    title.fadeIn();
                });
                form.fadeOut();
                form.promise().done(function () {
                    let imageUrl = document.location.href + responseText
                    feedback.html(`<a href="${imageUrl}">${imageUrl}</a>`);
                    feedback.fadeIn();
                });
            },
            error: function (xhr) {
                title.promise().done(function () {
                    title.text("Something went wrong :-(");
                    title.fadeIn();
                });
                form.fadeOut();
                form.promise().done(function () {
                    feedback.text("Try another file perhaps. It's not *our* fault.");
                    feedback.fadeIn();
                });
            }
        });
    });
