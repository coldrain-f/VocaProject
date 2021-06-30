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

    //특정 카테고리 조회
    function get(categoryId, callback, error) {
        console.log("특정 카테고리 조회 호출")
        $.get("/categories/" + categoryId + ".json", function(categoryVO) {
            if (callback) {
                callback(categoryVO)
            }
        }).fail(function(xhr, status, err) {
            if (error) {
                error(err)
            }
        })

    }
    return {
        getList: getList,
        get: get
    }
})()