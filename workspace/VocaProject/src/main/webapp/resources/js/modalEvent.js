document.addEventListener("DOMContentLoaded", () => {
    console.log("문서가 로딩 되었습니다.")

    const modifyModalButton = document.querySelector("#modifyModalButton")
    const removeModalButton = document.querySelector("#removeModalButton")
    const registerModalButton = document.querySelector("#registerModalButton")
    const closeButton = document.querySelector("#closeButton")    
    const modalFooter = document.querySelector(".modal-footer")

    const modalBody = document.querySelector(".modal-body")
    let modalTitle = document.querySelector(".modal-title")


    modifyModalButton.addEventListener("click", (event) => {
        console.log("폴더 수정 버튼을 클릭했습니다.")
        
        //모달 제목 설정
        modalTitle.textContent = "폴더 수정"

        //폴더 번호 라벨 설정
        const fnoLabel = document.createElement("label")
        fnoLabel.textContent = "번호"
        fnoLabel.setAttribute("for", "fno")
        modalBody.appendChild(fnoLabel)
        
        //폴더 번호 입력 태그 설정
        const fnoInput = document.createElement("input")
        fnoInput.value = "1"
        fnoInput.setAttribute("id", "fno")
        fnoInput.setAttribute("class", "form-control")
        fnoInput.setAttribute("readonly", "readonly")
        modalBody.appendChild(fnoInput)

        //폴더 이름 라벨 설정
        const nameLabel = document.createElement("label")
        nameLabel.textContent = "폴더 이름"
        nameLabel.setAttribute("for", "name")
        nameLabel.setAttribute("class", "mt-3")
        modalBody.append(nameLabel)

        //폴더 이름 입력 태그 설정
        const nameInput = document.createElement("input")
        nameInput.setAttribute("id", "name")
        nameInput.setAttribute("class", "form-control")
        modalBody.appendChild(nameInput)

        //모달 수정 버튼 설정
        const modifyButton = document.createElement("button")
        modifyButton.setAttribute("class", "btn btn-primary")
        modifyButton.setAttribute("id", "modifyButton")
        modifyButton.type = "submit"
        modifyButton.textContent = "수정하기"
        modalFooter.appendChild(modifyButton)

    })

    removeModalButton.addEventListener("click", () => {
        console.log("폴더 삭제 버튼을 클릭했습니다.")

        modalTitle.textContent = "폴더 삭제"
        
        
    })

    registerModalButton.addEventListener("click", () => {
        console.log("폴더 추가 버튼을 클릭했습니다.")

        modalTitle.textContent = "폴더 추가"
    })

    closeButton.addEventListener("click", () => {
        console.log("취소하기 버튼을 클릭했습니다.")

        document.querySelector("#fno").remove()
        document.querySelector("#name").remove()
        document.querySelector("label[for='fno']").remove()
        document.querySelector("label[for='name']").remove()
        document.querySelector("#modifyButton").remove()

    })
})