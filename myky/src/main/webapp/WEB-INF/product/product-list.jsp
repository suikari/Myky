<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 목록 페이지</title>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
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
                padding: 20px;
                max-width: 1200px;
                margin: 0 auto;
                cursor: pointer;
            }

            .product-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 10px;
                border-radius: 8px;
                height: 100%;
                transition: all 0.3s ease-in-out;
                background-color: transparent;
                box-shadow: none;
                border: none;
                text-align: center;
            }

            .product-item:hover {
                transform: translateY(-5px);
            }

            .product-item img {
                width: 250px;
                height: 250px;
                object-fit: contain;
                border-radius: 5px;
                margin-bottom: 10px;
                cursor: pointer;
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

            .del-price {
                text-align: left;
                width: 100%;
                font-size: 12px;
                color: #868080;
                margin-top: 4px;
                margin-bottom: 4px;
            }

            p.discount-info {
                text-align: left;
                width: 100%;
                font-size: 12px;
                font-weight: bold;
                color: rgb(142, 36, 4);
                margin-top: 2px;
                margin-bottom: 4px;
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
                        <select v-model="sortOption" @change="fnSortList" class="sort-select">
                            <option value="">:: 정렬방식 ::</option>
                            <option value="high">높은 가격순</option>
                            <option value="low">낮은 가격순</option>
                            <option value="name">상품명 순</option>
                        </select>
                    </div>
                </div>
                <hr>
                <section class="product-container">
                    <div v-for="item in list" class="product-item" :key="item.productId">
                        <template v-if="item.filePath">
                            <img :src="item.filePath" :alt="item.fileName" @click="fnView(item.productId)">
                        </template>
                        <template v-else>
                            <img src="../../img/product/product update.png" alt="이미지 없음"
                                @click="fnView(item.productId)">
                        </template>
                        <h3>{{ item.productName }}</h3>
                        <!-- 일반 가격 -->
                        <p class="price">{{ formatPrice(item.price) }}</p>
                        <p class="del-price">배송비 : 2000원</p>

                        <!-- 멤버십 회원이면 할인율과 할인 가격을 표시 -->
                        <template v-if="isMember">
                            <p class="discount-info">
                                멤버십 {{ Math.round((1 - membershipDiscountRate) * 100) }}% 할인 :
                                {{ formatPrice(Math.floor(item.price * membershipDiscountRate)) }}
                            </p>
                        </template>
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
                            <a v-if="page < index" id="index" href="javascript:;" @click="fnPageMove('next')"> >
                            </a>

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
                        totalCount: 0
                    };
                },
                methods: {
                    fnProductList() {
                        var self = this;
                        var nparmap = {
                            keyword: self.keyword,
                            searchOption: self.searchOption,
                            pageSize: self.pageSize,
                            page: (self.page - 1) * self.pageSize
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
                                self.fnSortList();
                            }
                        });
                    },
                    formatPrice(price) {
                        if (price == null) return '';
                        return price.toLocaleString('ko-KR') + '원';
                    },
                    fnView: function (productId) {
                        pageChange("/product/view.do", { productId: productId });
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
                    fnSortList() {
                        let self = this;
                        if (self.sortOption === "high") {
                            self.list.sort((a, b) => b.price - a.price);
                        } else if (self.sortOption === "low") {
                            self.list.sort((a, b) => a.price - b.price);
                        } else if (self.sortOption === "name") {
                            self.list.sort((a, b) => a.productName.localeCompare(b.productName));
                        }
                    }
                },
                setup() {
                    const params = new URLSearchParams(window.location.search);
                    const keyword = params.get("keyword") || "";
                    const searchOption = params.get("searchOption") || "";

                    return { keyword, searchOption };
                },
                mounted() {
                    this.fnProductList();
                }
            });

            app.mount("#app");
        });
    </script>