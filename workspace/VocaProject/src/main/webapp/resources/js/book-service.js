console.log("bookService module")
let bookService = (function() {

    //특정 책 조회하기
    function get(bookId, callback, error) {
        console.log("bookService.get()")
        $.get("/books/" + bookId + ".json", function(bookVO) {
            if (callback) {
                callback(bookVO)
            }
        }).fail(function(xhr, status, err) {
            if (error) {
                error(err)
            }
        })
    }

    //모든 책 조회하기
    function getList(callback, error) {
        console.log("bookService.getList()")
        $.getJSON("/books.json", function(books) {
            if (callback) {
                callback (books)
            }
        }).fail(function(xhr, status, err) {
            if (error) {
                error(err)
            }
        })
    }



    return {
        get: get,
        getList: getList
    }


})()