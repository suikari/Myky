<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>마이페이지</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <link rel="stylesheet" href="/css/user/user.css" />
        <style>

        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />

        <div id="app" class="container" style="font-family: 'Noto Sans KR', sans-serif;">
            <template v-if="userId!=''">
                <div class="mypage-container">
                    <div class="profile-wrapper">
                        <div class="user-info">
                            <template v-if="user.profileImage!=null">
                                <img :src="user.profileImage" alt="" class="profile-pic">
                            </template>
                            <template v-else>
                                <img src="/img/userProfile/Default-Profile-Picture.jpg" alt="프로필 이미지"
                                    class="profile-pic">
                            </template>
                            <div class="user-details">
                                <h2>안녕하세요, {{user.userName}}님!</h2>
                                <template v-if="membershipYn === 'Y'">
                                    <span class="badge badge-yes">⭐ 멤버십 회원</span>
                                </template>
                                <template v-else>
                                    <span class="badge badge-no">🛈 일반 회원</span>
                                </template>
                            </div>
                        </div>

                        <div class="summary">
                            <div class="summary-item" role="button" @click="activeTab = 'point'">
                                <div class="summary-title">현재 포인트</div>
                                <div class="summary-value">{{ formattedAmount(point.currentPoint) }}P</div>
                            </div>
                            <div class="summary-item" role="button" @click="activeTab = 'coupon'">
                                <div class="summary-title">보유 쿠폰</div>
                                <div class="summary-value">{{ couponCnt }}개</div>
                            </div>
                            <div class="summary-item" role="button" @click="activeTab = 'order'">
                                <div class="summary-title">총 주문 수</div>
                                <div class="summary-value">{{ orderAllCnt }}회</div>
                            </div>
                        </div>
                    </div>

                    <div class="main-content">
                        <aside class="sidebar">
                            <div class="sidebar-top"></div>
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
                                <div class="tab-menu">
                                    <h3>나의 개인정보</h3>
                                    <li><a @click="fnInfo()">회원 정보 수정</a></li>
                                    <li><a @click="fnWithdraw()">회원 탈퇴</a></li>
                                </div>
                            </ul>
                        </aside>

                        <!-- <template v-if="mainFlg"> -->

                        <section class="order-status">
                            <span v-if="activeTab === 'order'">
                                <h3>최근 주문내역 현황</h3>
                                <div class="status-box">
                                    <div class="status-item" role="button" @click="orderKey = 'none'; fnOrderList('')">
                                        <span class="status-label">주문접수</span><br>
                                        <span class="status-count">{{ orderCnt[2].orderCount }}</span>
                                    </div>
                                    <div class="status-item" role="button"
                                        @click="orderKey = 'shipped'; fnOrderList('')">
                                        <span class="status-label">배송 중</span><br>
                                        <span class="status-count">{{ orderCnt[4].orderCount }}</span>
                                    </div>
                                    <div class="status-item" role="button"
                                        @click="orderKey = 'delivered'; fnOrderList('')">
                                        <span class="status-label">배송 완료</span><br>
                                        <span class="status-count">{{ orderCnt[0].orderCount }}</span>
                                    </div>
                                    <div class="status-item" role="button"
                                        @click="orderKey = 'exchange'; fnOrderList('')">
                                        <span class="status-label">교환신청</span><br>
                                        <span class="status-count">{{ orderCnt[1].orderCount }}</span>
                                    </div>
                                    <div class="status-item" role="button"
                                        @click="orderKey = 'return'; fnOrderList('')">
                                        <span class="status-label">반품신청</span><br>
                                        <span class="status-count">{{ orderCnt[3].orderCount }}</span>
                                    </div>
                                </div>
                                <div class="order-list">
                                    <table class="order-table">
                                        <tr>
                                            <th>제품 사진</th>
                                            <th>제품 명</th>
                                            <th>제품 가격</th>
                                            <th>제품 수량</th>
                                            <th>주문 상태</th>
                                            <th>주문 날짜</th>
                                        </tr>
                                        <template v-if="orderList!=''">
                                            <tr v-for="item in orderList">
                                                <td><span><img :src="item.filepath" alt=""></span></td>
                                                <td><span @click="fnProduct(item.productId)"><a
                                                            href="javascript:;">{{item.productName}}</a></span></td>
                                                <td><span>{{formattedAmount(item.price)}} 원</span></td>
                                                <td><span>{{item.quantity}} 개</span></td>
                                                <td :data-status="item.refundStatus">
                                                    <span v-if="item.refundStatus == 'none'">주문접수</span>
                                                    <span v-if="item.refundStatus == 'shipped'">배송 중</span>
                                                    <span v-if="item.refundStatus == 'delivered'">배송 완료</span>
                                                    <span v-if="item.refundStatus == 'return'">반품 신청</span>
                                                    <span v-if="item.refundStatus == 'exchange'">교환 신청</span>
                                                </td>
                                                <td><span>{{item.orderedAt}}</span></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" @click="fnOrderListStatus()"><a href="javascript:;">주문조회
                                                        하러가기</a></td>
                                            </tr>
                                        </template>
                                        <template v-if="orderList==''">
                                            <tr>
                                                <td colspan="6">주문 내역이 없습니다</td>
                                            </tr>
                                        </template>

                                    </table>
                                </div>


                            </span>

                            <div v-if="activeTab === 'point'" class="cpoint-page">
                                <div class="cpoint-title">포인트 사용 내역</div>
                                <br>
                                <div class="current-cpoint">현재 포인트 <span
                                        style="color: red;">{{formattedAmount(point.currentPoint)}}</span>p</div>
                                <table class="cpoint-table">
                                    <tr>
                                        <th class="cpoint-header">적립(차감)된 포인트</th>
                                        <th class="cpoint-header">변경 후 포인트</th>
                                        <th class="cpoint-header">사용 용도</th>
                                        <th class="cpoint-header">갱신된 날짜</th>
                                    </tr>
                                    <tr v-for="item in pointList" class="cpoint-row">
                                        <td style="text-align: center;">{{formattedAmount(item.usePoint)}}p</td>
                                        <td style="text-align: center;">{{formattedAmount(item.currentPoint)}}p</td>
                                        <td>{{item.remarks}}</td>
                                        <td>{{item.usageDate}}</td>
                                    </tr>
                                    <tr v-if="pointList.length == 0">
                                        <td colspan="4" style="text-align: center; padding-top : 20px;"> 포인트 사용 내역이
                                            없습니다.</td>
                                    </tr>
                                </table>


                                <br>

                                <div class="cpoint-pagination">
                                    <a v-if="page3 != 1" href="javascript:;" class="bgColer2"
                                        @click="fnPageMove3('pvev')">
                                        &lt;
                                    </a>
                                    <a v-if="pointIndex > 1 && page3 != pointIndex" href="javascript:;" class="bgColer2"
                                        @click="fnPageMove3('next')">
                                        &gt;
                                    </a>
                                </div>

                            </div>


                            <div v-if="activeTab === 'coupon'">
                                <div class="coupon-container">
                                    <h2>보유 쿠폰 목록</h2>
                                    <hr>
                                    <div class="coupon-subContainer">
                                        <div v-for="item in couponList">
                                            <div class="coupon">
                                                <!-- 배경 이미지 추가 -->
                                                <img src="../../img/userProfile/coupon_reversed_stamp_style.png"
                                                    class="coupon-bg-logo">
                                                <img src="../../img/userProfile/mungNyangCoupon.png" alt="logo"
                                                    class="coupon-bg-logo2">

                                                <ul class="coupon-list">
                                                    <li class="coupon-item coupon-name">{{item.couponName}} 쿠폰</li>
                                                    <li class="coupon-item coupon-discount">-{{item.discountRate}}%
                                                        SALES
                                                    </li>
                                                    <li class="coupon-item coupon-condition">
                                                        {{formattedAmount(item.minimumSpend)}}원 이상 결제시 사용 가능
                                                    </li>
                                                    <li class="coupon-item coupon-limit">
                                                        최대 {{formattedAmount(item.maxDiscountAmount)}} 원 까지 할인
                                                    </li>
                                                    <li class="coupon-item coupon-info">발급 일 : {{item.createdAt}}</li>
                                                    <li class="coupon-item coupon-info">유효 기간: {{item.expirationDate}}
                                                        까지
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div v-if="couponList.length==0" class="coupon-non">
                                            보유하신 쿠폰이 없습니다.
                                        </div>
                                    </div>
                                    <div class="cpoint-pagination">
                                        <a v-if="couponPage != 1" href="javascript:;" class="bgColer2"
                                            @click="fnCouponPageMove('pvev')">
                                            &lt;
                                        </a>
                                        <a v-if="couponIndex > 1 && couponPage != couponIndex" href="javascript:;"
                                            class="bgColer2" @click="fnCouponPageMove('next')">
                                            &gt;
                                        </a>
                                    </div>
                                </div>
                            </div>



                            <div v-if="activeTab === 'board'" class="comment-page">
                                <h3>작성한 게시글 수 : 총 <span style="color: red;">{{boardCnt.cnt}} </span>개</h3>

                                <div class="board-controls">
                                    <select v-model="pageSize" @change="fnMyBoardList('')">
                                        <option value="5">게시글 5개</option>
                                        <option value="10">게시글 10개</option>
                                    </select>
                                    <input v-model="keyword2" type="text" placeholder="검색어를 입력하세요"
                                        @input="fnMyBoardList('')">
                                </div>
                                <table class="board-table">
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>작성일</th>
                                        <th>조회수</th>
                                    </tr>
                                    <template v-if="boardCnt.cnt!=0">
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
                                    </template>
                                    <template v-if="boardCnt.cnt == 0  && keyword2 === '' ">
                                        <tr>
                                            <td colspan="4">
                                                <h2>작성된 게시글이 없습니다. </h2>
                                                <button @click="fnBoardList()" class="btn-board-write">게시판 이동</button>
                                            </td>
                                        </tr>
                                    </template>

                                    <template v-else-if="boardCnt.cnt == 0 ">
                                        <tr>
                                            <td colspan="4">
                                                <h2> 검색된 게시글이 없습니다.</h2>
                                            </td>
                                        </tr>
                                    </template>

                                </table>
                                <div class="cpoint-pagination">
                                    <a v-if="page != 1" href="javascript:;" @click="fnPageMove('pvev')">&lt;</a>
                                    <a v-for="num in index" :key="num" href="javascript:;" @click="fnPage(num)">
                                        <span :class="page === num ? 'bgColer' : ''">{{ num }}</span>
                                    </a>
                                    <a v-if="index > 1 && page != index" href="javascript:;"
                                        @click="fnPageMove('next')">&gt;</a>
                                </div>
                            </div>

                            <div v-if="activeTab === 'vetBoard'" class="comment-page">
                                <h3>작성한 문의글 수 : 총 <span style="color: red;">{{boardCnt.cnt}} </span>개</h3>

                                <div class="board-controls">
                                    <select v-model="vetPageSize" @change="fnMyVetBoardList('')">
                                        <option value="5">문의글 5개</option>
                                        <option value="10">문의글 10개</option>
                                    </select>
                                    <input v-model="keyword2" type="text" placeholder="검색어를 입력하세요"
                                        @input="fnMyVetBoardList('')">
                                </div>
                                <table class="board-table">
                                    <tr>
                                        <th>게시판 번호</th>
                                        <th>제목(댓글)</th>
                                        <th>포인트</th>
                                        <th>채택 여부</th>
                                        <th>조회수</th>
                                        <th>작성 날짜</th>
                                    </tr>

                                    <template v-if="vetCnt.cnt!=0">
                                        <tr v-for="item in vetBoardList">
                                            <template v-if="item.isDeleted == 'N'">
                                                <td>{{item.vetBoardId}}</a></td>
                                                <td><a href="javascript:;"
                                                        @click="fnVetView(item.vetBoardId)">{{item.title}}<span
                                                            class="cmtCountColor"
                                                            v-if="parseInt(item.commentCount) > 0">({{item.commentCount}})</span></a>
                                                </td>
                                                <td>{{item.points}}</td>

                                                <td>
                                                    <template v-if="item.isAccepted=='Y'">
                                                        <span class="badge badge-yes">
                                                            채택 완
                                                        </span>
                                                    </template>
                                                    <template v-else>
                                                        <span class="badge badge-no">문의 중</span>
                                                    </template>

                                                </td>
                                                <td>{{item.cnt}}</td>
                                                <td>{{item.createdAt}}</td>
                                            </template>
                                        </tr>
                                    </template>
                                    <template v-if="vetCnt.cnt == 0  && keyword2 === '' ">
                                        <tr>
                                            <td colspan="6">
                                                <h2>작성된 문의글이 없습니다. </h2>
                                                <button @click="fnVetBoardList()" class="btn-board-write">게시판
                                                    이동</button>
                                            </td>
                                        </tr>
                                    </template>

                                    <template v-else-if="vetCnt.cnt == 0 ">
                                        <tr>
                                            <td colspan="6">
                                                <h2> 검색된 문의글이 없습니다.</h2>
                                            </td>
                                        </tr>
                                    </template>

                                </table>

                                <div class="cpoint-pagination">
                                    <a v-if="vetPage != 1" href="javascript:;" @click="fnVetPageMove('pvev')">&lt;</a>
                                    <a v-for="vetNum in vetIndex" :key="vetNum" href="javascript:;"
                                        @click="fnVetPage(vetNum)">
                                        <span :class="vetPage === vetNum ? 'bgColer' : ''">{{ vetNum }}</span>
                                    </a>
                                    <a v-if="vetIndex > 1 && vetPage != vetIndex" href="javascript:;"
                                        @click="fnVetPageMove('next')">&gt;</a>
                                </div>
                            </div>





                            <div v-if="activeTab === 'comment'" class="comment-page">

                                <h3>작성한 댓글 수 : 총 <span style="color: red;">{{commCnt}} </span>개</h3>
                                <div class="board-controls">
                                    <input v-model="commKeyword" type="text" placeholder="댓글 검색어를 입력하세요"
                                        @input="fnSeachComm('')">
                                </div>
                                <table class="comment-table" v-if="commCnt!=null">
                                    <thead>
                                        <tr class="comment-table-header">
                                            <th class="comment-table-column">게시글</th>
                                            <th class="comment-table-column">댓글내용</th>
                                            <th class="comment-table-column">작성일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <template v-if="commCnt!=0">
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
                                        </template>
                                        <template v-if="commCnt == 0  && commKeyword === '' ">
                                            <tr class="comment-table-row">
                                                <td colspan="4">
                                                    <h3>작성된 댓글이 없습니다. </h3>
                                                    <button @click="fnBoardList()" class="btn-board-write">게시판
                                                        이동</button>
                                                </td>
                                            </tr>
                                        </template>

                                        <template v-if="commCnt == 0 && commKeyword != ''">
                                            <tr class="comment-table-row">
                                                <td colspan="4">
                                                    <h3>검색된 댓글이 없습니다. </h3>
                                                </td>
                                            </tr>
                                        </template>

                                    </tbody>
                                </table>
                                <br>



                                <div class="cpoint-pagination">
                                    <a v-if="page2 != 1" id="index2" href="javascript:;" class="bgColer2"
                                        @click="fnPageMove2('pvev')">&lt;</a>
                                    <a id="index2" href="javascript:;" v-for="num2 in index2" @click="fnCommPage(num2)">
                                        <span v-if="page2 == num2" class="bgColer">{{num2}}</span>
                                        <span v-else class="bgColer2">{{num2}}</span>
                                    </a>
                                    <a v-if="index2 > 1 && page2 != index2" id="index2" href="javascript:;"
                                        class="bgColer2" @click="fnPageMove2('next')">&gt;</a>
                                </div>
                            </div>


                            <div v-if="activeTab === 'subscribe'" class="cpoint-page">
                                <div class="cpoint-title">멤버십 내역</div>
                                <br>
                                <table class="board-table">
                                    <tr>
                                        <th class="cpoint-header" style="text-align: center;">멤버십 내용</th>
                                        <th class="cpoint-header" style="text-align: center;">구독 날짜</th>
                                        <th class="cpoint-header" style="text-align: center;">만료 날짜</th>
                                    </tr>

                                    <tr v-for="item in membership">
                                        <br>
                                        <td style="text-align: center;">{{item.membershipType}}</td>
                                        <td style="text-align: center;">{{item.renewalDate}}</td>
                                        <td style="text-align: center;">{{item.expirationDate}}</td>

                                    </tr>
                                    <tr v-if="membership.length == 0">
                                        <td colspan="3" style="text-align: center;">
                                            <h3>멤버십 구독 내역이
                                                없습니다.</h3>
                                            <button @click="fnMemberShip()" class="btn-board-write">멤버십 구독하기</button>
                                        </td>

                                    </tr>
                                </table>



                            </div>


                            <div v-if="activeTab === 'donation'" class="comment-page">
                                <div class="page-container">
                                    <div class="page-title"> 후원 내역 페이지</div>
                                    <div class="thank-you-message">
                                        <span style="font-size: 20px;">{{user.userName}}</span>님이 후원하신 금액은
                                    </div>
                                    <div class="donation-amount">
                                        총
                                        <span>{{formattedAmount(sum.amount)}}</span>원 입니다.
                                    </div>
                                    <div class="thank-you-message">언제나 따뜻한 후원 감사합니다.<div>
                                            <br>
                                            <hr>
                                            <br>
                                            <table class="donation-table">
                                                <tr>
                                                    <th>후원 단체</th>
                                                    <th>후원 메시지</th>
                                                    <th>후원 금액</th>
                                                    <th>익명 여부</th>
                                                    <th>후원 날짜</th>
                                                </tr>
                                                <tr v-for="item in donaList">
                                                    <td class="center-name">{{ item.centerName }}</td>
                                                    <td class="message">{{ item.message }}</td>
                                                    <td>{{ formattedAmount(item.amount) }}</td>
                                                    <td>
                                                        <span v-if="item.anonymousYn == 'Y'" class="anonymous">익명
                                                            기부</span>
                                                        <span v-else class="real-name">실명 기부</span>
                                                    </td>
                                                    <td class="donation-date">{{ item.donationDate }}</td>
                                                </tr>

                                                <tr v-if="donaList.length == 0">
                                                    <td colspan="5">후원 내역이 없습니다.</td>
                                                </tr>
                                            </table>
                                            <div class="cpoint-pagination">
                                                <a v-if="page4 != 1" id="donaIndex" href="javascript:;" class="bgColer2"
                                                    @click="fnPageMove4('pvev')">
                                                    < </a>
                                                        <a v-if="donaIndex > 1 && page4 != donaIndex" id="pointIndex"
                                                            href="javascript:;" class="bgColer2"
                                                            @click="fnPageMove4('next')">
                                                            > </a>
                                            </div>
                                        </div>
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
                            { id: 'subscribe', label: '구독 내역' },
                            { id: 'coupon', label: '쿠폰 내역' }
                        ],
                        tabs2: [
                            { id: 'board', label: '게시글 내역' },
                            { id: 'comment', label: '댓글 내역' },
                            { id: 'vetBoard', label: '수의사 문의 내역' },
                            { id: 'donation', label: '후원금 내역' }
                        ],
                        activeTab: 'order',
                        board: [],
                        searchOption: "",
                        keyword: "",
                        keyword2: "",
                        category: "F",
                        pageSize: 5,
                        page: 1,
                        boardCnt: 0,
                        pageSize2: 10,
                        page2: 1,
                        index: 0,
                        index2: 0,
                        commentList: [],
                        commCnt: 0,
                        commKeyword: "",
                        donaList: [],
                        donaIndex: 0,
                        donaCnt: 0,
                        sum: "",
                        pointList: [],
                        pointIndex: 0,
                        pointCnt: 0,
                        pageSize3: 10,
                        page3: 1,
                        pageSize4: 10,
                        page4: 1,
                        couponList: [],
                        couponCnt: 1,
                        couponIndex: 0,
                        couponPage: 1,
                        couponPageSize: 6,
                        orderList: [],
                        orderCnt: [
                            { refundStatus: 'none', orderCount: '0' },
                            { refundStatus: 'shipped', orderCount: '0' },
                            { refundStatus: 'delivered', orderCount: '0' },
                            { refundStatus: 'exchange', orderCount: '0' },
                            { refundStatus: 'return', orderCount: '0' }
                        ],
                        orderAllCnt: "",
                        membership: [],
                        membershipYn: "",
                        paramsTab: "${map.paramsTab}",
                        vetBoardList: [],
                        vetIndex: 0,
                        vetPage: 1,
                        vetPageSize: 5,
                        vetCnt: 0,
                        orderKey: "none"



                    };
                },
                computed: {
                    formattedAmount() {
                        return (item) => {
                            // item.amount가 숫자가 아니면 숫자로 변환, 변환할 수 없으면 0 처리
                            return Number(item).toLocaleString('ko-KR'); // 숫자 포맷으로 반환
                        };
                    }
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
                                if (data.point == null || data.point == undefined) {
                                    self.point.currentPoint = 0;
                                } else {
                                    self.point = data.point;
                                }

                            }
                        });
                    },

                    changeTab(tabId) {
                        let self = this;

                        if (tabId == 'board') {
                            self.fnMyBoardList('C');
                        }

                        if (tabId == 'comment') {
                            self.fnSeachComm('C');
                        }

                        if (tabId == 'point') {
                            self.fnPoint2('C');
                        }

                        if (tabId == 'donation') {
                            self.fnDonaInfo('C');
                        }

                        if (tabId == 'vetBoard') {
                            self.fnMyVetBoardList('C');
                        }

                        if (tabId == 'coupon') {
                            self.fnCoupon('C');
                        }

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
                    fnMyBoardList(commend) {
                        var self = this;

                        if (commend == 'C') {
                            self.keyword2 = '';
                            self.page = 1;
                        }

                        var nparmap = {
                            searchOption: "userId2",
                            keyword: self.userId,
                            keyword2: self.keyword2,
                            category: self.category,
                            pageSize: self.pageSize,
                            page: (self.page - 1) * self.pageSize // 페이지 시작점
                        };
                        $.ajax({
                            url: "/board/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.board = data.board;
                                self.boardCnt = data.count;
                                if (data.count && data.count.cnt !== undefined) { // 율 코드 문의하기
                                    self.index = Math.ceil(data.count.cnt / self.pageSize);
                                } else {
                                    self.index = 0;
                                }

                            }
                        });
                    },

                    fnPage: function (num) {
                        let self = this;
                        self.page = num;
                        self.fnMyBoardList('');
                    },

                    fnPageMove: function (direction) {
                        let self = this;
                        if (direction == "next") {
                            self.page++;
                        } else {
                            self.page--;

                        }
                        self.fnMyBoardList('');
                    },

                    fnView(boardId, commentId) {
                        let self = this;
                        if (commentId == null) {
                            commentId = ""
                        }
                        localStorage.setItem("page", self.page);
                        location.href = "/board/view.do?boardId=" + boardId + "&category=" + self.category;
                    },

                    fnVetView(vetBoardId) {
                        let self = this;
                        localStorage.setItem("page", self.page);
                        location.href = "/board/vetBoardView.do?vetBoardId=" + vetBoardId;
                    },

                    fnSeachComm(commend) {
                        var self = this;

                        if (commend == 'C') {
                            self.commKeyword = '';
                            self.page2 = 1;
                        }

                        var nparmap = {
                            userId: self.userId,
                            pageSize2: self.pageSize2,
                            page2: (self.page2 - 1) * self.pageSize2, // 페이지 시작점
                            commKeyword: self.commKeyword
                        };
                        $.ajax({
                            url: "/user/comment.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.commentList = data.comment;
                                self.commCnt = data.count2;
                                self.index2 = Math.ceil(data.count2 / self.pageSize2);
                            }
                        });
                    },

                    fnCommPage: function (num2) {
                        let self = this;
                        self.page2 = num2;
                        self.fnSeachComm('');
                    },

                    fnPageMove2: function (direction) {
                        let self = this;
                        if (direction == "next") {
                            self.page2++;
                        } else {
                            self.page2--;
                        }
                        self.fnSeachComm('');
                    },

                    fnVetPage: function (vetNum) {
                        let self = this;
                        self.vetPage = vetNum;
                        self.fnMyVetBoardList('');
                    },

                    fnVetPageMove: function (direction) {
                        let self = this;
                        if (direction == "next") {
                            self.vetPage++;
                        } else {
                            self.vetPage--;

                        }
                        self.fnMyVetBoardList('');
                    },

                    fnBoardList() {
                        location.href = "/board/list.do"
                    },

                    fnVetBoardList() {
                        location.href = "/board/vetBoardList.do"
                    },

                    fnMemberShip() {
                        location.href = "/membership/main.do"
                    },

                    fnDonaInfo(commend) {
                        var self = this;
                        if (commend == 'C') {
                            self.page4 = 1;
                        }

                        var nparmap = {
                            userId: self.userId,
                            pageSize4: self.pageSize4,
                            page4: (self.page4 - 1) * self.pageSize4,
                        };

                        $.ajax({
                            url: "/user/donaInfo.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.donaList = data.donation;
                                self.sum = data.sum;
                                self.donaCnt = data.donaCount;
                                self.donaIndex = Math.ceil(data.donaCount / self.pageSize4);

                            }
                        });
                    },

                    fnPageMove4: function (direction) {
                        let self = this;
                        if (direction == "next") {
                            self.page4++;
                        } else {
                            self.page4--;
                        }
                        self.fnDonaInfo('');
                    },

                    fnPoint2(commend) {
                        var self = this;

                        if (commend == 'C') {
                            self.page3 = 1;
                        }
                        var nparmap = {
                            userId: self.userId,
                            pageSize3: self.pageSize3,
                            page3: (self.page3 - 1) * self.pageSize3,
                        };
                        $.ajax({
                            url: "/user/point.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.pointList = data.point;
                                self.pointCnt = data.pointCount;
                                self.pointIndex = Math.ceil(data.pointCount / self.pageSize3);
                            }
                        });
                    },

                    fnPageMove3: function (direction) {
                        let self = this;
                        if (direction == "next") {
                            self.page3++;
                        } else {
                            self.page3--;
                        }
                        self.fnPoint2('');
                    },

                    fnCoupon(commend) {
                        var self = this;
                        if (commend == 'C') {
                            self.couponPage = 1;
                        }
                        var nparmap = {
                            userId: self.userId,
                            couponPageSize: self.couponPageSize,
                            couponPage: (self.couponPage - 1) * self.couponPageSize // 페이지 시작점
                        };
                        $.ajax({
                            url: "/user/coupon.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.couponList = data.coupon;
                                self.couponCnt = data.count;
                                self.couponIndex = Math.ceil(data.count / self.couponPageSize);
                            }
                        });
                    },

                    fnCouponPageMove: function (direction) {
                        let self = this;
                        if (direction == "next") {
                            self.couponPage++;
                        } else {
                            self.couponPage--;
                        }
                        self.fnCoupon('');
                    },

                    fnOrderList: function (commend) {
                        let self = this;
                        let nparmap = {
                            userId: self.userId,
                            orderKey: self.orderKey
                        };

                        $.ajax({
                            url: "/user/orderList.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.orderList = data.orderList;
                                self.orderCnt = data.orderCount;
                                self.orderAllCnt = data.orderAllCount;


                            }
                        });
                    },

                    fnMemberShipInfo() {
                        var self = this;
                        var nparmap = {
                            userId: self.userId

                        };

                        $.ajax({
                            url: "/user/memberShip.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.count > 0) {
                                    self.membership = data.ship;
                                    self.membershipYn = "Y";
                                } else {
                                    self.membershipYn = "N";
                                }

                            }
                        });
                    },
                    fnGetTab() {
                        let self = this;
                        if (self.paramsTab != null && self.paramsTab != '') {
                            self.changeTab(self.paramsTab);
                        }
                    },

                    fnOrderListStatus: function () {
                        location.href = "/order/orderList.do";
                    },
                    fnProduct(productId) {
                        let self = this;
                        self.productId = productId;
                        location.href = "/product/view.do?productId=" + self.productId;
                    },

                    fnMyVetBoardList(commend) {
                        let self = this;
                        if (commend == 'C') {
                            self.keyword2 = '';
                            self.vetPage = 1;
                        }
                        let nparmap = {
                            searchOption: "userId2",
                            keyword: self.userId,
                            keyword2: self.keyword2,
                            userId: self.userId,
                            pageSize: self.vetPageSize,
                            page: (self.vetPage - 1) * self.pageSize // 페이지 시작점
                        };

                        $.ajax({
                            url: "/board/vetBoardList.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.result != 'success') {
                                    alert("잘못된 주소입니다.");
                                }
                                self.vetBoardList = data.vetBoard;
                                if (data.count && data.count.cnt !== undefined) {
                                    self.vetIndex = Math.ceil(data.count.cnt / self.vetPageSize);
                                    self.vetCnt = data.count;
                                    data.count.cnt
                                } else {
                                    self.vetIndex = 0;
                                }
                            }
                        });
                    }

                },

                mounted() {
                    let self = this;
                    if (self.userId == "") {
                        alert("로그인 후 이용가능한 서비스입니다.");
                        location.href = "/main.do";
                    }
                    self.fnMemberShipInfo();
                    self.fnInfo2();
                    self.fnPoint();
                    self.fnPoint2();
                    self.fnCoupon();
                    self.fnOrderList();
                    self.fnGetTab();
                    self.fnMyVetBoardList();
                    window.vueObj = this;

                }
            });

            app.mount("#app");
        });
    </script>