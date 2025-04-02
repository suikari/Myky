<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 목록 페이지</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <style>
            #app {
                margin: 40px auto;
                max-width: 1200px;
            }

            main {
                padding: 20px 0;
                width: 100%;
                box-sizing: border-box;
            }

            .product-container {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 30px;
                flex-wrap: wrap;
                gap: 30px;
                padding: 0 10px;
                justify-content: flex-start;
                box-sizing: border-box;
                cursor: pointer;
            }

            .product-info {
                width: 250px;
                text-align: left;
            }

            .product-item {
                width: 250px;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 4px;
                background: #fff;
            }

            .product-image {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 0;
                margin: 0;
                width: 250px;
                height: 250px;
                overflow: hidden;
                position: relative;
            }

            .product-image-wrapper {
                position: relative;
                width: 250px;
                height: 250px;
                background-color: #fff;
                border: 2px solid #e0e0e0;    
                border-radius: 10px;    
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05); 
                padding: 0;
                margin: 0;
                box-sizing: border-box;
                overflow: hidden;
            }
            .product-image img {
                width: 250px;
                height: 250px;
                object-fit: contain;
                border-radius: 5px;
                margin-bottom: 10px;
                cursor: pointer;
                justify-content: center;
                align-items: center;
            }

            /* hover 버튼 영역 */
            .hover-buttons {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                opacity: 0;
                display: flex;
                gap: 10px;
                transition: opacity 0.3s ease;
                z-index: 2;
            }

            /* 마우스 올리면 등장 */
            .product-image-wrapper:hover .hover-buttons {
                opacity: 1;
            }

            /* 버튼 스타일 */
            .hover-buttons button {
                padding: 15px 25px;
                background-color: rgba(255, 255, 255, 0.95);
                color: #333;
                border: 1px solid #ccc;
                border-radius: 30px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                transition: 0.2s;
            }

            .hover-buttons button:hover {
                background-color: #f08080;
                color: white;
            }

            .product-name {
                font-size: 14px;
                font-weight: bold;
                color: #333;
                margin-bottom: 8px;
                line-height: 1.4;
                min-height: 38px;
            }

            .original-price {
                font-size: 13px;
                text-decoration: line-through;
                color: #888;
                margin-bottom: 4px;
            }

            .discount-price {
                font-size: 16px;
                color: #d32f2f;
                font-weight: bold;
                margin-bottom: 6px;
            }

            .shipping-fee {
                font-size: 12px;
                color: #666;
                margin-top: auto;
            }

            .product-item h3 {
                text-align: left;
                width: 100%;
                font-size: 18px;
                font-weight: bold;
                color: rgb(52, 50, 50);
                margin-top: 4px;
                margin-bottom: 4px;
            }

            .product-item .price {
                text-align: left;
                width: 100%;
                font-size: 15px;
                font-weight: bold;
                color: rgb(52, 50, 50);
                margin-top: 4px;
                margin-bottom: 4px;
            }

            .product-item {
                text-align: left;
                width: 100%;
                font-size: 15px;
                font-weight: bold;
            }

            .discount-price strong {
                text-align: left;
                width: 100%;
                font-size: 16px;
                font-weight: bold;
            }

            .price {
                font-size: 20px;
                font-weight: bold;
                color: #000;
                margin-bottom: 6px;
            }

            .del-price {
                text-align: left;
                width: 100%;
                font-size: 12px;
                color: #868080;
                margin-top: 4px;
                margin-bottom: 4px;
            }

            .discount-info {
                font-size: 13px;
                color: #ff4444;
                margin-top: -4px;
                margin-bottom: 10px;
                font-weight: 500;
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }

            .pagination a {
                margin: 0 5px;
                text-decoration: none;
                color: black;
                font-size: 18px;
            }

            .pagination a:hover {
                text-decoration: none;
            }

            .pagination .active {
                font-weight: bold;
                color: #ff6600;
                text-decoration: none;
            }

            /* 상품 정렬 */
            .sort-box {
                display: flex;
                align-items: left;
            }

            .sort-select {
                padding: 6px 12px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                background-color: #fff;
                color: #333;
                cursor: pointer;
                appearance: none;
                background: url("data:image/svg+xml;utf8,<svg fill='black' height='12' viewBox='0 0 24 24' width='12' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/></svg>") no-repeat right 10px center;
                background-size: 12px;
                padding-right: 30px;
            }

            .sort-select:focus {
                outline: none;
                border-color: #888;
            }

            .product-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 20px;
                margin-bottom: 15px;
                box-sizing: border-box;
            }

            /* 상품 총 개수 */
            .total-count {
                font-size: 14px;
                color: #333;
            }

            .total-count strong {
                font-weight: bold;
                color: #000;
            }


            .breadcrumb-container {
                width: 100%;
                text-align: right;
                margin-bottom: 10px;
                position: relative;
                top: -40px;
            }

            .breadcrumb {
                display: inline-block;
                font-size: 14px;
                justify-content: flex-start;
                padding-left: 20px;
                padding-right: 20px;
                gap: 6px;
                color: #666;
                cursor: pointer;
                text-decoration: none;
            }

            .breadcrumb a {
                color: #444;
                text-decoration: none;
                font-weight: 450;
                cursor: pointer;
                display: inline-block;
            }

            .breadcrumb a:hover {
                text-decoration: none;
                color: #ff6600;
            }

            @media (max-width: 768px) {
                .top-bar {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="../common/header.jsp" />

        <div id="app" class="container">
            <main>
                <div class="breadcrumb-container">
                    <div class="breadcrumb">
                        <a href="/">홈</a>
                        / <a href="/product/list.do"> 전체상품 </a>
                        <template v-if="largeCategory">
                            /<a href="javascript:;" @click="goToCategory">{{ largeCategory }}</a>
                        </template>
                        <template v-if="subcategory">
                            / <a href="javascript:;" @click="goToSubCategory">{{ subcategory }}</a>
                        </template>
                    </div>
                </div>
                <div class="product-header">
                    <div class="total-count">
                        총 <strong>{{ totalCount }}</strong>개의 상품이 있습니다.
                    </div>
                    <div class="sort-box">
                        <select v-model="sortOption" @change="fnChangeSort" class="sort-select">
                            <option value="">:: 정렬방식 ::</option>
                            <option value="high">높은가격</option>
                            <option value="low">낮은가격</option>
                            <option value="name">상품명</option>
                            <option value="count">사용후기</option>
                            <option value="registration">신상품</option>
                        </select>
                    </div>
                </div>
                <hr>
                <section class="product-container">
                    <div v-for="item in list" class="product-item" :key="item.productId">
                        <div class="product-image-wrapper">
                            <img :src="item.filePath || '../../img/product/product update.png'"
                                :alt="item.fileName || '이미지 없음'" class="product-image"
                                @click.stop="fnView(item.productId)" />
                            <div class="hover-buttons">
                                <button @click.stop="fnAddCart(item.productId)">Cart</button>
                                <button @click.stop="fnAddBuy(item.productId)">ADD</button>
                            </div>
                        </div>
                        <div class="product-info">
                            <div class="product-name">{{ item.productName }}</div>

                            <!-- 할인 있는 경우 -->
                            <template v-if="isMember && item.discount > 0">
                                <div class="original-price">정상가: {{ formatPrice(item.price) }}</div>
                                <div class="discount-price">멤버십 할인가: {{ formatPrice(getDiscountedPrice(item)) }}</div>
                            </template>
                            <!-- 할인 없는 경우 -->
                            <template v-else>
                                <div class="discount-price">{{ formatPrice(item.price) }}</div>
                            </template>

                            <div class="shipping-fee">배송비: {{ formatPrice(item.shippingFee) }}</div>
                        </div>
                    </div>
                </section>

                <div class="pagination">
                    <a v-if="page != 1" id="index" href="javascript:;" @click="fnPageMove('prev')">
                        < </a>
                            <a v-for="num in index" :key="num" id="index" href="javascript:;" @click="fnPage(num)"
                                :class="{ active: page === num }">
                                <span v-if="page == num">{{ num }}</span>
                                <span v-else>{{ num }}</span>
                            </a>
                            <a v-if="page < index" id="index" href="javascript:;" @click="fnPageMove('next')"> > </a>
                </div>
            </main>
        </div>

        <jsp:include page="../common/footer.jsp" />
    </body>

    </html>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        keyword: "${map.keyword}",
                        searchOption: '${map.searchOption}',
                        list: [],
                        index: 0,
                        pageSize: 9,
                        page: 1,
                        isMember: true,
                        sessionRole: "${sessionRole}",
                        sortOption: "",
                        totalCount: 0,
                        sort: "",
                        productList: [],
                        category: "",
                        userInfo: {
                            membershipFlg: "${membershipFlg}",
                            userId: "${userId}"
                        },
                        sessionId: "${sessionId}",
                    };
                },
                computed: {
                    largeCategory() {
                        switch (this.searchOption) {
                            case 'dog': return '강아지';
                            case 'cat': return '고양이';
                            case 'pet': return '영양제';
                            default: return '';
                        }
                    },
                    subcategory() {
                        return this.keyword || '';
                    }
                },
                methods: {
                    fnProductList() {
                        var self = this;
                        var nparmap = {
                            keyword: self.keyword,
                            searchOption: self.searchOption,
                            pageSize: self.pageSize,
                            page: (self.page - 1) * self.pageSize,
                            sortOption: self.sortOption
                        };
                        $.ajax({
                            url: "/product/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.list = data.list;
                                self.index = Math.ceil(data.count / self.pageSize);
                                self.totalCount = data.count;
                            }
                        });
                    },
                    fnView: function (productId) {
                        let self = this;
                        localStorage.setItem("sortOption", self.sortOption);
                        localStorage.setItem("page", self.page);

                        location.href = "/product/view.do?productId=" + productId;
                    },
                    fnPage: function (num) {
                        let self = this;
                        self.page = num;
                        self.fnProductList();
                    },
                    fnPageMove: function (direction) {
                        let self = this;
                        if (direction == "next") {
                            self.page++;
                        } else {
                            self.page--;
                        }
                        self.fnProductList();
                    },
                    fnChangeSort() {
                        let self = this;
                        self.page = 1;

                        self.fnProductList();
                    },
                    formatPrice(value) {
                        if (!value && value !== 0) return '';
                        return Number(value).toLocaleString();
                    },
                    getDiscountedPrice(item) {
                        if (!item.discount || item.discount === 0) return item.price;
                        return Math.floor(item.price * (1 - item.discount / 100));
                    },
                    goToCategory: function () {
                        let self = this;
                        let searchOption = "";

                        if (self.largeCategory === "강아지") {
                            searchOption = "dog";
                        } else if (self.largeCategory === "고양이") {
                            searchOption = "cat";
                        } else if (self.largeCategory === "영양제") {
                            searchOption = "pet";
                        }

                        if (searchOption !== "") {
                            location.href = "/product/list.do?searchOption=" + searchOption;
                        } else {
                            alert("잘못된 카테고리입니다.");
                        }
                    },
                    goToSubCategory: function () {
                        let self = this;
                        let searchOption = "";
                        let subcategory = self.subcategory;

                        if (self.largeCategory === "강아지") {
                            searchOption = "dog";
                        } else if (self.largeCategory === "고양이") {
                            searchOption = "cat";
                        } else if (self.largeCategory === "영양제") {
                            searchOption = "pet";
                        }

                        if (searchOption !== "" && subcategory !== "") {
                            location.href = "/product/list.do?searchOption=" + searchOption + "&keyword=" + subcategory;
                        } else {
                            alert("카테고리 정보가 부족합니다.");
                        }
                    },
                    //유저 아이디 정보 가져오기
                    fnUserInfo() {
                        var self = this;
                        console.log("sessionId >>> ", self.sessionId);
                        var nparmap = {
                            userId: self.sessionId
                        };
                        $.ajax({
                            url: "/user/info.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("userInfo >>> ", data.user);
                                self.userInfo = data.user;
                            }
                        });
                    },
                    fnAddCart(productId) {
                        const self = this;
                        const item = self.list.find(p => p.productId === productId);
                        if (!item) {
                            alert("상품 정보를 불러올 수 없습니다.");
                            return;
                        }
                        const priceToAdd = self.userInfo.membershipFlg === 'Y'
                            ? Math.floor(item.price * (1 - item.discount / 100))
                            : item.price;

                        const nparmap = {
                            productId: productId,
                            sessionId: self.sessionId,
                            userId: self.userInfo.userId,
                            quantity: 1,
                            price: priceToAdd,
                            option: "",
                            checkYn: "N"
                        };
                        console.log("🧾 장바구니 요청 파라미터:", nparmap);
                        $.ajax({
                            url: "/cart/addProduct.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log("응답:", data);
                                if (data.result === "success") {
                                    alert("장바구니에 상품이 담겼습니다.");
                                } else {
                                    alert(data.message || "장바구니 담기에 실패했습니다.");
                                }
                            },
                            error: function (xhr, status, err) {
                                console.log("에러 발생:", err);
                                alert("장바구니 요청 실패");
                            }
                        });
                    }, fnAddBuy(productId) {
                        const self = this;

                        const item = self.list.find(p => p.productId === productId);
                        if (!item) {
                            alert("상품 정보를 불러올 수 없습니다.");
                            return;
                        }

                        const priceToAdd = self.userInfo.membershipFlg === 'Y'
                            ? Math.floor(item.price * (1 - item.discount / 100))
                            : item.price;

                        // 전체 checkYn 초기화
                        $.ajax({
                            url: "/cart/AllCheckYn.dox",
                            type: "POST",
                            data: {
                                userId: self.userInfo.userId,
                                checkYn: "N"
                            },
                            dataType: "json",
                            success: function () {
                                const nparmap = {
                                    productId: productId,
                                    sessionId: self.sessionId,
                                    userId: self.userInfo.userId,
                                    quantity: 1,
                                    price: priceToAdd,
                                    option: "instant",
                                    checkYn: "Y"
                                };

                                $.ajax({
                                    url: "/cart/addProduct.dox",
                                    type: "POST",
                                    data: nparmap,
                                    dataType: "json",
                                    success: function () {
                                        location.href = "/cart/order.do";
                                    },
                                    error: function () {
                                        alert("구매 처리에 실패했습니다.");
                                    }
                                });
                            }
                        });
                    }
                },
                setup() {
                    const params = new URLSearchParams(window.location.search);
                    const keyword = params.get("keyword") || "";
                    const searchOption = params.get("searchOption") || "";

                    //카테고리 분류
                    const category = params.get("category") || "";
                    const subcategory = params.get("subcategory") || "";

                    //localStorage에서 sortOption 가져오기(정렬 기준)
                    const savedSort = localStorage.getItem("sortOption");  //저장된 값을 꺼내기
                    const sortOption = savedSort || params.get("sortOption") || ""; //없으면 기본값
                    localStorage.removeItem("sortOption");
                    //localStorage에서 sortOption 가져오기(페이지 기준)
                    const page = Number(localStorage.getItem("page")) || 1;
                    localStorage.removeItem("page");

                    return { keyword, searchOption, sortOption, page, category, subcategory };

                },
                mounted() {
                    this.fnUserInfo();
                    this.fnProductList();

                    const action = new URLSearchParams(window.location.search).get("action");

                    // 페이지 진입 시 바로 실행
                    if (action === "cart") {
                        this.fnAddCart(); // 장바구니 담기
                    } else if (action === "buy") {
                        this.fnBuy(); // 즉시 구매
                    }

                }
            });

            app.mount("#app");
        });
    </script>