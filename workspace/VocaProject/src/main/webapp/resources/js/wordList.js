//책 셀렉트 박스 초기화 설정
bookService.getList(function(books) {
    let index = 0
    for (const book of books) {
        const bookOption = $(`<option value=${book.bookId}>${book.bookName}</option>`)
        if (index == 0) {
            //카테고리 셀렉트 박스 초기화 설정
            categoryService.getList(book.bookId, function(categories) {
                for (const category of categories) {
                    const categoryOption = $(`<option value=${category.categoryId}>${category.categoryName}</option>`)
                    $("#categorySelect").append(categoryOption)
                }
            })
        }
        $("#bookSelect").append(bookOption)
        ++index
    }
})



//책 셀렉트 박스 체인지 이벤트 핸들러
$("#bookSelect").on("change", function() {
    //카테고리 셀렉트 초기화
    $("#categorySelect").empty()

    const bookId = $(this).val()
    categoryService.getList(bookId, function(categories) {
        //기본이 내림차순이므로 오름차순으로 보여질 수 있도록 뒤집는다.
        categories.reverse()
        for (const category of categories) {
            const categoryOption = $(`<option value=${category.categoryId}>${category.categoryName}</option>`)
            $("#categorySelect").append(categoryOption)
        }
    })
})