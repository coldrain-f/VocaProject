<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="includes/header.jsp" %>

                <!-- 카테고리 관리 테이블 -->
                <div class="container-fluid">
                    <div class="card shadow">
                        <div class="card-header">
                            <!-- 카테고리 조회 폼 -->
                            <form action="/admin/category/list" method="get">
                                <div class="row mb-4 pl-2 pr-2">
                                    <label for="bookSelect" class="form-label">책</label>
                                    <select class="custom-select" name="bookId" id="bookSelect">
                                    	<c:forEach var="book" items="${books }">
                                    		<option value="<c:out value="${book.bookId }"/>" ${book.bookId eq bookId ? 'selected' : '' }>
                                    			<c:out value="${book.bookName }" />
                                    		</option>
                                    	</c:forEach>
                                    </select>
                                </div>
    
                                <div class="row d-flex justify-content-end mr-0">
                                    <button type="submit" class="btn btn-info">카테고리 조회</button>
                                </div>
                            </form>
                            <!-- 카테고리 조회 폼 -->
                        </div>
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
                                            <option value="">카테고리</option>
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

                            <!-- 테이블 데이터 -->
                            <div class="table-responsive bg-white">
                                <table class="table table-sm table-hover">
                                    <caption class="mt-2">Showing 1 to 10 of 57 entries</caption>
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" id="all"><label class="form-label p-0 m-0 pl-2" for="all">ALL</label></th>
                                            <th>CATEGORY_ID</th>
                                            <th>CATEGORY_NAME</th>
                                            <th>REGDATE</th>
                                            <th>UPDATEDATE</th>
                                            <th class="text-center">ACTIONS</th>
                                            <th class="text-center">STATE</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="category" items="${categories }">
                                    		<tr>
	                                            <td><input type="checkbox"></td>
	                                            <td><c:out value="${category.categoryId }" /></td>
	                                            <td>
	                                            	<a class="text-muted" href="/admin/word/list?bookId=<c:out value="${bookId }" />&categoryId=<c:out value="${category.categoryId }" />" ><c:out value="${category.categoryName }" /></a>
                                            	</td>
	                                            <td><fmt:formatDate value="${category.regdate }" pattern="yyyy-MM-dd" /></td>	
	                                            <td><fmt:formatDate value="${category.updatedate }" pattern="yyyy-MM-dd" /></td>
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
                            <!-- ./테이블 데이터 -->
                            
                            <!-- 자바스크립트 모듈 -->
                            <script src="/resources/js/book-service.js"></script>
                            <script src="/resources/js/category-service.js"></script>
                            <script src="/resources/js/word-service2.js"></script>
                            
                            <script>
                            	$(document).ready(function () {
                            		const bookId = "<c:out value='${bookId }' />"
                            		const result = "<c:out value='${result }' />"
                           			const page = "<c:out value='${criteria.page }' />"
        		                    const amount = "<c:out value='${criteria.amount }' />"	
                            		
                            		if (result === "REGISTER SUCCESS") {
                            			$("#result").text("카테고리 등록을 완료했습니다.")
                            		} else if (result === "MODIFY SUCCESS") {
                            			$("#result").text("카테고리 수정을 완료했습니다.")
                            		} else if (result === "REMOVE SUCCESS") {
                            			$("#result").text("카테고리 삭제를 완료했습니다.")
                            		}
                            		
                            		if (result !== "") {
                            			$("#resultModal").modal("show")
                            		}
                            		
                            		//테이블의 행 값을 가져오기
		                            $(".modalEventButton").on("click", function(){
							            const button = $(this)
							
							            const tr = button.parent().parent()
							            const td = tr.children()
							
							            const categoryId = td.eq(1).text();
							            const categoryName = td.eq(2).children("a").text()
							            
							            if (bookId !== "") {
								            bookService.get(bookId, function(bookVO) {
								            	$("#modifyBookName").val(bookVO.bookName)
								            	$("#removeBookName").val(bookVO.bookName)
								            	$("#addBookName").val(bookVO.bookName)
								            	$("#addBookNameInfo").text(bookVO.bookName)
								            	$("#addBookId").val(bookVO.bookId)
								            	$("#modifyBookId").val(bookVO.bookId)
								            	$("#removeBookId").val(bookVO.bookId)
								            })							            	
							            }
							            
							            //카테고리 아이디에 소속된 모든 단어를 조회한다.
							            if (categoryId !== "") { //추가하기 버튼은 카테고리 아이디가 없다.
								            wordService.getList(categoryId, function(words) {
							            		//기존의 삭제 셀렉트 박스에 있는 데이터 초기화
							            		$("#removeWordSelect").empty()
							            		let optionEmpty = true
								            	for (const word of words) {
								            		//삭제 셀렉트 박스에 소속된 단어 추가
								            		const option = $("<option>" + word.wordName + " / " + word.wordMeaning + "</option>")
								            		$("#removeWordSelect").append(option)
								            		optionEmpty = false
								            	}
							            		
							            		//소속된 단어가 하나도 없다면
							            		if (optionEmpty) {
							            			const option = $("<option>소속된 단어가 존재하지 않습니다.</option>")
							            			$("#removeWordSelect").append(option)
							            		}
								            })
							            }
							            
							            //페이징 정보 설정
							            $("input[name='page']").val(page)
							            $("input[name='amount']").val(amount)
							           
							            
							            $("#modifyCategoryId").val(categoryId)
							            $("#modifyCategoryName").attr("placeholder", categoryName)
							            $("#modifyCategoryNameInfo").text(categoryName)
							            
							            $("#removeCategoryId").val(categoryId)
							            $("#removeCategoryName").val(categoryName)
							            $("#removeCategoryNameInfo").text(categoryName)
							        })
                            	})
                            
                            </script>
                            

                            <!-- 카테고리 수정 모달창 -->
                            <div class="modal fade" id="modifyModal" tabindex="-1" aria-hidden="true">
                                <form action="/admin/category/modify" method="post">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">카테고리 수정</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <label class="form-label" for="modifyBookName">책 이름</label>
                                                <input type="text" class="form-control" name="bookName" id="modifyBookName" readonly />
                                                
                                                <input type="hidden" name="bookId" id="modifyBookId" />
                                                <input type="hidden" name="page" />
    										    <input type="hidden" name="amount" />
    
                                                <label class="form-label mt-2" for="modifyCategoryId">카테고리 번호</label>
                                                <input class="form-control" type="text" name="categoryId" id="modifyCategoryId" readonly />
    
                                                <label class="form-label mt-2" for="modifyCategoryName">카테고리 이름</label>
                                                <input class="form-control mb-4" type="text" name="categoryName" id="modifyCategoryName" 
                                                    onkeyup="printResult('modifyCategoryName', 'modifyCategoryNameResult')" autocomplete="off" />

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
                                                      [ <span id="modifyCategoryNameInfo"></span> ] → [ <span id="modifyCategoryNameResult"></span> ]
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
                                                <button type="submit" class="btn btn-primary" >수정하기</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <!-- ./카테고리 수정 모달창 -->

                            <!-- 카테고리 삭제 모달창 -->
                            <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
                                <form action="/admin/category/remove" method="post">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">카테고리 삭제</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <label class="form-label" for="removeBookName">책 이름</label>
                                                <input type="text" class="form-control" name="bookName" id="removeBookName" readonly >
                                                
                                                <input type="hidden" name="bookId" id="removeBookId" />
                                                <input type="hidden" name="page" />
    										    <input type="hidden" name="amount" />
    
                                                <label class="form-label mt-2" for="removeCategoryId">카테고리 번호</label>
                                                <input class="form-control" type="text" name="categoryId" id="removeCategoryId" readonly />
    
                                                <label class="form-label mt-2" for="removeCategoryName">카테고리 이름</label>
                                                <input class="form-control" type="text" name="categoryName" id="removeCategoryName" readonly />

                                                <label class="form-label mt-2" for="removeWordSelect">소속된 단어</label>
                                                <select class="custom-select mb-4" id="removeWordSelect"></select>

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

                                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                                    <svg class="bi flex-shrink-0 me-2 mr-2" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                                                    <div>
                                                      [ <span id="removeCategoryNameInfo"></span> ] 에 소속된 모든 단어들도 같이 삭제됩니다.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
                                                <button type="submit" class="btn btn-primary">삭제하기</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                            </div>
                            <!-- ./카테고리 삭제 모달창 -->

                            <!-- 카테고리 추가 모달창 -->
                            <div class="modal fade" id="addModal" tabindex="-1" aria-hidden="true">
                                <form action="/admin/category/register" method="post">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">카테고리 추가</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <label class="form-label" for="addBookName">책 이름</label>
                                                <input class="form-control" type="text" name="bookName" id="addBookName" readonly />
    
    											<input type="hidden" name="bookId" id="addBookId" />
    											<input type="hidden" name="page" />
    										    <input type="hidden" name="amount" />
    
                                                <label class="form-label mt-2" for="addCategoryName">카테고리 이름</label>
                                                <input class="form-control mb-4" type="text" name="categoryName" id="addCategoryName" 
                                                    onkeyup="printResult('addCategoryName', 'addCategoryNameResult')" placeholder="추가할 카테고리명을 입력해 주세요..." autocomplete="off" />

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
                                                      [ <span id="addBookNameInfo"></span> ] 책에 [ <span id="addCategoryNameResult"></span> ] 카테고리가 추가됩니다.
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
                            <!-- ./카테고리 추가 모달창 -->
                            
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

                            <!-- 추가, 삭제, 수정 관련 모달 JQuery -->
                            <script>
                                function printResult(inputElementId, targetElementId) {
                                    const val = document.getElementById(inputElementId).value;
                                    const result = document.getElementById(targetElementId).innerText = val;
                                }
                            </script>
                            <!-- ./추가, 삭제, 수정 관련 모달 JQuery -->
                            
                            <!-- Begin Pagination -->
                            <c:if test="${bookId ne null }">
	                            <div class="row mt-3">
	                                <div class="col d-flex justify-content-center">
	                                    <nav>
	                                        <ul class="pagination">
	                                            <li class="page-item ${pageDTO.prev ? '' : 'disabled' }">
	                                                <a class="page-link" href="/admin/category/list?bookId=${bookId }&page=${pageDTO.startPage - 1}&amount=10">
	                                                    <span>&laquo;</span>
	                                                </a>
	                                            </li>
	                                            <c:forEach var="index" begin="${pageDTO.startPage }" end="${pageDTO.endPage }" step="1">
		                                            <li class="page-item ${pageDTO.criteria.page eq index ? 'active' : '' }">
		                                            	<a class="page-link" 
		                                            		href="/admin/category/list?bookId=${bookId }&page=${index }&amount=${pageDTO.criteria.amount}">${index }
	                                            		</a>
		                                            </li>
	                                            </c:forEach>
	                                            <li class="page-item ${pageDTO.next ? '' : 'disabled' }">
	                                                <a class="page-link" href="#">
	                                                    <span>&raquo;</span>
	                                                </a>
	                                            </li>
	                                        </ul>
	                                    </nav>
	                                </div>
	                            </div>
                            </c:if>

                            <div class="row">
                                <div class="col d-flex justify-content-end">
                                    <button class="btn btn-primary modalEventButton" type="button" data-toggle="modal" data-target="#addModal">추가하기</button>
                                    <button type="button" class="ml-2 btn btn-primary">선택된 아이템 삭제</button>
                                </div>
                            </div>

                            
                        </div>
                    </div>
                </div>
                
                <!-- ./카테고리 관리 테이블 -->
                
<%@ include file="includes/footer.jsp" %>