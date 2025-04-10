<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멤버십 가입 - 본인확인 및 결제</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
        <link rel="stylesheet" href="/css/membership/membership.css" />
        <style>

        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />

        <div id="app" class="membership-wrapper">
            <div class="step-title">
                <h2>🐾 멍냥꽁냥 멤버십 가입</h2>
            </div>
            <ul class="step-bar">
                <li class="active">회원 정보 확인</li>
                <li :class="{ active: confirmed }">결제</li>
            </ul>

            <!-- ✅ 회원 정보 확인 -->
            <div class="card-section">
                <h3>회원 정보 확인</h3>
                <div class="info-grid">
                    <div class="info-item"><strong>이름:</strong> {{ userInfo.userName }}</div>
                    <div class="info-item"><strong>아이디:</strong> {{ userInfo.userId }}</div>
                    <div class="info-item"><strong>닉네임:</strong> {{ userInfo.nickName }}</div>
                    <div class="info-item"><strong>이메일:</strong> {{ userInfo.email }}</div>
                    <div class="info-item"><strong>연락처:</strong> {{ userInfo.phoneNumber }}</div>
                    <div class="info-item"><strong>주소:</strong> {{ userInfo.address }}</div>
                </div>
                <div class="mt-4">
                    <button class="btn-main" v-if="!confirmed" @click="handleConfirm">정보 확인 완료</button>
                    <button class="btn-main" v-else disabled>✅ 정보 확인 완료</button>
                </div>
            </div>

            <!-- ✅ 결제 수단 선택 -->
            <div class="card-section" ref="paymentBox" id="payment-section">
                <h3> 결제 옵션 선택</h3>

                <div class="plan-options" ref="planOptions" style="position: relative;">
                    <!-- 1개월 -->
                    <div class="plan-card" :class="{ active: selectedPlan === '1' }" @click="selectPlan('1')">
                        <div class="plan-icon">📦</div>
                        <div><strong>1개월</strong></div>
                        <div class="price-highlight">12,900원</div>
                    </div>

                    <!-- 6개월 -->
                    <div class="plan-card" :class="{ active: selectedPlan === '6' }" @click="selectPlan('6')">
                        <div class="plan-badge">추천</div>
                        <div class="plan-icon">🔥</div>
                        <div><strong>6개월</strong></div>

                        <div class="price-box">
                            <div class="price-original"> 77400원</div>
                            <div class="price-sale"> 65,790원</div>
                        </div>

                        <div v-if="selectedPlan === '6'" class="discount-tooltip">
                            💡 {{ selectedPlanText }}
                        </div>
                    </div>

                    <!-- 12개월 -->
                    <div class="plan-card" :class="{ active: selectedPlan === '12' }" @click="selectPlan('12')">
                        <div class="plan-badge">BEST</div>
                        <div class="plan-icon">💎</div>
                        <div><strong>12개월</strong></div>

                        <div class="price-box">
                            <div class="price-original"> 154,800원</div>
                            <div class="price-sale"> 123,840원</div>
                        </div>

                        <div v-if="selectedPlan === '12'" class="discount-tooltip">
                            💡 {{ selectedPlanText }}
                        </div>
                    </div>

                </div>

                <div class="payment-button-wrapper">
                    <button class="btn-main" :disabled="!selectedPlan || !confirmed" @click="submitPayment()">
                        결제 후 멤버십 가입완료
                    </button>
                </div>

                <p class="text-center text-muted mt-3">※ 결제 완료 후 멤버십 혜택이 즉시 적용됩니다.</p>
            </div>

            <div class="card-section">
                <h3>❓ 유의사항</h3>
                <ul class="text-muted small">
                    <li>결제 후 환불은 불가하며, 혜택은 즉시 적용됩니다.</li>
                    <li>멤버십은 기간 만료 시 자동으로 종료됩니다.</li>
                    <li>포인트는 가입 즉시 자동 지급됩니다.</li>
                    <li>결제 수단은 카드만 지원됩니다. (카카오페이, 네이버페이 등 포함)</li>
                </ul>
            </div>
        </div>


        <jsp:include page="/WEB-INF/common/footer.jsp" />

    </body>

    </html>
    <script>
        const userCode = "imp40283074";

        document.addEventListener("DOMContentLoaded", function () {

            if (typeof IMP !== 'undefined') {
                IMP.init(userCode);
            } else {

            }

            const app = Vue.createApp({
                data() {
                    return {
                        userInfo: {},
                        sessionId: "${sessionId}",
                        confirmed: false,
                        membershipType: "1",
                        selectedPlan: "",
                        showTooltip: false,
                        tooltipText: '',
                        selectedPlanText: '',
                        tooltipStyle: {}
                    };
                },
                computed: {

                },
                methods: {
                    fnUserInfo() {
                        let self = this;
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
                    handleConfirm() {
                        this.confirmed = true;
                        this.$nextTick(() => {
                            const el = this.$refs.paymentBox;
                            if (el) {
                                const offsetTop = el.getBoundingClientRect().top + window.pageYOffset;
                                window.scrollTo({
                                    top: offsetTop - 200, // ← 여기서 100은 살짝 위쪽 여백 확보
                                    behavior: 'smooth'
                                });
                            }
                        });
                    },
                    selectPlan(plan) {
                        this.selectedPlan = plan;
                        let msg = '';
                        let total = 0;

                        if (plan === '6') {
                            total = 12900 * 6 * 0.85; // 15% 할인
                            msg = '6개월 이용권' + ' (15% 할인)';
                        } else if (plan === '12') {
                            total = 12900 * 12 * 0.8; // 20% 할인
                            msg = '12개월 이용권' + ' (20% 할인)';
                        }

                        this.selectedPlanText = ''; // 이전 툴팁 제거

                        this.$nextTick(() => {
                            const tooltip = this.$refs.tooltip;
                            const planOptions = this.$refs.planOptions;
                            const selectedIndex = plan === '6' ? 1 : plan === '12' ? 2 : plan === '1' ? 0 : null;

                            if (tooltip && planOptions && selectedIndex !== null) {
                                const selectedCard = planOptions.querySelectorAll('.plan-card')[selectedIndex];
                                const cardRect = selectedCard.getBoundingClientRect();
                                const containerRect = planOptions.getBoundingClientRect();

                                this.tooltipStyle = {
                                    top: (cardRect.top - containerRect.top - 40) + 'px',
                                    left: (cardRect.left - containerRect.left + cardRect.width / 2) + 'px'
                                };
                            }

                            this.selectedPlanText = msg;
                        });
                    },

                    submitPayment() {
                        const self = this;

                        let amount = 0;
                        let label = "";
                        switch (self.selectedPlan) {
                            case "1":
                                amount = 100;
                                label = "1개월 멤버십";
                                break;
                            case "6":
                                amount = 100;  //65790원 15% 할인률
                                label = "6개월 멤버십";
                                break;
                            case "12":
                                amount = 123840;  //123840원 20% 할인률
                                label = "12개월 멤버십";
                                break;
                        }

                        self.membershipType = label;
                        self.expirationDate = self.selectedPlan;

                        IMP.request_pay({
                            channelKey: "channel-key-ab7c2410-b7df-4741-be68-1bcc35357d9b",
                            pg: "html5_inicis",
                            pay_method: "card",
                            merchant_uid: "membership_" + new Date().getTime(),
                            name: "멍냥꽁냥" + label,
                            amount: amount,
                            buyer_name: self.userInfo.userName,
                            buyer_tel: self.userInfo.phoneNumber
                        }, function (rsp) {
                            if (rsp.success) {
                                alert("멤버십 결제가 완료되었습니다! 감사합니다.");

                                self.fnAddMembership(rsp);
                                location.href = "/membership/main.do";

                            } else {
                                alert("결제에 실패했습니다.");
                            }
                        }
                        )
                    },
                    fnAddMembership: function (rsp) {
                        var self = this;
                        var nparmap = {
                            userId: self.userInfo.userId,
                            membershipType: self.membershipType,
                            expirationDate: self.expirationDate
                        };
                        $.ajax({
                            url: "/membership/addmember.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.membershipId = data.membershipId;

                                self.fnPaymentHistory(rsp);
                            }
                        });
                    },
                    fnPaymentHistory: function (rsp) {
                        let self = this;

                        let paymentMethod = "";
                        if (rsp.pay_method == "card") {
                            paymentMethod = rsp.pay_method + "-" + rsp.card_name;
                        } else {
                            paymentMethod = rsp.pay_method;
                        }
                        var nparmap = {
                            option: "",
                            paymentCode: rsp.merchant_uid,
                            description: rsp.name,
                            amount: rsp.paid_amount,
                            paymentMethod: paymentMethod,
                            installment: rsp.card_quota,
                            subscriptionPeriod: self.expirationDate,
                            paymentStatus: rsp.status,
                            isCanceled: "N",
                            cancelDate: null,
                            orderId: null,
                            donationId: null,
                            membershipId: self.membershipId,
                            userId: self.userInfo.userId,
                            usedPoint: null
                        };
                        $.ajax({
                            url: "/payment.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                            }
                        });
                    },

                },
                mounted() {
                    let self = this;
                    self.fnUserInfo();
                }
            });
            app.mount("#app");
        });
    </script>