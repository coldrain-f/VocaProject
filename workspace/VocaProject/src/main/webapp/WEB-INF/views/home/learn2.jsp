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
			
				//옵션 생성기능
				function createOption(value, text) {
					return "<option value='" + value + "'>" + text + "</option>";
				}
				
				//카테고리 셀렉트 박스 초기화
				function initCategorySelectBox(bookId) {
					//기존에 존재하는 카테고리의 모든 옵션을 제거한다.
					$("#categorySelectBox").empty();
					
					//bookId에 해당하는 카테고리로 화면을 구성한다.
					const url = "/books/" + bookId + "/categories";
					$.getJSON(url, (categories) => {
						//기본이 내림차순이므로 오름차순으로 변환한다.
						categories.reverse();
						
						//카테고리 객체를 하나씩 꺼내와서 옵션을 구성한다.
						for (const category of categories) {
							const option = createOption(category.categoryId, category.categoryName);
							$("#categorySelectBox").append(option);
						}
					});
				}
				
				//책 셀렉트 박스 초기화
				function initBookSelectBox(books) {
					//책 객체를 하나씩 꺼내와서 옵션을 구성한다.
					for (const book of books) {
						const option = createOption(book.bookId, book.bookName);
						$("#bookSelectBox").append(option);
					}
				}
				
				//단어 학습과 관련된 데이터 초기화
				function clearStudyForm() {
					$("#userInput").val("");
					$("#problem").text("");
					$("#bookName").text("");
					$("#categoryName").text("");
					$("#start").text("");
					$("#total").text("");
					$("#helpResultInput").attr("placeholder", "“모르겠어요”를 누르면 이곳에 정답이 표시돼요!");
				}
				
				//단어의 아이디로 중복 체크
				function duplicateCheck(words, wordId) {
					for (const word of words) {
						if ( word.wordId === wordId ) {
							return true;
						}
					}
					return false;
				}
				
				//단어 상태 모달창을 띄워준다.
				function showStateModal(message, millisecond) {
					$("#result").text(message);
					$("#stateModal").modal("show");
					
					setTimeout(() => {
						$("#stateModal").modal("hide");
						$("#userInput").focus();
						
						//모달창을 띄우고 엔터키를 허용한다.
						if ( isRun ) {
							isRun = false;
						}
						
					}, millisecond);
				}
				
				//엔터키 연타 방지 전역 변수 ( 완전 방지 불가능 / 임시용 )
				let isRun = false;
				
				//단어 학습 시작
				function startQuiz(words) {
					//문제 출제 ( 중복 코드 )
					const total = words.length;

					let word = words.pop();
					let problem = null;
					let answer = null;
					
					//타입 체크
					const checkedTypeRadioValue = $("input[name='type']:checked").val();
					if ( checkedTypeRadioValue === "0" ) { //타입이 0이라면 한글로 문제 출제
						problem = word.wordMeaning;
						answer = word.wordName;
					} else if ( checkedTypeRadioValue === "1" ) { //타입이 1이라면 출제 단어로 문제 출제
						problem = word.wordName;
						answer = word.wordMeaning;
					}
					
					//일본어 인지 체크한다.
					let japanese = problem.split("・");
					let hiragana = null;
					if ( japanese.length > 1 ) { // 2이상이면 일본어 [ 한자 , 히라가나 ] 
						hiragana = japanese[1];
						problem = japanese[0];
					}
										
					$("#problem").text(problem);
					
					$("#helpResultInput").attr("placeholder", "“모르겠어요”를 누르면 이곳에 정답이 표시돼요!");
					
					let count = 1;
					$("#start").text(count + "/");
					$("#total").text(total);
					
					//학습 제목 구성
					const bookName = $("#bookSelectBox option:selected").text();
					const categoryName = $("#categorySelectBox option:selected").text();
					
					$("#bookName").text(bookName);
					$("#categoryName").text(categoryName);

					//틀린 문제를 담을 배열 선언
					let wrongWords = [];
					
					//모르겠어요 버튼 클릭 이벤트 리스터
					$("#helpButton").on("click", () => {
						//사용자에게 정답을 표시해 준다.
						if ( hiragana !== null ) { //일본어라면
							hiragana = japanese[1];
							$("#helpResultInput").attr("placeholder", answer + " / " + hiragana);
						} else { //일본어가 아니라면
							$("#helpResultInput").attr("placeholder", answer);
						}
						
						//정답을 표시하고 정답 입력창으로 자동 포커스
						$("#userInput").focus();
						
						//모르겠어요를 누른 단어도 틀린 단어로 취급하고 틀린 단어 배열에 추가한다.
						const wordVO = {
								wordId : word.wordId, 
								wordName: word.wordName,
								wordMeaning: word.wordMeaning	
						};
								
						//이미 들어가있는 단어가 아니라면
						if ( !duplicateCheck( wrongWords, wordVO.wordId ) ) {
							//틀린 단어 배열에 추가한다.
							wrongWords.push(wordVO);
						}
					});
					
					//사용자가 정답을 입력 후 엔터키를 누른다.
					$("#userInput").on("keyup", function(event) {
						if ( event.keyCode === 13 && !isRun ) {
							//엔터키 방지 변수 활성화
							isRun = true;
							
							//사용자가 입력한 값과 정답을 비교한다.
							const userInput = $.trim( $("#userInput").val() );
							answer = $.trim ( answer );
							
							//사용자가 입력한 값이 정답인지 체크한다.
							console.log("사용자 입력: " + userInput);
							console.log("시스템 정답: " + answer);
							if ( userInput === answer ) {
								//사용자에게 정답임을 알려주는 모달창을 띄워준다.
								showStateModal("정답입니다.", 1000);
								
								//사용자가 기존에 입력한 값을 초기화 한다.
								$("#userInput").val("");
								$("#helpResultInput").attr("placeholder", "“모르겠어요”를 누르면 이곳에 정답이 표시돼요!");
								
								//현재 진행도를 갱신한다.
								$("#start").text(++count + "/");
							
								//모든 단어의 학습이 완료되었다면 학습을 종료한다.
								if (  words.length <= 0 ) {
									
									//틀린 단어가 없다면
									if ( wrongWords.length === 0 ) {
										//사용자에게 학습이 종료되었음을 알려주는 모달창을 띄워준다.
										showStateModal("학습을 종료합니다.", 2000);

										//정답 입력 엔터키 이벤트를 제거한다.
										$("#userInput").off("keyup");
										
										//모르겠어요 클릭 이벤트를 제거한다.
										$("#helpButton").off("click");
										
										//초기 상태로 초기화
										clearStudyForm();
										
										//학습 종료
										return;
									} else { //틀린 단어가 있다면
										//기존에 존재하는 keyup 이벤트 리스너를 제거한다.
										$("#userInput").off("keyup");
									
										//기존에 존재하는 모르겠어요 이벤트 리스너를 제거한다.
										$("#helpButton").off("click");
									
										//사용자에게 재 학습을 알리는 모달창을 띄워준다.
										showStateModal("틀린 단어를 모아서 새로 학습합니다.", 1000);

										//그 다음 틀린 단어를 뒤 섞고 학습을 재시작한다.
										wrongWords = _.shuffle(wrongWords);
										startQuiz(wrongWords);
										return;
									}
									
								} else { //학습할 단어가 남아있다면 다음 문제를 출제한다. ( 중복 코드 )
									word = words.pop();
								
									if ( checkedTypeRadioValue === "0" ) { //타입이 0이라면 한글로 문제 출제
										problem = word.wordMeaning;
										answer = word.wordName;
									} else if ( checkedTypeRadioValue === "1" ) { //타입이 1이라면 출제 단어로 문제 출제
										problem = word.wordName;
										answer = word.wordMeaning;
									}
									
									//일본어 처리
									japanese = problem.split("・");
									if ( japanese.length > 1 ) { // 2이상이면 일본어 [ 한자 , 히라가나 ] 
										hiragana = japanese[1];
										problem = japanese[0];
									}
									
									$("#problem").text(problem);
								}
								
							} else {//정답이 아니라면?
								//사용자에게 틀렸음을 알려주는 모달창을 띄워준다.
								showStateModal("틀렸습니다.", 1000);
								
								//사용자 입력창을 초기화 한다.
								$("#userInput").val("");
								
								const wordVO = {
										wordId : word.wordId, 
										wordName: word.wordName,
										wordMeaning: word.wordMeaning	
								};
								
								//이미 들어가있는 단어가 아니라면
								if ( !duplicateCheck( wrongWords, wordVO.wordId ) ) {
									//틀린 단어 배열에 추가한다.
									wrongWords.push(wordVO);
								}
							}
						}
					});
					
				}
			
				//셀렉트 박스 초기화
				(function() {
					//책의 리스트를 조회한다.
					$.getJSON("/books.json", (books) => {
						//기본이 내림차순이므로 오름차순으로 변환한다.
						books.reverse()
						
						//책 셀렉트 박스를 초기화 한다.
						initBookSelectBox(books);
						
						//책 구성이 끝나면 맨 상단에 해당하는 책으로 카테고리를 초기화한다. (수정 예정)
						initCategorySelectBox(1);
						
						console.log("셀렉트 박스 초기화를 완료했습니다.");
						
					}).fail((error) => {
						console.log("책 리스트 조회에 실패했습니다." + error);
					});
					
				})();
				
				
				//문서 로딩 완료
				$(document).ready(() => {
					console.log("문서 로딩이 완료되었습니다.");
					
					//책 셀렉트 박스 체인지 이벤트
					$("#bookSelectBox").on("change", function() {
						//선택된 책의 아이디값을 가져온다.
						const bookId = $(this).val();
						
						//선택된 책의 아이디값에 해당하는 카테고리로 셀렉트 박스를 초기화한다.
						initCategorySelectBox(bookId);
					});

					//학습 시작 버튼 클릭 이벤트
					$("#startButton").on("click", function() {
						//이미 학습중이었다면 이벤트를 제거한다.
						$("#userInput").off("keyup");
						
						//선택된 카테고리 아이디에 해당하는 단어로 학습을 시작한다.
						const categoryId = $("#categorySelectBox option:selected").val();
						const url = "/categories/" + categoryId + "/words/shuffle";
						$.getJSON(url, (words) => {
							console.log("단어 리스트 조회에 성공했습니다.");
							console.dir(words);
							//단어 리스트 조회에 성공하면 단어를 섞고 학습을 시작한다.
							words = _.shuffle(words);
							startQuiz(words);
							
						}).fail((error) => {
							console.log("단어 리스트 조회에 실패했습니다.");
						});
						
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