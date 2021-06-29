console.log("CategoryService Module")
let categoryService = (function() {
    //특정 책의 모든 카테고리 리스트
    function getList(bookId, callback, error) {
        const url = "/books/" + bookId + "/categories"
        $.getJSON(url, function(list) {
            if (callback) {
                callback(list)
            }
        }).fail(function(xhr, status, err) {
            if (error) {
                error(err)
            }
        })
    }
    
    return {
        getList: getList
    }
})()