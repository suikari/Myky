<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 목록 페이지</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <style>
            /* 헤더, 푸터 간격 조정 */
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
                grid-template-columns: repeat(4, 1fr);
                column-gap: 20px;
                row-gap: 40px;
                flex-wrap: wrap;
                gap: 24px;
                justify-content: flex-start;
            }

            .product-item {
                width: 260px;
                height: 100%;
                background: #fff;
                padding: 12px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
                border-radius: 6px;
                display: flex;
                flex-direction: column;
                transition: all 0.3s ease-in-out;
                background-color: transparent;
                box-shadow: none;
                border: none;
                text-align: left
            }
            .product-image img {
                width: 250px;
                height: 250px;
                object-fit: contain;
                border-radius: 5px;
                margin-bottom: 10px;
                cursor: pointer;
            }
            .product-name {
                font-size: 14px;
                font-weight: bold;
                color: #333;
                margin-bottom: 8px;
                line-height: 1.4;
                min-height: 38px;
                /* 두 줄 보장 */
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
            .product-item:hover {
                transform: translateY(-5px);
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
                <!-- <select v-model="searchOption" id="selectBox">
                <option value="all">:: 전체 상품 ::</option>
                <option value="dog">강아지 상품</option>
                <option value="cat">고양이 상품</option>
            </select> -->
                <div class="product-header">
                    <div class="total-count">
                        총 <strong>{{ totalCount }}</strong>개의 상품이 있습니다.
                    </div>
                    <div class="sort-box">
                        <select v-model="sortOption" @change="fnChangeSort" class="sort-select">
                            <option value="">:: 정렬방식 ::</option>
                            <option value="high">높은 가격순</option>
                            <option value="low">낮은 가격순</option>
                            <option value="name">상품명 순</option>
                            <option value="rating">평점 높은 순</option>
                        </select>
                    </div>
                </div>
                <hr>
                <section class="product-container">
                    <div v-for="item in list" class="product-item" :key="item.productId">
                        <div class="product-image" @click="fnView(item.productId)">
                            <img :src="item.filePath || '../../img/product/product update.png'"
                                :alt="item.fileName || '이미지 없음'">
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
                <!-- <button @click="fnChange">강아지</button>
            <button @click="fnChange2">장난감</button> -->
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
                        pageSize: 8,
                        page: 1,
                        isMember: true,
                        membershipDiscountRate: 0.9,
                        sessionRole: "${sessionRole}",
                        sortOption: "",
                        totalCount: 0,
                        sort : "",
                        productList : []
                    };
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
                    }
                },
                setup() {
                    const params = new URLSearchParams(window.location.search);
                    const keyword = params.get("keyword") || "";
                    const searchOption = params.get("searchOption") || "";
                    const sortOption = params.get("sortOption") || "";
                    const page = Number(params.get("page")) || 1;

                    return { keyword, searchOption, sortOption, page };

                },
                mounted() {
                    this.fnProductList();
                }
            });

            app.mount("#app");
        });
    </script>