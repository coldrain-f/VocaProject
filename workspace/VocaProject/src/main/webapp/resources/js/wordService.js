console.log("WordService Module")
var wordService = (function() {
    
    function getList(categoryId, callback, error) {
        const url = "/categories/" + categoryId + "/words"
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