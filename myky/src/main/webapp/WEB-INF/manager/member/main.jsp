<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
           
     <style>
		/* 전체 대시보드 배경 */
		.dashboard-container {
		    background-color: #f8fafd;
		    min-height: 100vh;
		    padding: 30px 20px;
		    font-family: 'Segoe UI', sans-serif;
		    
		}
		
		/* 메인 콘텐츠 */
		.main-content {
		    padding: 10px 30px;
		}
		
		/* 카드 공통 */
		.card {
		    border: none;
		    border-radius: 20px;
		    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.04);
		    background-color: #ffffff;
		    margin-bottom: 10px;
		}
		
		.card-header {
		    background-color: transparent;
		    font-weight: 600;
		    font-size: 18px;
		    border-bottom: none;
		    padding: 20px;
		}
		
		/* 차트 높이 조절 */
		.chart-container {
		    padding: 0 20px 20px;
		}
		
		/* 리스트 및 테이블 */
		.list-group-item {
		    border: none;
		    padding: 12px 20px;
		    font-size: 14px;
		    color: #374151;
		}
		
		/* 테이블 */
		.table th {
		    background-color: #f1f5f9;
		    font-weight: 600;
		    color: #475569;
		}
		
		.table td {
		    color: #374151;
		    font-size: 14px;
		}
		
		/* Priority 뱃지 */
		.priority-low {
		    background-color: #dbeafe;
		    color: #2563eb;
		    padding: 5px 10px;
		    border-radius: 9999px;
		    font-size: 12px;
		    font-weight: 600;
		}
		
		.priority-medium {
		    background-color: #fef9c3;
		    color: #ca8a04;
		    padding: 5px 10px;
		    border-radius: 9999px;
		    font-size: 12px;
		    font-weight: 600;
		}
		
		.priority-high {
		    background-color: #fee2e2;
		    color: #dc2626;
		    padding: 5px 10px;
		    border-radius: 9999px;
		    font-size: 12px;
		    font-weight: 600;
		}
		
		/* 제품 판매 카드 내 아이콘 원 */
		.product-sales-icon {
		    width: 36px;
		    height: 36px;
		    background-color: #fef2f2;
		    border-radius: 50%;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    color: #ef4444;
		    font-weight: bold;
		    font-size: 20px;
		}
		
		/* 전체 카드 그리드 */
		.stats-cards {
		    margin-top: 20px;
		}
		
		/* 카드 스타일 */
		.stat-card {
		    background-color: #ffffff;
		    border-radius: 16px;
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
		    transition: transform 0.2s ease;
		}
		.stat-card:hover {
		    transform: translateY(-3px);
		}
		
		/* 아이콘 원형 배경 */
		.stat-icon {
		    width: 48px;
		    height: 48px;
		    border-radius: 50%;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    margin: 0 auto;
		    font-size: 20px;
		    color: white;
		}
		
		/* 색상 클래스 */
		.bg-blue { background-color: #c7dfff; color: #2563eb; }
		.bg-yellow { background-color: #fff7da; color: #eab308; }
		.bg-red { background-color: #fee2e2; color: #dc2626; }
		.bg-purple { background-color: #ede9fe; color: #7c3aed; }
		
		/* 숫자와 텍스트 */
		.stat-number {
		    font-weight: bold;
		    font-size: 20px;
		    color: #111827;
		}
		.stat-label {
		    font-size: 14px;
		    color: #6b7280;
		}
		
		
		/* 추가된 카드 스타일 */
		.bg-green {
		    background-color: #d1fae5;
		    color: #10b981;
		}
		
		.bg-orange {
		    background-color: #fff7ed;
		    color: #fb923c;
		}
		
		/* 카드 숫자 크기 조정 */
		.stat-number {
		    font-weight: bold;
		    font-size: 22px;
		    color: #111827;
		}
		
		.stat-label {
		    font-size: 14px;
		    color: #6b7280;
		}
		
		/* 카드 hover 효과 */
		.stat-card:hover {
		    transform: translateY(-5px);
		    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
		}

		/* 테이블 스타일 */
		.member-table {
		    width: 100%;
		}

		.member-table th {
		    background-color: #f1f5f9;
		    font-weight: 600;
		    color: #475569;
		}

		.member-table td {
		    color: #374151;
		    font-size: 14px;
		}

		/* 회원 상태 뱃지 */
		.status-active {
		    background-color: #d1fae5;
		    color: #10b981;
		    padding: 5px 10px;
		    border-radius: 10px;
		    font-size: 12px;
		    font-weight: 600;
		}

		.status-inactive {
		    background-color: #fee2e2;
		    color: #dc2626;
		    padding: 5px 10px;
		    border-radius: 10px;
		    font-size: 12px;
		    font-weight: 600;
		}

		/* 버튼 스타일 */
		.btn-edit {
		    background-color: #0d6efd;
		    color: white;
		    border: none;
		    padding: 5px 10px;
		    border-radius: 5px;
		}

		.btn-delete {
		    background-color: #dc3545;
		    color: white;
		    border: none;
		    padding: 5px 10px;
		    border-radius: 5px;
		}
		
		
/* 수정 폼 스타일 - 부트스트랩 사용 */
.edit-form {
    display: flex;
    gap: 15px;
    background-color: #f8f9fa;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* 각 입력 요소가 가로로 꽉 차게 하기 위해 col 사용 */
.edit-form .col {
    flex: 1;  /* 모든 항목들이 고르게 넓어지도록 설정 */
}

/* 버튼 영역을 오른쪽 끝에 배치 */
.edit-form .col.d-flex.justify-content-end {
    flex: 0;
}

/* 스위치 토글 크기 */
.form-check-input {
    width: 40px;
    height: 20px;
}

/* 버튼 글자 크기 맞추기 */
.custom-btn {
    font-size: 14px; /* 글자 크기를 텍스트에 맞게 조정 */
    padding: 5px 15px; /* 적당한 여백을 설정 */
    text-align: center;
}

		/* 페이지 버튼 기본 스타일 */
		.board-page-btn {
		    min-width: 40px;
		    padding: 8px 12px;
		    margin: 0 4px;
		    border-radius: 5px;
		    font-size: 14px;
		}
		
		/* 숫자 페이지 버튼 스타일 */
		.board-page-btn:not(.prev-next-btn):not(.active) {
		    background-color: #f1f5f9;
		    color: #374151;
		    border-color: #d1d5db;
		}
		
		/* 현재 페이지 버튼 강조 */
		.board-page-btn.active {
		    background-color: #2563eb;
		    color: white;
		    border-color: #2563eb;
		}
		
		/* 이전/다음 페이지 버튼 스타일 */
		.board-page-btn.prev-next-btn {
		    background-color: #ffffff;
		    color: #374151;
		    border-color: #d1d5db;
		}
		
		.board-page-btn.prev-next-btn:hover {
		    background-color: #f1f5f9;
		    color: #2563eb;
		}
		
		/* 이전/다음 페이지 아이콘 크기 */
		.board-page-btn i {
		    font-size: 18px;
		}
		/* 선택 삭제 버튼 스타일 */
		.board-delete-btn {
		    min-width: 120px;
		    padding: 8px 12px;
		    font-size: 14px;
		    border-radius: 5px;
		}
		
		/* 버튼 비활성화 스타일 */
		.board-delete-btn:disabled {
		    background-color: #e5e7eb;
		    color: #9ca3af;
		    cursor: not-allowed;
		}

    
    </style>
    
</head>
<body>

    <div id="app" class="dashboard-container col-9">
       
         <!-- Main Content1 -->
         <div class=" main-content">
                <h2>회원 관리</h2>


				<div class="card p-3">
	               	 <div class="row g-2 align-items-center mb-3">
						    <!-- N개씩 보기 -->
						    <div class="col-auto">
						        <select v-model="pageSize" class="form-select board-select" @change="fnMainList">
						            <option value="5">5개씩</option>
						            <option value="10">10개씩</option>
						            <option value="15">15개씩</option>
						            <option value="20">20개씩</option>
						        </select>
						    </div>
						
						    <!-- 검색 옵션 -->
						    <div class="col-auto">
						        <select v-model="searchOption" class="form-select">
						            <option value="all">전체</option>
						            <option value="title">제목</option>
						            <option value="userId">작성자</option>
						        </select>
						    </div>
						
						    <!-- 검색어 입력 -->
						    <div class="col">
						        <input v-model="keyword" @keyup.enter="fnMainList" class="form-control board-search" placeholder="🔍 검색어 입력" />
						    </div>
						
						    <!-- 검색 버튼 -->
						    <div class="col-auto">
						        <button class="btn btn-primary board-search-btn" @click="fnBoardSearch">검색</button>
						    </div>
					</div>
						
	                <table class="table member-table">
	                    <thead>
	                        <tr>
	                            <th>번호</th>
	                            <th>이름</th>
								<th>닉네임</th>
	                            <th>이메일</th>
	                            <th>가입일</th>
	                            <th>상태</th>
								<th>멤버쉽</th>
	                            <th>관리</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<template v-for="(member, index) in members" >
	                        <tr >
	                            <td>{{ index + 1 }}</td>
	                            <td>{{ member.userName }}</td>
								<td>{{ member.nickName }}</td>								
	                            <td>{{ member.email }}</td>
	                            <td>{{ member.createdAt }}</td>
	                            <td>
	                                <span :class="member.DeleteYn === 'N' ? 'status-active' : 'status-inactive'">
	                                    {{ member.DeleteYn === 'N' ? '회원' : '탈퇴회원' }}
	                                </span>
	                            </td>
								<td>
								    <span :class="member.membershipType ? 'status-active' : 'status-inactive'">
								        {{ member.membershipType ? '멤버쉽' : '일반회원' }}
								    </span>
								</td>
	                            <td>
           							<button class="btn-edit me-2" @click="fnEdit(member.userId)">수정</button>
	                                <!-- <button class="btn-delete">삭제</button> -->
	                            </td>
	                        </tr>
	                        
                            <!-- 토글되는 수정 입력란 -->
							<tr v-if="selectedMemberId === member.userId">
								<td colspan="8">
								    <div class="edit-form d-flex align-items-center p-3 border rounded">
								        <!-- 이름 입력 필드 -->
								        <div class="col">
								            <label for="userName" class="form-label">이름:</label>
								            <input type="text" id="userName" v-model="editData.userName" class="form-control">
								        </div>
								         <div class="col">
								            <label for="userName" class="form-label">보유 포인트 : {{currentPoint}}</label>
								            <button class="btn btn-primary me-2 custom-btn" @click="FnAddPoint(editData.userId)">포인트 수정</button>
								        </div>
										<!-- 탈퇴 여부 토글 스위치 -->
								        <div class="col-auto d-flex align-items-center">
								            <label for="deleteYn" class="form-label me-2">회원 상태:</label>
								            <div class="form-check form-switch">
								                <input class="form-check-input" type="checkbox" id="deleteYn" v-model="editData.DeleteYn" 
								                    true-value="N" false-value="Y">
								            </div>
								        </div>
								
								        <!-- 저장 및 취소 버튼 -->
								        <div class="col-auto d-flex justify-content-end">
								            <button class="btn btn-primary me-2 custom-btn" @click="fnSave">저장</button>
								            <button class="btn btn-secondary custom-btn" @click="selectedMemberId = null">취소</button>
								        </div>
								    </div>
								</td>
						    </tr> 
    						</template>
	                    </tbody>
	                </table>
	                
					<div class="d-flex justify-content-center align-items-center mt-3">
					    <!-- 페이지네이션 버튼 -->
					    <div>
					        <!-- 이전 페이지 버튼 -->
					        <a class="btn btn-outline-secondary board-page-btn prev-next-btn" href="javascript:;" @click="fnPageMove('prev')" v-if="page != 1">
					            <i class="bi bi-chevron-left"></i>
					        </a>
					
					        <!-- 페이지 번호 -->
							<template v-for="num in index">
								<!-- 첫 번째 페이지로 이동하는 "..." -->
								    <a v-if="num === 1 && page > 3" 
								       href="javascript:;"  
								       @click="fnPage(1)" 
								       class="btn btn-outline-secondary board-page-btn">
								       ...
								    </a>
								
								    <!-- 현재 페이지 기준 좌우 2개씩 표시 -->
								    <a v-if="num >= page - 2 && num <= page + 2" 
								       href="javascript:;"  
								       @click="fnPage(num)" 
								       class="btn btn-outline-secondary board-page-btn" 
								       :class="{ 'active': page === num }">
								       {{ num }}
								    </a>
								
								    <a v-if="num === index && page < index - 2" 
								       href="javascript:;"  
								       @click="fnPage(index)" 
								       class="btn btn-outline-secondary board-page-btn">
								       ...
								    </a>
							</template>
					
					        <!-- 다음 페이지 버튼 -->
					        <a class="btn btn-outline-secondary board-page-btn prev-next-btn" href="javascript:;" @click="fnPageMove('next')" v-if="index > 0 && page != index">
					            <i class="bi bi-chevron-right"></i>
					        </a>
					    </div>
					</div>
					
	            </div>



        </div>
    </div>
    
</body>
</html>

<script>
    
   
            const app = Vue.createApp({
            	 data() {
                     return {
 	                    index: 0,
						menu : '',
						submenu : '',  
						members : [],
						selectedMemberId : null,
				        editData: {
				            userName : '',
				            DeleteYn : '',
				        },
				        currentPoint : 0,
	                    searchOption: 'userId',
	                    page: 1,
	                    pageSize: 5,
	                    keyword: '',
                     };
                 },
                computed: {

                },
                methods: {
                	fnMainList : function() {
                    	var self = this;
                    	var nparmap = {
                                searchOption: self.searchOption,
                                page: (self.page - 1) * self.pageSize,
                                pageSize: self.pageSize,
                                keyword: self.keyword,
                    	};
                    	$.ajax({
                    		url: "/admin/memberList.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log("main",data);
								self.members = data.User;
                                if (data.count && data.count.cnt !== undefined) {
                                    self.index = Math.ceil(data.count.cnt / self.pageSize);
                                    console.log("1!", self.index);

                                } else {
                                    self.index = 0;
                                    console.warn("count 정보 없음!", data);
                                }		
                    		}
                    	});
                    },
                    fnEdit(userId) {
                    	var self = this;

                    	console.log("1",userId);
                        if (self.selectedMemberId === userId) {
                        	self.selectedMemberId = null;  // 같은 걸 누르면 닫힘
                        	console.log("2",userId);

                        } else {
                            const member = self.members.find(m => m.userId === userId);
                            self.editData = { ...member };  // 수정할 데이터 채우기
                            self.selectedMemberId = userId;
                        	console.log("3",userId);
                        	self.getPoints(userId);
                        }
                    },
                    fnSave () {
                    	var self = this;
                    	var nparmap = {
                    			userId : self.selectedMemberId,
    				            userName : self.editData.userName ,
    				            DeleteYn : self.editData.DeleteYn,
                    	};
                    	$.ajax({
                    		url: "/admin/updateUser.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			//console.log("main",data);
                    			alert("수정 완료");
                            	self.selectedMemberId = null;  // 같은 걸 누르면 닫힘
                				self.fnMainList();
                    		}
                    	});
                    },
                    fnView(boardId) {
                        let self = this;
                        localStorage.setItem("page", self.page);
                        location.href="/board/view.do?boardId=" + boardId + "&category="+self.category;
                    },
                    fnPage(num) {
                        this.page = num;
                        this.fnMainList();
                    },
                    fnPageMove(direction) {
                        if (direction === "next") this.page++;
                        else this.page--;
                        this.fnMainList();
                    },
                    fnOrder(orderKey) {
                        if (this.orderKey !== orderKey) this.orderType = "";
                        this.orderKey = orderKey;
                        this.orderType = this.orderType === "ASC" ? "DESC" : "ASC";
                        this.fnMainList();
                    },
                    fnBoardSearch : function(){
                        let self = this;
                        let pageCnt = 1;
                        self.page = pageCnt;
                        self.fnMainList();
                    },
                    getPoints : function(userId){
                        let self = this;
                        let nparmap = {
                            userId : userId,
                        };
                        $.ajax({
				        	url:"/point/current.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
				        		console.log("11",data);
                                self.currentPoint = data.point.currentPoint;
				        	}
				        });
                    },
                    FnAddPoint: async function(userId) {
                    		let self = this;
                    		
                    	    let { value: point } = await Swal.fire({
                    		  title: "추가 또는 삭감할 포인트를 입력하세요",
                    		  input: "number",
                    		  inputLabel: "Point",
                    		  inputPlaceholder: "예: 1000 , -1000"
                    		});
                    	    
                    		if (point) {
                    		  
                    		  let pointAdd = {
                                      userId : userId, //받을 수의사 아이디
                                      usedPoint: Number(point),
                                      remarks : "관리자에 의한 포인트 수정",
                              }
                			  
                			  $.ajax({
                                  url:"/point/used.dox",
                                  dataType:"json",	
                                  type : "POST", 
                                  data : pointAdd,
                                  success : function(data) { 
                                	  alert("수정 완료");
	                                  	self.selectedMemberId = null;  // 같은 걸 누르면 닫힘
	                      				self.fnMainList();
                                  },
                                  
                              });
                    		  
                    		}
                    },   
                },
                mounted() {
                	let self = this;
                	const params = new URLSearchParams(window.location.search);
                    
                    self.menu = params.get("menu") || "stat";
                    self.submenu = params.get("submenu") || "1";
					self.fnMainList();

                	
                }
            });
            
            app.mount("#app");
            
    </script>
