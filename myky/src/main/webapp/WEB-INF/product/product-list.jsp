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
            /* 헤더, 푸터와의 간격 */
            max-width: 1200px;
        }

        main {
            padding: 20px 0;
            /* 상단, 하단 여백 */
        }

        .product-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            column-gap: 20px;
            /* 좌우 간격 유지 */
            row-gap: 40px;
            /* 위아래 간격 증가 */
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .product-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            height: 100%;
            transition: all 0.3s ease-in-out;

            /* 배경 박스 제거 */
            background-color: transparent;
            box-shadow: none;
            border: none;
        }

        .product-item:hover {
            transform: translateY(-5px);
        }

        .product-item img {
            width: 200px;
            height: 200px;
            object-fit: contain;
            border-radius: 5px;
            margin-bottom: 10px;
            cursor: pointer;
        }

        .product-item h3 {
            margin: 10px 0;
        }

        .product-item p {
            flex-grow: 1;
            font-size: 16px;
            color: #555;
        }

        .product-item .price {
            font-size: 18px;
            font-weight: bold;
            color: #ff6600;
            margin-top: auto;
        }

        /* 페이징 스타일 */
        .pagination {
            display: flex;
            justify-content: center; /* 가운데 정렬 */
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
            <section class="product-container">
                <div v-for="item in list" class="product-item" :key="item.productId">
                    <template v-if="item.filePath">
                        <img :src="item.filePath" :alt="item.fileName" @click="fnView(item.productId)">
                    </template>
                    <template v-else>
                        <img src="../../img/product/product update.png" alt="이미지 없음" @click="fnView(item.productId)">
                    </template>
                    <h3>{{ item.productName }}</h3>
                    <p>{{ item.description }}</p>
                    <p class="price">₩ {{ item.price }}</p>
                </div>
            </section>
            <div class="pagination">
                <a v-if="page != 1" id="index" href="javascript:;" @click="fnPageMove('prev')"> < </a>
                <a v-for="num in index" :key="num" id="index" href="javascript:;" @click="fnPage(num)" :class="{ active: page === num }">
                    <span v-if="page == num">{{ num }}</span>
                    <span v-else>{{ num }}</span>
                </a>
                <a v-if="page != index" id="index" href="javascript:;" @click="fnPageMove('next')"> > </a>
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
                    page: 1
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
                        }
                    });
                },
                fnView: function (productId) {
                    pageChange("/product/view.do", { productId: productId });
                },
                //테스트용용
                // fnChange : function(){
                //     pageChange("/product/list.do", {searchOption : "dog" });
                // },
                // fnChange2 : function(){
                //     pageChange("/product/list.do", {searchOption : "dog" ,keyword : "장난감" });
                // }
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
