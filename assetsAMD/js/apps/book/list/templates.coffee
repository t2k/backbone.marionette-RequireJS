# modular template loading
define (require) ->
    book: require("text!apps/book/list/templates/book.htm")
    books: require("text!apps/book/list/templates/booklist.htm")
    layout: require("text!apps/book/list/templates/layout.htm")
    bookdetail:require("text!apps/book/detail/templates/bookdetail.htm")
