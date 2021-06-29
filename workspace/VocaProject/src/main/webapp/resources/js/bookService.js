console.log("BookService Module")
var bookService = (function() {
//책 리스트
function getList(callback, error) {
    
    $.getJSON("/books.json", function(list) {
        if (callback) {
            callback(list)
        }
        
    }).fail(function(xhr, status, err) {
        if (error) {
            error(err)
        }
    })
    
}

//책 추가하기
function add(bookVO, callback, error) {
    $.ajax({
        type: "post",
        url: "/books/new",
        data: JSON.stringify(bookVO),
        contentType: "application/json; charset=utf-8",
        success: function(result, status, xhr) {
            if (callback) {
                callback(result)
            }
        },
        error: function(xhr, status, er) {
            if (error) {
                error(er)
            }
        }
    })
}

//책 삭제하기
function remove(bookId, callback, error) {
    $.ajax({
        type: "delete",
        url: "/books/" + bookId,
        success: function(result, status, xhr) {
            if (callback) {
                callback(result)
            }
        },
        error: function(xhr, status, er) {
            if (error) {
                error(er)
            }
        }
    })
}

//책 수정하기
function modify(bookVO, callback, error) {
    $.ajax({
        type: "patch",
        url: "/books/" + bookVO.bookId,
        data: JSON.stringify(bookVO),
        contentType: "application/json; charset=utf-8",
        success: function(result, status, xhr) {
            if (callback) {
                callback(result)
            }
        },
        error: function(xhr, status, er) {
            if (error) {
                error(er)
            }
        }
    })
}

return {
    getList: getList,
    add: add,
    remove: remove,
    modify: modify
}
})()