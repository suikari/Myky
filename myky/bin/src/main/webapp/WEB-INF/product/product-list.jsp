<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 목록 페이지</title>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <script src="js/swiper8.js"></script>

        <link rel="stylesheet" href="../css/main.css">
        <style>
            .product-container {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                padding: 20px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .product {
                background-color: #f9f9f9;
                padding: 10px;
                border-radius: 8px;
                text-align: center;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .product img {
                width: 100%;
                height: 200px;
                object-fit: contain;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            .product-item img {
                width: 200px;
                height: 200px;
            }

            .product p {
                font-size: 16px;
                color: #555;
            }

            .product .price {
                font-size: 18px;
                font-weight: bold;
                color: #ff6600;
            }
        </style>
    </head>

    <body>
        <jsp:include page="../common/header.jsp" />
        <div id="app" class="container">
            <main>
                <section class="product-container">
                    <!-- 상품 항목 -->
                    <div v-for="item in list" class="product-item">
                       <template v-if="item.filePath">
                        <img :src="item.filePath" :alt="item.fileName" @click="fnView(item.productId)">
                       </template>

                       <template v-else>
                        <img src="../../img/product/product update.png" alt="이미지 없음" @click="fnView(item.productId)">
                       </template>

                        <h3>{{item.productName}}</h3>
                        <p>{{item.description}}</p>
                        <p class="price">₩ {{item.price}}</p>
                </section>
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
                        list: []

                    };
                },
                computed: {

                },
                methods: {
                    fnProductList() {
                        var self = this;
                        var nparmap = {};
                        $.ajax({
                            url: "/product/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.list = data.list;
                            }
                        });
                    },
                    fnView: function (productId) {
                        pageChange("/product/view.do", { productId: productId });
                    }
                },
                mounted() {
                    let self = this;
                    self.fnProductList("");
                }
            });

            app.mount("#app");
        });
    </script>