:- module('page', [page_/1]).

:- use_module(library(http/html_write)).

:- use_module('body/body').
:- use_module('head/head').

:- meta_predicate page_(:).

page_(Content) :- 
    reply_html_page(
        [\head],
        [\body_(Content)]
    ).