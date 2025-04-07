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
                justify-content: space-between;
                padding: 20px;
                border-bottom: 1px solid #ddd;
            }

            .user-details {
                flex-grow: 1;
                padding-left: 20px;
            }

            .user-rank-mark img {
                width: 60px;
                height: 60px;
            }

            .profile-pic {
                width: 150px;
                height: 150px;
                background: gray;
                border-radius: 100%;
            }

            /* 전체 summary 박스 레이아웃 */
            .summary {
                display: flex;
                justify-content: space-between;
                gap: 20px;
                margin: 20px 0;
                padding: 10px 0;
            }

            /* 공통 summary item 스타일 */
            .summary-item {
                flex: 1;
                padding: 25px 15px;
                text-align: center;
                border-radius: 15px;
                color: #fff;
                font-size: 18px;
                font-weight: 600;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.12);
                transition: transform 0.2s ease, box-shadow 0.2s ease;
                line-height: 1.6;
                letter-spacing: 0.5px;
            }

            /* 호버 효과 */
            .summary-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.2);
            }

            /* 각 항목별 색상 커스터마이징 */
            .point-box {
                background: linear-gradient(135deg, #FFD700, #FFA500);
                /* 노랑 → 주황 */
            }

            .coupon-box {
                background: linear-gradient(135deg, #8A2BE2, #BA55D3);
                /* 보라 계열 */
            }

            .order-box {
                background: linear-gradient(135deg, #00BFFF, #1E90FF);
                /* 파랑 계열 */
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
                justify-content: space-between;
                gap: 15px;
                padding: 20px;
                margin: 20px 0;
                background-color: #f9f9f9;
                border-radius: 15px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
                font-family: 'Noto Sans KR', sans-serif;
            }

            .status-item {
                flex: 1;
                padding: 15px 10px;
                background-color: #ffffff;
                border-radius: 10px;
                text-align: center;
                box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
                transition: transform 0.2s ease;
                cursor: default;
            }

            .status-item:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .status-label {
                font-size: 14px;
                color: #888;
            }

            .order-list {
                text-align: center;
                padding: 20px;
                background: #f8f8f8;
                border-radius: 10px;
                margin-top: 10px;
            }


            .order-table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                margin-bottom: 20px;
            }

            .order-table th {
                background-color: #f0f0f0;
                color: #333;
                font-weight: 600;
                padding: 12px 10px;
                text-align: center;
                font-size: 15px;
                border-bottom: 1px solid #ddd;
            }

            .order-table td {
                text-align: center;
                padding: 12px 10px;
                font-size: 14px;
                color: #444;
                border-bottom: 1px solid #eee;
            }

            .order-table td img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
                border: 1px solid #ccc;
            }



            .order-table tr:last-child {
                border-bottom: none;
            }

            .order-table td:nth-child(2) {
                font-weight: bold;
                flex: 2;
            }

            .order-table td:nth-child(5) {
                color: #007bff;
                font-weight: bold;
            }

            .order-table tr:hover {
                background-color: #fafafa;
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


            /* 전체 페이지 배경 */
            .page-container {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                max-width: 800px;
                margin: 0 auto;
            }

            /* 페이지 제목 스타일 */
            .page-title {
                font-size: 28px;
                font-weight: bold;
                color: #333;
                text-align: center;
                margin-top: 30px;
                margin-bottom: 20px;
                font-family: 'Arial', sans-serif;
                background: linear-gradient(to right, #ff6600, #ff9966);
                background-clip: text;
                -webkit-background-clip: text;
                color: transparent;
                padding: 10px 0;
            }

            /* 페이지 제목 아래 작은 선 추가 */
            .page-title::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background-color: #ff6600;
                margin: 10px auto;
            }

            /* 감사 메시지 스타일 */
            .thank-you-message {
                font-size: 18px;
                color: #555;
                text-align: center;
                margin-bottom: 30px;
                font-family: 'Arial', sans-serif;
            }

            .thank-you-message h3 {
                color: #ff6600;
                font-size: 22px;
                font-weight: bold;
                margin-top: 10px;
            }

            /* 후원 금액 스타일 */
            .donation-amount {
                font-size: 20px;
                text-align: center;
                margin-bottom: 20px;
            }

            .donation-amount span {
                font-size: 25px;
                color: #007bff;
                font-weight: bold;
            }

            /* 테이블 스타일 */
            .donation-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 40px;
            }

            .donation-table th,
            .donation-table td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
            }

            .donation-table th {
                background-color: #f1f1f1;
                font-size: 16px;
                color: #333;
                font-weight: bold;
                text-transform: uppercase;
            }

            .donation-table td {
                font-size: 14px;
                color: #555;
            }

            /* 후원 단체와 메시지 스타일 */
            .donation-table .center-name {
                font-weight: bold;
                color: #007bff;
            }

            .donation-table .message {
                font-style: italic;
                color: #888;
            }

            /* 익명 여부 스타일 */
            .donation-table .anonymous {
                color: red;
                font-weight: bold;
            }

            .donation-table .real-name {
                color: green;
                font-weight: bold;
            }

            /* 후원 날짜 스타일 */
            .donation-table .donation-date {
                color: #666;
            }

            /* 모바일 대응 */
            @media (max-width: 768px) {

                .donation-table th,
                .donation-table td {
                    font-size: 12px;
                    padding: 8px;
                }

                .thank-you-message h3 {
                    font-size: 20px;
                }

                .donation-amount span {
                    font-size: 22px;
                }
            }

            /* 전체 포인트 페이지 스타일 */
            .cpoint-page {
                font-family: 'Arial', sans-serif;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                max-width: 800px;
                margin: 0 auto;
            }

            /* 미니 타이틀 스타일 */
            .cpoint-title {
                font-size: 20px;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
                border-bottom: 2px solid #0078d4;
                padding-bottom: 5px;
            }

            /* 현재 포인트 스타일 */
            .current-cpoint {
                font-size: 25px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            /* 테이블 스타일 */
            .cpoint-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            /* 테이블 헤더 스타일 */
            .cpoint-header {
                background-color: #0078d4;
                color: white;
                padding: 10px;
                text-align: left;
                font-size: 16px;
            }

            /* 테이블 행 스타일 */
            .cpoint-row {
                background-color: #fff;
                border-bottom: 1px solid #ddd;
            }

            .cpoint-row td {
                padding: 12px 15px;
                text-align: left;
                font-size: 14px;
            }

            /* 테이블 행 호버 효과 */
            .cpoint-row:hover {
                background-color: #f1f1f1;
            }

            .coupon-container {
                display: flex;
                flex-wrap: wrap;
                gap: 16px;
                justify-content: center;
            }

            .coupon-container {
                display: flex;
                flex-wrap: wrap;
                gap: 16px;
                justify-content: center;
            }

            .coupon {
                /* background: linear-gradient(135deg, #ff9a9e, #fad0c4); */
                background: linear-gradient(135deg, #FF5722, #ffe000c4);
                border-radius: 12px;
                padding: 16px;
                color: #ffffff;
                font-family: 'Arial', sans-serif;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 300px;
                flex: none;
                margin: 10px;
            }

            .coupon-non {
                background: linear-gradient(135deg, #f5e6e7, #f7f4f3);
                border-radius: 12px;
                padding: 16px;
                color: #ffffff;
                font-family: 'Arial', sans-serif;
                width: 800px;
                height: 200px;
                text-align: center;
                line-height: 150px;
                color: #35383dbd;
                font-size: 20px;
            }

            .coupon-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .coupon-item {
                padding: 6px 0;
                font-size: 14px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.5);
            }

            .coupon-name {
                font-size: 24px;
                color: #ffffff;
                border-bottom: 1px solid rgba(255, 255, 255, 0.5);
            }

            .coupon-item:last-child {
                border-bottom: none;
            }

            .coupon-discount {
                font-style: italic;
                font-size: 28px;
                font-weight: bold;
                color: #ffffff;
                text-shadow: 3px 4px 5px #ed0606;
                text-align: right;
            }

            .coupon-info {
                font-size: 12px;
                color: #ffffff;
            }

            .badge {
                display: inline-block;
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: bold;
                margin-left: 10px;
            }

            .badge-yes {
                background-color: #4caf50;
                /* 초록색 */
                color: white;
            }

            .badge-no {
                background-color: #ccc;
                /* 회색 */
                color: #333;
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
                            <template v-if="membershipYn === 'Y'">
                                <span class="badge badge-yes">
                                    ⭐ 멤버십 회원
                                </span>
                            </template>
                            <template v-else>
                                <span class="badge badge-no">
                                    🛈 일반 회원
                                </span>
                            </template>
                        </div>

                        <!-- <div class="user-rank-mark" style="font-size: 72px;">

                            <span v-if="membershipYn === 'Y'">👑</span>
                            <span v-else>👤</span>
                        </div> -->


                    </div>



                    <div class="summary">
                        <div class="summary-item point-box">
                            💰 현재 포인트 <br>{{formattedAmount(point.currentPoint)}}P
                        </div>
                        <div class="summary-item coupon-box">
                            🎟 쿠폰<br>{{couponCnt}}개
                        </div>
                        <div class="summary-item order-box">
                            📦 주문 수<br>{{orderAllCnt}} 회
                        </div>
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
                                <h3>최근 주문내역 현황</h3>
                                <div class="status-box">
                                    <div class="status-item">
                                        <span class="status-label">주문접수</span><br>
                                        <span class="status-count">{{ orderCnt[2].orderCount }}</span>
                                    </div>
                                    <div class="status-item">
                                        <span class="status-label">배송 중</span><br>
                                        <span class="status-count">{{ orderCnt[3].orderCount }}</span>
                                    </div>
                                    <div class="status-item">
                                        <span class="status-label">배송 완료</span><br>
                                        <span class="status-count">{{ orderCnt[1].orderCount }}</span>
                                    </div>
                                    <div class="status-item">
                                        <span class="status-label">취소</span><br>
                                        <span class="status-count">{{ orderCnt[0].orderCount }}</span>
                                    </div>
                                </div>
                                <div class="order-list" v-if="">
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
                                                <td>
                                                    <span v-if="item.orderStatus == 'paid'"
                                                        class="anonymous">주문접수</span>
                                                    <span v-if="item.orderStatus == 'shipped'" class="anonymous">배송
                                                        중</span>
                                                    <span v-if="item.orderStatus == 'delivered'" class="anonymous">배송
                                                        완료</span>
                                                    <span v-if="item.orderStatus == 'cancel'"
                                                        class="anonymous">취소</span>
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

                                <!-- <div class="order-list">
                                    <p>주문 내역이 없습니다.</p>
                                </div> -->
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
                                <table class="cpoint-table">


                                </table>

                                <br>

                                <a v-if="page3 != 1" id="pointIndex" href="javascript:;" class="bgColer2"
                                    @click="fnPageMove3('pvev')">
                                    < </a>
                                        <a v-if="pointIndex > 1 && page3 != pointIndex" id="pointIndex"
                                            href="javascript:;" class="bgColer2" @click="fnPageMove3('next')">
                                            > </a>

                            </div>


                            <div v-if="activeTab === 'coupon'">
                                <div class="coupon-container">
                                    <div v-for="item in couponList">
                                        <div class="coupon">
                                            <ul class="coupon-list">
                                                <li class="coupon-item coupon-name">{{item.couponName}} 쿠폰</li>
                                                <li class="coupon-item coupon-discount">-{{item.discountRate}}% SALES
                                                </li>
                                                <li class="coupon-item coupon-condition">
                                                    {{formattedAmount(item.minimumSpend)}}원 이상 결제시 사용 가능</li>
                                                <li class="coupon-item coupon-limit">최대
                                                    {{formattedAmount(item.maxDiscountAmount)}} 원 까지 할인</li>
                                                <li class="coupon-item coupon-info">발급 일 : {{item.createdAt}}</li>
                                                <li class="coupon-item coupon-info">유효 기간: {{item.expirationDate}} 까지
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div v-if="couponList.length==0" class="coupon-non">
                                        보유하신 쿠폰이 없습니다.
                                    </div>


                                </div>
                            </div>



                            <div v-if="activeTab === 'board'" class="comment-page">
                                <h3>작성한 게시글 수 : 총 <span style="color: red;">{{boardCnt.cnt}} </span>개</h3>
                                <div>
                                    <select v-model="pageSize" @change="fnMyBoardList('')">
                                        <option value="5">5개</option>
                                        <option value="10">10개</option>
                                    </select>
                                    <input v-model="keyword2" placeholder="검색어" @input="fnMyBoardList('')">

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
                                                <button @click=fnBoardList()>게시글 작성하기</button>
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
                                <div>
                                    <br>
                                    <a v-if="page != 1" id="index" href="javascript:;" class="bgColer2"
                                        @click="fnPageMove('pvev')">
                                        < </a>
                                            <a id="index" href="javascript:;" v-for="num in index" @click="fnPage(num)">
                                                <span v-if="page == num" class="bgColer">{{num}}</span>
                                                <span v-else class="bgColer2">{{num}}</span>
                                            </a>
                                            <a v-if="index > 1 && page != index" id="index" href="javascript:;"
                                                class="bgColer2" @click="fnPageMove('next')">
                                                >
                                            </a>
                                </div>
                            </div>

                            <div v-if="activeTab === 'comment'" class="comment-page">

                                <h3>작성한 댓글 수 : 총 <span style="color: red;">{{commCnt}} </span>개</h3>
                                <input v-model="commKeyword" placeholder="검색어" @input="fnSeachComm('')">
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
                                            <tr>
                                                <td colspan="4">
                                                    <h2>작성된 댓글이 없습니다. </h2>
                                                    <button @click=fnBoardList()>댓글 작성하기</button>
                                                </td>
                                            </tr>
                                        </template>

                                        <template v-if="commCnt == 0 && commKeyword != ''">
                                            <tr>
                                                <td colspan="4">
                                                    <h2>검색된 댓글이 없습니다. </h2>
                                                </td>
                                            </tr>
                                        </template>

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
                                        <a v-if="index2 > 1 && page2 != index2" id="index2" href="javascript:;"
                                            class="bgColer2" @click="fnPageMove2('next')">
                                            >
                                        </a>


                            </div>
                            <div v-if="activeTab === 'donation'" class="comment-page">
                                <div class="page-container">
                                    <div class="page-title"> 후원 내역 페이지</div>
                                    <div class="thank-you-message">
                                        <span style="font-size: 20px;">{{user.userName}}</span>님이 후원하신 금액은
                                    </div>
                                    <div class="donation-amount">
                                        총
                                        <span>{{sum.amount}}</span>원 입니다.
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

                                            <a v-if="page4 != 1" id="donaIndex" href="javascript:;" class="bgColer2"
                                                @click="fnPageMove4('pvev')">
                                                < </a>
                                                    <a v-if="donaIndex > 1 && page4 != donaIndex" id="pointIndex"
                                                        href="javascript:;" class="bgColer2"
                                                        @click="fnPageMove4('next')">
                                                        > </a>
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
                        couponCnt: 0,
                        orderList: [],
                        orderCnt: [
                            { orderStatus: 'shipped', orderCount: '0' },
                            { orderStatus: 'delivered', orderCount: '0' },
                            { orderStatus: 'paid', orderCount: '0' },
                            { orderStatus: 'cancel', orderCount: '0' }
                        ],
                        orderAllCnt: "",
                        membership: {},
                        membershipYn: "",
                        paramsTab: "${map.paramsTab}"



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
                        console.log(nparmap);
                        $.ajax({
                            url: "/board/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("board", data);
                                self.board = data.board;
                                self.boardCnt = data.count;
                                console.log('test', self.boardCnt.cnt);
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
                        console.log(nparmap);
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

                    fnBoardList() {
                        location.href = "/board/list.do"
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
                                console.log(data);
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

                    fnCoupon() {
                        var self = this;
                        var nparmap = {
                            userId: self.userId,
                        };
                        $.ajax({
                            url: "/user/coupon.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.couponList = data.coupon;
                                self.couponCnt = data.count;
                                console.log(self.couponCnt);

                            }
                        });
                    },

                    fnOrderList: function () {
                        let self = this;
                        let nparmap = {
                            userId: self.userId
                        };
                        console.log(nparmap);
                        $.ajax({
                            url: "/user/orderList.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("주문 상세 목록 >>> ", data.orderList);
                                self.orderList = data.orderList;
                                self.orderCnt = data.orderCount;
                                self.orderAllCnt = data.orderAllCount;
                                console.log('올카운트', self.orderAllCnt);

                            }
                        });
                    },

                    fnMemberShipInfo() {
                        var self = this;
                        var nparmap = {
                            userId: self.userId

                        };
                        console.log("파라", nparmap);
                        $.ajax({
                            url: "/user/memberShip.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("데이타 카운트", data.count);
                                if (data.count > 0) {
                                    self.ship = data.ship;
                                    self.membershipYn = "Y";
                                } else {
                                    self.membershipYn = "N";
                                }

                            }
                        });
                    },
                    fnGetTab() {
                        if (self.paramsTab != null) {
                            self.activeTab = self.paramsTab;
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



                    // //수의사 정보 공유
                    // fnVetInfo() {
                    //     var self = this;
                    //     var nparmap = {
                    //         userId: self.userId
                    //     };
                    //     $.ajax({
                    //         url: "/user/vetInfo.dox",
                    //         dataType: "json",
                    //         type: "POST",
                    //         data: nparmap,
                    //         success: function (data) {
                    //             console.log(data);
                    //             self.user = data.user;
                    //             self.vet = data.vet;
                    //             console.log(self.vet);

                    //         }
                    //     });
                    // }

                },

                mounted() {
                    let self = this;
                    if (self.userId == "") {
                        alert("로그인 후 이용가능한 서비스입니다.");
                        location.href = "/main.do";
                    }
                    self.fnInfo2();
                    self.fnPoint();
                    self.fnCoupon();
                    self.fnOrderList();
                    self.fnMemberShipInfo();
                    self.fnGetTab();
                    // self.fnVetInfo();
                    window.vueObj = this;

                }
            });

            app.mount("#app");
        });
    </script>