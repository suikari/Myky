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

            /* 배너 안쪽 이미지 영역 */
            .swiper-slide img {
                width: 100%;
                height: 380px;
                object-fit: cover;
                border-radius: 0;
                display: block;
                /* ✅ inline-block 이면 간격 생김 */
            }

            .swiper-wrapper {
                width: 100% !important;
                display: flex;
            }

            .swiper-slide img {
                width: 100%;
                height: 100%;
                object-fit: cover;
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
                width: 100% !important;
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

            .best-products {
                width: 100%;
                max-width: 1280px;
                margin-top: 30px;
                padding: 40px;
                text-align: center;
                font-size: 1.2em;
                font-weight: bold;
                background: #fff;
                border-radius: 8px;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            }

            .best-product-container {
                width: 100%;
                max-width: 1280px;
                margin: 20px auto;
                text-align: center;
            }

            .best-product-title {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 15px;
            }

            .product-list {
                display: flex;
                gap: 10px;
                justify-content: center;
                flex-wrap: wrap;
            }

            .product-card {
                width: calc(20% - 35px);
                min-width: 150px;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 10px;
                text-align: center;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            }

            .product-image img {
                width: 100%;
                height: 120px;
                object-fit: cover;
                border-radius: 6px;
                margin-bottom: 8px;
            }

            .product-name {
                font-size: 15px;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .product-price {
                font-size: 14px;
                color: #555;
            }

            .section-title {
                font-size: 22px;
                font-weight: bold;
                margin: 40px auto 20px;
                text-align: center;
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

            .board-more:hover {
                text-decoration: underline;
            }

            .badge {
                background: #ff6b6b;
                color: white;
                font-size: 10px;
                padding: 2px 4px;
                border-radius: 4px;
                margin-right: 6px;
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
                border-top: 4px solid #ffa94d;
            }

            .navigation {
                margin-top: 15px;
            }

            .nav-button {
                padding: 8px 15px;
                font-size: 14px;
                border: none;
                background-color: #007bff;
                color: white;
                border-radius: 5px;
                cursor: pointer;
                margin: 0 5px;
            }

            .nav-button:disabled {
                background-color: #ccc;
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
                    <div class="shortcut-item">
                        <a href="/partner/list.do">
                            <img src="img/quick/vet.png" alt="병원찾기" />
                            <span>병원찾기</span>
                        </a>
                    </div>
                    <div class="shortcut-item">
                        <a href="/product/list.do">
                            <img src="img/quick/pet-shop.png" alt="용품구매" />
                            <span>용품구매</span>
                        </a>
                    </div>
                    <div class="shortcut-item">
                        <a href="/partner/info.do">
                            <img src="img/quick/partner.png" alt="제휴사" />
                            <span>제휴처 소개</span>
                        </a>
                    </div>
                    <div class="shortcut-item">
                        <a href="/center.do">
                            <img src="img/quick/donation.png" alt="후원하기" />
                            <span>후원하기</span>
                        </a>
                    </div>
                    <div class="shortcut-item">
                        <a href="/cart/list.do">
                            <img src="img/quick/manifest.png" alt="주문조회" />
                            <span>주문조회</span>
                        </a>
                    </div>
                </section>

                <!-- ✅ 공지사항 & 후원내역 -->
                <section class="info-section">
                    <!-- 공지사항 -->
                    <div class="board-container notice">
                        <div class="board-title-wrapper">
                            <div class="board-header">
                                <img src="img/quick/advertisement.png" class="board-icon" alt="공지">
                                <div class="board-title">공지사항</div>
                            </div>
                            <a href="/board/list.do" class="board-more">더보기</a>
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
                    </div>


                    <!-- 후원내역 -->
                    <div class="board-container donation">
                        <div class="board-title-wrapper">
                            <div class="board-header">
                                <img src="img/quick/charity.png" class="board-icon" alt="후원">
                                <div class="board-title">후원내역</div>
                            </div>
                            <!-- <a href="/donation/list.do" class="board-more">더보기</a> -->
                        </div>
                        <div class="board-div scroll" id="scrollBox">
                            <div v-for="post in donations" class="post-item">
                                <div>
                                    <span v-if="post.anonymousYn == 'N'">{{ post.nickName }}</span>
                                    <span v-if="post.anonymousYn == 'Y'">익명</span>
                                    님이 {{ post.centerName }} 에
                                </div>
                                <div class="post-content">{{ post.amount }} 원을 후원 해주셨습니다.</div>
                                <div class="post-content">{{ post.donationDate }}</div>
                            </div>
                        </div>
                    </div>

                </section>

                <!-- ✅ 베스트 상품 -->
                <section class="best-products">
                    <div class="best-product-container">
                        <div class="best-product-title">베스트 상품</div>
                        <div class="product-list">
                            <div v-for="product in getDisplayedProducts(products, currentPageBest)"
                                class="product-card">
                                <div class="product-image">
                                    <template v-if="product.filePath">
                                        <img class="product_img" :src="product.filePath" :alt="product.fileName"
                                            @click="fnPView(product.productId)" />
                                    </template>
                                    <template v-else>
                                        <img class="product_img" src="../../img/product/product update.png" alt="이미지 없음"
                                            @click="fnPView(product.productId)" />
                                    </template>
                                </div>
                                <div class="product-name">{{ product.productName }}</div>
                                <div class="product-price">{{ product.price }}원</div>
                            </div>
                        </div>
                        <div class="navigation">
                            <button class="nav-button" @click="prevPage('best')"
                                :disabled="currentPageBest === 0">이전</button>
                            <button class="nav-button" @click="nextPage('best')"
                                :disabled="currentPageBest >= maxPage(products)">다음</button>
                        </div>
                    </div>
                </section>

                <!-- ✅ 신상품 -->
                <section class="best-products">
                    <div class="best-product-container">
                        <div class="best-product-title">신규 상품</div>
                        <div class="product-list">
                            <div v-for="product in getDisplayedProducts(productsN, currentPageNew)"
                                class="product-card">
                                <div class="product-image">
                                    <template v-if="product.filePath">
                                        <img class="product_img" :src="product.filePath" :alt="product.fileName"
                                            @click="fnPView(product.productId)" />
                                    </template>
                                    <template v-else>
                                        <img class="product_img" src="../../img/product/product update.png" alt="이미지 없음"
                                            @click="fnPView(product.productId)" />
                                    </template>
                                </div>
                                <div class="product-name">{{ product.productName }}</div>
                                <div class="product-price">{{ product.price }}원</div>
                            </div>
                        </div>
                        <div class="navigation">
                            <button class="nav-button" @click="prevPage('new')"
                                :disabled="currentPageNew === 0">이전</button>
                            <button class="nav-button" @click="nextPage('new')"
                                :disabled="currentPageNew >= maxPage(productsN)">다음</button>
                        </div>
                    </div>
                </section>

                <!-- ✅ 보호소 소개 -->
                <!-- <section>
                    <div class="section-title">보호소 소개</div>
                    <div class="shelter-preview">
                        <div class="shelter-card" v-for="shelter in shelters" :key="shelter.name">
                            <img :src="shelter.image" alt="shelter">
                            <div class="shelter-name">{{ shelter.name }}</div>
                            <div class="shelter-detail">{{ shelter.location }}</div>
                            <button @click="goToCenter">보러가기</button>
                        </div>
                    </div>
                </section> -->
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
                            pageSize: 10,
                            sortOption: "count"
                        };
                        $.ajax({
                            url: "/product/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                //console.log(data);
                                self.products = data.list;

                            }
                        });
                    },
                    fnNewProductList: function () {
                        var self = this;
                        var nparmap = {
                            page: 0,
                            pageSize: 10,
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
                                console.log("334",kakaodata.kakao_account.email);
                                 
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

             								if((data.result == "fail1")){
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

             											pageChange("/user/consent.do", {email : kakaodata.kakao_account.email , name : kakaodata.kakao_account.profile.nickname});
             											
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
                            if (!container) return;

                            container.scrollTop += speed;

                            // **끝까지 스크롤되면 다시 처음으로 이동**
                            if (container.scrollTop + container.clientHeight >= container.scrollHeight) {
                                this.fnDonationList();
                                container.scrollTop = 0; // 처음으로 리셋
                            }
                        }, 50); // 50ms마다 실행 (속도 조절 가능)
                    },
                },
                mounted() {
                    let self = this;

                    this.$nextTick(() => {
                        new Swiper(this.$refs.swiperContainer, {
                            loop: true, // 반복
                            autoplay: {
                                delay: 3000,
                                disableOnInteraction: false, // 사용자가 버튼을 눌러도 자동 재생 유지
                            },
                            slidesPerView: 1, // 자동 너비 조절
                            spaceBetween: 0, // 슬라이드 간격
                            pagination: {
                                el: ".swiper-pagination",
                                clickable: true,
                            },
                            navigation: {
                                nextEl: ".swiper-button-next",
                                prevEl: ".swiper-button-prev",
                            },
                        });
                    });


                    const queryParams = new URLSearchParams(window.location.search);
                    self.code = queryParams.get('code') || '';

                    if (self.code != "") {
                        self.kakaotest();
                        //console.log(self.code);
                    }

                    self.fnboardList();
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