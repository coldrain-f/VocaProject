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


			<!-- 자바스크립트 모듈 -->
            <script src="/resources/js/category-service.js"></script>
            <script src="/resources/js/book-service.js"></script>
            <script src="/resources/js/word-service2.js"></script>
            
            <!-- Underscore.js -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.15/lodash.min.js"></script>
            
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
					
					
					$("#startButton").on("click", function() {
						const categoryId = $("#categorySelect option:selected").val()
						
						const bookName = $("#bookSelect option:selected").text()
						const categoryName = $("#categorySelect option:selected").text()
						
						$("#bookName").text(bookName)
						$("#categoryName").text(categoryName)
						
						let words = null
						let wrongWords = []
						let total = 0
						let completeGetShuffleList = false
						wordService.getShuffleList(categoryId, function(list) {
							words = list
							//total을 구한다.
							for (const word of words) {
								++total
							}
							completeGetShuffleList = true
						})
						
						const listCheckInterval = setInterval(function() {
							//0.1초 단위로 리스트를 가져왔는지 체크한다.
							if (completeGetShuffleList) { //단어 리스트를 가져왔다면
								console.log("RestAPI에서 정상적으로 단어 리스트를 가져왔습니다.")
								//인터벌을 클리어하고 학습을 시작한다.
								clearInterval(listCheckInterval)
								startStudy(words)
							}
						}, 100)
						
						let isRun = false
						
						// 학습 시작
						function startStudy(items) {
							console.log("단어 학습을 시작합니다.")
							for (const item of items) {
								console.log(item)
							}
							// 첫 번째 문제 출제
							let index = 0
							let problem = items[index].wordMeaning
							$("#problem").text(problem)
							$("#total").text(total)
							$("#start").text((index + 1) +"/")
							$("#helpResultInput").attr("placeholder", '"모르겠어요"를 누르면 이곳에 정답이 표시돼요!')
							$("#userInput").on("keyup", function(e) {
								if (e.keyCode === 13 && isRun == false) {
									//사용자가 정답 전송의 연타를 방지하기 위한 코드
									
									isRun = true
									// 사용자 입력과 정답이 같다면
									const answer = $.trim(items[index].wordName)
									const userInput = $.trim($("#userInput").val())

									//console.log("정답: " + answer)
									//console.log("사용자 입력: " + userInput)
									
									//정답일 경우 처리
									if (userInput === answer) {
										++index
										if (index >= items.length) { //학습이 종료 되었다면
											$("#result").text("학습을 종료합니다.")
											$("#resultModal").modal("show")
											setTimeout(function() {
												location.reload()
											}, 1000)
										} else { //학습이 종료되지 않았다면
											$("#result").text("정답입니다.")
											$("#resultModal").modal("show")
											setTimeout(function() {
												$("#userInput").val("")
												$("#helpResultInput").attr("placeholder", '"모르겠어요"를 누르면 이곳에 정답이 표시돼요!')
												$("#resultModal").modal("hide")
												$("#userInput").focus()
												
												//새로운 문제 출제
												problem = items[index].wordMeaning
												$("#start").text((index + 1) + "/")
												$("#problem").text(problem)
												isRun = false
												
											}, 1000)
										}
										
									} else { //틀렸을 경우 처리
										$("#result").text("틀렸습니다.")
										$("#resultModal").modal("show")
										//틀린 단어를 모아둔다.
										const id = items[index].wordId
										const name = items[index].wordName
										const meaning = items[index].wordMeaning
										
										console.log("name = " + name)
										
										//이미 존재하는 단어면 추가하지 않는다.
										let distinct = false 
										for (const wrongWord of wrongWords) {
											if (wrongWord.id === id) {
												distinct = true
											}
										}
										if (!distinct) {
											wrongWords.push({id: id, wordName: name, wordMeaning: meaning})
										}
										
										setTimeout(function() {
											$("#resultModal").modal("hide")
											$("#userInput").val("")
											$("#userInput").focus()
											isRun = false
										}, 1000)
									}
									
								}
							})
							
							//모르겠어요 버튼을 클릭하면?
							$("#helpButton").on("click", function() {
								console.log("모르겠어요!")
								const answer = words[index].wordName
								$("#helpResultInput").attr("placeholder", answer)
							})
						}

					})
					
				})
			</script>

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <div class="card shadow">
                        <div class="card-header">
                            <div class="row mb-4 pl-2 pr-2">
                                <label for="" class="form-label">책</label>
                                <select name="" id="bookSelect" class="custom-select">
                                    <option value=""></option>
                                </select>
                            </div>
                            <div class="row mb-4 pl-2 pr-2">
                                <label for="" class="form-label">카테고리</label>
                                <select name="" id="categorySelect" class="custom-select">
                                    <option value=""></option>
                                </select>
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
	                                    <label id="problem" for="userInput" class="form-label mr-2 mb-1" style="font-size: 18px"></label>
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
                        </div>
                    </div>
                </div>
              	<!-- //추가, 수정, 삭제 완료 모달창 -->

           <%@ include file="../admin/includes/footer.jsp" %>