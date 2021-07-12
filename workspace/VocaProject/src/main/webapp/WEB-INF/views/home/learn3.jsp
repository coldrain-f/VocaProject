<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../admin/includes/header.jsp" %>
		
			<style>
				.input-answer {
						width: 298px !important;
				}
				#helpButton {
					margin-right: 2px;
				}
				.input-group {
					margin-top: 2px;
				}
				#problem {
					padding-bottom: 5px;
					padding-left: 5px;
					width: 453.06px;
					
				}
			
				/* PC 1024px ~ */
				@media all and (min-width:1024px) {
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
					.input-answer {
						width: 150px !important;
					}
					#helpResultInput {
						width: 270px !important;	
					}
					.state {
						font-size: 14px !important;
					}
				}
			</style>
			
            <!-- Underscore.js -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.15/lodash.min.js"></script>
            
			<script>
			
				function createOption(value, text) {
					return "<option value='" + value + "'>" + text + "</option>";
				}
			
				function getBookList() {
					return new Promise((resolve, reject) => {
						const url = "/books.json";
						$.getJSON(url, (books) => {
							resolve(books);
						}).fail((error) => {
							reject(new Error("getBookList() failed !"));
						});
					});
				}
				
				function getCategoryList(bookId) {
					return new Promise((resolve, reject) => {
						const url = "/books/" + bookId + "/categories.json";
						$.getJSON(url, (categories) => {
							resolve(categories);
						}).fail((error) => {
							reject(new Error("getCategoryList() failed !"));
						});
					});
				}
				
				getBookList().then(books => {
					books.reverse();
					books.forEach(book => {
						const option = createOption(book.bookId, book.bookName);
						$("#bookSelectBox").append(option);
					});
					
					const firstBook = books[0];
					return getCategoryList(firstBook.bookId);
					
				}).then(categories => {
					categories.reverse();
					categories.forEach(category => {
						const option = createOption(category.categoryId, category.categoryName);
						$("#categorySelectBox").append(option);
					});
				}).catch(error => console.log(error));
				
				$(document).ready(function() {
					$("#bookSelectBox").on("change", function() {
						console.log("change event !");
					});
				});
				
			</script>

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <div class="card shadow">
                        <div class="card-header">
                            <div class="row mb-4 pl-2 pr-2">
                                <label for="bookSelectBox" class="form-label">책</label>
                                <select name="" id="bookSelectBox" class="custom-select"></select>
                            </div>
                            <div class="row mb-4 pl-2 pr-2">
                                <label for="categorySelectBox" class="form-label">카테고리</label>
                                <select name="" id="categorySelectBox" class="custom-select"></select>
                            </div>
                           	<div class="form-check mb-2">
							  <input class="form-check-input" type="radio" name="type" id="type0" value="0" checked>
							  <label class="form-check-label" for="type0">
							    한글 단어로 퀴즈 출제하기 <br/>예시) 여자아이 → 女の子
							  </label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="radio" name="type" id="type1" value="1">
							  <label class="form-check-label" for="type1">
							    학습하려는 단어로 퀴즈 출제하기 <br/>예시) 女の子 → 여자아이
							  </label>
							</div>
                            <div class="row mb-4 pl-2 pr-2 d-flex justify-content-end">
                                <button id="startButton" type="button" class="btn btn-info">학습 시작</button>
                            </div>
                            <hr>
                            <div class="row pl-2 pr-2 mt-1">
                                <h6 class="w-100 d-flex justify-content-center title mt-3">
                                    <span id="bookName"></span>&nbsp;<span id="categoryName"></span>
                                </h6>
                                <span class="w-100 d-flex justify-content-center state" style="font-size: 12px;">
                                	<span id="start"></span><span id="total"></span>
                               	</span>                                
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
                                    <div class="input-group d-flex justify-content-center">
	                                    <label id="problem" for="userInput" class="form-label mr-2 mb-1" style="font-size: 24px"></label>
                                    </div>
                                <form class="form-inline" onsubmit="return false" >
                                    <div class="input-group">
                                        <input class="form-control input-answer" type="text" id="userInput" autocomplete="off" placeholder="스펠링을 입력해 주세요..." >
                                        <div class="input-group-append">
                                            <button id="checkButton" type="button" class="btn btn-outline-secondary">확인</button>
                                            <button id="helpButton" type="button" class="btn btn-outline-secondary">모르겠어요</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="row d-flex justify-content-center">
                                <form class="form-inline">
                                	<div class="input-group">
                                		<input class="form-control" id="helpResultInput" type="text" autocomplete="off" 
                                			size="48" placeholder="&ldquo;모르겠어요&rdquo;를 누르면 이곳에 정답이 표시돼요!" readonly>
                                		<div class="input-group-append">
                                			<button type="button" class="btn btn-outline-secondary btn-sm">
                                				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-volume-up-fill" viewBox="0 0 16 16">
  <path d="M11.536 14.01A8.473 8.473 0 0 0 14.026 8a8.473 8.473 0 0 0-2.49-6.01l-.708.707A7.476 7.476 0 0 1 13.025 8c0 2.071-.84 3.946-2.197 5.303l.708.707z"/>
  <path d="M10.121 12.596A6.48 6.48 0 0 0 12.025 8a6.48 6.48 0 0 0-1.904-4.596l-.707.707A5.483 5.483 0 0 1 11.025 8a5.483 5.483 0 0 1-1.61 3.89l.706.706z"/>
  <path d="M8.707 11.182A4.486 4.486 0 0 0 10.025 8a4.486 4.486 0 0 0-1.318-3.182L8 5.525A3.489 3.489 0 0 1 9.025 8 3.49 3.49 0 0 1 8 10.475l.707.707zM6.717 3.55A.5.5 0 0 1 7 4v8a.5.5 0 0 1-.812.39L3.825 10.5H1.5A.5.5 0 0 1 1 10V6a.5.5 0 0 1 .5-.5h2.325l2.363-1.89a.5.5 0 0 1 .529-.06z"/>
												</svg>
                                			</button>
                                		</div>
                                	</div>
                                </form>
                            </div>

                            
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->
                
                <!-- 단어 학습 상태 모달창 -->
                <div class="modal fade" id="stateModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
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
                        </div>
                    </div>
                </div>
              	<!-- //추가, 수정, 삭제 완료 모달창 -->

           <%@ include file="../admin/includes/footer.jsp" %>