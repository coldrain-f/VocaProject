<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="includes/header.jsp" %>
                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <div class="card shadow">
                        <div class="card-header">
                            <form action="/admin/word/list" method="get">
                                <!-- 책 이름 조회 -->
                                <div class="row mb-4 pl-2 pr-2">
                                    <label for="bookSelect" class="form-label">책</label>
                                    <select class="custom-select" name="bookId" id="bookSelect"></select>
                                </div>
                                <!-- ./책 이름 조회 -->
    
                                <!-- 카테고리 조회 -->
                                <div class="row mb-4 pl-2 pr-2">
                                    <label for="categorySelect" class="form-label">카테고리</label>
                                    <select class="custom-select" name="categoryId" id="categorySelect"></select>
                                </div>
                                <!-- ./카테고리 조회 -->

                                <div class="row d-flex justify-content-end">
                                    <button type="submit" class="btn btn-info mr-2">단어 조회</button>
                                </div>
                            </form>
                        </div>
                        
                        <!-- 자바스크립트 모듈 -->
                        <script src="/resources/js/category-service.js"></script>
                        <script src="/resources/js/book-service.js"></script>
                        
                        <script>
                        	$(document).ready(function() {
		                        const bookId = "<c:out value='${bookId }' />"
		                    	const categoryId = "<c:out value='${categoryId }' />"
		                    	const result = "<c:out value='${result }' />"
		                    	
		                    	//추가, 수정, 삭제 완료시 결과 모달창을 띄워준다.
		                    	if (result === "REGISTER SUCCESS") {
		                    		$("#result").text("단어 등록을 완료했습니다.")
		                    	} else if (result === "MODIFY SUCCESS") {
		                    		$("#result").text("단어 수정을 완료했습니다.")
		                    	} else if (result === "REMOVE SUCCESS") {
		                    		$("#result").text("단어 삭제를 완료했습니다.")
		                    	} else if (result === "NOT FOUND CATEGORY") {
		                    		$("#result").text("조회할 카테고리가 없습니다.")
		                    	}
		                    	
		                    	if (result !== "") {
		                    		$("#resultModal").modal("show")
		                    	}
		                    	
		                    	//단어 조회 버튼을 클릭하지 않았을 경우 처리 ( list 페이지 최초 접속 )
		                    	if (bookId === "" && categoryId === "") {
		                    		//책 셀렉트 박스 초기화 설정
			                        bookService.getList(function(books) {
			                            let index = 0
			                            //오름차순으로 보여주기 위해서 리스트를 뒤집는다.
			                            books.reverse()
			                            for (const book of books) {
			                                const bookOption = $("<option value='" + book.bookId + "'>" + book.bookName + "</option>")
			                                //첫 번째 책의 카테고리로 초기화해야 한다.
			                                if (index == 0) {	
			                                    //카테고리 셀렉트 박스 초기화 설정
			                                    categoryService.getList(book.bookId, function(categories) {
			                                    	//오름차순으로 보여질 수 있도록 리스트를 뒤집는다.
			                                    	categories.reverse()
			                                    	let optionEmpty = true
			                                        for (const category of categories) {
			                                        	const categoryOption = $("<option value='" + category.categoryId + "'>" + category.categoryName + "</option>")
			                                            $("#categorySelect").append(categoryOption)
			                                            optionEmpty = false
			                                        } 
			                                    	if (optionEmpty) { //카테고리가 비어있으면
			                                    		const categoryOption = $("<option value='-1'>소속된 카테고리가 존재하지 않습니다.</option>")
			                                    		$("#categorySelect").append(categoryOption)
			                                    	}
			                                    })
			                                }
			                                $("#bookSelect").append(bookOption)
			                                ++index
			                            }
			                        })	                    		
		                    	} else { //단어 조회 버튼을 클릭했을 경우 처리
		                    		if (bookId !== "" && categoryId !== "") {
		                    			//책 셀렉트 박스 초기화 설정
				                    	bookService.getList(function(books) {
				                    		//오름차순으로 보여질 수 있도록 리스트를 뒤집는다.
				                    		books.reverse()
				                    		for (const book of books) {
				                    			const bookOption = $("<option value='" + book.bookId + "'>" + book.bookName + "</option>")
				                    			$("#bookSelect").append(bookOption)
				                    		} 
				                    		//조회된 책이 선택되어야 한다.
				                    		$("#bookSelect option[value='" + bookId + "']").attr("selected", true)
				                    	})
			                    		
				                    	//기존의 카테고리 셀렉트 옵션 초기화
				                    	$("#categorySelect").empty()
				                    	
				                    	//카테고리 셀렉트 박스 초기화 설정
				                    	categoryService.getList(bookId, function(categories) {
				                    		//기본이 내림차순이므로 오름차순으로 보여질 수 있도록 뒤집는다.
				                    		categories.reverse()
				                    		for (const category of categories) {
				                    			const categoryOption = $("<option value='" + category.categoryId + "'>" + category.categoryName + "</option>")
				                    			//조회된 카테고리가 선택되어야 한다.
				                    			if ($(categoryOption).val() == categoryId) {
				                    				categoryOption.attr("selected", true)
				                    			}
				                    			$("#categorySelect").append(categoryOption)
				                    		}
				                    	})
			                    	}
		                    	}
		                    	
		                        //책 셀렉트 박스 체인지 이벤트 핸들러
								$("#bookSelect").on("change", function() {
								    //카테고리 셀렉트 초기화
								    $("#categorySelect").empty()
								    
								    const bookId = $(this).val()
								    categoryService.getList(bookId, function(categories) {
								        //기본이 내림차순이므로 오름차순으로 보여질 수 있도록 뒤집는다.
								        categories.reverse()
								        let optionEmpty = true
								        for (const category of categories) {
								        	const categoryOption = $("<option value='" + category.categoryId + "'>" + category.categoryName + "</option>")
								            $("#categorySelect").append(categoryOption)
								            optionEmpty = false
								        }
								        if (optionEmpty) { //카테고리가 비어있으면
								        	const categoryOption = $("<option value='-1'>소속된 카테고리가 존재하지 않습니다.</option>")
                                    		$("#categorySelect").append(categoryOption)
								        }
								    })
								})
								
								//테이블의 행 값 가져오기 (추가하기, 수정하기, 삭제하기 모달)
								$(".modalEventButton").on("click", function() {
						            const button = $(this)

						            const tr = button.parent().parent()
						            const td = tr.children()

						            const wordId = td.eq(1).text()
						            const wordName = td.eq(2).text()
						            const wordMeaning = td.eq(3).text()
						           	
						           	//최초 접근시엔 책 아이디와 카테고리가 아이디가 없으므로 체크해준다.
						            if (bookId !== "" && categoryId !== "") {
							            bookService.get(bookId, function(bookVO) {
							            	$("#modifyBookName").val(bookVO.bookName)
							            	$("#removeBookName").val(bookVO.bookName)
							            	$("#addBookName").val(bookVO.bookName)
							            	$("#addBookNameInfo").text(bookVO.bookName)
							            })
							            
							            categoryService.get(categoryId, function(categoryVO) {
							            	$("#modifyCategoryName").val(categoryVO.categoryName)
							            	$("#removeCategoryName").val(categoryVO.categoryName)
							            	$("#addCategoryName").val(categoryVO.categoryName)
							            	$("#addCategoryNameInfo").text(categoryVO.categoryName)
							            })
						            }
						            
						            
						            $("#modifyWordId").val(wordId)
						           	$("#modifyWordName").attr("placeholder", wordName)
						           	$("#modifyWordMeaning").attr("placeholder", wordMeaning)
						           	
						           	$("#modifyBookId").val(bookId)
						           	$("#modifyCategoryId").val(categoryId)

						           	$("#removeWordId").val(wordId)
						           	$("#removeWordName").val(wordName)
						           	$("#removeWordMeaning").val(wordMeaning)
						           	
						           	$("#removeBookId").val(bookId)
						           	$("#removeCategoryId").val(categoryId)
						           	
						           	$("#addBookId").val(bookId)
						           	$("#addCategoryId").val(categoryId)
						            
						           	$("#modifyWordNameInfo").text(wordName)
						           	$("#modifyWordMeaningInfo").text(wordMeaning)
						        });
                        		
                        	})
                        </script>
  
                        <div class="card-body">
                            <form class="form-inline" action="">
                                <select class="custom-select custom-select-sm mt-1" name="" id="">
                                    <option value="5">5</option>
                                    <option value="10" selected>10</option>
                                    <option value="15">15</option>
                                    <option value="20">20</option>
                                    <option value="25">25</option>
                                </select>

                                <label class="ml-2 form-label" for="">entries per page</label>
                            </form>

                            <!-- Begin Search Form -->
                            <div class="row mb-2 pl-2 pr-2 d-flex justify-content-end">
                                <form class="form-inline" action="" method="GET">
                                    <div class="input-group input-group-sm">
                                        <select class="custom-select custom-select-sm mr-1" name="" id="">
                                            <option value="">단어</option>
                                            <option value="">뜻</option>
                                        </select>
                                        <input class="form-control" type="text">

                                        <div class="input-group-append">
                                            <button class="btn btn-outline-secondary" type="button">
                                                <i class="fas fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <!-- Begin Table -->
                            <div class="table-responsive bg-white">
                                <table id="table" class="table table-sm table-hover">
                                    <caption class="mt-2">Showing 1 to 10 of 57 entries</caption>
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" id="all"><label class="form-label p-0 m-0 pl-2" for="all">ALL</label></th>
                                            <th>WORD_ID</th>
                                            <th>WORD_NAME</th>
                                            <th>WORD_MEANING</th>
                                            <th>REGDATE</th>
                                            <th>UPDATEDATE</th>
                                            <th class="text-center">ACTIONS</th>
                                            <th class="text-center">STATE</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="word" items="${words }">
	                                        <tr>
	                                            <td><input type="checkbox"></td>
	                                            <td><c:out value="${word.wordId }" /></td>
	                                            <td><c:out value="${word.wordName }" /></td>
	                                            <td><c:out value="${word.wordMeaning }" /></td>
	                                            <td><fmt:formatDate value="${word.regdate }" pattern="yyyy-MM-dd" /></td>	
	                                            <td><fmt:formatDate value="${word.updatedate }" pattern="yyyy-MM-dd" /></td>
	                                            <td class="text-center">
	                                                <button class="btn text-dark p-0 modalEventButton" type="button" data-toggle="modal" data-target="#modifyModal">
	                                                    <i class="fas fa-edit"></i>
	                                                </button>
	                                                <button class="btn text-dark p-0 ml-1 modalEventButton" type="button" data-toggle="modal" data-target="#deleteModal">
	                                                    <i class="fas fa-trash-alt"></i>
	                                                </button>
	                                                
	                                            </td>
	                                            <td class="text-center"><span class="badge badge-pill badge-info">NEW</span></td>
	                                        </tr>
                                    	</c:forEach>
                                        
                                    </tbody>
                                </table>
                            </div>

                            <!-- 단어 수정 모달창 -->
                            <div class="modal fade" id="modifyModal" tabindex="-1" aria-hidden="true">
                                <form action="/admin/word/modify" method="post">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">단어 수정</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <label class="form-label" for="modifyBookName">책 이름</label>
                                                <input type="text" class="form-control" name="bookName" id="modifyBookName" value="단어가 읽기다 기본편" readonly />

                                                <label class="form-label mt-2" for="modifyCategoryName">카테고리 이름</label>
                                                <input type="text" class="form-control" name="categoryName" id="modifyCategoryName" value="Unit 01 - 요리" readonly />

												<input type="hidden" name="bookId" id="modifyBookId" />
    										    <input type="hidden" name="categoryId" id="modifyCategoryId"  />
    										    
                                                <label class="form-label mt-2" for="modifyWordId">단어 번호</label>
                                                <input class="form-control" type="text" name="wordId" id="modifyWordId" value="1" readonly />
    
                                                <label class="form-label mt-2" for="modifyWordName">단어</label>
                                                <input class="form-control" type="text" name="wordName" id="modifyWordName" onkeyup="printResult('modifyWordName', 'modifyWordNameResult')" placeholder="spice" autocomplete="off" />
    
                                                <label class="form-label mt-2" for="modifyWordMeaning">뜻</label>
                                                <input class="form-control mb-4" type="text" name="wordMeaning" id="modifyWordMeaning" onkeyup="printResult('modifyWordMeaning', 'modifyWordMeaningResult')" placeholder="양념" autocomplete="off" />

                                                <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                                                    <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
                                                      <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
                                                    </symbol>
                                                    <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
                                                      <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
                                                    </symbol>
                                                    <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
                                                      <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                    </symbol>
                                                </svg>

                                                <div class="alert alert-info d-flex align-items-center" role="alert">
                                                    <svg class="bi flex-shrink-0 me-2 mr-2" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                                                    <div>
                                                      [ <span id="modifyWordNameInfo">spice</span> ] → [ <span id="modifyWordNameResult"></span> ]
                                                    </div>
                                                </div>
                                                <div class="alert alert-info d-flex align-items-center" role="alert">
                                                    <svg class="bi flex-shrink-0 me-2 mr-2" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                                                    <div>
                                                      [ <span id="modifyWordMeaningInfo">양념</span> ] → [ <span id="modifyWordMeaningResult"></span> ]
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
                                                <button type="submit" class="btn btn-primary">수정하기</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <!-- ./단어 수정 모달창 -->

                            <!-- 단어 삭제 모달창 -->
                            <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
                                <form action="/admin/word/remove" method="post">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">단어 삭제</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <label class="form-label" for="removeBookName">책 이름</label>
                                                <input type="text" class="form-control" name="bookName" id="removeBookName" value="단어가 읽기다 기본편" readonly />
                                                
                                                <label class="form-label mt-2" for="removeCategoryName">카테고리 이름</label>
                                                <input type="text" class="form-control" name="categoryName" id="removeCategoryName" value="Unit 01 - 요리" readonly /> 
    
                                                <input type="hidden" name="bookId" id="removeBookId" />
    										    <input type="hidden" name="categoryId" id="removeCategoryId" />
    
                                                <label class="form-label mt-2" for="removeWordId">단어 번호</label>
                                                <input class="form-control" type="text" name="wordId" id="removeWordId" value="1" readonly />
    
                                                <label class="form-label mt-2" for="removeWordName">단어</label>
                                                <input class="form-control" type="text" name="wordName" id="removeWordName" value="spice" readonly />
    
                                                <label class="form-label mt-2" for="removeWordMeaning">뜻</label>
                                                <input class="form-control" type="text" name="removeWordName" id="removeWordMeaning" value="양념" readonly />
                                            </div>
    
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
                                                <button type="submit" class="btn btn-primary">삭제하기</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                            </div>
                            <!-- ./단어 삭제 모달창 -->

                            <!-- 단어 추가 모달창 -->
                            <div class="modal fade" id="addModal" tabindex="-1" aria-hidden="true">
                                <form action="/admin/word/register" method="post">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">단어 추가</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <label class="form-label" for="addBookName">책 이름</label>     
                                                <input type="text" class="form-control" name="bookName" id="addBookName" readonly />
    
                                                <label class="form-label mt-2" for="addCategoryName">카테고리 이름</label>
                                                <input type="text" class="form-control" name="categoryName" id="addCategoryName" readonly />
                                                
                                                <input type="hidden" name="bookId" id="addBookId" value="" />
    										    <input type="hidden" name="categoryId" id="addCategoryId" value="" />

                                                <label class="form-label mt-2" for="addWordName">단어</label>
                                                <input type="text" class="form-control" name="wordName" id="addWordName" autocomplete="off"
                                                    onkeyup="printResult('addWordName', 'addWordNameResult')" placeholder="추가할 단어를 입력해 주세요..." />

                                                <label class="form-label mt-2" for="addWordMeaning">뜻</label>
                                                <input type="text" class="form-control mb-4" name="wordMeaning" id="addWordMeaning" autocomplete="off"
                                                    onkeyup="printResult('addWordMeaning', 'addWordMeaningResult')" placeholder="추가할 단어의 뜻을 입력해 주세요..." />

                                                <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                                                    <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
                                                      <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
                                                    </symbol>
                                                    <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
                                                      <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
                                                    </symbol>
                                                    <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
                                                      <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                                    </symbol>
                                                </svg>

                                                <div class="alert alert-info d-flex align-items-center" role="alert">
                                                    <svg class="bi flex-shrink-0 me-2 mr-2" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                                                    <div>
                                                      [ <span id="addBookNameInfo">단어가 읽기다 기본편</span> ] 책의 [ <span id="addCategoryNameInfo">Unit 01 - 요리</span> ]
                                                       카테고리에 [ <span id="addWordNameResult"></span> / <span id="addWordMeaningResult"></span> ] 단어가 추가됩니다.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
                                                <button type="submit" class="btn btn-primary" >추가하기</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <!-- ./단어 추가 모달창 -->
                            
                            <!-- 추가, 수정, 삭제 완료시 안내 모달창 -->
                            <div class="modal fade" id="resultModal" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">상태</h5>
                                            <button type="button" class="close" data-dismiss="modal">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <p id="result"></p>
                                        </div>
                                        <div class="modal-footer">
                                            <button id="stateCheckButton" type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- //추가, 수정, 삭제 완료 모달창 -->

                            <!-- Begin Pagination -->
                            <div class="row mt-3">
                                <div class="col d-flex justify-content-center">
                                    <nav>
                                        <ul class="pagination">
                                            <li class="page-item">
                                                <a class="page-link" href="#">
                                                    <span>&laquo;</span>
                                                </a>
                                            </li>
                                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                                            <li class="page-item"><a class="page-link" href="#">4</a></li>
                                            <li class="page-item"><a class="page-link" href="#">5</a></li>
                                            <li class="page-item">
                                                <a class="page-link" href="#">
                                                    <span>&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col d-flex justify-content-end">
                                    <button class="btn btn-primary modalEventButton" type="button" data-toggle="modal" data-target="#addModal">추가하기</button>
                                    <button type="button" class="ml-2 btn btn-primary">선택된 아이템 삭제</button>
                                </div>
                            </div>

                            
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
                
                <script type="text/javascript">
				    function printResult(inputElementId, targetElementId) {
				        const val = document.getElementById(inputElementId).value;
				        const result = document.getElementById(targetElementId).innerText = val;
				    }
			  	</script>

            <%@include file="includes/footer.jsp" %>