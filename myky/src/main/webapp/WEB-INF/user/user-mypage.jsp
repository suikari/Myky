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


            .mypage-container {
                width: 100%;
                margin: 30px auto;
                background: #fff;
                padding: 30px;
                box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
                border-radius: 16px;
            }


            .profile-wrapper {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                gap: 40px;
                border-bottom: 1px solid #ddd;
                padding-bottom: 20px;
            }

            /* 유저 정보 영역 */

            .user-info {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .profile-pic {
                width: 120px;
                height: 120px;
                background: #ddd;
                border-radius: 50%;
                object-fit: cover;
            }

            /* 유저 이름, 배지 */
            .user-details h2 {
                margin: 0 0 10px;
                font-size: 20px;
                color: #333;
            }

            .badge {
                font-size: 14px;
                padding: 5px 10px;
                border-radius: 12px;
                display: inline-block;
            }

            .badge-yes {
                background-color: #ccc;
                color: #222;
            }

            .badge-no {
                background-color: #eee;
                color: #555;
            }

            /* 요약 정보 */
            .summary {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
                /* 작은 화면 대응 */
                justify-content: flex-start;
            }

            .summary-item {
                flex: 0 0 130px;
                /* 고정 너비 설정 (원하는 크기로 조정 가능) */
                background-color: #f7f7f7;
                border: 1px solid #e0e0e0;
                padding: 25px 20px;
                border-radius: 12px;
                text-align: center;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
                transition: transform 0.2s ease, box-shadow 0.2s ease;
                min-width: 130px;
                /* 줄어들지 않게 최소 너비도 설정 */
            }

            .summary-item:hover {
                transform: translateY(-4px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                background-color: rgb(203, 235, 255);
                border: 1px solid rgb(110, 158, 255);
            }

            .summary-title {
                font-size: 16px;
                color: #666;
                margin-bottom: 8px;
                font-weight: 500;
            }

            .summary-value {
                font-size: 22px;
                font-weight: 700;
                color: #333;
            }

            .main-content {
                display: flex;
                margin-top: 20px;
            }

            .sidebar {
                width: 25%;
                background: #f7f7f7;
                padding: 20px;
                border-radius: 10px;
                font-family: 'Noto Sans KR', sans-serif;
                box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
            }

            .sidebar h3 {
                font-size: 16px;
                color: #333;
                margin-bottom: 10px;
                font-weight: 600;
            }

            .tab-menu {
                margin-bottom: 20px;
            }

            .tab-item {
                padding: 10px 15px;
                border-radius: 6px;
                margin-bottom: 8px;
                font-size: 14px;
                color: #444;
                background-color: transparent;
                transition: background-color 0.2s ease, color 0.2s ease;
            }

            .tab-item:hover {
                background-color: rgb(203, 235, 255);
                color: #333;
                cursor: pointer;
            }

            .tab-item.active {
                background-color: rgb(110, 158, 255);
                color: white;
                font-weight: 600;
            }

            .sidebar ul {
                list-style: none;
                color: #444;
                padding: 0;
            }

            .sidebar ul li {
                padding: 10px 15px;
                border-radius: 6px;
                font-size: 14px;
                margin-bottom: 6px;
                transition: background-color 0.2s ease, color 0.2s ease;
            }

            .sidebar ul li:hover {
                background-color: rgb(203, 235, 255);
                color: #333;
                cursor: pointer;
            }

            .sidebar ul li a {
                color: inherit;
                text-decoration: none;
                display: block;
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
                background-color: rgb(203, 235, 255);
                ;
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

            .board-page {
                font-family: 'Arial', sans-serif;
                margin: 20px auto;
                padding: 20px;
                background-color: #f9f9f9;
                border-radius: 8px;
                max-width: 1000px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            }

            /* 게시판 테이블 */
            .board-table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                font-family: Arial, sans-serif;
            }

            .board-table th {
                background-color: rgb(203, 235, 255);
                ;
                color: #333;
                padding: 12px 15px;
                text-align: center;
                font-size: 16px;
            }

            .board-table td {
                padding: 12px 15px;
                text-align: center;
                border-bottom: 1px solid #ddd;
                color: #333;
                font-size: 14px;
            }

            .board-table tr:hover {
                background-color: #f1f1f1;
            }

            .board-table tr[style*="display: none"] {
                display: none;
            }

            .board-table a {
                color: #333;
                text-decoration: none;
            }

            .board-table a:hover {
                color: rgb(110, 158, 255);
                text-decoration: none;
            }

            .board-table td:nth-child(3),
            .board-table td:nth-child(1) {
                text-align: center;
            }

            /* 검색 입력, 셀렉트박스 */
            .board-page select,
            .board-page input {
                margin: 10px 5px 20px 0;
                padding: 6px 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
                font-size: 14px;
            }

            /* 게시글 없음 안내 */
            .board-page h2 {
                color: #999;
                font-weight: normal;
                margin-top: 20px;
            }

            .board-page button {
                margin-top: 10px;
                padding: 8px 16px;
                background-color: rgb(110, 158, 255);
                border: none;
                border-radius: 6px;
                color: white;
                cursor: pointer;
            }

            .board-page button:hover {
                background-color: rgb(0, 80, 255);
            }

            .cmtCountColor {
                color: #007bff;
            }

            /* 페이징 스타일 */
            .pagination {
                padding: 5px 10px;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 50px;
                gap: 8px;
            }

            .pagination a {
                padding: 5px 10px;
                background-color: #eee;
                color: #333;
                text-decoration: none;
                border-radius: 6px;
                font-size: 14px;
                transition: 0.2s;
            }

            .pagination a:hover {
                background-color: #ccc;
            }

            .pagination .bgColer {
                padding: 5px 10px;
                border-radius: 6px;
                background-color: rgb(110, 158, 255);
                ;
                color: white;
            }

            /* 반응형 */
            @media (max-width: 768px) {
                .board-table {
                    font-size: 14px;
                }

                .board-table th,
                .board-table td {
                    padding: 8px;
                }

                .board-page select,
                .board-page input {
                    width: 100%;
                    margin: 5px 0;
                }

                .pagination {
                    flex-wrap: wrap;
                    gap: 4px;
                }
            }

            /* 인풋과 셀렉트 공통 스타일 */
            .board-page {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                margin-bottom: 20px;
                align-items: center;
            }

            .board-page select,
            .board-page input[type="text"],
            .board-page input[type="search"] {
                padding: 10px 14px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 14px;
                background-color: #fff;
                transition: border-color 0.2s, box-shadow 0.2s;
                outline: none;
                min-width: 180px;
            }

            .board-page select:focus,
            .board-page input[type="text"]:focus,
            .board-page input[type="search"]:focus {
                border-color: rgb(110, 158, 255);
                box-shadow: 0 0 6px rgba(76, 175, 80, 0.3);
            }

            /* 반응형 처리 */
            @media (max-width: 768px) {
                .board-page {
                    flex-direction: column;
                    align-items: stretch;
                }

                .board-page select,
                .board-page input[type="text"],
                .board-page input[type="search"] {
                    width: 100%;
                }
            }

            .board-controls {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                margin: 15px 0 25px;
                align-items: center;
            }

            .board-controls select,
            .board-controls input[type="text"] {
                padding: 10px 14px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 14px;
                background-color: #fff;
                transition: border-color 0.2s, box-shadow 0.2s;
                outline: none;
                min-width: 180px;
            }

            .board-controls select:focus,
            .board-controls input[type="text"]:focus {
                border-color: rgb(110, 158, 255);
                box-shadow: 0 0 6px rgba(76, 175, 80, 0.3);
            }

            /* 반응형 대응 */
            @media (max-width: 768px) {
                .board-controls {
                    flex-direction: column;
                    align-items: stretch;
                }

                .board-controls select,
                .board-controls input[type="text"] {
                    width: 100%;
                }
            }

            /* 게시글 작성 버튼 */
            .btn-board-write {
                background-color: rgb(110, 158, 255);
                ;
                color: #fff;
                padding: 10px 20px;
                font-size: 15px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            .btn-board-write:hover {
                background-color: rgb(0, 80, 255);
                ;
                /* 조금 더 진한 오렌지 */
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
                background-color: rgb(203, 235, 255);
                color: #333;
                text-align: center;
                font-weight: bold;
            }

            .comment-table-column {
                padding: 12px 20px;
                text-align: center;
            }

            .comment-table-row {
                border-bottom: 1px solid #ddd;
                text-align: center;
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
                color: rgb(110, 158, 255);
                text-decoration: none;
            }

            .comment-link:hover {
                color: rgb(0, 80, 255);
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
                /* background: linear-gradient(to right, #ff6600, #ff9966); */
                background-clip: text;
                -webkit-background-clip: text;
                color: rgb(110, 158, 255);
                padding: 10px 0;
            }

            /* 페이지 제목 아래 작은 선 추가 */
            .page-title::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background-color: rgb(110, 158, 255);
                ;
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
                border-bottom: 2px solid rgb(110, 158, 255);
                ;
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
                border-radius: 12px;
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            /* 테이블 헤더 스타일 */
            .cpoint-header {
                background-color: rgb(203, 235, 255);
                ;
                color: #333;
                padding: 10px;
                text-align: center;
                font-size: 16px;
            }

            /* 테이블 행 스타일 */
            .cpoint-row {
                background-color: #fff;
                border-bottom: 1px solid #ddd;
            }

            .cpoint-row td {
                padding: 12px 15px;
                text-align: center;
                font-size: 14px;
            }

            /* 테이블 행 호버 효과 */
            .cpoint-row:hover {
                background-color: #f1f1f1;
            }

            .cpoint-pagination {
                margin-top: 30px;
                text-align: center;
            }

            .cpoint-pagination a {
                display: inline-block;
                padding: 8px 14px;
                background-color: rgb(110, 158, 255);
                color: #fff;
                border-radius: 6px;
                margin: 0 5px;
                font-size: 14px;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }

            .cpoint-pagination a:hover {
                background-color: rgb(0, 80, 255);
            }

            .coupon-container {
                display: block;
                flex-wrap: wrap;
                gap: 8px;
                text-align: center;
                justify-content: center;
                background-color: #f6f5f5;
                border-radius: 8px;
            }
            .coupon-container h2 {
                padding-top: 30px;
            }

            .coupon-subContainer {
                display: flex;
                flex-wrap: wrap;
                gap: 16px;
                justify-content: center;
                background-color: #f6f5f5;
                border-radius: 8px;
            }

            .coupon {
                position: relative;
                border-radius: 12px;
                padding: 16px;
                color: #333;
                font-family: 'Arial', sans-serif;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 300px;
                flex: none;
                margin: 10px;
                overflow: hidden;
                background-color: #ffffff;
            }

            .coupon-bg-logo {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                z-index: 0;
                /* 🔽 배경으로! */
                pointer-events: none;
                opacity: 1;
                /* ❗ 흐림 제거 */
                filter: none;
                /* ❗ 흐림 제거 */
            }

            .coupon-bg-logo2 {
                position: absolute;
                top: 100px;
                right: -60px;
                width: 70%;
                height: 70%;
                object-fit: cover;
                z-index: 0;
                /* 🔽 배경으로! */
                pointer-events: none;
                opacity: 0.6;
                /* ❗ 흐림 제거 */
                filter: none;
                /* ❗ 흐림 제거 */
            }

            .coupon-non {
                background-color: #f6f5f5;
                border-radius: 12px;
                padding: 16px;
                color: #ffffff;
                font-family: 'Arial', sans-serif;
                width: 1280px;
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
                color: #333;
                position: relative;
                /* ⭐ 이게 핵심! 글씨가 이미지 위에 보이도록 */
                z-index: 1;
            }

            .coupon-item {
                padding: 6px 0;
                font-size: 14px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.5);
            }

            .coupon-name {
                font-size: 24px;
                color: white;
                ;
                border-bottom: 1px solid rgba(255, 255, 255, 0.5);
            }

            .coupon-item:last-child {
                border-bottom: none;
            }

            .coupon-discount {
                font-style: italic;
                font-size: 28px;
                font-weight: bold;
                color: white;
                text-shadow: 3px 4px 5px #888;
                text-align: right;
            }

            .coupon-info {
                font-size: 12px;
                color: #333;
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
                background-color: rgb(0, 80, 255);
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
                            <div class="summary-item">
                                <div class="summary-title">현재 포인트</div>
                                <div class="summary-value">{{ formattedAmount(point.currentPoint) }}P</div>
                            </div>
                            <div class="summary-item">
                                <div class="summary-title">보유 쿠폰</div>
                                <div class="summary-value">{{ couponCnt }}개</div>
                            </div>
                            <div class="summary-item">
                                <div class="summary-title">총 주문 수</div>
                                <div class="summary-value">{{ orderAllCnt }}회</div>
                            </div>
                        </div>
                    </div>

                    <div class="main-content">
                        <aside class="sidebar">
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
                                <h3>나의 개인정보</h3>
                                <li><a @click="fnInfo()">회원 정보 수정</a></li>
                                <li><a @click="fnWithdraw()">회원 탈퇴</a></li>
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
                                        <a v-if="couponIndex > 1 && couponPage != couponIndex" href="javascript:;" class="bgColer2"
                                            @click="fnCouponPageMove('next')">
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
                            { id: 'coupon', label: '쿠폰 내역' }
                        ],
                        tabs2: [
                            { id: 'board', label: '게시글 내역' },
                            { id: 'comment', label: '댓글 내역' },
                            { id: 'vetBoard', label: '수의사 문의 내역' },
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
                        couponCnt: 1,
                        couponIndex:0,
                        couponPage:1,
                        couponPageSize:6,
                        orderList: [],
                        orderCnt: [
                            { orderStatus: 'shipped', orderCount: '0' },
                            { orderStatus: 'delivered', orderCount: '0' },
                            { orderStatus: 'paid', orderCount: '0' },
                            { orderStatus: 'cancel', orderCount: '0' }
                        ],
                        orderAllCnt: "",
                        membership: [],
                        membershipYn: "",
                        paramsTab: "${map.paramsTab}",
                        vetBoardList: [],
                        vetIndex: 0,
                        vetPage: 1,
                        vetPageSize: 5,
                        vetCnt: 0



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
                                console.log('쿠폰인덱스',self.couponIndex)
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

                    fnOrderList: function () {
                        let self = this;
                        let nparmap = {
                            userId: self.userId
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
                        if (self.paramsTab != null && self.paramsTab != '' ) {
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
                    self.fnCoupon();
                    self.fnOrderList();
                    self.fnGetTab();
                    self.fnMyVetBoardList();
                    window.vueObj = this;
                    console.log("dididi",self.activeTab);

                }
            });

            app.mount("#app");
        });
    </script>