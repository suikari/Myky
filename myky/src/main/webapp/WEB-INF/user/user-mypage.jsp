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
                text-align: left;
                font-size: 16px;
            }

            /* 테이블 데이터 셀 스타일 */
            .board-table td {
                padding: 10px;
                text-align: left;
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
                            <p>{{user.userName}}님의 회원등급은 <strong>SILVER</strong>입니다.</p>
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


                            <!-- <ul> 
                                <li>주문내역 조회</li>
                                <li>포인트 내역</li>
                                <li>쿠폰 내역</li>
                            </ul> -->
                            <hr>
                            <ul>
                                <h3>나의 활동 정보</h3>
                                <li><a @click="fnMyBoard()">게시글 내역</a></li>
                                <li>댓글 내역</li>
                                <li>구독 정보</li>
                                <li>후원 금액내역</li>
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
                            <div v-if="activeTab === 'board'">
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
                                            <td><a href="javascript:;" @click="fnView2(item.boardId)">{{item.title}}
                                                    <span v-if="parseInt(item.commentCount) > 0 && category == 'F'" class="cmtCountColor">({{item.commentCount}})</span>
                                                </a></td>
                                            <td>{{item.createdAt}}</td>
                                            <td>{{item.cnt}}</td>
                                        </template>
                                    </tr>
                                </table>
                            </div>

                        </section>


                        <!-- </template> -->

                        <!-- <template v-if="boardFlg"> -->

                        <!-- </template> -->
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
                        mainFlg: true,
                        boardFlg: false,
                        point: {},
                        //탭 관련
                        tabs: [
                            { id: 'order', label: '주문내역' },
                            { id: 'point', label: '포인트내역' },
                            { id: 'coupon', label: '쿠폰내역' },
                            { id: 'board', label: '나의 게시판 내역' }
                        ],
                        activeTab: 'order',
                        board: [],
                        searchOption: "",
                        keyword: "",
                        category: "F",
                        pageSize: 5,
                        page: 0

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


                    fnMyBoard: function () {
                        let self = this;
                        self.boardFlg = true;
                        self.mainFlg = false;
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

                    fnBoardList2() {
                        var self = this;
                        var nparmap = {
                            searchOption: "userId",
                            keyword: self.userId,
                            userId: self.userId,
                            category: self.userId,
                            pageSize: self.pageSize,
                            page: self.page
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
                            }
                        });
                    },

                    fnView2(boardId) {
                        let self = this;
                        localStorage.setItem("page", self.page);
                        location.href = "/board/view.do?boardId=" + boardId + "&category=" + self.category;
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
                    self.fnBoardList2();
                    window.vueObj = this;

                }
            });

            app.mount("#app");
        });
    </script>