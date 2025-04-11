<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수의사 게시판</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<link rel="stylesheet" href="/css/board/board.css"/>
    
    <style>

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
    <div id="fb-app" class="fb-container fb-a">

        <div class="fb-section-header">
            수의사 게시판
        </div>
        <div class="fb-section-headerDown">
            수의사분들과 함께 질문을 나눠보세요
        </div>    
        <div class="fb-setCss">
            <hr class="fb-custom-hr">
        </div>
            <div class="fb-search-wrapper">
                <div class="fb-search-right">
                    <select v-model="pageSize" @change="fnBoardSearch">
                        <option value="5">5개씩</option>
                        <option value="10">10개씩</option>
                        <option value="15">15개씩</option>
                        <option value="20">20개씩</option>
                    </select>
                </div>
                <div class="fb-search-left">
                    <select v-model="searchOption">
                        <option value="all">전체</option>
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="userId">작성자</option>
                    </select>
                    <input v-model="keyword" @keyup.enter="fnBoardSearch" placeholder="🔍 검색어 입력" />
                    <button @click="fnBoardSearch">검색</button>
                </div>
            </div>
        <div class="fb-table-vet">
            <table class="fb-table-wrapper fb-table">
                <tr class="fb-table-th">
                    <th>번호</th>
                    <th style="width: 350px;">제목</th>
                    <th>작성자</th>
                    <th style="width: 100px;">포인트</th>
                    <th>답변</th>
                    <th>조회수</th>
                    <th style="width: 50px;">작성일</th>
                    <th>채택</th>
                </tr>
                <tr v-if="list.length === 0 || !list.some(item => item.isDeleted === 'N')">
                    <td colspan="8" style="text-align: center; padding: 50px;">검색된 게시글이 없습니다.</td>
                </tr>
                <tr v-for="(item, index) in list" class="fb-table-td fb-tr" v-else>
                    <template v-if="item.isDeleted == 'N'">
                        <td>{{item.vetBoardId}}</td>
                        <td href="javascript:;" @click="fnView(item.vetBoardId)" style="font-weight: bold;">{{item.title}}</td>
                        <td>{{item.nickName}}</td>
                        <td>{{item.points}}</td>
                        <td style="color: rgb(255, 147, 0); font-weight: bold;">
                            <template v-if="parseInt(item.commentCount) > 0">
                                {{ item.commentCount }}
                            </template>
                        </td>
                        <td>{{item.cnt}}</td>
                        <td>{{item.createdAt.substring(0, 10)}}</td>
                        <td>
                            <div class="fb-acceptButtonY" v-if="item.isAccepted == 'Y'">채택완료</div>
                            <div class="fb-acceptButtonN" v-else-if="parseInt(item.commentCount) > 0">채택 전</div>
                            <div class="fb-acceptButtonW" v-else>답변대기</div>
                        </td>
                    </template>
                </tr>
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
            <button class="fb-button" @click="fnAdd" v-if="sessionId">글쓰기</button>     
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
                        boardId : "",
                        userId : "",
                        nickName : "",
                        vetId : "",
                        content : "",
                        index : 0,
                        pageSize: 5,
                        page: 0,
                        searchOption: "all",
                        keyword: "",
                        orderKey: "",
                        orderType: "",
                        sessionId : "${sessionId}" || "",
                        sessionRole: "${sessionRole}" || "",
                       
                    };
                },
                computed: {

                },
                methods: {
                    fnBoardSearch : function(){
                        let self = this;
                        let pageCnt = 1;
                        self.page = pageCnt;
                        self.fnVetBoardList();
                    },
                    fnVetBoardList() {
                        let self = this;

                        let nparmap = {
                            searchOption: self.searchOption,
                            page: (self.page - 1) * self.pageSize,
                            pageSize: self.pageSize,
                            orderKey: self.orderKey,
                            orderType: self.orderType,
                            keyword: self.keyword,
                            userId: self.userId,
                            nickName : self.nickName,
                            content : self.content,
                        };
                        $.ajax({
                            url: "/board/vetBoardList.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap, 
                            success: function (data) {
                                if(data.result != 'success'){
                                    alert("잘못된 주소입니다.");
                                    location.href="/board/vetBoardList.do";
                                }
                                self.list = data.vetBoard;

                                if (data.count && data.count.cnt !== undefined) {
                                    self.index = Math.ceil(data.count.cnt / self.pageSize);
                                } else {
                                    self.index = 0;
                                }
                            }
                        });
                    },
                    fnAdd() {
                        let self = this;

                        location.href="/board/vetBoardAdd.do";
                    },
                    fnView(vetBoardId) {
                        let self = this;                        
                        localStorage.setItem("page", self.page);
                        location.href="/board/vetBoardView.do?vetBoardId=" + vetBoardId;
                    },
                    fnPage(num) {
                        this.page = num;
                        this.fnVetBoardList();
                    },
                    fnPageMove(direction) {
                        if (direction === "next") this.page++;
                        else this.page--;
                        this.fnVetBoardList();
                    },
                    fnOrder(orderKey) {
                        if (this.orderKey !== orderKey) this.orderType = "";
                        this.orderKey = orderKey;
                        this.orderType = this.orderType === "ASC" ? "DESC" : "ASC";
                        this.fnVetBoardList();
                    },
                },
                mounted() {
                	let self = this;
                    let savedPage;
                    const params = new URLSearchParams(window.location.search);
                    this.boardId = params.get("page") || "";
                    this.category = params.get("category") || "F";

                    if(localStorage.getItem('page') == "undefined"){
                        savedPage  = 1;
                    } else {
                        savedPage  = localStorage.getItem('page');
                    }
                    
                    self.page = savedPage ? Number(savedPage) : 1;
                    
                    self.fnVetBoardList();
                    localStorage.removeItem('page');
                }
            });

            app.mount("#fb-app");
        });
    </script>
