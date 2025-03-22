<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 상세보기</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            body {
                font-family: 'Noto Sans KR', sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                background-color: #f5f5f5;
            }

            .container {
                max-width: 1100px;
                margin: 20px auto;
                padding: 20px;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-wrap: wrap;
            }

            .product-detail {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                width: 100%;
            }

            .product-image-container {
                flex: 1;
                max-width: 48%;
                text-align: center;
            }

            .product-image-container img {
                width: 100%;
                max-width: 420px;
                border-radius: 8px;
                box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.1);
            }

            .product-image-thumbNails {
                display: flex;
                justify-content: center;
                margin-top: 10px;
            }

            .product-image-thumbNails img {
                width: 55px;
                height: 55px;
                margin: 5px;
                cursor: pointer;
                border-radius: 5px;
                border: 2px solid transparent;
                transition: all 0.3s;
            }

            .product-image-thumbNails img:hover {
                border: 2px solid #28a745;
            }

            .product-info {
                flex: 1;
                max-width: 48%;
                padding: 20px;
            }

            .product-info h1 {
                font-size: 26px;
                margin-bottom: 10px;
                font-weight: bold;
                color: #333;
            }

            .product-info p {
                font-size: 18px;
                color: #666;
                margin-bottom: 10px;
            }

            .price {
                font-size: 24px;
                font-weight: bold;
                color: #dc3545;
                margin-top: 10px;
            }

            .buy-btn {
                display: block;
                width: 100%;
                padding: 12px;
                font-size: 20px;
                font-weight: bold;
                color: #fff;
                background-color: #28a745;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                margin-top: 15px;
                transition: background 0.3s;
            }

            .buy-btn:hover {
                background-color: #218838;
            }

            @media (max-width: 768px) {
                .product-detail {
                    flex-direction: column;
                    align-items: center;
                }

                .product-image-container,
                .product-info {
                    max-width: 100%;
                    text-align: center;
                }

                .buy-btn {
                    width: 90%;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="../common/header.jsp" />
        <div id="app" class="container">
            <!-- 상품 상세 정보 -->
            <section class="product-detail">
                <div class="product-image-container">
                    <img :src="info.filePath" alt="info.fileName" id="mainImage">
                    <!-- 상품 이미지 슬라이드 -->
                    <div class="product-image-thumbNails">
                        <img v-for="(img, index) in imgList" :src="img.filePath" alt="상품 썸네일"
                            @click="changeImage(img.filePath)">
                    </div>
                </div>
                <div class="product-info">
                    <h1> 상품명 : {{info.productName}}</h1>
                    <p> 가격 : {{info.price}}</p>
                    <p> 제조사 : {{info.manufacturer}}</p>
                    <p> 상품코드 : {{info.productCode}}</p>
                    <p class="price">₩ {{ info.price }}</p>
                    <button class="buy-btn" @click="fnPay">상품 구매</button>
                </div>
            </section>


        </div>


        <jsp:include page="../common/footer.jsp" />


    </body>

    </html>
    <script>


        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        productId: '${map.productId}',
                        info: {},
                        imgList: []

                    };
                },
                computed: {

                },
                methods: {
                    fnProduct() {
                        var self = this;
                        var nparmap = { productId: self.productId };
                        $.ajax({
                            url: '/product/get.dox',
                            dataType: 'json',
                            type: 'POST',
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.info = data.info; // 서버로부터 받은 정보로 info를 채움
                                self.imgList = data.imgList; // 이미지 리스트 받아오기
                            },
                        });
                    },
                    // 클릭된 이미지로 메인 이미지 변경
                    changeImage(filePath) {
                        document.getElementById('mainImage').src = filePath;
                    }
                },
                mounted() {
                    let self = this;
                    self.fnProduct();

                }
            });

            app.mount("#app");
        });
    </script>