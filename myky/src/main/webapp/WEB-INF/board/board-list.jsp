<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <script src="js/swiper8.js"></script>
    <link rel="stylesheet" href="css/main.css">
    <script src="../js/page-Change.js"></script>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        /* 공지사항 제목 */
        .section-header {
            /* background-color: #202060; */
            color: #202060;
            font-weight: bold;
            height: 70px;
            width: 100%;
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
            margin-left: 80px;
            margin-bottom: 20px;
        } 
        .section-headerDown {
            color: #333;
            font-weight: bold;
            text-align: left;
            margin-left: 90px;
            margin-top: -35px;
            margin-bottom: 30px;
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
            margin-top: 20px;
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
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div id="app" class="container">
    <div class="section-header">
        NOTICE
    </div>
    <div class="section-headerDown">
        새 소식을 알려드립니다.
    </div>
    <hr class="custom-hr">
    <div class="search-wrapper">
        <div class="search-right">
            <select v-model="pageSize" @change="fnBoardList">
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
                <option value="userId">작성자</option>
            </select>
            <input v-model="keyword" @keyup.enter="fnBoardList" placeholder="🔍 검색어 입력" />
            <button @click="fnBoardList">검색</button>
        </div>
    </div>
    <table class="table-wrapper">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        <tr v-for="(item, index) in list">
            <td>{{item.boardId}}</td>
            <td><a href="javascript:;" @click="fnView(item.boardId)">{{item.title}}</a></td>
            <td>{{item.userId}}</td>
            <td>{{item.createdAt}}</td>
            <td>{{item.cnt}}</td>
        </tr>
    </table>
    <div v-if="index > 0">
        <a href="javascript:;" @click="fnPageMove('prev')" v-if="page != 1"> < </a>
        <a href="javascript:;" v-for="num in index" @click="fnPage(num)">
            <span :class="{ 'current-page': page === num }">{{ num }}</span>
        </a>
        <a href="javascript:;" @click="fnPageMove('next')" v-if="page != index"> > </a>
    </div>
    <button class="button buttonMargin" @click="fnAdd">글쓰기</button>
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
                index: 0,
                pageSize: 5,
                page: 1,
                searchOption: "all",
                keyword: "",
                orderKey: "",
                orderType: "",
            };
        },
        computed: {

        },
        methods: {
            fnBoardList() {
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
                };
                $.ajax({
                    url: "/board/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        self.list = data.board;
                        console.log("data", data);
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
                pageChange("/board/add.do", {});
            },
            fnView(boardId) {
                let self = this;
                localStorage.setItem("page", self.page);
                pageChange("/board/view.do", { boardId: boardId });
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
    app.mount("#app");
});
</script>