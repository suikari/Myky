<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<link rel="stylesheet" href="/css/board/board.css"/>
    <style>

        /* 공지사항 제목 */
        .section-header {
            /* background-color: #202060; */
            color: #202060;
            font-weight: bold;
            height: 70px;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
            align-items: center;
            justify-content: center;
            display: flex;
            align-items: left; /* 세로 중앙 정렬 */
            justify-content: left; /* 가로 중앙 정렬 */
            font-size: 40px;
            margin-top: 80px;
            width: 100%;
            max-width: 1000px;
        } 
        .section-headerDown {
            color: #333;
            font-weight: bold;
            text-align: left;
            margin-top: -10px;
            width: 100%;
            max-width: 1000px;
        }
        .search-wrapper {
            width: 90%;
            margin: 20px auto;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            flex-wrap: wrap;
        }
        .search-left,
        .search-right {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 3px;
        }
        .search-left select,
        .search-left input,
        .search-left button,
        .search-right select {
            height: 38px;
            font-size: 14px;
            border-radius: 6px;
            padding: 0 12px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        .search-left input {
            width: 220px;
            background-color: #f0f0f0;
            border: 2px solid #202060;
            border-radius: 30px;
            transition: all 0.3s ease;
        }
        .search-left input:focus {
            background-color: #fff;
            border-color: #fca311;
        }
        .search-left button {
            background-color: #202060;
            color: #fca311;
            border: none;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .search-left button:hover {
            background-color: #fca311;
            color: #202060;
        }
        .table-wrapper {
            width: 90%;
            margin: 30px auto;
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        #fb-board-app {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
            padding-bottom: 120px;
        }
        #fb-board-app table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
        }

        #fb-board-app th {
            background-color: #202060;
            color: #fca311;
            padding: 12px;
            font-weight: 600;
            font-size: 15px;
        }

        #fb-board-app a {
            color: #202060;
            font-weight: bold;
            text-decoration: none;
            margin: 0 6px;
        }

        #fb-board-app a:hover {
            color: #fca311;
            text-decoration: underline;
        }

        .buttonTitle {
            font-weight: bold;
            /* background-color: #ccc; */
            /* color: #000000; */
            cursor: pointer;
            /* border: 1px solid #f9f9f9; */
            /* border-radius: 6px; */
            font-size: 15px;
            padding: 10px;
            text-align: center;
        }
        .buttonTitle:hover {
            color: #fca311;
        }
        button.button {
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            background-color: #202060;
            color: #fca311;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }
        button.button:hover {
            background-color: #fca311;
            color: #202060;
        }
        .buttonMargin{
            margin-bottom: 100px;
        }
        .fb-pagination {
            text-align: center;
        }

        .fb-pagination span {
            margin: 0 4px;
            font-weight: bold;
            cursor: pointer;
            color: #202060;
        }

        .fb-pagination span.current-page {
            color: #fca311;
            text-decoration: underline;
            cursor: default;
        }

        .fb-pagination span:hover {
            text-decoration: underline;
        }
        div {
            text-align: center;
        }
        span {
            margin: 0 4px;
            font-weight: bold;
            cursor: pointer;
            color: #202060;
        }
        span.current-page {
            color: #fca311;
            text-decoration: underline;
            cursor: default;
        }
        span:hover {
            text-decoration: underline;
        }
        .custom-hr {
            width: 1000px;
            max-width: 100%;
            border: none;
            border-top: 1px solid #ccc;
            margin-top: 10px;
            margin-bottom: 70px;
            width: 100%;
        }
        .setCss {
            width: 100%;
            max-width: 1000px;

        }
        .cmtCountColor {
            color: #fca311;
        }
        .dropdown-content {
            display: none;  /* 기본적으로 숨김 처리 */
            padding: 10px;
            background-color: #f9f9f9; 
            border: 1px solid #ddd;  /* 테두리 */
            border-radius: 5px;  /* 모서리 둥글게 */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);  /* 그림자 효과 */
            margin-top: 5px;  /* 위쪽 여백 */
            font-size: 14px;  /* 폰트 크기 */
            line-height: 1.6;  /* 줄 간격 */
            max-height: 300px;  /* 최대 높이 */
            overflow-y: auto;  /* 내용이 넘칠 경우 스크롤 */
            font-weight: bold;
        }

            /* 드롭다운 메뉴가 열릴 때 표시되도록 */
        tr.dropdown-content {
            display: table-row;  /* 드롭다운이 보이도록 설정 */
        }
            /* 드롭다운 컨텐츠에 마우스를 올렸을 때 */
        .dropdown-content:hover {
            background-color: #f8f8f8;  /* 호버시 배경색 */
            color: #202060;
            font-weight: bold;
        }
        .setCss {
            width: 100%;
            max-width: 1000px;

        }
        tr.faq-td.faq-even td {
            background-color: #f0f0f0;
        }
        tr.faq-td.faq-odd td {
            background-color: #fafafa;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
    <div id="app" class="container">
        <div id="fb-board-app">


            <div class="section-header" @click="fnFAQView('')">
                FAQ
            </div>
            <div class="section-headerDown">
                자주 묻는 질문
            </div>    
            <div class="setCss"></div>
            <hr class="custom-hr">


            <div class="setCss">
                <button class="button" @click="fnChange('이용방법')">이용방법</button>
                <button class="button" @click="fnChange('교환/반품')">교환/반품</button>
                <button class="button" @click="fnChange('계정')">계정</button>
                <button class="button" @click="fnChange('상품관련')">상품관련</button>
                <button class="button" @click="fnChange('배송')">배송</button>
                <button class="button" @click="fnChange('결제관리')">결제관리</button>

                <template class="search-right">
                    <select v-model="pageSize" @change="fnBoardSearch">
                        <option value="5">5개씩</option>
                        <option value="10">10개씩</option>
                        <option value="15">15개씩</option>
                        <option value="20">20개씩</option>
                    </select>
                </template>
            </div>
            <table class="table-wrapper setCss" style="width: 100%; max-width: 1000px;">
                <tr>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th> 
                </tr>

                <!-- 게시글 목록 -->


                <template v-for="(item, index) in menu">
                    <template v-if="item.isDeleted == 'N'">
                        <tr :class="['faq-td', index % 2 === 1 ? 'faq-even' : 'faq-odd']" @click="fnFAQDrop(item.boardId)">
                            <td>{{item.boardId}}</td>
                            <td>{{item.menu}}</td>
                            <td>
                                <div class="buttonTitle">{{item.title}}</div>
                            </td>
                        </tr>

                        <tr v-show="selectedBoardId == item.boardId" class="dropdown-content">
                            <td colspan="3">
                                <div v-html="item.content"></div>
                            </td>
                        </tr>
                    </template>
                </template>
            </table>

            <!-- 페이지네이션 버튼 -->
            <div>
                <!-- 이전 페이지 버튼 -->
                <a class="btn btn-outline-secondary board-page-btn prev-next-btn" href="javascript:;" @click="fnPageMove('prev')" v-if="page != 1">
                    <i class="bi bi-chevron-left"> < </i>
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
                        class="btn btn-outline-secondary board-page-btn" 
                        :class="{ 'current-page': page === num }">
                        {{ num }}
                        </span>
                    
                        <a v-if="num === index && page < index - 2" 
                        href="javascript:;"  
                        @click="fnPage(index)" 
                        class="btn btn-outline-secondary board-page-btn">
                        ...
                        </a>
                </template>
    
                <!-- 다음 페이지 버튼 -->
                <a class="btn btn-outline-secondary board-page-btn prev-next-btn" href="javascript:;" @click="fnPageMove('next')" v-if="index > 0 && page != index">
                    <i class="bi bi-chevron-right"> > </i>
                </a>
            </div>

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

            app.mount("#app");
        });
    </script>
