<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 상세보기</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <link rel="stylesheet" href="/css/product/product.css" />
        <style>
            .product-view p {
                text-align: center;
            }
        </style>
    </head>

    <body>
        <jsp:include page="../common/header.jsp" />
        <div id="app" class="container">
            <div class="breadcrumb-container">
                <div class="breadcrumb" v-if="info.categoryId">
                    <!-- <a href="/">홈</a> / -->
                    <a href="/product/list.do">전체상품</a> /
                    <a href="javascript:;" @click="goToCategory(largeCategory)">{{ largeCategory }}</a> /
                    <a href="javascript:;" @click="goToSubCategory(info.categoryId)">
                        {{ largeCategory + ' ' + subCategory }}
                    </a> /
                    <a>{{ info.productName }}</a>
                </div>
            </div>

            <!-- 상품 상세 정보 -->
            <section class="product-detail">
                <div class="product-image-container">
                    <template v-if="imgList.length > 0">
                        <img :src="currentImage" alt="대표 이미지" id="mainImage">
                    </template>
                    <template v-else>
                        <img src="../../img/product/product update.png" alt="이미지 없음">
                    </template>

                    <div class="product-image-thumbNails" id="thumbnailScroll">
                        <img v-for="(img, index) in imgList" :key="index" :src="img.filePath" alt="상품 썸네일"
                            @click="changeImage(img.filePath)" :class="{ active: index === currentImageIndex }"
                            draggable="false">
                    </div>
                </div>
                <div class="product-info">
                    <hr>
                    <h1>{{info.productName}}</h1>
                    <!-- 정상가 (할인 전 가격) -->
                    <div class="detail-product-info">
                        <p class="original-price" v-if="info.discount > 0">
                            정상가: {{ formatPrice(info.price) }}원
                        </p>
                        <!-- 멤버십 할인가 -->
                        <p class="discount-price">
                            멤버십 할인가:
                            <strong>{{ formatPrice(discountedPrice)}}원</strong>
                            <span v-if="userInfo && userInfo.membershipFlg !== 'Y'"></span>
                        </p>
                    </div>
                    <p class="product-avg-rating">
                        평균 별점 :
                        <span class="stars-inline">
                            <span v-for="n in 5" :key="n" class="star" :class="getStarClass(n)">★</span>
                        </span>
                        <span v-if="averageRating > 0" class="rating-number"> ({{ averageRating }} / 5)</span>
                        <span v-else class="rating-number">별점 없음</span>
                    </p>


                    <p>제조사 : {{ info.manufacturer }}</p>
                    <p>상품코드 : {{ info.productCode }}</p>
                    <p>배송비 : {{ info.shippingFee }}원</p>
                    <div v-if="info.shippingFreeMinimum" class="shipping-note">
                        ({{ info.shippingFreeMinimum }}원 이상 주문 시 무료배송)
                    </div>
                    <p>(최소 주문수량 1개 이상)</p>
                    <p>배송 지역 : 전국 배송 가능</p>
                    <p>배송 기간 : 결제 완료 후 2~3일 이내 출고 (주말/공휴일 제외)</p>
                    <hr>

                    <div class="purchase-section">
                        <!-- 수량 조절 -->
                        <div class="qty-box">
                            <span>수량</span>
                            <div class="qty-controller">
                                <button @click="decreaseQty" class="qty-btn" :disabled="quantity === 0">-</button>
                                <input type="text" :value="quantity" readonly class="qty-input" />
                                <button @click="increaseQty" class="qty-btn">+</button>
                            </div>
                        </div>

                        <!-- ✅ 수량이 1개 이상일 때만 표시 -->
                        <div class="price-info" v-if="quantity >= 1">
                            <p><strong>선택 수량:</strong> {{ quantity }}개</p>
                            <p><strong>상품 단가:</strong> {{ formatPrice(priceToAdd) }}원</p>
                            <p><strong>배송비:</strong> {{ isFreeShipping ? '무료' : formatPrice(shippingCost) + '원' }}</p>
                            <p><strong>총 결제 금액:</strong> {{ formattedPrice }}원</p>
                        </div>

                        <!-- 장바구니 / 구매 버튼 -->
                        <div class="action-buttons">
                            <button class="cart-btn" @click="fnAddCart()">장바구니</button>
                            <button class="buy-btn" @click="fnBuy()">구매하기</button>
                        </div>
                    </div>


            </section>
            <hr style="margin-top: 70px;">
            <!-- 상세 설명 -->
            <section class="notice-section">
                <h2>📘 멍냥꽁냥 이용 가이드</h2>
                <p class="sub-title">제품 특성, 배송 안내, 사은품 등 구매 전 알아두면 좋은 정보들을 안내드립니다.</p>
                <!-- 멤버십 관련 -->
                <section class="vip-membership-section">
                    <div class="vip-header">
                        <p class="vip-subtitle">🎁 멤버십 혜택 안내</p>
                        <h2>
                            반려인을 위한 프리미엄 혜택,<br>
                            <span>멍냥꽁냥 멤버십</span>으로 누리세요
                        </h2>
                        <p class="vip-description">
                            단순한 할인 그 이상! <strong>멤버십 할인 / 매월 자동 기부 / 포인트 지급</strong>까지<br>
                            반려 생활에 필요한 모든 혜택을 한 번에 제공합니다.
                        </p>
                    </div>
                    <div class="vip-benefit-cards">
                        <div class="vip-card">
                            <h4>💸 전상품 멤버십 할인가 적용</h4>
                            <p>멤버십 회원은 항상 <strong>할인된 가격</strong>으로 구매 가능합니다</p>
                        </div>
                        <div class="vip-card">
                            <h4>🌱 매월 자동 반려동물 후원</h4>
                            <p>회원님의 이름으로 <strong>매달 일정 금액을 유기동물 보호소에 기부</strong>합니다</p>
                        </div>
                        <div class="vip-card">
                            <h4>🎉 매월 5000포인트 지급</h4>
                            <p><strong>포인트 5000P</strong>를 매달 자동으로 받아 쇼핑몰과 게시판,후원에서 바로 사용하세요</p>
                        </div>
                    </div>
                    <button class="join-btn" @click="MembershipJoin">지금 멤버십 가입하기</button>
                </section>
                <hr style="margin-bottom: 70px;">
            </section>
            <!-- 탭 UI -->
            <div class="tab-menu">
                <div v-for="tab in tabs" :key="tab.id" :class="['tab-item', { active: activeTab === tab.id }]"
                    @click="changeTab(tab.id)">
                    {{ tab.label }} {{ tab.cmtcount }}
                </div>
            </div>
            <div class="tab-content">
                <!-- 상품 상세정보 -->
                <div v-if="activeTab === 'detail'">
                    <!-- 배송 관련 -->
                    <section class="shipping-warning-section">
                        <div class="vip-subtitle">🚛 배송 및 주문 관련 안내</div>
                        <h2 class="warning-title">꼭 확인해주세요!</h2>
                        <p class="warning-desc">정확한 배송과 원활한 쇼핑을 위해 아래 내용을 사전에 꼭 확인 부탁드립니다.</p>

                        <div class="warning-cards">
                            <div class="warning-card">
                                <h4>⏰ 평일 오후 4시 이후 주문</h4>
                                <p>
                                    오후 4시 이후 주문 건은 당일 출고가 어려우며,<br>
                                    다음 날 출고로 지연됩니다. 이로 인한 <strong>단순 변심 취소는 불가</strong>합니다.
                                </p>
                            </div>

                            <div class="warning-card">
                                <h4>📦 운송장 발급 후 취소 불가</h4>
                                <p>
                                    운송장 발급 및 택배사 인계 후에는 <strong>취소 또는 변경이 불가</strong>합니다.<br>
                                    반품 시 <strong>왕복 배송비가 부과</strong>되오니, 신중한 구매 부탁드립니다.
                                </p>
                                <p class="sub-text">※ 금요일 오후 4시 이후 주문은 월요일부터 순차 출고됩니다.</p>
                            </div>
                        </div>
                    </section>

                    <div class="product-view" v-html="info.description"></div>

                    <hr style="margin-top: 40px;">


                    <!--제품 안내 -->
                    <section class="product-info-section">
                        <div class="product-info-header">
                            <p class="vip-subtitle">📢 제품 관련 안내</p>
                            <h2>정확한 이해를 위한 제품 특성 및 주의사항 안내</h2>
                            <p class="info-desc">
                                멍냥꽁냥에서 판매하는 모든 제품은 고객님의 소중한 반려동물을 위한 상품으로,<br>
                                아래 내용을 충분히 숙지하신 후 구매해주시기 바랍니다.
                            </p>
                        </div>
                        <div class="product-info-card">
                            <p>
                                ✅ 본 제품은 제조 시기 및 생산 공정에 따라 <strong>알갱이의 색상, 크기, 모양</strong> 등에 약간의 차이가 발생할 수 있습니다.<br>
                                이는 원재료 수급 및 공정 조건에 따른 <strong>정상적인 현상</strong>이며, 제품의 품질에는 영향을 미치지 않습니다.
                            </p>

                            <p>
                                ✅ 일부 제품(특히 습식, 파우치 제품)의 경우, 내용물의 <strong>점도 및 색상</strong>이 계절 또는 보관 상태에 따라 달라질 수
                                있습니다.<br>
                                해당 사항은 제품 이상이 아니며, 반품 또는 교환의 사유가 되지 않습니다.
                            </p>

                            <p>
                                ✅ 제품에 포함된 주원료(예: 닭고기, 곡물, 유제품 등)에 따라 <strong>알러지 반응</strong>이 나타날 수 있습니다.<br>
                                반려동물에게 특이체질 또는 과거 알러지 반응 이력이 있다면, 반드시 성분표 확인 후 급여해주세요.
                            </p>

                            <p>
                                ✅ 급여 후 <strong>소화불량, 묽은 변, 식욕 저하</strong> 등의 이상 반응이 있을 경우 급여를 중단하고 수의사 상담을 권장드립니다.
                            </p>

                            <p>
                                ✅ 개봉 후 제품은 밀봉하여 직사광선을 피하고 <strong>서늘하고 건조한 곳</strong>에 보관해주세요.<br>
                                특히 습식 제품은 <strong>냉장 보관 후 빠른 시일 내에 사용</strong> 바랍니다.
                            </p>

                            <p>
                                ✅ 제품 유통기한은 제조일로부터 충분한 여유가 있는 상품으로 출고되며,<br>
                                이벤트나 할인 상품은 상대적으로 유통기한이 짧을 수 있습니다.
                            </p>

                            <p>
                                ✅ 제품 이상이 의심되는 경우 수령 즉시 고객센터로 연락주시면 <strong>신속히 확인 및 대응</strong> 드리겠습니다.
                            </p>

                            <p class="sub-text">
                                ※ 본 안내는 공통 적용되는 사항이며, 각 상품별 추가 상세 정보는 상품 페이지 하단 또는 고객센터를 통해 확인하실 수 있습니다.
                            </p>
                        </div>
                    </section>
                    <hr style="margin-top: 40px;">
                    <section class="event-gift-section">
                        <div class="event-gift-wrap">
                            <div class="event-gift-img">
                                <img src="../../img/product/eventProduct1.png" alt="이벤트 사은품" />
                            </div>
                            <div class="event-gift-text">
                                <h3>🎁 지금 구매 시 특별 사은품 증정!</h3>
                                <p><strong>멍냥꽁냥 회원을 위한 한정 이벤트!</strong></p>
                                <ul>
                                    <li>✔ 이벤트 대상 상품 구매 시 자동 증정</li>
                                    <li>✔ 수량 한정, 조기 소진 시 종료</li>
                                    <li>✔ 교환/반품 불가 · 종류 랜덤</li>
                                    <li>✔ 2025.04.01 ~ 소진 시까지</li>
                                </ul>
                            </div>
                        </div>
                    </section>

                </div>
                <!-- 상품 리뷰 -->
                <div v-else-if="activeTab === 'review'" class="review-section">
                    <!-- ⭐ 리뷰 요약 통계 먼저 -->
                    <div class="review-summary-box" v-if="tabs[1].cmtcount > 0">
                        <div class="avg-score">
                            <div class="score">{{ averageRating }}</div>
                            <div class="stars">
                                <span class="star-rating">
                                    <span v-for="n in 5" :key="n" class="star" :class="getStarClass(n)">★</span>
                                </span>
                            </div>
                        </div>

                        <div class="score-bars">
                            <div v-for="i in [5, 4, 3, 2, 1]" :key="i" class="bar-row">
                                <span class="label">{{ i }}점</span>
                                <div class="bar-track">
                                    <div class="bar-fill" :style="{ width: getBarWidth(i) + '%' }"></div>
                                </div>
                                <span class="count">{{ scoreCounts[i] || 0 }}</span>
                            </div>
                        </div>
                    </div>
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
                                        <span v-for="n in 5" :key="n" class="star"
                                            :class="{ filled: n <= review.rating }">★</span>
                                    </div>
                                    <span class="review-user-id">[{{ review.userId }}]</span>
                                    <span class="rating-text">{{ review.rating ?? 0 }} / 5</span>
                                </div>
                            </div>
                            <div class="review-card-body">
                                <h4 class="review-title" v-if="review.title">{{ review.title }}</h4>
                                <p class="review-text" v-html="review.reviewText"></p>
								<div v-for="fileList in review.Reviews" class="review-image">
	                                    <img v-if="fileList.filePath" :src="fileList.filePath" alt="리뷰 이미지">
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
                        <a href="javascript:;" v-if="reviewPage < reviewPages.length" @click="fnReviewPageMove('next')">
                            &gt; </a>
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
                        <div class="qna-item" v-for="qna in qnaList" :key="qna.qnaId"  :id="'comment-' + qna.qnaId" >
                            <div class="qna-block question">
                                <div class="qna-label">
                                    질문 <span class="qna-user-id">[{{ qna.userId }}]</span>
                                </div>
                                <div class="qna-text" v-html="qna.questionText"></div>
                                <div class="qna-info">
                                    <span class="qna-date">{{ qna.createdAt }}</span>
                                    <button v-if="qna.userId === sessionId" @click="fnQnaEdit(qna.qnaId)"
                                        class="qna-delete-btn">수정</button>
                                    <button v-if="qna.userId === sessionId" @click="fnQnaDelete(qna.qnaId)"
                                        class="qna-delete-btn">삭제</button>
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
                            <a href="javascript:;" v-for="num in qnaPages" :key="num" @click="fnQnaPage(num)"
                                :class="{ active: qnaPage === num }">
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
                            "membershipFlg": "N",
                            userId: ""
                        }, //사용자 정보 가져오기
                        info: {},
                        imgList: [],
                        mainImage: '',
                        quantity: 0,
                        isSelected: false,
                        selectedReviewId: null,
                        alreadyClicked: {},
                        averageRating: 0,
                        currentImageIndex: 0,
                        // autoSlideInterval: null,

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
                        allReviews: [], // 전체 리뷰 저장용

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
                        return result;
                    },
                    isFreeShipping() {
                        const condition = this.totalProductPrice >= this.info.shippingFreeMinimum;
                        return condition;
                    },
                    shippingCost() {
                        const cost = this.isFreeShipping ? 0 : this.info.shippingFee;
                        return cost;
                    },
                    totalPrice() {
                        const total = this.totalProductPrice + this.shippingCost;
                        return total;
                    },
                    formattedPrice() {
                        return this.totalPrice.toLocaleString();
                    },
                    discountedPrice() {
                        return Math.floor(this.info.price * (1 - this.info.discount / 100));
                    },
                    categoryParts() {
                        if (!this.info.categoryId) return [];
                        return this.info.categoryId.split(',');
                    },
                    largeCategory() {
                        return this.categoryParts[0] || '';
                    },
                    subCategory() {
                        return this.categoryParts[1] || '';
                    },
                    breadcrumbState() {
                        if (!this.info || !this.info.categoryId) {
                            return "all";  // 전체상품용
                        }
                        return "categorized";  // 카테고리 있음
                    },
                    searchOptionFromCategory() {
                        switch (this.largeCategory) {
                            case '강아지':
                                return 'dog';
                            case '고양이':
                                return 'cat';
                            case '영양제':
                                return 'pet';
                            default:
                                return 'all';
                        }
                    },
                    currentImage() {
                        return this.imgList.length > 0 ? this.imgList[this.currentImageIndex].filePath : '';
                    },
                    priceToAdd() {
                        return this.userInfo.membershipFlg === 'Y' ? this.discountedPrice : this.info.price;
                    },
                    scoreCounts() {
                        const counts = { 0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 }; // ✅ 0점 포함
                        this.allReviews.forEach(r => {
                            const rate = Number(r.rating);
                            if (rate >= 0 && rate <= 5 && r.deleteYn !== 'Y') {
                                counts[rate]++;
                            }
                        });
                        return counts;
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
                                if (data.result !== "success" || !data.info) {
                                    alert("상품을 불러올 수 없습니다.");
                                    location.href = "/product/list.do";
                                    return;
                                }
								
                                self.info = data.info;
                                self.imgList = data.imgList;
                                self.reviewList = data.reviewList || [];

                                // 썸네일 Y인 이미지가 있으면 제일 앞으로 정렬
                                const thumbnailIndex = self.imgList.findIndex(img => img.thumbNail === 'Y');
                                if (thumbnailIndex > -1) {
                                    const thumbnailImage = self.imgList.splice(thumbnailIndex, 1)[0];
                                    self.imgList.unshift(thumbnailImage); // 맨 앞에 넣기
                                    self.currentImageIndex = 0;
                                } else {
                                    self.currentImageIndex = 0;
                                }

                                // self.mainImage = self.info.filePath || '../../img/product/product update.png';
                                self.imgList.push({ filePath: "../../img/product/Official Product.jpg" });
                            },
                            error: function () {
                                alert("상품 정보를 불러오는 중 오류가 발생했습니다.");
                                location.href = "/product/list.do";
                            }
                        });
                    },
                    goToCategory() {
                        let self = this;
                        localStorage.removeItem("page");
                        location.href = "/product/list.do?searchOption=" + self.searchOptionFromCategory;
                    },
                    goToSubCategory() {
                        let self = this;
                        var category = this.largeCategory;
                        var subcategory = self.subCategory;
                        localStorage.removeItem("page");
                        if (category && subcategory) {
                            location.href = "/product/list.do?searchOption=" + this.searchOptionFromCategory + "&keyword=" + subcategory;
                        } else {
                            alert("카테고리 정보가 부족합니다.");
                        }
                    },
                    // 클릭된 이미지로 메인 이미지 변경
                    changeImage(filePath) {
                        const index = this.imgList.findIndex(img => img.filePath === filePath);
                        if (index !== -1) {
                            this.currentImageIndex = index;

                            this.$nextTick(() => {
                                const thumbnails = document.querySelectorAll("#thumbnailScroll img");
                                if (thumbnails[index]) {
                                    thumbnails[index].scrollIntoView({ behavior: "smooth", inline: "center", block: "nearest" });
                                }
                            });
                        }
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
								
                                self.reviewList = data.reviewList;
                                self.tabs[1].cmtcount = data.totalCount;
                                self.reviewPages = Array.from({ length: Math.ceil(data.totalCount / self.reviewPageSize) }, (_, i) => i + 1);

                            }
                        });
                    },
                    //별점
                    getStarClass(index) {
                        const rating = Number(this.averageRating);
                        if (rating >= index) return "filled";
                        if (rating >= index - 0.5) return "half";
                        return "";
                    },

                    //리뷰 도움체크
                    markHelpful(reviewId) {
                        const self = this;
                        if (!self.sessionId || self.sessionId === "") {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do";
                            return;
                        }
                        if (this.alreadyClicked[reviewId]) return;

                        $.ajax({
                            url: "/product/reviewHelpCnt.dox",
                            type: "POST",
                            data: { 
                                reviewId: reviewId,
                                userId : self.sessionId
                            },
                            dataType: "json",
                            success: function (data) {
                                if (data.result === "success") {
                                    alert("리뷰가 도움이 되었다고 표시되었습니다!");
                                    self.fnReviewList();
                                    self.alreadyClicked[reviewId] = true;
                                } else if (data.result === "fail") {
                                    alert(data.message || "이미 추천한 리뷰입니다.");
                                }
                            }
                        });
                    },
                    //상품 리뷰 페이징
                    fnReviewPage(num) {
                        this.reviewPage = num;
                        this.fnReviewList();
                        this.scrollToReviewSection();
                    },
                    fnReviewPageMove(direction) {
                        if (direction === 'prev' && this.reviewPage > 1) {
                            this.reviewPage--;
                        } else if (direction === 'next' && this.reviewPage < this.reviewPages.length) {
                            this.reviewPage++;
                        }
                        this.fnReviewList();
                        this.scrollToReviewSection();
                    },
                    scrollToReviewSection() {
                        this.$nextTick(() => {
                            const section = document.querySelector(".review-section");
                            if (section) {
                                const offset = section.offsetTop - 100; // 필요에 따라 여백 조절
                                window.scrollTo({ top: offset, behavior: "smooth" });
                            }
                        });
                    },
                    //상품 리뷰 글쓰기
                    fnReviewWtite: function () {
                        let self = this;
                        if (!self.sessionId || self.sessionId === "") {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do";
                            return;
                        }
                        const nparmap = {
                            userId: self.sessionId,
                            productId: self.productId
                        };
                        $.ajax({
                            url: "/product/checkPurchase.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                //구매한 사람만 리뷰 가능
                                if (data.result === "success" && data.purchased === "Y") {
                                    location.href = "/product/review.do?productId=" + self.productId;
                                } else {
                                    alert("해당 상품을 구매한 사용자만 리뷰를 작성할 수 있습니다.");
                                }
                            },
                            error: function () {
                                alert("서버와 통신 중 오류가 발생했습니다.");
                            }
                        });
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
                        var nparmap = {
                            userId: self.sessionId
                        };
                        $.ajax({
                            url: "/user/info.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.userInfo = data.user;
                            }
                        });
                    },
                    //장바구니
                    fnAddCart() {
                        const self = this;
                        if (!self.sessionId || !self.userInfo || !self.userInfo.userId) {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do";
                            return;
                        }
                        if (self.quantity === 0) {
                            alert("수량을 선택해주세요.");
                            return;
                        }
                        const nparmap = {
                            productId: self.productId,
                            sessionId: self.sessionId,
                            userId: self.userInfo.userId,
                            quantity: self.quantity,
                            price: self.priceToAdd,
                            option: "",
                            checkYn: "N"
                        };
                        $.ajax({
                            url: "/cart/addProduct.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                alert("장바구니에 상품이 담겼습니다.");
                            }
                        });
                    },
                    //선택한 상품만 장바구니로
                    fnBuy: function () {
                        const self = this;
                        if (!self.sessionId || !self.userInfo || !self.userInfo.userId) {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do";
                            return;
                        }
                        if (self.quantity === 0) {
                            alert("수량을 선택해주세요.");
                            return;
                        }
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
                                self.fnAddBuy();
                            }
                        });
                    },
                    //선택한 상품을 즉시 구매페이지로
                    fnAddBuy() {
                        const self = this;
                        if (!self.sessionId || !self.userInfo || !self.userInfo.userId) {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do";
                            return;
                        }
                        if (self.quantity === 0) {
                            alert("수량을 선택해주세요.");
                            return;
                        }
                        const nparmap = {
                            productId: self.productId,
                            sessionId: self.sessionId,
                            userId: self.userInfo.userId,
                            quantity: self.quantity,
                            price: self.priceToAdd,
                            option: "instant",
                            checkYn: "Y"
                        };
                        $.ajax({
                            url: "/cart/addProduct.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
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
                        if (this.quantity > 0) {
                            this.quantity--;
                        }
                    },
                    //수량 확인
                    confirmQuantity() {
                        this.isSelected = true;
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
                    },
                    //멤버십 이동
                    MembershipJoin() {
                        if (!this.sessionId || this.sessionId === "") {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do";
                            return;
                        }
                        location.href = "/membership/main.do";
                    },
                    formatPrice(value) {
                        const num = Number(value);
                        if (isNaN(num)) return '';
                        return num.toLocaleString();
                    },
                    fnAllReviews() {
                        const self = this;
                        $.ajax({
                            url: "/product/reviewList.dox",
                            type: "POST",
                            data: {
                                productId: self.productId,
                                page: 0,
                                pageSize: 9999 // 충분히 큰 수
                            },
                            dataType: "json",
                            success: function (data) {
                                self.allReviews = data.reviewList;

                                // 평균 평점 계산
                                const valid = self.allReviews.filter(r =>
                                    !isNaN(r.rating) && Number(r.rating) >= 0 && r.deleteYn !== 'Y'  // ✅ 0점 포함
                                );

                                const total = valid.reduce((sum, r) => sum + Number(r.rating), 0);
                                self.averageRating = valid.length > 0
                                    ? (total / valid.length).toFixed(1)
                                    : 0;
                            }
                        });
                    },
                    getBarWidth(score) {
                        const counts = this.scoreCounts;
                        const total = Object.values(counts).reduce((sum, count) => sum + count, 0);
                        const scoreNum = Number(score);
                        if (total === 0 || isNaN(scoreNum)) return 0;
                        return Math.round((counts[scoreNum] || 0) / total * 100);
                    }
                },
				watch: {
					qnaList(newVal) {
					    const params = new URLSearchParams(window.location.search);
					    const qnaId = params.get("qnaId");

					    if (qnaId) {
							this.activeTab = 'qna';

					        this.$nextTick(() => {
								//console.log("33",this.activeTab);
								
					            const element = document.getElementById('comment-' + qnaId);
					            if (element) {
					                //console.log('찾은 요소:', element);

					                element.scrollIntoView({ behavior: 'smooth', block: 'center' });

					            } else {
					                //console.warn('댓글 요소를 찾지 못했습니다:', qnaId);
					            }
					        });
					    }
					}
				},
                mounted() {
                    const params = new URLSearchParams(window.location.search);
                    this.productId = params.get("productId") || "";

                    if (!this.productId) {
                        alert("상품을 불러올수 없습니다.");
                        location.href = "/product/list.do";
                        return;
                    }

                    let self = this;
                    self.fnProduct();
                    self.fnReviewList();
                    self.fnAllReviews();
                    self.fnUserInfo();
                    self.fnQnaList();

                    setTimeout(() => {
                        const thumbnailScroll = document.getElementById("thumbnailScroll");
                        if (!thumbnailScroll) return;

                        let isDragging = false;
                        let startX;
                        let scrollLeft;

                        thumbnailScroll.addEventListener("mousedown", (e) => {
                            isDragging = true;
                            thumbnailScroll.classList.add("active");
                            startX = e.pageX - thumbnailScroll.offsetLeft;
                            scrollLeft = thumbnailScroll.scrollLeft;
                        });

                        thumbnailScroll.addEventListener("mouseleave", () => {
                            isDragging = false;
                            thumbnailScroll.classList.remove("active");
                        });

                        thumbnailScroll.addEventListener("mouseup", () => {
                            isDragging = false;
                            thumbnailScroll.classList.remove("active");
                        });

                        thumbnailScroll.addEventListener("mousemove", (e) => {
                            if (!isDragging) return;
                            e.preventDefault();
                            const x = e.pageX - thumbnailScroll.offsetLeft;
                            const walk = (x - startX) * 2;
                            thumbnailScroll.scrollLeft = scrollLeft - walk;
                        });
                    }, 300); // 0.3초 후에 실행
					
					
					
                }
            });

            app.mount("#app");

        });
    </script>