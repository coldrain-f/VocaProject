<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../admin/includes/header.jsp" %>
		
			<style>
				/* PC 1024px ~ */
				@media all and (min-width:1024px) {
					.input-answer {
						width: 300px !important;
					}
					.show-answer {
						width: 498px !important;
					}
					.title {
						font-size: 26px !important;
					}
					.state {
						font-size: 18px !important;
					}
				}
				
				/* 태블릿 가로, 태블릿 세로 768px ~ 1023px */
				@media all and (min-width: 768px) and (max-width:1023px) {
					.title {
						font-size: 22px;
					}
					.state {
						font-size: 16px !important;
					}
				}
				
				/* 모바일 가로, 모바일 세로 480px ~ 767px */
				@media all and (max-width: 767px) {
					.state {
						font-size: 14px !important;
					}
				}
			</style>


			<!-- 자바스크립트 모듈 -->
            <script src="/resources/js/category-service.js"></script>
            <script src="/resources/js/book-service.js"></script>
            
			<script>
				$(document).ready(function() {
					$("#bookSelect").empty()
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
		                            $("#categorySelect").empty()
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
				})
			</script>

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <div class="card shadow">
                        <div class="card-header">
                            <div class="row mb-4 pl-2 pr-2">
                                <label for="" class="form-label">폴더</label>
                                <select name="" id="bookSelect" class="custom-select">
                                    <option value="">단어가 읽기다 기본편</option>
                                </select>
                            </div>
                            <div class="row mb-4 pl-2 pr-2">
                                <label for="" class="form-label">카테고리</label>
                                <select name="" id="categorySelect" class="custom-select">
                                    <option value="">Unit 01 - 요리</option>
                                </select>
                            </div>
                            <div class="row mb-4 pl-2 pr-2 d-flex justify-content-end">
                                <button type="button" class="btn btn-info">학습 시작</button>
                            </div>
                            <hr>
                            <div class="row pl-2 pr-2 mt-1">
                                <h6 class="w-100 d-flex justify-content-center title mt-3">
                                    단어가 읽기다 기본편 Unit 01 - 요리
                                </h6>
                                <span class="w-100 d-flex justify-content-center state" style="font-size: 12px;">1/20</span>
                                <form action="" class="form-inline d-flex justify-content-end w-100 mt-4">
                                    <div class="input-group">
                                        <select name="" id="speech-language" class="custom-select mr-1">
                                            <option value="en-US" selected>영어</option>
                                            <option value="ja-JP">일본어</option>
                                            <option value="ko-KR">한국어</option>
                                        </select>
                                        <input type="text" id="speech-word" class="form-control" autocomplete="off" />
                                        <div class="input-group-append">
                                            <button type="button" id="speech-button" class="btn btn-outline-secondary">발음듣기</button>
                                        </div>
                                        <!-- TTS Script -->
                                        <script src="/resources/js/tts.js"></script>
                                    </div>
                                </form>
                            </div>
                            <!-- <h6 class="d-flex justify-content-center">단어가 읽기다 기본편 Unit 01 - 요리</h6> -->
                        </div>

                        <div class="card-body pt-5" style="height: 330px">
                            <div class="row d-flex justify-content-center mb-1 pt-5">
                                <form class="form-inline" action="">
                                    <label class="form-label mr-2 mb-1" for="" style="font-size: 18px">양념</label>
                                    <div class="input-group">
                                        <input class="form-control input-answer" type="text" placeholder="스펠링을 입력해 주세요..." >
                                        <div class="input-group-append">
                                            <button type="button" class="btn btn-outline-secondary">확인</button>
                                            <button type="button" class="btn btn-outline-secondary">모르겠어요</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="row d-flex justify-content-center">
                                <form class="form-inline" action="">
                                    <input class="form-control show-answer mt-2" type="text" size="48" placeholder="&ldquo;모르겠어요&rdquo;를 누르면 이곳에 뜻이 표시돼요!" disabled>
                                </form>
                            </div>

                            
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

           <%@ include file="../admin/includes/footer.jsp" %>