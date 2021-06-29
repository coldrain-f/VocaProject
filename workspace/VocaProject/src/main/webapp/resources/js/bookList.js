document.addEventListener("DOMContentLoaded", () => {
    bookService.getList(function(list) {
        
        //단어 책 리스트를 제대로 가져오는지 테스트
        const len = list.length || 0
        for (let i = 0; i < len; i++) {
            //console.log(list[i])
        }
        
        //<tr>태그 만들어서 뿌려주는 로직을 작성해야 됨
        for (let i = 0; i < len; i++) {
            const bookVO = {
                    bookId: list[i].bookId,
                    bookName: list[i].bookName,
                    regdate: list[i].regdate,
                    updatedate: list[i].updatedate
            } 
            createTableData(bookVO)
        }
        
    })
    
    //추가 모달창에서 추가하기 버튼을 클릭하면 데이터 추가
    let addButton = document.querySelector("#addButton")
    addButton.addEventListener("click", function() {
        const bookName = document.querySelector("#addBookName").value
        console.log("bookName = " + bookName)
        
        const bookVO = { bookName: bookName }
        bookService.add(bookVO, function() {
            $("#addModal").modal("hide")
            const result = document.querySelector("#result")
            result.textContent = "[ " + bookVO.bookName + " ]"+ "을/를 추가했습니다."
            $("#resultModal").modal("show")
        })
    })
    
    //상태 모달창에서 확인 버튼을 클릭하면 새로고침
    const stateCheckButton = document.querySelector("#stateCheckButton")
    stateCheckButton.addEventListener("click", function() {
        $("#resultModal").modal("hide")
        location.reload(true)
    })
    
    //삭제 모달창에서 삭제하기 버튼을 클릭하면 데이터 삭제
    const removeButton = document.querySelector("#removeButton")
    removeButton.addEventListener("click", function() {
        const bookName = document.querySelector("#removeBookName").value
        const bookId = document.querySelector("#removeBookId").value
        bookService.remove(bookId, function() {
            $("#deleteModal").modal("hide")
            const result = document.querySelector("#result")
            result.textContent =  "[ " + bookName + " ]" + "을/를 삭제했습니다."
            $("#resultModal").modal("show")
            
        })
    })
    
    //삭제 모달창에서 취소하기 버튼을 클릭하면 소속된 카테고리 초기화
    const removeCloseButton = document.querySelector("#removeCloseButton")
    removeCloseButton.addEventListener("click", function() {
        //카테고리 셀레트를 가지고 온다.
        const categorySelect = document.querySelector("#categorySelect")
        
        //모든 자식을 제거한다.
        while(categorySelect.hasChildNodes()) {
            categorySelect.removeChild(categorySelect.firstChild)
        }
    })	
    
    //수정 모달창에서 수정하기 버튼을 클릭하면 데이터 수정
    const modifyButton = document.querySelector("#modifyButton")
    modifyButton.addEventListener("click", function() {
        const bookId = document.querySelector("#modifyBookId").value
        const bookName = document.querySelector("#modifyBookName").value
        
        //console.log("bookId = " + bookId)
        //console.log("bookName = " + bookName)
        const bookVO = {
            bookId: bookId,
            bookName: bookName
        }
        bookService.modify(bookVO, function() {
            $("#modifyModal").modal("hide")
            const result = document.querySelector("#result")
            result.textContent = "[ " + bookVO.bookName + " ]" + "을/를 수정했습니다."
            $("#resultModal").modal("show")
        })
        
    })
    
    
    function createTableData(bookVO) {
        //console.log("createTableData()")
        const tbody = document.querySelector("tbody")
        const tr = document.createElement("tr")
        
        // <th>ALL</th>
        const all = document.createElement("td")
        const checkbox = document.createElement("input")
        checkbox.setAttribute("type", "checkbox")
        all.appendChild(checkbox)
        
        // <th><BOOK_ID></th>
        const bookId = document.createElement("td")
        bookId.textContent = bookVO.bookId
        
        // <th>BOOK_NAME</th>
        const bookName = document.createElement("td")
        bookName.textContent = bookVO.bookName
        
        // <th>REGDATE</th>
        const regdate = document.createElement("td")
        regdate.textContent = bookVO.regdate
        
        // <th>UPDATEDATE</th>
        const updatedate = document.createElement("td")
        updatedate.textContent = bookVO.updatedate
        
        // <th>ACTIONS</th>
        const actions = document.createElement("td")
        actions.setAttribute("class", "text-center")
        const modifyButton = document.createElement("button")
        modifyButton.setAttribute("class", "btn text-dark p-0 modalEventButton")
        modifyButton.setAttribute("type", "button")
        modifyButton.setAttribute("data-toggle", "modal")
        modifyButton.setAttribute("data-target", "#modifyModal")
        
        const modifyIcon = document.createElement("i")
        modifyIcon.setAttribute("class", "fas fa-edit")

        modifyButton.appendChild(modifyIcon)
        actions.appendChild(modifyButton)

        const removeButton = document.createElement("button")
        removeButton.setAttribute("class", "event btn text-dark p-0 ml-1 modalEventButton")
        removeButton.setAttribute("type", "button")
        removeButton.setAttribute("data-toggle", "modal")
        removeButton.setAttribute("data-target", "#deleteModal")
        
        const removeIcon = document.createElement("i")
        removeIcon.setAttribute("class", "fas fa-trash-alt")
        
        removeButton.appendChild(removeIcon)
        actions.appendChild(removeButton)
        
        // <th>STATE</th>
        const state = document.createElement("td")
        state.setAttribute("class", "text-center")
        const span = document.createElement("span")
        span.setAttribute("class"," badge badge-pill badge-info")
        span.textContent = "NEW"
        
        state.appendChild(span)
        
        // td 추가
        tr.appendChild(all)
        tr.appendChild(bookId)
        tr.appendChild(bookName)
        tr.appendChild(regdate)
        tr.appendChild(updatedate)
        tr.appendChild(actions)
        tr.appendChild(state)
        
        // tr 추가
        tbody.appendChild(tr)
    }
    
    //클릭한 행의 테이블 데이터 가져오기
    $(document).on("click", ".modalEventButton", function() {
        console.log("이벤트 버튼...........")
        const button = $(this)
        
        const tr = button.parent().parent()
        const td = tr.children()

        //console.log("FNO = " + td.eq(1).text())
        //console.log("FOLDER_NAME = " + td.eq(2).text())

        const bookId = td.eq(1).text()
        const bookName = td.eq(2).text()

        //수정 창
        document.getElementById("modifyBookId").value = bookId
        document.getElementById("modifyBookName").placeholder = bookName
        document.getElementById("modify_result0").innerText = bookName

        //삭제 창
        document.getElementById("removeBookId").value = bookId
        document.getElementById("removeBookName").value = bookName
        document.getElementById("remove_result0").innerText = bookName
        
        //삭제 창 카테고리 셀렉트
        const categorySelect = document.querySelector("#categorySelect")
        
        categoryService.getList(bookId, function(list) {
            const len = list.length || 0
            for (i = len - 1; i >= 0; i--) {
                const option = document.createElement("option")
                option.setAttribute("value", list[i].categoryId)
                if (i == len - 1) {
                    option.setAttribute("selected", "selected")
                }
                option.textContent = list[i].categoryName
                categorySelect.appendChild(option)
            }
        })
        
    })  	
})