<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vue3 레이아웃 예제</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f8f8;
            }

            .mypage-container {
                width: 80%;
                margin: 20px auto;
                background: white;
                padding: 20px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            .user-info {
                display: flex;
                align-items: center;
                padding: 20px;
                border-bottom: 1px solid #ddd;
            }

            .profile-pic {
                width: 150px;
                height: 150px;
                background: gray;
                border-radius: 100%;
            }

            .summary {
                display: flex;
                justify-content: space-around;
                padding: 20px 0;
            }

            .summary-item {
                background: #eee;
                padding: 15px;
                border-radius: 10px;
                text-align: center;
                width: 30%;
            }

            .main-content {
                display: flex;
                margin-top: 20px;
            }

            .sidebar {
                width: 25%;
                background: #f1f1f1;
                padding: 20px;
                border-radius: 10px;
                cursor: pointer;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
            }

            .sidebar ul li {
                padding: 10px 0;
                cursor: pointer;
            }

            .order-status {
                width: 75%;
                padding: 20px;
            }

            .status-box {
                display: flex;
                justify-content: space-around;
                padding: 10px 0;
            }

            .status-box div {
                background: #eee;
                padding: 15px;
                border-radius: 10px;
                text-align: center;
                width: 20%;
            }

            .order-list {
                text-align: center;
                padding: 20px;
                background: #f8f8f8;
                border-radius: 10px;
                margin-top: 10px;
            }

            a {
                text-decoration: none;
                /* 링크의 밑줄 제거 */
                color: inherit;
                /* 링크의 색상 제거 */
            }

            /* 미니 게시판 테이블 */
            .board-table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                font-family: Arial, sans-serif;

            }

            /* 테이블 헤더 스타일 */
            .board-table th {
                background-color: #4CAF50;
                color: white;
                padding: 10px;
                text-align: center;
                font-size: 16px;
            }

            /* 테이블 데이터 셀 스타일 */
            .board-table td {
                padding: 10px;
                text-align: center;
                border-bottom: 1px solid #ddd;

            }

            /* 호버 효과 - 각 셀에 마우스를 올렸을 때 */
            .board-table tr:hover {
                background-color: #f1f1f1;
            }

            /* 삭제되지 않은 항목만 보여주는 조건 스타일 */
            .board-table tr[style*="display: none"] {
                display: none;
            }

            /* 제목 링크 스타일 */
            .board-table a {
                color: #333;
                text-decoration: none;
            }

            .board-table a:hover {
                color: #4CAF50;
                text-decoration: underline;
            }

            /* 테이블의 번호, 제목, 작성일, 조회수 칼럼 간격 */
            .board-table th,
            .board-table td {
                padding: 12px 15px;
            }

            /* 작성일 칼럼의 날짜 포맷에 맞춰 정렬 */
            .board-table td:nth-child(3) {
                text-align: center;
            }

            /* 번호 컬럼 중앙 정렬 */
            .board-table td:nth-child(1) {
                text-align: center;
            }

            /* 반응형 스타일 (작은 화면에서 테이블이 잘 보이도록 조정) */
            @media (max-width: 768px) {
                .board-table {
                    font-size: 14px;
                }

                .board-table th,
                .board-table td {
                    padding: 8px;
                }
            }

            .comment-page {
                font-family: 'Arial', sans-serif;
                margin: 20px;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 8px;
            }

            /* 테이블 스타일 */
            .comment-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .comment-table-header {
                background-color: #4CAF50;
                color: white;
                text-align: left;
                font-weight: bold;
            }

            .comment-table-column {
                padding: 12px 20px;
                text-align: left;
            }

            .comment-table-row {
                border-bottom: 1px solid #ddd;
            }

            .comment-table-row:hover {
                background-color: #f1f1f1;
            }

            /* 제목 스타일 */
            .comment-title {
                font-size: 16px;
                font-weight: bold;
                color: #333;
                padding-right: 10px;
            }

            /* 댓글 내용 스타일 */
            .comment-content {
                font-size: 14px;
                color: #555;
                max-width: 300px;
                word-wrap: break-word;
                padding: 10px;
            }

            .comment-link {
                color: #007BFF;
                text-decoration: none;
            }

            .comment-link:hover {
                text-decoration: underline;
            }

            /* 작성일 스타일 */
            .comment-date {
                font-size: 12px;
                color: #888;
                padding-left: 10px;
            }

            /* 기본 링크 스타일 */
            #index2,
            #index {
                text-decoration: none;
                font-size: 14px;
                padding: 5px 10px;
                cursor: pointer;
            }

            /* "bgColer2" 클래스: 기본 배경색 */
            .bgColer2 {
                background-color: #f0f0f0;
                color: #333;
                border-radius: 3px;
                padding: 5px 10px;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            /* "bgColer" 클래스: 선택된 항목 스타일 */
            .bgColer {
                background-color: #007bff;
                color: white;
                border-radius: 3px;
                padding: 5px 10px;
            }

            /* 페이지네이션 왼쪽과 오른쪽 화살표 */
            a#prev,
            a#next {
                font-size: 16px;
                font-weight: bold;
                margin: 0 5px;
            }

            /* 페이지가 선택된 상태일 때 */
            .bgColer {
                background-color: #007bff;
                /* 선택된 페이지는 파란색 */
                color: white;
                /* 글자는 흰색 */
            }

            /* 페이지가 선택되지 않은 상태일 때 */
            .bgColer2 {
                background-color: #f0f0f0;
                /* 비선택 페이지는 회색 */
                color: #333;
                /* 글자는 검정색 */
            }

            /* "next", "prev" 화살표 hover 효과 */
            a#prev:hover,
            a#next:hover {
                background-color: #007bff;
                color: white;
            }

            /* 페이지 번호 호버 효과 */
            a#index2:hover {
                background-color: #007bff;
                color: white;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />

        <div id="app" class="container">
            <template v-if="userId!=''">
                <div class="mypage-container">
                    <div class="user-info">
                        <img :src="user.profileImage" alt="" class="profile-pic">
                        <div class="user-details">
                            <h2>안녕하세요, {{user.userName}}님!</h2>
                            <p>{{user.userName}}님의 회원등급은 <strong>{{user.role}}</strong>입니다.</p>
                        </div>
                    </div>
                    <div class="summary">
                        <div class="summary-item">현재 포인트<br>{{point.currentPoint}}P</div>
                        <div class="summary-item">1개<br>쿠폰</div>
                        <div class="summary-item">0건(0회)<br>총 주문</div>
                    </div>
                    <div class="main-content">
                        <aside class="sidebar">

                            <!-- 재원 코딩 -->
                            <ul>
                                <div class="tab-menu">
                                    <h3>나의 쇼핑 정보</h3>
                                    <div v-for="tab in tabs" :key="tab.id"
                                        :class="['tab-item', { active: activeTab === tab.id }]"
                                        @click="changeTab(tab.id)">
                                        {{ tab.label }}
                                    </div>
                                </div>
                            </ul>
                            <!-- 재원 코딩 -->
                            <hr>
                            <ul>
                                <div class="tab-menu">
                                    <h3>나의 활동 정보</h3>
                                    <div v-for="tab in tabs2" :key="tab.id"
                                        :class="['tab-item', { active: activeTab === tab.id }]"
                                        @click="changeTab(tab.id)">
                                        {{ tab.label }}
                                    </div>
                                </div>
                            </ul>
                            <hr>
                            <ul>
                                <h3>나의 개인정보</h3>
                                <li><a @click="fnInfo()">회원 정보 수정</a></li>
                                <li><a @click="fnWithdraw()">회원 탈퇴</a></li>
                                <li></li>
                            </ul>
                        </aside>

                        <!-- <template v-if="mainFlg"> -->

                        <section class="order-status">
                            <span v-if="activeTab === 'order'">
                                <h3>나의 주문처리 현황</h3>
                                <div class="status-box">
                                    <div>입금<br>0</div>
                                    <div>배송 준비중<br>0</div>
                                    <div>배송 중<br>0</div>
                                    <div>배송 완료<br>0</div>
                                </div>
                                <div class="order-list">
                                    <p>주문 내역이 없습니다.</p>
                                </div>
                            </span>
                            <div v-if="activeTab === 'board'" class="comment-page">
                                <h3>작성한 게시글 수 : 총 <span style="color: red;">{{boardCnt.cnt}} </span>개</h3>
                                <template v-if="boardCnt.cnt!=0">
                                    <div>
                                        <select v-model="pageSize" @change="fnMyBoardList">
                                            <option value="5">5개</option>
                                            <option value="10">10개</option>
                                        </select>

                                        
                                    </div>
                                    <table class="board-table">
                                        <tr>
                                            <th>번호</th>
                                            <th>제목</th>
                                            <th>작성일</th>
                                            <th>조회수</th>
                                        </tr>
                                        <tr v-for="item in board">
                                            <template v-if="item.isDeleted == 'N'">
                                                <td>{{item.boardId}}</td>
                                                <td><a href="javascript:;" @click="fnView(item.boardId)">{{item.title}}
                                                        <span v-if="parseInt(item.commentCount) > 0 && category == 'F'"
                                                            class="cmtCountColor">({{item.commentCount}})</span>
                                                    </a></td>
                                                <td>{{item.createdAt}}</td>
                                                <td>{{item.cnt}}</td>
                                            </template>
                                        </tr>
                                    </table>
                                    <div>
                                        <br>
                                        <a v-if="page != 1" id="index" href="javascript:;" class="bgColer2"
                                            @click="fnPageMove('pvev')">
                                            < </a>
                                                <a id="index" href="javascript:;" v-for="num in index"
                                                    @click="fnPage(num)">
                                                    <span v-if="page == num" class="bgColer">{{num}}</span>
                                                    <span v-else class="bgColer2">{{num}}</span>
                                                </a>
                                                <a v-if="page != index" id="index" href="javascript:;" class="bgColer2"
                                                    @click="fnPageMove('next')">
                                                    >
                                                </a>
                                    </div>
                                </template>
                                
                                <template v-else >
                                    <h2>작성된 댓글이 없습니다.</h2>
                                    <button @click=fnBoardList()>게시글 작성하기</button>
                                </template>

                            </div>

                            <div v-if="activeTab === 'comment'" class="comment-page">

                                <h3>작성한 댓글 수 : 총 <span style="color: red;">{{commCnt}} </span>개</h3>
                                <template v-if="commCnt!=0">
                                    <table class="comment-table" v-if="commCnt!=null">
                                        <thead>
                                            <tr class="comment-table-header">
                                                <th class="comment-table-column">게시글</th>
                                                <th class="comment-table-column">댓글내용</th>
                                                <th class="comment-table-column">작성일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="item in commentList" :key="item.commentId"
                                                class="comment-table-row">
                                                <template v-if="item.isDeleted === 'N'">
                                                    <td class="comment-title">{{ item.title }}</td>
                                                    <td class="comment-content">
                                                        <a href="javascript:;"
                                                            @click="fnView(item.boardId,item.commentId)"
                                                            class="comment-link">
                                                            {{ item.content }}
                                                        </a>
                                                    </td>
                                                    <td class="comment-date">{{ item.updatedAt }}</td>
                                                </template>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br>
                                    <a v-if="page2 != 1" id="index2" href="javascript:;" class="bgColer2"
                                        @click="fnPageMove2('pvev')">
                                        < </a>
                                            <a id="index2" href="javascript:;" v-for="num2 in index2"
                                                @click="fnCommPage(num2)">
                                                <span v-if="page2 == num2" class="bgColer">{{num2}}</span>
                                                <span v-else class="bgColer2">{{num2}}</span>
                                            </a>
                                            <a v-if="page2 != index2" id="index2" href="javascript:;" class="bgColer2"
                                                @click="fnPageMove2('next')">
                                                >
                                            </a>
                                </template>
                                <template v-else>
                                    <h2>작성된 댓글이 없습니다.</h2>
                                    <button @click=fnBoardList()>댓글 작성하기</button>
                                </template>
                            </div>
                        </section>
                    </div>
                </div>
            </template>


        </div>


        <jsp:include page="/WEB-INF/common/footer.jsp" />


    </body>

    </html>
    <script>

        function withdrawBack() {
            window.vueObj.fnResult();
        }

        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        user: {},
                        userId: "${sessionId}",
                        point: {},
                        //탭 관련
                        tabs: [
                            { id: 'order', label: '주문 내역' },
                            { id: 'point', label: '포인트 내역' },
                            { id: 'coupon', label: '쿠폰 내역' }
                        ],
                        tabs2: [
                            { id: 'board', label: '게시글 내역' },
                            { id: 'comment', label: '댓글 내역' },
                            { id: 'subscribe', label: '구독 내역' },
                            { id: 'donation', label: '후원금 내역' }
                        ],
                        activeTab: 'order',
                        board: [],
                        searchOption: "",
                        keyword: "",
                        category: "F",
                        pageSize: 5,
                        page: 1,
                        boardCnt: 0,
                        pageSize2: 10,
                        page2: 1,
                        index: 0,
                        index2: 0,
                        commentList: [],
                        commCnt: 0

                    };
                },
                computed: {

                },
                methods: {
                    fnInfo2() {
                        var self = this;
                        var nparmap = {
                            userId: self.userId
                        };
                        $.ajax({
                            url: "/user/info.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.user = data.user;
                            }
                        });
                    },


                    fnInfo: function () {
                        let self = this;
                        pageChange("/user/info.do", { userId: self.userId });
                    },

                    fnWithdraw: function () {
                        let self = this;
                        window.open(
                            "/user/withdraw.do",
                            "check",
                            "width=600, height=230"
                        );
                    },
                    fnResult: function () {
                        location.reload();
                    },
                    fnPoint() {
                        var self = this;
                        var nparmap = {
                            userId: self.userId
                        };
                        $.ajax({
                            url: "/point/current.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.point = data.point
                            }
                        });
                    },

                    changeTab(tabId) {
                        let self = this;
                        self.activeTab = tabId;
                    },
                    // 재원코딩 원본
                    // changeTab(tabId) {
                    //     let self = this;
                    //     self.activeTab = tabId;
                    //     if (tabId === 'order') {

                    //     } else if (tabId === 'board') {

                    //     }
                    // }
                    // 재원코딩 원본

                    fnMyBoardList() {
                        var self = this;
                        var nparmap = {
                            searchOption: "userId",
                            keyword: self.userId,
                            category: self.category,
                            pageSize: self.pageSize,
                            page: (self.page - 1) * self.pageSize // 페이지 시작점
                        };
                        console.log(nparmap);
                        $.ajax({
                            url: "/board/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.board = data.board;
                                self.boardCnt = data.count;
                                if (data.count && data.count.cnt !== undefined) { // 율 코드 문의하기
                                    self.index = Math.ceil(data.count.cnt / self.pageSize);
                                } else {
                                    self.index = 0;
                                    console.warn("count 정보 없음!", data);
                                }

                            }
                        });
                    },

                    fnPage: function (num) {
                        let self = this;
                        self.page = num;
                        self.fnMyBoardList();
                    },

                    fnPageMove: function (direction) {
                        let self = this;
                        if (direction == "next") {
                            self.page++;
                        } else {
                            self.page--;

                        }
                        self.fnMyBoardList();
                    },

                    fnView(boardId, commentId) {
                        let self = this;
                        if (commentId == null) {
                            commentId = ""
                        }
                        localStorage.setItem("page", self.page);
                        location.href = "/board/view.do?boardId=" + boardId + "&category=" + self.category;
                    },

                    fnSeachComm() {
                        var self = this;
                        var nparmap = {
                            userId: self.userId,
                            pageSize2: self.pageSize2,
                            page2: (self.page2 - 1) * self.pageSize2 // 페이지 시작점
                        };
                        $.ajax({
                            url: "/user/comment.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.commentList = data.comment;
                                self.commCnt = data.count2;
                                self.index2 = Math.ceil(data.count2 / self.pageSize2);
                                console.log(self.index2);
                            }
                        });
                    },

                    fnCommPage: function (num2) {
                        let self = this;
                        self.page2 = num2;
                        self.fnSeachComm();
                    },

                    fnPageMove2: function (direction) {
                        let self = this;
                        if (direction == "next") {
                            self.page2++;
                        } else {
                            self.page2--;
                        }
                        self.fnSeachComm();
                    },

                    fnBoardList() {
                        location.href = "/board/list.do"
                    }
                },

                mounted() {
                    let self = this;
                    if (self.userId == "") {
                        alert("로그인 후 이용가능한 서비스입니다.");
                        location.href = "/main.do";
                    }
                    self.fnInfo2();
                    self.fnPoint();
                    self.fnMyBoardList();
                    self.fnSeachComm();
                    window.vueObj = this;

                }
            });

            app.mount("#app");
        });
    </script>