:- module('head', [head//0]).

:- use_module(library(http/html_write)).

head -->
    html([
        title('ZeusWPI'),
        \uikit
    ]).

uikit -->
    html([
        link([
            href='https://cdn.jsdelivr.net/npm/uikit@3.7.2/dist/css/uikit.min.css',
            rel=stylesheet
        ]),
        script([src='https://cdn.jsdelivr.net/npm/uikit@3.7.2/dist/js/uikit.min.js'], []),
        script([src='https://cdn.jsdelivr.net/npm/uikit@3.7.2/dist/js/uikit-icons.min.js'], []),
        meta([name='viewport', content='width=device-width', 'initial-scale'='1.0'])
    ]).