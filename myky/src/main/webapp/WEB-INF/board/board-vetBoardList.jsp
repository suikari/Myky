<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수의사 게시판</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        #app {
            padding-bottom: 120px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
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
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
        }
        th {
            background-color: #202060;
            color: #fca311;
            padding: 12px;
            font-weight: 600;
            font-size: 15px;
        }
        td {
            padding: 12px;
            font-size: 14px;
            color: #333;
            background-color: #fafafa;
        }
        tr:nth-child(even) td {
            background-color: #f0f0f0;
        }
        a {
            color: #202060;
            font-weight: bold;
            text-decoration: none;
            margin: 0 6px;
        }
        a:hover {
            color: #fca311;
            text-decoration: underline;
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
        .acceptButtonN {
            color: #fca311;
            font-weight: bold;
            background-color: #202060;
            border-radius: 6px;
            width: 100px;
            height: 30px;
            text-align: center;
        }
        .acceptButtonY {
            color: #202060;
            font-weight: bold;
            background-color: #fca311;
            border-radius: 6px;
            width: 100px;
            height: 30px;
            text-align: center;
        }

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
    <div id="app" class="container">

        <div class="section-header">
            수의사 게시판
        </div>
        <div class="section-headerDown">
            질문과 답
        </div>    
        <div class="setCss"></div>
        <hr class="custom-hr">
            <div class="search-wrapper">
                <div class="search-right">
                    <select v-model="pageSize" @change="fnBoardSearch">
                        <option value="5">5개씩</option>
                        <option value="10">10개씩</option>
                        <option value="15">15개씩</option>
                        <option value="20">20개씩</option>
                    </select>
                </div>
                <div class="search-left">
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
            <table class="table-wrapper">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                    <th>포인트</th>
                    <th>답변</th>
                    <th>채택</th>
                </tr>
                <tr v-for="(item, index) in list">
                    <template v-if="item.isDeleted == 'N'">
                        <td>{{item.vetBoardId}}</td>
                        <td><a href="javascript:;" @click="fnView(item.vetBoardId)">{{item.title}}</a></td>
                        <td>{{item.nickName}}</td>
                        <td>{{item.createdAt}}</td>
                        <td>{{item.cnt}}</td>
                        <td>{{item.points}}</td>
                        <td class="cmtCountColor">
                            <template v-if="parseInt(item.commentCount) > 0">
                              ({{ item.commentCount }})
                            </template>
                          </td>
                        <td>
                            <div class="acceptButtonN" v-if="item.isAccepted == 'N'">채택 전</div>
                            <div class="acceptButtonY" v-if="item.isAccepted == 'Y'">채택완료</div>
                        </td>
                    </template>
                        
                </tr>
            </table>
            <div v-if="index > 0">
                <a href="javascript:;" @click="fnPageMove('prev')" v-if="page != 1"> < </a>
                <a href="javascript:;" v-for="num in index" @click="fnPage(num)">
                    <span :class="{ 'current-page': page === num }">{{ num }}</span>
                </a>
                <a href="javascript:;" @click="fnPageMove('next')" v-if="page != index"> > </a>
            </div>
            <button class="button" @click="fnAdd" v-if="sessionId">글쓰기</button>
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
                        console.log("searchOption:", self.searchOption);
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
                                result
                                console.log("self.nickName", data.nickName);
                                console.log("vetBoard list:", data.vetBoard);

                                if (data.count && data.count.cnt !== undefined) {
                                    self.index = Math.ceil(data.count.cnt / self.pageSize);
                                } else {
                                    self.index = 0;
                                    console.warn("count 정보 없음!", data);
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
                    console.log("sessionId:", this.sessionId); 
                },
            });

            app.mount("#app");
        });
    </script>
