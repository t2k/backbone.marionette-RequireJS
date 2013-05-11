#templates
define (require) ->
    book: require('text!templates/book.htm')
    bookdetail: require('text!templates/bookdetail.htm')
    booklist: require('text!templates/booklist.htm')
    librarylayout: require('text!templates/librarylayout.htm')
    secondapp: require('text!templates/secondapp.htm')