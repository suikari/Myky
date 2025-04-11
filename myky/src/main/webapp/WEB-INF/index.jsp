<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멍냥꽁냥에 오신걸 환영합니다!</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <script src="js/swiper8.js"></script>

        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: 'Segoe UI', sans-serif;
                background: #fffdfc;
                overflow-x: hidden;
                /* ✅ 좌우 스크롤 방지 */
            }

            main {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .swiper,
            .swiper.hero-banner {
                width: 100%;
                /* ✅ 100vw → 100% 로 수정 */
                max-width: 100%;
                height: 500px;
                padding: 0;
                border-radius: 0;
                box-shadow: none;
            }



            .swiper-wrapper {
                width: 100%;
                display: flex;
            }

            /* 하단 그라데이션 효과 */
            .swiper.hero-banner::after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 0;
                height: 60px;
                width: 100%;
                background: linear-gradient(to bottom, rgba(255, 255, 255, 0) 0%, #fffdfc 100%);
                z-index: 2;
            }

            .swiper-slide {
                width: 100% ;
                /* 한 슬라이드가 전체 너비 차지 */
                margin: 0 !important;
                /* 가운데 정렬 방지 */
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #fff;
                height: 100%;
                border-radius: 0;
                /* 필요시 */
            }

            .swiper-slide-product {
                width: 20% !important ;
                background: none !important;
            }

            .swiper-slide-product img {
                height: 185px !important;
                object-fit: cover;

            }
            
            .swiper-slide img {
                width: 100%;
                height: auto;
                object-fit: cover;
                border-radius: 12px;
                display: block;
            }

            .shortcut-grid {
                display: grid;
                grid-template-columns: repeat(5, 1fr);
                gap: 40px;
                max-width: 1024px;
                margin: 40px auto 30px;
                justify-content: center;
            }

            .shortcut-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                background: #fff;
                border-radius: 16px;
                padding: 20px 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                transition: transform 0.2s ease-in-out;
            }

            .shortcut-item a {
                display: flex;
                flex-direction: column;
                align-items: center;
                text-decoration: none;
                color: #333;
            }

            .shortcut-item:hover {
                transform: scale(1.05);
            }

            .shortcut-item img {
                width: 64px;
                height: 64px;
                margin-bottom: 12px;
            }

            .shortcut-item span {
                font-size: 20px;
                font-weight: 600;
                color: #333;
            }

            .info-section {
                display: flex;
                justify-content: center;
                gap: 40px;
                max-width: 1024px;
                margin-bottom: 50px;
                flex-wrap: wrap;
            }

            .post-item {
                padding: 10px 0;
                border-bottom: 1px solid #eee;
                font-size: 14px;
                color: #333;
                cursor: pointer;
            }

            .post-item:hover {
                background-color: #fafafa;
            }

            .post-content {
                font-size: 13px;
                color: #777;
            }

            .scroll {
                -ms-overflow-style: none;
                scrollbar-width: none;
            }

            .scroll::-webkit-scrollbar {
                display: none;
            }

            .product-list {
                display: flex;
                gap: 10px;
                justify-content: center;
                flex-wrap: wrap;
            }

            .product-card {
                width: calc(20% - 40px);
                min-width: 150px;
                height: 230px;
                flex-direction: column;
                background: #fff;
                border-radius: 6px;
                padding: 10px;
                position: relative;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                transition: transform 0.2s, box-shadow 0.2s;
                text-align: center;
            }

            .product-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
            }

            .product-image img {
                width: 100%;
                height: 150px;
                object-fit: cover;
                box-shadow: 0px 3px 8px  rgb(244, 244, 244);
                border-radius: 6px;
                margin-bottom: 8px;

            }

            .product-name {
                font-size: 12px;
                font-weight: 600;
                margin-bottom: 5px;
                color: #333;
                height: 40px;
                line-height: 1.2;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .product-price {
                font-size: 15px;
                font-weight: bold;
                color: black;
            }

            /* ✅ 베스트 + 신상품 나란히 배치 컨테이너 */
            .product-pair-section {
                display: flex;
                justify-content: center;
                gap: 30px;
                max-width: 1280px;
                margin: 40px auto;
                flex-wrap: wrap;
                /* 반응형 대비 */
            }

            /* ✅ 개별 박스 공통 스타일 */
            .product-box {
                width: 100%;
                background: #fff8f0;
                border-radius: 12px;
                padding: 30px 40px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
                box-sizing: border-box;
                position: relative;
            }

            /* ✨ 신규 상품 박스 색상 */
            .new-products {
                background-color: #f0faff;
            }

            @media (max-width: 1024px) {
                .product-pair-section {
                    flex-direction: column;
                }

                .product-box {
                    width: 100%;
                }
            }

            .section-header {
                text-align: center;
                margin-top: 10px;
                margin-bottom: 30px;
            }

            .section-header h2 {
                font-size: 28px;
                font-weight: bold;
                color: #ff6f61;
                margin-bottom: 10px;
            }

            .section-header p {
                font-size: 14px;
                color: #555;
            }

            .section-header p {
                font-size: 14px;
                color: #555;
            }

            .board-container {
                width: 380px;
                min-height: 300px;
                background: #fff;
                padding: 24px;
                border-radius: 12px;
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.06);
            }

            .board-div {
                max-height: 220px;
                overflow-y: auto;
            }

            .board-header {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 12px;
                gap: 8px;
            }

            .board-icon {
                width: 50px;
                height: 50px;
            }

            .board-title-wrapper {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 12px;
            }

            .board-more {
                font-size: 13px;
                color: #888;
                text-decoration: none;
            }
			
			a {
				text-decoration: none;     
			}
			
            .board-more:hover {
                text-decoration: underline;
            }

            .badge {
                position: absolute;
                top: 0px;
                left: 5px;
                background: #ff6f61;
                color: white;
                padding: 4px 8px;
                font-size: 12px;
                border-radius: 6px;
                font-weight: bold;
            }

            .section-subtitle {
                font-size: 22px;
                font-weight: bold;
                text-align: center;
                margin: 40px auto 20px;
                color: #444;
            }

            .board-container.notice {
                background: #f0f7ff;
                border-top: 4px solid #339af0;
            }

            .board-container.donation {
                background: #fff8f0;
                border-top: 4px solid rgb(110, 158, 255);;
            }

            /* 신규 상품 색상 전용 배경 */
            .new-products {
                background-color: #f0faff;
                /* 연한 하늘색 */
            }

            /* 신규 상품 제목 색상 */
            .new-products .section-header h2 {
                color: #339af0;
            }

            /* 신규 상품 전용 뱃지 */
            .new-products .badge {
                background-color: rgb(89, 138, 240);
                /* 파란색 계열 */
                color: white;
                font-weight: bold;
                font-size: 12px;
                position: absolute;
                top: 0px;
                left: 5px;
                padding: 4px 8px;
                border-radius: 6px;
            }

            .navigation {
                margin-top: 30px;
                display: flex;
                justify-content: center;
                gap: 20px;
            }

            .nav-button {
                background-color: #ff6f61;
                color: white;
                border: none;
                padding: 10px 20px;
                font-weight: bold;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .nav-button:hover:not(:disabled) {
                background-color: #ff3e2e;
            }

            .nav-button:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }
            .new-nav-button {
                background-color: rgb(157, 186, 247);
                color: white;
                border: none;
                padding: 10px 20px;
                font-weight: bold;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .new-nav-button:hover:not(:disabled) {
                background-color: rgb(89, 138, 240);
            }

            .new-nav-button:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }
            .swiper-button-next,
            .swiper-button-prev {
                opacity: 0;
                width: 80px;
                height: 100%;
                position: absolute;
                top: 0;
                z-index: 10;
                cursor: pointer;
            }

            .swiper-button-next {
                right: 0;
            }

            .swiper-button-prev {
                left: 0;
            }



            @media (max-width: 1024px) {
                .product-card {
                    width: calc(33.33% - 16px);
                    /* 태블릿: 3개씩 */
                }
            }

            @media (max-width: 768px) {
                .product-card {
                    width: calc(50% - 16px);
                    /* 모바일: 2개씩 */
                }
            }

            @media (max-width: 768px) {

                .swiper-button-next,
                .swiper-button-prev {
                    display: none !important;
                }
            }

            .scroll {
                -ms-overflow-style: none;
                /* IE and Edge */
                scrollbar-width: none;
                /* Firefox */

            }

            .scroll::-webkit-scrollbar {
                display: none;
                /* Chrome, Safari, Opera*/
            }

            .donation-close-btn {
                position: absolute;
                top: 10px;
                right: 10px;
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                color: #666;
                padding: 5px 10px;
                border-radius: 50%;
                transition: background-color 0.2s;
            }

            .donation-close-btn:hover {
                background-color: rgba(0, 0, 0, 0.1);
            }

            .donation-toggle-btn {
                position: fixed;
                right: 85px;
                bottom: 20px;
                background: white;
                border: none;
                border-radius: 50%;
                width: 50px;
                height: 50px;
                cursor: pointer;
                z-index: 999;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: transform 0.2s;
                border: 3px solid rgb(110, 158, 255);
            }

            .donation-toggle-btn:hover {
                transform: translateY(-10%) scale(1.1);
            }

            /* 슬라이더 컨테이너 스타일 */
            .product-swiper {
                position: relative;
                overflow: hidden;
            }

            /* 슬라이드 아이템 스타일 */
            .slide-item {
                width: calc(20% - 20px); /* 5개씩 보이도록 설정 */
                height: auto;
            }

            /* 슬라이더 카드 스타일 */
            .slider-card {
                width: 100%;
                height: 100%;
                background: #fff;
                border-radius: 6px;
                padding: 10px;
                position: relative;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                transition: transform 0.2s;
                text-align: center;
                padding: 20px 20px;
                margin: 10px 10px;
            }

            .slider-card:hover {
                transform: translateY(-5px);
            }

            /* 슬라이더 이미지 컨테이너 */
            .slider-image {
                width: 100%;
                height: 180px;
                position: relative;
                margin-bottom: 10px;
            }

            /* 슬라이더 이미지 */
            .slider-img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 6px;
            }

            /* 슬라이더 텍스트 스타일 */
            .slider-name {
                font-size: 14px;
                font-weight: 600;
                margin: 10px 0;
                height: 40px;
                overflow: hidden;
                text-overflow: ellipsis;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
            }

            .slider-price {
                font-size: 16px;
                font-weight: bold;
                color: #333;
            }

            /* 슬라이더 뱃지 */
            .slider-badge {
                position: absolute;
                top: 10px;
                left: 10px;
                background: #ff6f61;
                color: white;
                padding: 4px 8px;
                font-size: 12px;
                border-radius: 6px;
                font-weight: bold;
                z-index: 1;
            }

            /* 신상품 뱃지 색상 */
            .new-products .slider-badge {
                background-color: rgb(89, 138, 240);
            }

            /* 네비게이션 버튼 스타일 수정 */
            .product-swiper .swiper-button-next,
            .product-swiper .swiper-button-prev {
                width: 40px;
                height: 40px;
                background-color: white;
                border-radius: 50%;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                opacity: 1;
                top: 50%;
                transform: translateY(-50%);
                margin-top: 0;
            }

            .product-swiper .swiper-button-next {
                right: 0;
            }

            .product-swiper .swiper-button-prev {
                left: 0;
            }

            .product-swiper .swiper-button-next::after,
            .product-swiper .swiper-button-prev::after {
                font-size: 18px;
                color: #333;
            }

            /* 베스트 상품 네비게이션 버튼 */
            .best-swiper .swiper-button-next,
            .best-swiper .swiper-button-prev {
                color: #ff6f61;
            }

            /* 신상품 네비게이션 버튼 */
            .new-swiper .swiper-button-next,
            .new-swiper .swiper-button-prev {
                color: rgb(89, 138, 240);
            }

        </style>
    </head>

    <body>
        <jsp:include page="common/header.jsp" />



        <div id="app" class="container">



            <main class="content">

                <!-- ✅ 배너 -->
                <div ref="swiperContainer" class="swiper hero-banner">
                    <div class="swiper-wrapper">
                        <img v-for="img in slides" :src="img" class="swiper-slide" />
                    </div>
                    <div class="swiper-pagination"></div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>

                <!-- ✅ 아이콘 4개 -->
                <section class="shortcut-grid">
                    
                        <a href="/partner/list.do">
                        	<div class="shortcut-item">
                            <img src="img/quick/vet.png" alt="병원찾기" />
                            <span>병원찾기</span>
                            </div>
                        </a>
                    
                        <a href="/product/list.do">
                            <div class="shortcut-item">
	                            <img src="img/quick/pet-shop.png" alt="용품구매" />
	                            <span>용품구매</span>
                            </div>
                        </a>
                        <a href="/partner/info.do">
                            <div class="shortcut-item">
	                            <img src="img/quick/partner.png" alt="제휴사" />
	                            <span>제휴처 소개</span>
                            </div>
                        </a>
                        <a href="/center.do">
                            <div class="shortcut-item">
	                            <img src="img/quick/donation.png" alt="후원하기" />
	                            <span>후원하기</span>
	                        </div>
                        </a>
                        <a href="/cart/list.do">
                           <div class="shortcut-item">
	                            <img src="img/quick/manifest.png" alt="주문조회" />
	                            <span>주문조회</span>
                            </div>
                        </a>
                </section>

                
                <section class="info-section">
                    <!-- ✅ 공지사항 & 후원내역
                    <div class="board-container notice">
                        <div class="board-title-wrapper">
                            <div class="board-header">
                                <img src="img/quick/advertisement.png" class="board-icon" alt="공지">
                                <div class="board-title">공지사항</div>
                            </div>
                            <a href="/board/list.do?category=A" class="board-more">더보기</a>
                        </div>
                        <div class="board-div">
                            <div v-for="post in freeposts" @click="fnView(post.boardId)" class="post-item">
                                <div>
                                    <span class="badge" v-if="post.new">NEW</span>
                                    {{ post.title }}
                                </div>
                                <div class="post-content">{{ post.createdAt }}</div>
                            </div>
                        </div>
                    </div> -->

                    <!-- 후원내역 -->
                    <div v-if="showDonation" class="board-container donation">
                        <button @click="toggleDonation" class="donation-close-btn">×</button>
                        <div class="board-title-wrapper">
                            <div class="board-header">
                                <img src="img/quick/charity.png" class="board-icon" alt="후원">
                                <div class="board-title">후원내역</div>
                            </div>
                        </div>
                        <div class="board-div scroll" id="scrollBox">
                            <div v-for="post in donations" class="post-item">
                                <div>
                                    <span v-if="post.anonymousYn == 'N'">{{ post.nickName }}</span>
                                    <span v-if="post.anonymousYn == 'Y'">익명</span>
                                    님이 {{ post.centerName }} 에 {{ post.amount }} 원을 후원 해주셨습니다.
                                </div>
                                <div class="post-content">{{ post.donationDate }}</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 하단에 후원내역 아이콘 추가 -->
                    <button v-if="!showDonation" @click="toggleDonation" class="donation-toggle-btn">
                        <img src="img/quick/charity.png" alt="후원내역" style="width: 24px; height: 24px;">
                    </button>

                </section>

                <!-- ✅ 베스트 + 신상품 좌우 배치 -->
                <section class="product-pair-section">
                    <!-- 🔥 베스트 상품 -->
                    <div class="product-box">
                        <div class="section-header">
                            <h2>🔥 베스트 상품</h2>
                            <p>가장 인기 있는 반려동물 용품을 소개합니다</p>
                        </div>
                        <div class="product-swiper best-swiper">
                            <div class="swiper-wrapper">
                                <div v-for="product in products" class="swiper-slide swiper-slide-product">
                                    <div class="slider-card">
                                        <div class="slider-badge">BEST</div>
                                        <div class="slider-image" @click="fnPView(product.productId)">
                                            <img class="slider-img"
                                                :src="product.filePath || '../../img/product/product update.png'"
                                                :alt="product.fileName || '이미지 없음'" />
                                        </div>
                                        <div class="slider-name">{{ product.productName }}</div>
                                        <div class="slider-price">{{ product.price.toLocaleString() }}원</div>
                                    </div>
                                </div>
                            </div>
                            <div class="swiper-button-next best-next"></div>
                            <div class="swiper-button-prev best-prev"></div>
                        </div>
                    </div>

                    <!-- ✨ 신상품 -->
                    <div class="product-box new-products">
                        <div class="section-header">
                            <h2>✨ 신규 상품</h2>
                            <p>따끈따끈! 막 들어온 반려동물 신상품을 만나보세요</p>
                        </div>
                        <div class="product-swiper new-swiper">
                            <div class="swiper-wrapper">
                                <div v-for="product in productsN" class="swiper-slide swiper-slide-product">
                                    <div class="slider-card">
                                        <div class="slider-badge">NEW</div>
                                        <div class="slider-image" @click="fnPView(product.productId)">
                                            <img class="slider-img"
                                                :src="product.filePath || '../../img/product/product update.png'"
                                                :alt="product.fileName || '이미지 없음'" />
                                        </div>
                                        <div class="slider-name">{{ product.productName }}</div>
                                        <div class="slider-price">{{ product.price.toLocaleString() }}원</div>
                                    </div>
                                </div>
                            </div>
                            <div class="swiper-button-next new-next"></div>
                            <div class="swiper-button-prev new-prev"></div>
                        </div>
                    </div>
                </section>


            </main>
        </div>


        <jsp:include page="common/footer.jsp" />


    </body>

    </html>
    <script>


        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        alertMessage: "${alertMessage}" || "",
                        slides: [
                            'img/banner/M.banner1-1.png',
                            'img/banner/M.banner2.png',
                            'img/banner/M.banner4-1.png',
                            'img/banner/M.banner5-1.png',
                            'img/banner/M.banner6-1.png'
                        ],
                        freeposts: [],
                        donations: [],
                        products: [],
                        productsN: [],
                        currentPageBest: 0, // 베스트 상품 현재 페이지
                        currentPageNew: 0,  // 신규 상품 현재 페이지
                        itemsPerPage: 5,   // 한 페이지당 상품 개수
                        code: "",
                        showDonation: true, 
                    };
                },
                computed: {
                    maxPage() {
                        return (list) => Math.ceil(list.length / this.itemsPerPage) - 1;
                    },
                },
                methods: {
                    getDisplayedProducts(list, page) {
                        const start = page * this.itemsPerPage;
                        return list.slice(start, start + this.itemsPerPage);
                    },
                    // 이전 페이지 버튼
                    prevPage(type) {
                        if (type === 'best' && this.currentPageBest > 0) {
                            this.currentPageBest--;
                        } else if (type === 'new' && this.currentPageNew > 0) {
                            this.currentPageNew--;
                        }
                    },
                    // 다음 페이지 버튼
                    nextPage(type) {
                        if (type === 'best' && this.currentPageBest < this.maxPage(this.products)) {
                            this.currentPageBest++;
                        } else if (type === 'new' && this.currentPageNew < this.maxPage(this.productsN)) {
                            this.currentPageNew++;
                        }
                    },
                    fnboardList: function () {
                        var self = this;
                        var nparmap = {
                            page: 0,
                            pageSize: 3,
                            category: "A"
                        };
                        $.ajax({
                            url: "board/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                //console.log(data);
                                self.freeposts = data.board;

                            }
                        });
                    },
                    fnProductList: function () {
                        var self = this;
                        var nparmap = {
                            page: 0,
                            pageSize: 20,
                            sortOption: "count"
                        };
                        $.ajax({
                            url: "/product/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.products = data.list;

                            }
                        });
                    },
                    fnNewProductList: function () {
                        var self = this;
                        var nparmap = {
                            page: 0,
                            pageSize: 20,
                            sortOption: "registration"
                        };
                        $.ajax({
                            url: "/product/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("2", data);
                                self.productsN = data.list;

                            }
                        });
                    },
                    fnDonationList: function () {
                        var self = this;
                        var nparmap = {
                        };
                        $.ajax({
                            url: "/donation/info.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                //console.log("dona",data);
                                self.donations = data.info;
                            }
                        });
                    },
                    kakaotest: function () {
                        var self = this;
                        var nparmap = {
                            code: self.code
                        };
                        $.ajax({
                            url: "user/kakao.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (kakaodata) {
                                console.log(kakaodata);
                                console.log("334", kakaodata.kakao_account.email);

                                if (kakaodata.kakao_account && kakaodata.kakao_account.email) {
                                    nparmap = {
                                        email: kakaodata.kakao_account.email
                                    };

                                    $.ajax({
                                        url: "/user/socialEmail.dox", // 얘한테 요청함 'controller'에게 요청
                                        dataType: "json",
                                        type: "POST",
                                        data: nparmap,
                                        success: function (data) {
                                            console.log(data);

                                            if ((data.result == "fail1")) {
                                                return;
                                            } else {
                                                if (data.count > 0) {
                                                    alert(data.user.userName + "님 환영해요!");
                                                    location.href = "/main.do";
                                                } else {
                                                    console.log("구글 카운트:", data.count);
                                                    if (confirm("이 사이트를 이용하시려면 회원가입이 필요합니다. 회원가입하시겠습니까?")) {
                                                        //sessionStorage.setItem("socialLoginConfirmed", "true"); 
                                                        //location.href = "/user/consent.do";

                                                        pageChange("/user/consent.do", { email: kakaodata.kakao_account.email, name: kakaodata.kakao_account.profile.nickname });

                                                    }
                                                }
                                            }

                                        }
                                    });
                                } else {
                                    alert("로그인 실패 (이메일동의 필요)");
                                    location.href = "/main.do";
                                }

                            }
                        });
                    },

                    fnView(boardId) {
                        location.href = "/board/view.do?category=A&boardId=" + boardId;
                    },
                    fnPView(productId) {
                        location.href = "/product/view.do?productId=" + productId;
                    },
                    autoScroll() {
                        let container = document.getElementById("scrollBox");
                        let speed = 1; // 스크롤 속도

                        setInterval(() => {
                            if (!container || container.scrollHeight === 0) return; // 내용이 없을 때 작동하지 않음

                            container.scrollTop += speed;

                            // **끝까지 스크롤되면 다시 처음으로 이동**
                            if (container.scrollTop + container.clientHeight >= container.scrollHeight) {
                                this.fnDonationList();
                                container.scrollTop = 0; // 처음으로 리셋
                            }
                        }, 50); // 50ms마다 실행 (속도 조절 가능)
                    },
                    toggleDonation() {
                        this.showDonation = !this.showDonation;
                        if (this.showDonation) {
                            this.fnDonationList(); // 다시 열 때 데이터 새로고침
                            this.$nextTick(() => {
                                this.autoScroll(); // 스크롤 재시작
                            });
                        }
                    },
                },
                mounted() {
                    let self = this;

                    // 기존 hero-banner 스와이퍼
                    this.$nextTick(() => {
                            new Swiper(this.$refs.swiperContainer, {
                                loop: true,
                                autoplay: {
                                    delay: 3000,
                                    disableOnInteraction: false,
                                },
                                slidesPerView: 1,
                                spaceBetween: 0,
                                pagination: {
                                    el: ".swiper-pagination",
                                    clickable: true,
                                },
                                navigation: {
                                    nextEl: ".swiper-button-next",
                                    prevEl: ".swiper-button-prev",
                                },
                            });

                            // 베스트 상품 스와이퍼
                            new Swiper('.best-swiper', {
                                slidesPerView: 5,
                                slidesPerGroup: 5,
                                spaceBetween: 0,
                                navigation: {
                                    nextEl: '.best-next',
                                    prevEl: '.best-prev',
                                },
                                loop: false,
                                speed: 600,
                                allowTouchMove: true,
                                touchRatio: 1,
                                touchAngle: 45,
                                grabCursor: true
                            });

                            // 신상품 스와이퍼
                            new Swiper('.new-swiper', {
                                slidesPerView: 5,
                                slidesPerGroup: 5,
                                spaceBetween: 0,
                                navigation: {
                                    nextEl: '.new-next',
                                    prevEl: '.new-prev',
                                },
                                loop: false,
                                speed: 600,
                                allowTouchMove: true,
                                touchRatio: 1,
                                touchAngle: 45,
                                grabCursor: true
                            });
                        });


                    const queryParams = new URLSearchParams(window.location.search);
                    self.code = queryParams.get('code') || '';

                    if (self.code != "") {
                        self.kakaotest();
                        //console.log(self.code);
                    }

                    //self.fnboardList();
                    self.fnProductList();
                    self.fnDonationList();
                    self.autoScroll();
                    self.fnNewProductList();
                    if (self.alertMessage != "") {
                        alert(self.alertMessage);

                    }
                }
            });

            app.mount("#app");
        });
    </script>