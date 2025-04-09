<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ 게시판</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<link rel="stylesheet" href="/css/board/board.css"/>
    <style>
       
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
    <div id="fb-app" class="fb-container">

            <div class="fb-section-header" @click="fnFAQView('')">
                FAQ
            </div>
            <div class="fb-section-headerDown">
                자주 묻는 질문
            </div>    
            <!-- <div class="fb-setCss"></div> -->
            <hr class="fb-custom-hr">

        <div class="fb-setCss">
            <div class="fb-button-group">
                <button class="fb-button" @click="fnChange('이용방법')">이용방법</button>
                <button class="fb-button" @click="fnChange('교환/반품')">교환/반품</button>
                <button class="fb-button" @click="fnChange('계정')">계정</button>
                <button class="fb-button" @click="fnChange('상품관련')">상품관련</button>
                <button class="fb-button" @click="fnChange('배송')">배송</button>
                <button class="fb-button" @click="fnChange('결제관리')">결제관리</button>
            </div>
            <div class="fb-search-wrapper">
                <template class="fb-search-right">
                    <select v-model="pageSize" @change="fnBoardSearch">
                        <option value="5">5개씩</option>
                        <option value="10">10개씩</option>
                        <option value="15">15개씩</option>
                        <option value="20">20개씩</option>
                    </select>
                </template>
            </div>
            <table class="fb-table-wrapper fb-setCss">
                <tr class="fb-table-th fb-table-td">
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th> 
                </tr>
                <!-- 게시글 목록 -->
                <template v-for="(item, index) in menu" class="fb-table-td fb-tr">
                    <template v-if="item.isDeleted == 'N'">
                        <tr :class="['faq-td', index % 2 === 1 ? 'faq-even' : 'faq-odd']" @click="fnFAQDrop(item.boardId)">
                            <td>{{item.boardId}}</td>
                            <td>{{item.menu}}</td>
                            <td>
                                <div class="fb-buttonTitle">{{item.title}}</div>
                            </td>
                        </tr>

                        <tr v-show="selectedBoardId == item.boardId" class="fb-dropdown-content">
                            <td colspan="3">
                                <div v-html="item.content"></div>
                            </td>
                        </tr>
                    </template>
                </template>
            </table>
        </div>

            <!-- 페이지네이션 버튼 -->
            <div class="fb-a">
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
                        <span v-if="num >= page - 2 && num <= page + 2" 
                            href="javascript:;"  
                            @click="fnPage(num)" 
                            class="fb-page-number" 
                            :class="{ 'fb-current-page': page === num }">
                            {{ num }}
                        </span>
                    
                        <a v-if="num === index && page < index - 2" 
                            href="javascript:;"  
                            @click="fnPage(index)" 
                            class="fb-page-number">
                            ...
                        </a>
                </template>
    
                <!-- 다음 페이지 버튼 -->
                <a class="fb-page-number" href="javascript:;" @click="fnPageMove('next')" v-if="index > 0 && page != index">
                    <i class="bi bi-chevron-right"></i>
                </a>
            </div>

    </div>
	<jsp:include page="/WEB-INF/common/footer.jsp"/>

    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        list : [],
                        menu : [],
                        category: "FAQ",
                        boardId : "",
                        content : "",
                        selectedBoardId : null,
                        index: 0,
                        pageSize: 5,
                        page: 1,
                        isDeleted : "",
                    };
                },
                computed: {

                },
                methods: {
                    fnFAQView(menuName) {
                        let self = this;
                        self.selectedBoardId = null;

                        let nparmap = {
                            menu : menuName,
                            category: self.category,
                            searchOption: self.searchOption,
                            page: (self.page - 1) * self.pageSize,
                            pageSize: self.pageSize,
                        }
                        $.ajax({
				    	    url:"/board/FAQView.dox",
				    	    dataType:"json",	
				    	    type : "POST", 
				    	    data : nparmap,
				    	    success : function(data) {
                                console.log("FAQ",data);
                                if(data.result != 'success'){
                                    alert("잘못된 주소입니다.");
                                    location.href="/board/FAQView.do";
                                }
                                self.menu = data.menu;
                                if (data.count && data.count.cnt !== undefined) {
                                    self.index = Math.ceil(data.count.cnt / self.pageSize);
                                } else {
                                    self.index = 0;
                                    console.warn("count 정보 없음!", data);
                                }
                            }
				        });       
                    },
                    fnChange(menu){
                        let self = this;

                        self.page = 1;
                        self.fnFAQView(menu);
                    },
                    fnFAQDrop : function (boardId){
                        let self = this;

                        console.log("1", boardId);

                        if (self.selectedBoardId === boardId) {
                        	self.selectedBoardId = null;  // 같은 걸 누르면 닫힘
                        	console.log("2",boardId);

                        } else {
                            self.selectedBoardId = boardId;
                        	console.log("3",boardId);
                        }
                    },
                    fnBoardSearch : function(){
                        let self = this;
                        let pageCnt = 1;
                        self.page = pageCnt;
                        self.fnFAQView();
                    },
                    fnPage(num) {
                        this.page = num;
                        this.fnFAQView();
                    },
                    fnPageMove(direction) {
                        if (direction === "next") this.page++;
                        else this.page--;
                        this.fnFAQView();
                    },
                },
                mounted() {
                	let self = this;
                    self.fnFAQView();
                	
                }
            });

            app.mount("#fb-app");
        });
    </script>
