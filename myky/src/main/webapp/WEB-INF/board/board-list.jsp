<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/board/board.css"/>
    <title>자유게시판</title>

    <style>
       
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div id="fb-app" class="fb-container fb-a">
    <div class="fb-section-header" v-if="category == 'F'">
        자유게시판
    </div>
    <div class="fb-section-header" v-if="category == 'A'">
        NOTICE
    </div>
    <div class="fb-section-headerDown" v-if="category == 'F'">
        여러분의 이야기를 들려주세요
    </div>
    <div class="fb-section-headerDown" v-if="category == 'A'">
        새 소식을 알려드립니다.
    </div>
    <div class="fb-setCss">
    <hr class="fb-custom-hr">
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
            <table class="fb-table-wrapper fb-table">
                <tr class="fb-table-th">
                    <th>번호</th>
                    <th style="width: 300px;">제목</th>
                    <th>작성자</th>
                    <th style="width: 50px;">작성일</th>
                    <th>조회수</th>
                </tr>
                <tr v-if="list.length === 0 || !list.some(item => item.isDeleted === 'N')">
                    <td colspan="5" style="text-align: center; padding: 50px;">검색된 게시글이 없습니다.</td>
                </tr>
                <tr v-for="(item, index) in list" class="fb-table-td fb-tr" v-else>
                    <template v-if="item.isDeleted == 'N'">
                        <td>{{item.boardId}}</td>
                        <td href="javascript:;" @click="fnView(item.boardId)" style="font-weight: bold;">{{item.title}}
                        <span v-if="parseInt(item.commentCount) > 0 && category == 'F'" class="fb-cmtCountColor">({{item.commentCount}})</span>
                        </td>
                        <td>{{item.nickName}}</td>
                        <td>{{item.createdAt.substring(0, 10)}}</td>
                        <td>{{item.cnt}}</td>
                    </template>
                </tr>
            </table>
        </div>
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

                    <template  v-if="category == 'A'">
                        <button class="fb-button" @click="fnAdd" v-if="sessionRole == 'ADMIN'">글쓰기</button>
                    </template>
                    
                    <template  v-else>
                        <button class="fb-button" @click="fnAdd" v-if="sessionId">글쓰기</button>
                    </template>

                </div>
            <jsp:include page="../common/footer.jsp"/>
        </body>
    </html>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const app = Vue.createApp({
        data() {
            return {
                list: [],
                boardId: "",
                userId: "",
                nickName : "",
                title : "",
                index: 0,
                pageSize: 5,
                page: 0,
                searchOption: "all",
                keyword: "",
                orderKey: "",
                orderType: "",
                sessionId : "${sessionId}" || "",
                sessionRole: "${sessionRole}" || "",
                category : "",
            };
        },
        computed: {

        },
        methods: {
            fnBoardSearch : function(){
                let self = this;
                let pageCnt = 1;
                self.page = pageCnt;
                self.fnBoardList();
            },
            fnBoardList() {
                let self = this;
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
                $.ajax({
                    url: "/board/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        if(data.result != 'success'){
                            alert("잘못된 주소입니다.");
                            location.href="/board/boardList.do";
                        }
                        self.list = data.board;                       
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
                location.href="/board/add.do?category="+self.category;
            },
            fnView(boardId) {
                let self = this;
                localStorage.setItem("page", self.page);
                location.href="/board/view.do?boardId=" + boardId + "&category="+self.category;
            },
            fnPage(num) {
                this.page = num;
                this.fnBoardList();
            },
            fnPageMove(direction) {
                if (direction === "next") this.page++;
                else this.page--;
                this.fnBoardList();
            },
            fnOrder(orderKey) {
                if (this.orderKey !== orderKey) this.orderType = "";
                this.orderKey = orderKey;
                this.orderType = this.orderType === "ASC" ? "DESC" : "ASC";
                this.fnBoardList();
            },
        },
        mounted() {
            let self = this;
            let savedPage;
            const params = new URLSearchParams(window.location.search);
            this.boardId = params.get("page") || "";
            this.category = params.get("category") || "F";

            if(!(self.category == 'A' || self.category == 'F')){
                        alert("잘못된 접근입니다.");
                        location.href="/board/list.do?category=F";
            }

             if(localStorage.getItem('page') == "undefined"){
                savedPage  = 1;
             } else {
                savedPage  = localStorage.getItem('page');
             }
             
             self.page = savedPage ? Number(savedPage) : 1;


            self.fnBoardList();
            localStorage.removeItem('page');
        },
    });
    app.mount("#fb-app");
});
</script>