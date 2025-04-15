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
		
		/* 게시판 테이블 스타일 */
		.board-table {
		    width: 100%;
		    border-collapse: collapse;
		}
		.board-th, .board-td {
		    padding: 10px;
		    text-align: center;
		}
		.board-th {
		    background-color: #f1f5f9;
		    font-weight: bold;
		}
		.board-tr:hover {
		    background-color: #f8fafc;
		}
		.board-title {
		    color: #2563eb;
		    font-weight: 600;
		    text-decoration: none;
		}
		.board-title:hover {
		    text-decoration: underline;
		}
		.board-search {
		    flex-grow: 1;
		    margin-right: 10px;
		}
		.board-search-btn {
		    min-width: 80px;
		}
		.board-page-btn {
		    min-width: 80px;
		}
		.board-select {
		    width: 120px;
		}
		.search-left {
		    display: flex;
		    align-items: center;
		    gap: 10px; /* 요소 사이 여백 */
		    flex-wrap: wrap; /* 화면이 작아지면 자동 줄바꿈 */
		}
		.search-left select,
		.search-left input,
		.search-left button {
		    height: 38px; /* 높이 통일 */
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
		
		/* 회원 상태 뱃지 */
		.status-active {
		    background-color: #d1fae5;
		    color: #10b981;
		    padding: 5px 10px;
		    border-radius: 10px;
		    font-size: 12px;
		    font-weight: 600;
		    display: inline-block; /* 뱃지가 글자에 맞게 조정 */
		    min-width: 60px; /* 최소 너비 확보 */
		    text-align: center;
		}

		.status-inactive {
		    background-color: #fee2e2;
		    color: #dc2626;
		    padding: 5px 10px;
		    border-radius: 10px;
		    font-size: 12px;
		    font-weight: 600;
		    display: inline-block; /* 뱃지가 글자에 맞게 조정 */
		    min-width: 60px; /* 최소 너비 확보 */
		    text-align: center;
		}	
		
		.editor-control {
		    height: 200px;
		    width: 100%;
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
		
    </style>
    
</head>
<body>

    <div id="app" class="dashboard-container col-9">
       
         <!-- Main Content1 -->
         <div class=" main-content">
                <h2>상품 리뷰/문의 관리</h2>

				<!-- 게시판 리스트 -->
				<div class="card">

					<!-- 게시판 선택 버튼 -->
					<div class="d-flex justify-content-center gap-2 mt-3">
					    <button class="btn"  :class="currentType === 'F' ? 'btn-primary' : 'btn-outline-primary'" @click="fnBoardList('F')">상품 리뷰</button>
					    <button class="btn"  :class="currentType === 'A' ? 'btn-warning' : 'btn-outline-warning'" @click="fnBoardList('A')">상품 문의</button>
					</div>
					
				    <div class="card-body">
				    
						<div class="row g-2 align-items-center mb-3">
						    <!-- N개씩 보기 -->
						    <div class="col-auto">
						        <select v-model="pageSize" class="form-select board-select" @change="fnBoardSearch">
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
						        <input v-model="keyword" @keyup.enter="fnBoardSearch" class="form-control board-search" placeholder="🔍 검색어 입력" />
						    </div>
						
						    <!-- 검색 버튼 -->
						    <div class="col-auto">
						        <button class="btn btn-primary board-search-btn" @click="fnBoardSearch">검색</button>
						    </div>
						</div>
            
				        <table class="table board-table">
				            <thead>
				                <tr>
				                    <th><input type="checkbox" @click="fnAllCheck" v-model="allChk" ></th>
				                    <th class="board-th">번호</th>
				                    <th class="board-th">제목</th>
				                    <th class="board-th">작성자</th>
				                    <th class="board-th">작성일</th>
				                    <th style="width: 10%;" class="text-center">상태</th>  
				                    <th v-if="currentType == 'A'" >관리</th>
				                </tr>
				            </thead>
				            <tbody>
				                <template v-for="(post, index) in boardList">
				                <tr  class="board-tr">
				                    <td><input type="checkbox" :value="post.boardId" v-model="selectList"></td>
				                    <td class="board-td">{{ index + 1 }}</td>
				                    <td class="board-td">
				                        <a @click="fnView(post.productId)" class="board-title">{{ post.title }}</a>
				                    </td>
				                    <td class="board-td">{{ post.userId }}</td>
				                    <td class="board-td">{{ post.createdAt }}</td>
				                    <td>
				                      <span v-if="post.deleteYn" :class="post.deleteYn === 'N' ? 'status-active' : 'status-inactive'">
									    {{ post.deleteYn === 'N' ? '정상' : '삭제' }}
									  </span>
									  <span v-else-if="post.answerText" class="badge bg-success">
									    답변완료
									  </span>
									  <span v-else class="badge bg-danger">
									    답변필요
									  </span>
	                           		</td>
	                           		<td  v-if="currentType == 'A'" >
           								<button class="btn-edit me-2" @click="fnEdit(post.qnaId)">답변</button>
	                            	</td>
				                </tr>
								<!-- 토글되는 수정 입력란 -->
								<tr v-if="updateqnaId === post.qnaId">
								    <td colspan="8">
								        <div class="edit-form border rounded p-4 bg-light">
								            
								            <!-- 상품 정보 (썸네일 + 상품명) -->
								            <div class="row align-items-center mb-4" v-if="productInfo">
								                <!-- 썸네일 이미지 -->
								                <div class="col-auto">
								                    <img 
								                        :src="productInfo.filePath" 
								                        alt="상품 이미지" 
								                        class="img-thumbnail" 
								                        style="width: 80px; height: 80px; object-fit: cover;" 
								                    />
								                </div>
								                <!-- 상품 이름 -->
								                <div class="col">
								                    <h5 class="mb-0 fw-bold">{{ productInfo.productName }}</h5>
								                </div>
								            </div>
								
								            <!-- 질문 내용 -->
								            <div class="row mb-3">
								                <div class="col-12">
								                    <label class="form-label fw-bold">질문 내용:</label>
								                    <div class="form-control" v-html="editData.questionText"></div>
								                </div>
								            </div>
								
								            <!-- 관리자 답변 입력 -->
								            <div class="row mb-3">
								                <div class="col-12">
								                    <label for="answerText" class="form-label fw-bold">관리자 답변:</label>
								                    <input
								                        type="text"
								                        id="answerText"
								                        v-model="editData.answerText"
								                        class="form-control"
								                        placeholder="답변 내용을 입력하세요"
								                    />
								                </div>
								            </div>
								
								            <!-- 버튼 영역 -->
								            <div class="d-flex justify-content-end gap-2">
								                <button class="btn btn-primary custom-btn" @click="fnSave">저장</button>
								                <button class="btn btn-secondary custom-btn" @click="updateqnaId = null">취소</button>
								            </div>
								        </div>
								    </td>
								</tr>
				                </template>
				            </tbody>
				        </table>
				        
						<div class="d-flex justify-content-between align-items-center mt-3">
						    <!-- 버튼 영역 -->
						    <div class="d-flex gap-2 me-auto">
						        <!-- 선택 삭제 버튼 -->
						        <button class="btn btn-danger board-delete-btn" @click="fnDeleteSelected" :disabled="selectList.length === 0">
						            선택 삭제
						        </button>
						    </div>
						
						    <!-- 페이지네이션 버튼 -->
						    <div class="d-flex align-items-center">
						        <!-- 이전 페이지 버튼 -->
						        <a class="btn btn-outline-secondary board-page-btn prev-next-btn" href="javascript:;" @click="fnPageMove('prev')" v-if="page != 1">
						            <i class="bi bi-chevron-left"></i>
						        </a>
						
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
						
						            <!-- 마지막 페이지로 이동하는 "..." -->
						            <a v-if="num === index && page < index - 2" 
						               href="javascript:;"  
						               @click="fnPage(index)" 
						               class="btn btn-outline-secondary board-page-btn">
						               ...
						            </a>
						        </template>
						
						        <!-- 다음 페이지 버튼 -->
						        <a class="btn btn-outline-secondary board-page-btn prev-next-btn" href="javascript:;" @click="fnPageMove('next')" v-if="page != index">
						            <i class="bi bi-chevron-right"></i>
						        </a>
						    </div>
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
						boardList: [],
						index: 0,
						pageSize: 5,
						page: 1,
						searchOption: "all",
						keyword: "",
						orderKey: "",
						orderType: "",
						sessionId : "${sessionId}" || "",
						category : "",
						selectList : [],
						allChk : false,
						isCreating : false,
						currentType : '',
						updateqnaId : '',
						productInfo : {},
                     };
                 },
                computed: {

                },
                methods: {
                	fnBoardList : function( fnkey ) {
                        let self = this;
                        self.isCreating = false;
                        
                        if (fnkey == '' || fnkey == null ) {
                        	self.category = 'F';
                        } else {
                        	if (self.category != fnkey){
                            	self.page = 1;
                            	self.category = fnkey;
                        	}

                        }
                        
                        self.currentType = self.category;
                        
                        
                        let url = "";
                        
                        
                        if (self.category == 'F') {
                        	url = "/product/reviewList.dox";
                        } else {
                        	url = "/product/qnaList.dox";
                        }
                        
                         
                        
                        
                        console.log("searchOption:", self.searchOption);
                        
                        let nparmap = {
                            searchOption: self.searchOption,
                            page: (self.page - 1) * self.pageSize,
                            pageSize: self.pageSize,
                            orderKey: self.orderKey,
                            orderType: self.orderType,
                            keyword: self.keyword,
                            userId: self.userId,
                            category : self.category,
                        };
                        self.selectList = [];
                        self.allChk = false;
                        
                        $.ajax({
                            url: url,
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("data", data);
								
                                if (data.reviewList ) {
                                    self.boardList = data.reviewList;
                                }
                                
                                if (data.list ) {
                                    self.boardList = data.list;
                                }
                                
                                if (data.totalCount && data.totalCount !== undefined) {
                                    self.index = Math.ceil(data.totalCount / self.pageSize);
                                } else {
                                    self.index = 0;
                                    console.warn("count 정보 없음!", data);
                                }
                            }
                        });
                	},
                	fnProduct(productId) {
                        var self = this;
                        var nparmap = { productId: productId };
                        $.ajax({
                            url: '/product/get.dox',
                            dataType: 'json',
                            type: 'POST',
                            data: nparmap,
                            success: function (data) {
                                console.log("234",data);
                                self.productInfo = data.info;

                            }
                        });
                    },
                    fnView(productId) {
                        let self = this;
                        localStorage.setItem("page", self.page);
                        location.href="/product/view.do?productId=" + productId ;
                    },
                    fnPage(num) {
                        this.page = num;
                        this.fnBoardList(this.category);
                    },
                    fnPageMove(direction) {
                        if (direction === "next") this.page++;
                        else this.page--;
                        this.fnBoardList(this.category);
                    },
                    fnOrder(orderKey) {
                        if (this.orderKey !== orderKey) this.orderType = "";
                        this.orderKey = orderKey;
                        this.orderType = this.orderType === "ASC" ? "DESC" : "ASC";
                        this.fnBoardList(this.category);
                    },
                    fnBoardSearch : function(){
                        let self = this;
                        let pageCnt = 1;
                        self.page = pageCnt;
                        self.fnBoardList(this.category);
                    },
                    fnAllCheck : function() {
                        let self = this;
                        self.allChk = !self.allChk;
                        if(self.allChk){
                            for(let i=0; i<self.boardList.length; i++){
                                self.selectList.push(self.boardList[i].boardId);
                            }
                        } else {
                            self.selectList = [];
                        }   
                    },
                    fnDeleteSelected : function(){
                        let self = this;
                        
						if(!confirm('삭제하시면 복구할수 없습니다. \n 정말로 삭제하시겠습니까??')){
						    return false;
						}
						
        				var nparmap = {
                            selectList : JSON.stringify(self.selectList),
                            category : self.category,
                        };
        				$.ajax({
        					url:"/admin/remove-list.dox",
        					dataType:"json",	
        					type : "POST", 
        					data : nparmap,
        					success : function(data) { 
        						console.log(data);
                                alert(data.count + "건 삭제 완료!");
                                self.page = 1;
                                self.fnBoardList();
        					}
        				});
                    },
                    fnEdit(qnaId){
                    	
                    	var self = this;

                        if (self.updateqnaId === qnaId) {
                        	self.updateqnaId = null;  // 같은 걸 누르면 닫힘
							self.productInfo = null ;
                        } else {
                            const member = self.boardList.find(m => m.qnaId === qnaId);
                            self.editData = { ...member };  // 수정할 데이터 채우기
                            self.updateqnaId = qnaId;
                            self.fnProduct(self.editData.productId);
                        }
                        
                    },
                    fnSave() {
                    	var self = this;
                    	
                    	self.editData.message = "상품 문의 답변 등록";
                    	
                    	var nparmap = self.editData;
                    	$.ajax({
                    		url: "/admin/UpdateAdminQna.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			//console.log("main",data);
                    			alert("수정 완료");
                            	self.updateqnaId = null;  // 같은 걸 누르면 닫힘
                				self.fnBoardList();
                    		}
                    	});
                    },
                    
                },
                mounted() {
                	let self = this;
                	const params = new URLSearchParams(window.location.search);
                    
                    self.menu = params.get("menu") || "stat";
                    self.submenu = params.get("submenu") || "1";
                    self.category = params.get("category") || "F";

                    self.fnBoardList();
                	
                }
            });
            
            app.mount("#app");
            
    </script>
