<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>CATEGORY CRUD</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- JQuery import -->
    <script src="https://code.jquery.com/jquery-2.2.1.js"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap');
        .card { font-family: 'Noto Sans KR', sans-serif; }
    </style>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">coldrain</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="index.html">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                학습 관리
            </div>

            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="/folder_list.html">
                    <i class="fas fa-fw fa-table"></i>
                    <span>폴더 관리</span></a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="/category_list.html">
                    <i class="fas fa-fw fa-table"></i>
                    <span>카테고리 관리</span></a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="/word_list.html">
                    <i class="fas fa-fw fa-table"></i>
                    <span>단어 관리</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 12, 2019</div>
                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 7, 2019</div>
                                        $290.29 has been deposited into your account!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 2, 2019</div>
                                        Spending Alert: We've noticed unusually high spending for your account.
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>

                        <!-- Nav Item - Messages -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                <!-- Counter - Messages -->
                                <span class="badge badge-danger badge-counter">7</span>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header">
                                    Message Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/img/undraw_profile_1.svg"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">Hi there! I am wondering if you can help me with a
                                            problem I've been having.</div>
                                        <div class="small text-gray-500">Emily Fowler · 58m</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/img/undraw_profile_2.svg"
                                            alt="...">
                                        <div class="status-indicator"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">I have the photos that you ordered last month, how
                                            would you like them sent to you?</div>
                                        <div class="small text-gray-500">Jae Chun · 1d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="/resources/img/undraw_profile_3.svg"
                                            alt="...">
                                        <div class="status-indicator bg-warning"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Last month's report looks great, I am very happy with
                                            the progress so far, keep up the good work!</div>
                                        <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Am I a good boy? The reason I ask is because someone
                                            told me that people say this to all dogs, even if they aren't good...</div>
                                        <div class="small text-gray-500">Chicken the Dog · 2w</div>
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Douglas McGee</span>
                                <img class="img-profile rounded-circle"
                                    src="/resources/img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- 카테고리 관리 테이블 -->
                <div class="container-fluid">
                    <div class="card shadow">
                        <div class="card-header">
                            <!-- 카테고리 조회 폼 -->
                            <form action="" method="GET">
                                <div class="row mb-4 pl-2 pr-2">
                                    <label for="bookSelect" class="form-label">폴더</label>
                                    <select class="custom-select" name="folder_name" id="bookSelect"></select>
                                </div>
    
                                <div class="row d-flex justify-content-end mr-0">
                                    <button id="categoryListButton" type="button" class="btn btn-info">카테고리 조회</button>
                                </div>
                            </form>
                            <!-- 카테고리 조회 폼 -->
                        </div>
                        <div class="card-body">
                            <form class="form-inline" action="" method="">
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
                                    <tbody></tbody>
                                </table>
                            </div>
                            <!-- ./테이블 데이터 -->
                            
                            <!-- 책 서비스 모듈 -->
                            <script src="/resources/js/bookService.js"></script>
                            
                            <!-- 카테고리 서비스 모듈 -->
                            <script src="/resources/js/categoryService.js"></script>
                            
                            <script>
                            	//책 셀렉트 데이터 생성
                            	bookService.getList(function(list) {
                            		const len = (list.length - 1) || 0
                            		
                            		const bookSelect = document.querySelector("#bookSelect")
                            		for (let i = len; i >= 0; i--) {
                            			const option = document.createElement("option")
                            			option.setAttribute("value", list[i].bookId)
                            			option.textContent = list[i].bookName
                            			if (i == len) {
                            				option.setAttribute("selected", "selected")
                            			}
                            			bookSelect.appendChild(option)
                            		}
                            	})
                            	
                            	//카테고리 조회 버튼 클릭시 테이블에 해당하는 책의 카테고리 데이터 생성
                            	const categoryListButton = document.querySelector("#categoryListButton")
                            	categoryListButton.addEventListener("click", function() {
                            		const bookSelect = document.querySelector("#bookSelect")
                            		let child = null
                            		while (bookSelect.hasChildNodes()) {
                            			child = bookSelect.firstChild
                            			if (child.getAttribute("selected") == "selected") {
                            				break
                            			}
                            		}
                            		
                            		const bookId = child.getAttribute("value")
                            		console.log("bookId = " + bookId)
                            		
                            		// bookId번에 해당하는 카테고리 리스트를 조회한다.
                            		categoryService.getList(bookId, function(list) {
                            			//리스트의 길이만큼 테이블에 카테고리를 추가한다.
                            			const len = list.length || 0
                            			for (let i = 0; i < len; i++) {
	                            			const tbody = document.querySelector("tbody")
	                            			const tr = document.createElement("tr")
	
	                            			const all = document.createElement("td")
	                            			const checkbox = document.createElement("input")
	                            			checkbox.setAttribute("type", "checkbox")
	                            			all.appendChild(checkbox)
	
	                            			const categoryId = document.createElement("td")
	                            			categoryId.textContent = list[i].categoryId
	                            			
	                            			const categoryName = document.createElement("td")
	                            			categoryName.textContent = list[i].categoryName
	                            			
	                            			const regdate = document.createElement("td")
	                            			regdate.textContent = list[i].regdate
	                            			
	                            			const updatedate = document.createElement("td")
	                            			updatedate.textContent = list[i].updatedate
	                            			
	                            			const actions = document.createElement("td")
	                            			actions.setAttribute("class", "text-center")
	                            			
	                            			const modifyButton = document.createElement("button")
	                            			modifyButton.setAttribute("class", "btn text-dark p-0 modalEventButton")
	                            			modifyButton.setAttribute("type", "button")
	                            			modifyButton.setAttribute("data-toggle", "modal")
	                            			modifyButton.setAttribute("data-target", "#modifyModal")
	                            			const modifyButtonIcon = document.createElement("i")
	                            			modifyButtonIcon.setAttribute("class", "fas fa-edit")
	                            			
	                            			modifyButton.appendChild(modifyButtonIcon)
	                            			
	                            			const removeButton = document.createElement("button")
	                            			removeButton.setAttribute("class", "btn text-dark p-0 ml-2 modalEventButton")
	                            			removeButton.setAttribute("type", "button")
	                            			removeButton.setAttribute("data-toggle", "modal")
	                            			removeButton.setAttribute("data-target", "#deleteModal")
	                            			const removeButtonIcon = document.createElement("i")
	                            			removeButtonIcon.setAttribute("class", "fas fa-trash-alt")
	                            			
	                            			removeButton.appendChild(removeButtonIcon)
	                            			
	                            			actions.appendChild(modifyButton)
	                            			actions.appendChild(removeButton)
	                            			
	                            			const state = document.createElement("td")
	                            			state.setAttribute("class", "text-center")
	                            			
	                            			const span = document.createElement("span")
	                            			span.setAttribute("class", "badge badge-pill badge-info")
	                            			span.textContent = "NEW"
	                            			state.appendChild(span)
	                            			
	                            			tr.appendChild(all)
	                            			tr.appendChild(categoryId)
	                            			tr.appendChild(categoryName)
	                            			tr.appendChild(regdate)
	                            			tr.appendChild(updatedate)
	                            			tr.appendChild(actions)
	                            			tr.appendChild(state)
	                            			
	                            			tbody.appendChild(tr)
                            			}
                            		})
                            	})
                            	
                            </script>
                            

                            <!-- 카테고리 수정 모달창 -->
                            <div class="modal fade" id="modifyModal" tabindex="-1" aria-hidden="true">
                                <form action="" method="GET">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">카테고리 수정</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <label class="form-label" for="modify_folder_name">폴더</label>
                                                <input type="text" class="form-control" name="folder_name" id="modify_folder_name" value="단어가 읽기다 기본편" readonly />
    
                                                <label class="form-label mt-2" for="modify_cno">번호</label>
                                                <input class="form-control" type="text" name="cno" id="modify_category_cno" value="5" readonly />
    
                                                <label class="form-label mt-2" for="modify_category_name">카테고리 이름</label>
                                                <input class="form-control mb-4" type="text" name="category_name" id="modify_category_name" 
                                                    onkeyup="print_result('modify_category_name', 'modify_result')"  placeholder="Unit 05 - 취미1" autocomplete="off" />

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
                                                      [ <span id="modify_result0">Unit 05 - 취미1</span> ] → [ <span id="modify_result"></span> ]
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
                                <form action="" method="POST">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">카테고리 삭제</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <label class="form-label" for="remove_folder_name">폴더</label>
                                                <input type="text" class="form-control" name="folder_name" id="remove_folder_name" value="단어가 읽기다 기본편" readonly >
    
                                                <label class="form-label mt-2" for="remove_category_cno">번호</label>
                                                <input class="form-control" type="text" name="cno" id="remove_category_cno" value="5" readonly />
    
                                                <label class="form-label mt-2" for="remove_category_name">카테고리</label>
                                                <input class="form-control" type="text" name="category_name" id="remove_category_name" value="Unit 05 - 취미1" readonly />

                                                <label class="form-label mt-2" for="word_list">소속된 단어</label>
                                                <select class="custom-select mb-4" name="" id="word_list">
                                                    <option value="">spice, 양념</option>
                                                    <option value="">delicous, 맛있는</option>
                                                    <option value="">bake, (빵을)굽다</option>
                                                </select>

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
                                                      [ <span id="remove_result0">Unit 05 - 취미1</span> ] 에 소속된 모든 단어들도 같이 삭제됩니다.
                                                    </div>
                                                </div>
                                            </div>

                                            
    
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
                                                <button type="button" class="btn btn-primary">삭제하기</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                            </div>
                            <!-- ./카테고리 삭제 모달창 -->

                            <!-- 카테고리 추가 모달창 -->
                            <div class="modal fade" id="addModal" tabindex="-1" aria-hidden="true">
                                <form action="" method="GET">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">카테고리 추가</h5>
                                                <button type="button" class="close" data-dismiss="modal">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <label class="form-label" for="add_folder_name">폴더</label>
                                                <select class="custom-select" name="folder_name" id="add_folder_name">
                                                    <option value="단어가 읽기다 - 기본편">단어가 읽기다 기본편</option>
                                                    <option value="단어가 읽기다 - 실전편">단어가 읽기다 실전편</option>
                                                </select>
    
                                                <label class="form-label mt-2" for="add_category_name">카테고리 이름</label>
                                                <input class="form-control mb-4" type="text" name="category_name" id="add_category_name" 
                                                    onkeyup="print_result('add_category_name', 'add_result')" placeholder="추가할 카테고리명을 입력해 주세요..." autocomplete="off" />

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
                                                      [ 단어가 읽기다 기본편 ] 폴더에 [ <span id="add_result"></span> ] 카테고리가 추가됩니다.
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

                            <!-- 추가, 삭제, 수정 관련 모달 JQuery -->
                            <script>
                                function print_result(inputElementId, targetElementId) {
                                    const val = document.getElementById(inputElementId).value;
                                    const result = document.getElementById(targetElementId).innerText = val;
                                }
                            </script>
                            <!-- ./추가, 삭제, 수정 관련 모달 JQuery -->
                            
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
                                    <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#addModal">추가하기</button>
                                    <button type="button" class="ml-2 btn btn-primary">선택된 아이템 삭제</button>
                                </div>
                            </div>

                            
                        </div>
                    </div>
                </div>
                <!-- ./카테고리 관리 테이블 -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>
    <!-- 테이블 행 값을 모달로 전달하기  -->
    <script>
        $(".modalEventButton").on("click", function(){
            var button = $(this);

            var tr = button.parent().parent();
            var td = tr.children();

            console.log("CNO = " + td.eq(1).text());
            console.log("CATEGORY_NAME = " + td.eq(2).text());

            var cno = td.eq(1).text();
            var category_name = td.eq(2).text();

            //수정 창
            document.getElementById("modify_category_cno").value = cno;
            document.getElementById("modify_category_name").placeholder = category_name;
            document.getElementById("modify_result0").innerText = category_name;

            //삭제 창
            document.getElementById("remove_category_cno").value = cno;
            document.getElementById("remove_category_name").value = category_name;
            document.getElementById("remove_result0").innerText = category_name;
        });

    </script>
    
    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>

</body>

</html>