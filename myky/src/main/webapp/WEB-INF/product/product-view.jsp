<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 상세보기</title>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            body {
                font-family: 'Noto Sans KR', sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                background-color: #ffffff;
            }
            .container {
                max-width: 1100px;
                margin: 20px auto;
                padding: 20px;
                background: transparent;
                border-radius: 0;
                box-shadow: none;
                display: block;
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
                max-width: 70%;
                text-align: left;
            }

            .product-image-container img {
                width: 100%;
                max-width: 420px;
                border-radius: 8px;
                box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.1);
            }

            .product-image-thumbNails {
                display: flex;
                justify-content: left;
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
                margin-top: 10px;
                margin-bottom: 50px;
                font-weight: bold;
                color: #333;
            }

            .detail-product-info .original-price {
                text-decoration: line-through;
                color: #999;
                font-size: 18px;
                margin-bottom: 4px;
            }

            .detail-product-info .discount-price {
                color: #d32f2f;
                font-size: 22px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .product-info p {
                font-size: 13px;
                color: #666;
                margin-bottom: 15px;
                font-weight: bold;
            }


            /* 수량 */
            .purchase-section {
                margin-top: 20px;
            }
            .qty-box {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 20px;
            }

            .qty-controller {
                display: flex;
                align-items: center;
                border: 1px solid #ccc;
                border-radius: 4px;
                overflow: hidden;
                width: fit-content;
                background-color: #fff;
            }

            .qty-btn {
                width: 36px;
                height: 36px;
                background-color: #fff;
                border: none;
                font-size: 18px;
                cursor: pointer;
                border-right: 1px solid #ccc;
            }

            .qty-btn:last-child {
                border-left: 1px solid #ccc;
                border-right: none;
            }

            .qty-input {
                width: 50px;
                height: 36px;
                text-align: center;
                border: none;
                font-size: 16px;
            }

            .qty-btn:hover {
                background-color: #f0f0f0;
            }

            .shipping-note {
                font-size: 12px;
                color: #777;
                margin-top: -10px;
                margin-bottom: 10px;
            }

            .remove-btn {
                background: none;
                border: none;
                font-size: 18px;
                cursor: pointer;
                color: #999;
            }

            .remove-btn:hover {
                color: #333;
            }

            .confirmed-box {
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 12px 16px;
                background-color: #fafafa;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
                margin-bottom: 10px;
            }

            .confirmed-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-weight: bold;
                font-size: 16px;
                margin-bottom: 10px;
            }

            .product-name {
                font-weight: bold;
            }

            .remove-btn {
                background: none;
                border: none;
                font-size: 18px;
                cursor: pointer;
            }

            .price-display {
                font-size: 18px;
                font-weight: bold;
                margin-top: 10px;
            }

            .total-price {
                margin-top: 20px;
                font-size: 20px;
                text-align: right;
                font-weight: bold;
            }

            .select-btn {
                height: 34px;
                padding: 0 10px;
                border: 1px solid #ccc;
                background-color: #f3f3f3;
                border-radius: 4px;
                cursor: pointer;
                white-space: nowrap;
            }

            .select-btn:disabled {
                background-color: #ddd;
                color: #666;
                cursor: not-allowed;
            }

            /* 장바구니 + 구매 */
            .action-buttons {
                display: flex;
                gap: 10px;
            }

            .cart-btn {
                flex: 1;
                height: 45px;
                font-size: 16px;
                background-color: #fff;
                border: 1px solid #000;
                cursor: pointer;
            }

            .buy-btn {
                flex: 1;
                height: 45px;
                font-size: 16px;
                background-color: red;
                color: white;
                border: none;
                cursor: pointer;
            }



            /* 상세보기 */
            .notice-section {
                max-width: 1000px;
                margin: 50px auto;
                /* auto로 수평 가운데 정렬 */
                padding: 20px;
                background-color: transparent;
                /* border: 1px solid #ddd;
                border-radius: 12px; */
                text-align: center;
                font-size: 16px;
                line-height: 1.8;
                color: #333;
            }

            .notice-section2 {
                max-width: 1000px;
                margin: 50px auto;
                /* auto로 수평 가운데 정렬 */
                margin-top: 10px;
                padding: 20px;
                background-color: transparent;
                /* border: 1px solid #ddd;
                border-radius: 12px; */
                text-align: center;
                font-size: 16px;
                line-height: 1.8;
                color: #333;
            }

            .notice-section h2 {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .notice-badge {
                display: inline-block;
                background-color: #00b894;
                color: #fff;
                font-weight: bold;
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 14px;
                margin-bottom: 20px;
            }

            .notice-section .sub-text {
                color: #999;
                font-size: 14px;
                margin-top: 8px;
            }

            /* 탭 부분 */
            .tab-wrapper {
                max-width: 1100px;
                margin: 40px auto;
                font-size: 16px;
            }

            .tab-menu {
                display: flex;
                border-bottom: 1px solid #ccc;
            }

            .tab-item {
                flex: 1;
                text-align: center;
                padding: 14px 0;
                cursor: pointer;
                border: 1px solid #ccc;
                border-bottom: none;
                background-color: transparent;
                color: #888;
            }

            .tab-item.active {
                background-color: #fff;
                color: #000;
                font-weight: bold;
                border-top: 2px solid #000;
                cursor: pointer;
            }

            .tab-content {
                padding: 30px;
                min-height: 200px;
                cursor: pointer;
            }

            /* 상품 후기 영역 */
            .review-section {
                padding: 30px;
                font-family: 'Noto Sans KR', sans-serif;
                background-color: #fff;
                max-width: 1100px;
                margin: 0 auto;
            }

            .review-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .review-header h3 {
                font-size: 20px;
                font-weight: bold;
                margin: 0;
            }

            .review-buttons .btn {
                padding: 6px 14px;
                font-size: 14px;
                border: 1px solid #ccc;
                background-color: white;
                color: #333;
                cursor: pointer;
                border-radius: 4px;
            }

            .review-buttons .btn:hover {
                background-color: #f7f7f7;
            }

            .review-empty {
                text-align: center;
                color: #777;
                font-size: 14px;
                margin-top: 100px;
            }

            .line-review {
                padding: 20px 0;
                border-bottom: 1px solid #e0e0e0;
                font-family: 'Noto Sans KR', sans-serif;
            }

            .line-review-header {
                font-weight: bold;
                color: #333;
                font-size: 16px;
                margin-bottom: 8px;
            }

            .line-review-header .stars {
                color: #ffcc00;
                margin-right: 10px;
            }

            .line-review-body p {
                font-size: 15px;
                color: #444;
                margin-bottom: 10px;
                line-height: 1.6;
            }

            .line-review-footer {
                font-size: 13px;
                color: #888;
                text-align: right;
                margin-top: 5px;
            }

            .review-detail {
                background-color: #f9f9f9;
                padding: 15px;
                text-align: left;
            }

            .review-card {
                border-bottom: 1px solid #ddd;
                padding: 20px 0;
                background-color: transparent;
            }

            .review-card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }

            .star-rating {
                font-size: 18px;
                color: #ddd;
            }

            .star-rating .star.filled {
                color: #FFD700;
            }

            .review-card-header,
            .review-card-body,
            .review-card-footer {
                padding: 0 10px;
            }

            .rating-text {
                font-size: 14px;
                color: #555;
                margin-left: 8px;
            }

            .review-meta {
                font-size: 13px;
                color: #999;
            }

            .review-card-body {
                margin-top: 10px;
            }

            .review-text {
                font-size: 15px;
                color: #444;
                line-height: 1.6;
                margin-bottom: 10px;
            }
            .review-title {
                font-size: 17px;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }
            .review-image img {
                width: 130px;
                height: 130px;
                object-fit: cover;
                border-radius: 8px;
                border: 1px solid #eee;
            }
            .review-deleted-content {
                padding: 20px 10px;
                text-align: left;
            }

            .review-deleted-content .review-text {
                font-size: 15px;
                color: #999;
                font-style: italic;
                margin: 0;
            }
            .review-card-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 10px;
                font-size: 13px;
                color: #888;
            }

            .review-actions button {
                background-color: transparent;
                border: none;
                color: #007BFF;
                cursor: pointer;
                margin-left: 10px;
                font-size: 13px;
            }

            .review-helpful {
                margin-top: 10px;
                font-size: 14px;
                color: #444;
            }

            .review-helpful button {
                background: none;
                border: 1px solid #28a745;
                color: #28a745;
                padding: 5px 12px;
                border-radius: 20px;
                cursor: pointer;
                margin-right: 8px;
                transition: 0.2s;
                font-size: 14px;
            }

            .review-helpful button:hover {
                background-color: #28a745;
                color: #fff;
            }


            .review-actions button:hover {
                text-decoration: underline;
            }

            /* QnA */
            .qna-header-container {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                border-bottom: 1px solid #ddd;
                padding: 1rem 0;
                margin-bottom: 1rem;
            }

            .qna-title-area {
                flex: 1;
            }

            .qna-title-area h3 {
                margin-bottom: 0.5rem;
            }

            .qna-notice {
                font-size: 0.9rem;
                color: #555;
                line-height: 1.6;
                list-style: disc;
                padding-left: 1.2rem;
            }

            .qna-notice li {
                margin-bottom: 0.3rem;
            }

            .qna-write-btn {
                margin-left: 1.5rem;
            }

            .btn-outline-purple {
                padding: 0.5rem 1rem;
                border: 1px solid #7b61ff;
                background: #fff;
                color: #7b61ff;
                border-radius: 4px;
                font-weight: bold;
                cursor: pointer;
            }

            .btn-outline-purple:hover {
                background: #f3f0ff;
            }

            .qna-list {
                margin-top: 20px;
            }

            .qna-item {
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
            }

            .qna-block {
                background-color: #f9f9f9;
                padding: 15px 20px;
                border-radius: 8px;
                margin-bottom: 10px;
            }
            .qna-block.answer {
                background-color: #fff;
                border-left: 4px solid #7b61ff;
                font-style: italic;
            }

            .qna-label {
                font-weight: bold;
                color: #333;
                margin-bottom: 6px;
                font-size: 14px;
            }

            .answer-label {
                color: #7b61ff;
            }

            .qna-text {
                font-size: 15px;
                line-height: 1.6;
                color: #444;
                margin-bottom: 10px;
            }

            .qna-info {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                gap: 10px;
                font-size: 13px;
                color: #888;
                margin-top: 6px;
            }
            .qna-label {
                font-weight: bold;
                color: #333;
                margin-bottom: 6px;
                font-size: 14px;
            }

            .qna-user-id {
                font-weight: normal;
                color: #555;
                margin-left: 8px;
                font-size: 13px;
            }

            .qna-delete-btn {
                background: none;
                border: none;
                color: #999;
                cursor: pointer;
                font-size: 13px;
                padding: 0;
            }

            .qna-delete-btn:hover {
                color: #d32f2f;
                text-decoration: none;
            }


            .qna-block.pending {
                background-color: #fcfcfc;
                border-left: 4px solid #7b61ff;
                font-style: italic;
                color: #888;
            }

            /* 배송, 교환, 환불 영역 */
            .policy-section {
                padding: 30px;
                max-width: 1100px;
                margin: 0 auto;
            }

            .policy-grid {
                display: flex;
                flex-wrap: wrap;
                gap: 30px 80px;
                justify-content: space-between;
            }

            .policy-box {
                flex: 1 1 45%;
                min-width: 280px;
                font-size: 15px;
                color: #444;
                line-height: 1.7;
            }

            .policy-box h3 {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #222;
            }

            /* 페이징 */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                margin-top: 30px;
            }

            .pagination a {
                text-decoration: none;
                color: #333;
                font-weight: bold;
                padding: 4px 8px;
                border: none;
                border-radius: 0;
                background: none;
                font-size: 15px;
            }

            .pagination a.active {
                color: #000;
                font-weight: 900;
                text-decoration: none;
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
            }

            @media (max-width: 768px) {

                .buy-btn1,
                .buy-btn2 {
                    width: 100%;
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
                    <template v-if="info && info.filePath">
                        <img :src="info.filePath" alt="info.fileName" id="mainImage">
                    </template>
                    <template v-else>
                        <img src="../../img/product/product update.png" alt="이미지 없음">
                    </template>
                    <div class="product-image-thumbNails">
                        <img v-for="(img, index) in imgList" :src="img.filePath" alt="상품 썸네일"
                            @click="changeImage(img.filePath)">
                    </div>
                </div>
                <div class="product-info">
                    <hr>
                    <h1>{{info.productName}}</h1>
                    <!-- 정상가 (할인 전 가격) -->
                    <div class="detail-product-info">
                        <p class="original-price"  v-if="info.discount > 0">
                            정상가: {{ info.price }}원
                        </p>
                        <!-- 멤버십 할인가 -->
                        <p class="discount-price">
                            멤버십 할인가:
                            <strong>{{ discountedPrice}}원</strong>
                            <span v-if="userInfo.membershipFlg !== 'Y'" ></span>
                        </p>
                    </div>
                    <p>제조사 : {{ info.manufacturer }}</p>
                    <p>배송비 : {{ info.shippingFee }}원</p>
                    <div v-if="info.shippingFreeMinimum" class="shipping-note">
                        ({{ info.shippingFreeMinimum }}원 이상 주문 시 무료배송)
                    </div>
                    <p>상품코드 : {{ info.productCode }}</p>
                    <hr>

                    <div class="purchase-section">
                        <!-- 수량 선택 화면 (선택 전만 보임) -->
                        <div v-if="!isSelected" class="qty-box">
                            <span>수량</span>
                            <div class="qty-controller">
                                <button @click="decreaseQty" class="qty-btn">-</button>
                                <input type="text" :value="quantity" readonly class="qty-input" />
                                <button @click="increaseQty" class="qty-btn">+</button>
                            </div>
                            <button @click="confirmQuantity" class="select-btn">선택</button>
                        </div>

                        <div v-if="isSelected">
                            <div class="confirmed-box">
                                <div class="confirmed-header">
                                    <span class="product-name">{{ info.productName }}</span>
                                    <button class="remove-btn" @click="cancelSelection">X</button>
                                </div>
                                <div class="qty-controller">
                                    <button @click="decreaseQty" class="qty-btn">-</button>
                                    <input type="text" :value="quantity" readonly class="qty-input" />
                                    <button @click="increaseQty" class="qty-btn">+</button>
                                </div>
                            </div>

                            <div class="price-display">
                                <strong>총 결제 금액 : {{ formattedPrice }}원</strong>
                            </div>
                        </div>

                        <div class="action-buttons">
                            <button class="cart-btn" @click="fnAddCart()">장바구니</button>
                            <button class="buy-btn" @click="fnBuy()">구매하기</button>
                        </div>
            </section>

            <!-- 상세 설명 -->
            <section class="notice-section">
                <h2>NOTICE</h2>
                <div class="notice-badge">★ 배송 전 주문 취소 ★</div>
                <p>
                    평일 오후 4시 이후 주문건은 당일 출고에 해당되지 않아<br>
                    다음날 배송 지연으로 인한 취소가 불가하며,<br>
                    반품 신청 시 배송비가 부과됩니다.
                </p>
                <p class="sub-text">
                    *금요일 오후 4시 이후 주문건은 월요일 발송됩니다.
                </p>
                <p>
                    또한 운송장 번호가 확인되는 상태에서는<br>
                    상품이 택배사에 전달된 상태로 취소/변경이 어려우니 양해 부탁드립니다.
                </p>
                <p class="sub-text">
                    *택배사 전달 이후 요청 시 반품 비용으로 왕복 배송비가 발생됩니다.
                </p>
                <hr style="margin-bottom: 10px;">
            </section>
            <!-- 안내 -->
            <section class="notice-section2">
                <div class="notice-badge">★ [안내] ★</div>
                <p>
                    동일한 제품도 상황에 따라<br>
                    사료 알갱이 및 습식 제품의 색상의 차이가 있을 수 있습니다.<br>
                    해당 사유로 인한 교환 및 반품은 불가능합니다.
                </p>
                <img src="../../img/product/event.jpg" alt="사은품 증정">
            </section>
            <!-- 탭 UI -->
            <section id="tab-area" class="tab-wrapper">
                <div class="tab-menu">
                    <div v-for="tab in tabs" :key="tab.id" :class="['tab-item', { active: activeTab === tab.id }]"
                        @click="changeTab(tab.id)">
                        {{ tab.label }} {{ tab.cmtcount }}
                    </div>
                </div>

                <div class="tab-content">
                    <!-- 상품 상세정보 -->
                    <div v-if="activeTab === 'detail'">
                        <div v-html="info.description"></div>
                    </div>
                    <!-- 상품 리뷰 -->
                    <div v-else-if="activeTab === 'review'" class="review-section">
                        <div class="review-header">
                            <h3>REVIEW</h3>
                            <div class="review-buttons">
                                <button class="btn" @click="fnReviewWtite()">글쓰기</button>
                            </div>
                        </div>

                        <div v-if="reviewList.length === 0" class="review-empty">
                            현재 게시물이 없습니다
                        </div>
                        
                            <div class="review-card" v-for="review in reviewList" :key="review.reviewId">
                            <!-- 삭제된 리뷰일 경우 -->
                            <div v-if="review.deleteYn === 'Y'" class="review-deleted-content">
                                <p class="review-text">삭제된 리뷰입니다.</p>
                            </div>
                            <div v-else>

                                <div class="review-card-header">
                                    <div class="review-left">
                                        <div class="star-rating">
                                          <span v-for="n in 5" :key="n" class="star" :class="{ filled: n <= review.rating }">★</span>
                                        </div>
                                        <span class="review-user-id">[{{ review.userId }}]</span>
                                        <span class="rating-text">{{ review.rating ?? 0 }} / 5</span>
                                    </div>
                                </div>
                                <div class="review-card-body">
                                    <h4 class="review-title" v-if="review.title">{{ review.title }}</h4>
                                    <p class="review-text" v-html="review.reviewText"></p>
                                    <div v-if="review.filePath" class="review-image">
                                        <img :src="review.filePath" alt="리뷰 이미지">
                                    </div>
                                </div>
                                <div class="review-card-footer">
                                    <div class="review-helpful">
                                        <button @click="markHelpful(review.reviewId)">도움돼요 👍</button>
                                        <span>{{ review.helpCnt || 0 }}명에게 도움이 되었어요</span>
                                    </div>
                                    <div class="review-actions" v-if="sessionId && sessionId === review.userId">
                                        <button @click.stop="fnEdit(review.reviewId)">수정</button>
                                        <button @click.stop="fnDelete(review.reviewId)">삭제</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="pagination" style="margin-top: 30px;">
                            <a href="javascript:;" v-if="reviewPage > 1" @click="fnReviewPageMove('prev')"> &lt; </a>

                            <a href="javascript:;" v-for="num in reviewPages" :key="num" @click="fnReviewPage(num)"
                                :class="{ active: reviewPage === num }">
                                <span v-if="reviewPage === num">{{ num }}</span>
                                <span v-else>{{ num }}</span>
                            </a>
                            <a href="javascript:;" v-if="reviewPage < reviewPages.length"
                                @click="fnReviewPageMove('next')"> &gt; </a>
                        </div>
                    </div>

                    <!-- 상품 문의 -->
                    <div v-else-if="activeTab === 'qna'" class="qna-section">
                        <div class="qna-header-container">
                            <div class="qna-title-area">
                                <h3>상품문의</h3>
                                <ul class="qna-notice">
                                    <li>구매한 상품의 <strong>취소/반품은 멍냥꽁냥 구매내역</strong>에서 신청 가능합니다.</li>
                                    <li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
                                    <li>해당 상품 자체와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수
                                        있습니다.</li>
                                    <li>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
                                </ul>
                            </div>
                            <div class="qna-write-btn">
                                <button class="btn-outline-purple" @click="fnQna()">문의하기</button>
                            </div>
                        </div>

                        <div v-if="qnaList.length === 0" class="qna-empty">
                            등록된 Q&A가 없습니다.
                        </div>

                        <div v-else class="qna-list">
                            <div class="qna-item" v-for="qna in qnaList" :key="qna.qnaId">
                                <div class="qna-block question">
                                    <div class="qna-label">
                                        질문 <span class="qna-user-id">[{{ qna.userId }}]</span>
                                    </div>
                                    <!-- <h5 class="qna-title" v-if="qna.title">{{ qna.title }}</h5> -->
                                    <div class="qna-text" v-html="qna.questionText"></div>
                                    <div class="qna-info">
                                        <span class="qna-date">{{ qna.createdAt }}</span>
                                        <button v-if="qna.userId === sessionId" @click="fnQnaEdit(qna.qnaId)" class="qna-delete-btn">수정</button>
                                        <button v-if="qna.userId === sessionId" @click="fnQnaDelete(qna.qnaId)" class="qna-delete-btn">삭제</button>
                                    </div>
                                </div>
                                
                                <!-- 답변 있을 경우 -->
                                <div class="qna-block answer" v-if="qna.answerText">
                                    <div class="qna-label answer-label"> ⤷ 답변 [멍냥꽁냥 관리자]</div>
                                    <div class="qna-text" v-html="qna.answerText"></div>
                                    <div class="qna-info">
                                        <span class="qna-date">{{ qna.answeredAt }}</span>
                                    </div>
                                </div>
                                <!-- 답변이 없는 경우 -->
                                <div class="qna-block answer pending" v-else>
                                    <div class="qna-label answer-label">⤷ 답변 [멍냥꽁냥 관리자]</div>
                                    <div class="qna-text">관리자가 답변을 준비 중입니다.</div>
                                </div>
                            </div>
                            <div class="pagination" style="margin-top: 30px;">
                                <a href="javascript:;" v-if="qnaPage > 1" @click="fnQnaPageMove('prev')">&lt;</a>
                                <a href="javascript:;" v-for="num in qnaPages" :key="num"
                                   @click="fnQnaPage(num)" :class="{ active: qnaPage === num }">
                                  <span v-if="qnaPage === num">{{ num }}</span>
                                  <span v-else>{{ num }}</span>
                                </a> 
                                <a href="javascript:;" v-if="qnaPage < qnaPages.length"
                                   @click="fnQnaPageMove('next')">&gt;</a>
                              </div>
                        </div>
                    </div>
                    <!-- 배송, 교환, 환불 설명 -->
                    <div v-else-if="activeTab === 'policy'" class="policy-section">
                        <div class="policy-grid">
                            <div class="policy-box">
                                <h3>PAYMENT INFO</h3>
                                <p>
                                    고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수 있습니다.<br>
                                    확인 과정에서 도난 카드의 사용이나 타인의 명의의 주문등 정상적인 주문이 아니라고 판단될 경우<br>
                                    임의로 주문을 보류 또는 취소할 수 있습니다.
                                </p>
                                <p>
                                    무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹,텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.
                                </p>
                                <p>
                                    주문시 입력한 입금자명과 실제입금자의 성며이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며<br>
                                    입금되지 않은 주문은 자동취소 됩니다.
                                </p>
                            </div>
                            <div class="policy-box">
                                <h3>DELIVERY INFO</h3>
                                <p>
                                    배송 방법 : 택배<br>
                                    배송 지역 : 전국지역<br>
                                    배송 비용 : 2000원<br>
                                    배송 기간 : 2일 ~ 5일<br>
                                    배송 안내 : 산간벽지나 도서지방은 별도의 추가금액이 발생할 수 있습니다.
                                </p>
                            </div>
                            <div class="policy-box">
                                <h3>EXCHANGE INFO</h3>
                                <p>
                                    <strong>교환 및 반품 주소</strong><br>
                                    [10246] 인천광역시 부평구 경원대로 1366, [스테이션타워 7층] 멍냥꽁냥<br><br>

                                    <strong>교환 및 반품이 가능한 경우</strong><br>
                                    - 계약내용에 관한 서면을 받은 날부터 7일 이내<br>
                                    - 공급받은 상품 및 용역의 내용이 표시/광고 내용과 다를 경우<br><br>

                                    <strong>교환 및 반품이 불가능한 경우</strong><br>
                                    - 소비자에게 책임이 있는 사유<br>
                                    - 시간 경과에 의해 재판매가 곤란한 경우 등
                                </p>
                            </div>
                            <div class="policy-box">
                                <h3>SERVICE INFO</h3>
                                <p>
                                    - 고객센터: 1234-5678<br>
                                    - 운영시간: 평일 09:00 ~ 18:00 (점심시간 12:00 ~ 13:00)<br>
                                    - 토/일/공휴일 휴무
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </body>

    </html>
    <script>


        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        productId: "",
                        sessionId: "${sessionId}",
                        userInfo: {
                            "membershipFlg": "Y"
                        }, //사용자 정보 가져오기
                        info: {},
                        imgList: [],
                        mainImage: '',
                        quantity: 1,
                        isSelected: false,
                        selectedReviewId: null,
                        alreadyClicked: {},

                        //탭 관련
                        tabs: [
                            { id: 'detail', label: '상세정보', cmtcount: "" },
                            { id: 'review', label: '상품후기 ', cmtcount: 0 },
                            { id: 'qna', label: '상품문의 ', cmtcount: "" },
                            { id: 'policy', label: '배송/교환/환불 안내', cmtcount: "" }
                        ],
                        activeTab: 'detail',

                        //상품 리뷰 페이징
                        reviewList: [],
                        reviewPage: 1,
                        reviewPageSize: 5,
                        reviewTotal: 0,
                        reviewPages: [],
                        deleteYn: "Y",

                        // 상품 문의..
                        qnaList: [],
                        qnaPage: 1,
                        qnaPageSize: 5,
                        qnaTotal: 0,
                        qnaPages: []
                    };
                },
                computed: {
                    // 총 상품 금액 (상품 가격 × 수량)
                    totalProductPrice() {
                        const result = this.info.price * this.quantity;
                        console.log("📦 총 상품 금액:", result);
                        return result;
                    },
                    isFreeShipping() {
                        const condition = this.totalProductPrice >= this.info.shippingFreeMinimum;
                        console.log("🚚 무료배송 조건:", this.totalProductPrice, ">=", this.info.shippingFreeMinimum, "→", condition);
                        return condition;
                    },
                    shippingCost() {
                        const cost = this.isFreeShipping ? 0 : this.info.shippingFee;
                        console.log("💸 배송비 적용:", cost);
                        return cost;
                    },
                    totalPrice() {
                        const total = this.totalProductPrice + this.shippingCost;
                        console.log("💰 총 결제 금액:", total);
                        return total;
                    },
                    formattedPrice() {
                        return this.totalPrice.toLocaleString();
                    },
                    discountedPrice() {
                        return Math.floor(this.info.price * (1 - this.info.discount / 100));
                    }
                },
                methods: {
                    //상품 보여주기
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

                                if (data.result != "success") {
                                    if (this.productId == "") {
                                        alert("상품을 불러올수 없습니다.");
                                        location.href = "/product/list.do";
                                    }
                                }
                                self.info = data.info;
                                self.imgList = data.imgList;
                                self.reviewList = data.reviewList || [];
                                self.mainImage = self.info.filePath || '../../img/product/product update.png';
                            },
                        });
                    },
                    // 클릭된 이미지로 메인 이미지 변경
                    changeImage(filePath) {
                        document.getElementById('mainImage').src = filePath;
                    },
                    //리뷰 보여주기
                    fnReviewList() {
                        const self = this;
                        const nparmap = {
                            productId: self.productId,
                            page: (self.reviewPage - 1) * self.reviewPageSize,
                            pageSize: self.reviewPageSize
                        };
                        $.ajax({
                            url: "/product/reviewList.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log("11", data);
                                self.reviewList = data.reviewList;
                                self.tabs[1].cmtcount = data.totalCount;
                                self.reviewPages = Array.from({ length: Math.ceil(data.totalCount / self.reviewPageSize) }, (_, i) => i + 1);
                            }
                        });
                    },
                    //리뷰 도움체크
                    markHelpful(reviewId) {
                        if (this.alreadyClicked[reviewId]) return;

                        const self = this;
                        $.ajax({
                            url: "/product/reviewHelpCnt.dox",
                            type: "POST",
                            data: { reviewId: reviewId },
                            dataType: "json",
                            success: function (data) {
                                if (data.result === "success") {
                                    alert("리뷰가 도움이 되었다고 표시되었습니다!");
                                    self.fnReviewList();
                                    self.alreadyClicked[reviewId] = true;
                                } else if (data.result === "fail"){
                                    alert(data.message || "이미 추천한 리뷰입니다.");
                                }
                            }
                        });
                    },
                    //상품 리뷰 페이징
                    fnReviewPage(num) {
                        this.reviewPage = num;
                        this.fnReviewList();
                    },
                    fnReviewPageMove(direction) {
                        if (direction === 'prev' && this.reviewPage > 1) {
                            this.reviewPage--;
                        } else if (direction === 'next' && this.reviewPage < this.reviewPages.length) {
                            this.reviewPage++;
                        }
                        this.fnReviewList();
                    },
                    //상품 리뷰 글쓰기
                    fnReviewWtite: function () {
                        let self = this;
                        if (!self.sessionId || self.sessionId === "") {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do"; // ← 로그인 페이지 경로
                            return;
                        }
                        location.href = "/product/review.do?productId=" + self.productId;
                    },
                    //개인 리뷰 삭제
                    fnDelete: function (reviewId) {
                        var self = this;
                        if (!confirm("정말 삭제하시겠습니까?")) {
                            return;
                        }
                        var nparmap = {
                            userId: self.sessionId,
                            reviewId: reviewId
                        };
                        $.ajax({
                            url: "/product/reviewRemove.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                if (data.result == "success") {
                                    alert("삭제가 완료되었습니다");
                                    location.href = "/product/view.do?productId=" + self.productId;
                                } else {
                                    alert("삭제에 실패했습니다.");
                                }
                            }
                        });
                    },
                    //개인 리뷰 수정
                    fnEdit: function (reviewId) {
                        let self = this;
                        location.href = "/product/reviewEdit.do?productId=" + self.productId + "&reviewId=" + reviewId;
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
                    //장바구니
                    fnAddCart() {
                        const self = this;
                        const priceToAdd = self.userInfo.membershipFlg === 'Y'? self.discountedPrice : self.info.price;

                        const nparmap = {
                            productId: self.productId,
                            sessionId: self.sessionId,
                            userId: self.userInfo.userId,
                            quantity: self.quantity,
                            price: priceToAdd,
                            option : "",
                            checkYn: "N"
                        };
                        $.ajax({
                            url: "/cart/addProduct.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                alert("장바구니에 상품이 담겼습니다.");
                            }
                        });
                    },
                    //선택한 상품만 장바구니로
                    fnBuy: function () {
                        const self = this;
                        const nparmap = {
                            userId: self.userInfo.userId,
                            checkYn: "N"
                        };
                        $.ajax({
                            url: "/cart/AllCheckYn.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                self.fnAddBuy();
                            }
                        });
                    },
                    //선택한 상품을 즉시 구매페이지로
                    fnAddBuy() {
                        const self = this;
                        const priceToAdd = self.userInfo.membershipFlg === 'Y'? self.discountedPrice : self.info.price;
                        const nparmap = {
                            productId: self.productId,
                            sessionId: self.sessionId,
                            userId: self.userInfo.userId,
                            quantity: self.quantity,
                            price: priceToAdd,
                            option : "instant",
                            checkYn: "Y"
                        };
                        $.ajax({
                            url: "/cart/addProduct.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                location.href = "/cart/order.do";
                            }
                        });
                    },
                    changeTab(tabId) {
                        let self = this;
                        self.activeTab = tabId;
                        if (tabId === 'review') {
                            self.fnReviewList();
                        } else if (tabId === 'qna') {
                            self.fnQnaList();
                        }
                    },
                    //수량 감소
                    increaseQty() {
                        this.quantity++;
                    },
                    //수량 증가
                    decreaseQty() {
                        if (this.quantity > 1) {
                            this.quantity--;
                        }
                    },
                    //수량 확인
                    confirmQuantity() {
                        this.isSelected = true;
                        // 필요하면 서버에 확정된 수량 보내기 or 알림 띄우기 가능
                    },
                    cancelSelection() {
                        this.isSelected = false;
                        this.quantity = 1;
                    },
                    //QnA 목록 보여주기
                    fnQnaList() {
                        let self = this;
                        let nparmap = {
                            productId: self.productId,
                            page: (self.qnaPage - 1) * self.qnaPageSize,
                            pageSize: self.qnaPageSize
                        };
                        self.qnaList = [];
                        $.ajax({
                            url: "/product/qnaList.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log("QNA 불러오기 성공:", data);
                                self.qnaList = data.list;
                                self.qnaTotal = data.totalCount;
                                self.qnaPages = Array.from(
                                    { length: Math.ceil(data.totalCount / self.qnaPageSize) },
                                    (_, i) => i + 1
                                );
                                self.tabs[2].cmtcount = data.totalCount;
                            }
                        });
                    },
                    fnQnaPage(num) {
                        this.qnaPage = num;
                        this.fnQnaList();
                    },
                    fnQnaPageMove(direction) {
                        if (direction === 'prev' && this.qnaPage > 1) {
                            this.qnaPage--;
                        } else if (direction === 'next' && this.qnaPage < this.qnaPages.length) {
                            this.qnaPage++;
                        }
                        this.fnQnaList();
                    },
                    //QnA 글쓰기 이동
                    fnQna() {
                        let self = this;
                        if (!self.sessionId || self.sessionId === "") {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do";
                            return;
                        }
                        location.href = "/product/qnawrite.do?productId=" + self.productId;
                    },
                    //QnA 글 삭제
                    fnQnaDelete(qnaId) {
                        if (!confirm("정말 삭제하시겠습니까?")) return;

                        const self = this;
                        $.ajax({
                            url: "/product/qnaDelete.dox",
                            type: "POST",
                            data: {
                                qnaId: qnaId,
                                userId: self.sessionId 
                            },
                            dataType: "json",
                            success: function (data) {
                                if (data.result === "success") {
                                    alert("삭제되었습니다.");
                                    self.fnQnaList(); 
                                } else {
                                    alert(data.message || "삭제에 실패했습니다.");
                                }
                            }
                        });
                    },
                    //QnA 글 수정
                    fnQnaEdit(qnaId) {
                        let self = this;
                        location.href = "/product/qnaEdit.do?qnaId=" + qnaId + "&productId=" + self.productId;
                    }
                },
                mounted() {
                    const params = new URLSearchParams(window.location.search);
                    this.productId = params.get("productId") || "";

                    if (this.productId == "") {
                        alert("상품을 불러올수 없습니다.");
                        location.href = "/product/list.do";
                    }

                    let self = this;
                    self.fnProduct();
                    self.fnReviewList();
                    self.fnUserInfo();
                    self.fnQnaList();
                }
            });

            app.mount("#app");
        });
    </script>