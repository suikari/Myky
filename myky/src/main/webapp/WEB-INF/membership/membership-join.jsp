<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멤버십 가입 - 본인확인 및 결제</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

        <style>
            body {
                font-family: 'Pretendard', sans-serif;
                background-color: #f2f4f6;
                margin: 0;
                padding: 0;
            }

            .membership-container {
                max-width: 1280px;
                margin: 60px auto;
                background-color: #ffffff;
                border-radius: 16px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                padding: 40px 32px;
            }

            .membership-header {
                text-align: center;
                margin-bottom: 40px;
            }

            .membership-header h2 {
                font-size: 28px;
                color: #222;
            }

            .info-box,
            .payment-box {
                background-color: #fdfdfd;
                border: 1px solid #e2e2e2;
                border-radius: 12px;
                padding: 24px 20px;
                margin-bottom: 30px;
            }

            .info-list {
                list-style: none;
                padding: 0;
            }

            .info-list li {
                font-size: 15px;
                padding: 6px 0;
                border-bottom: 1px dashed #ddd;
            }

            .plan-options {
                display: flex;
                gap: 20px;
                margin-bottom: 10px;
            }

            .plan-options label {
                padding: 10px 18px;
                background-color: #f0f0f0;
                border-radius: 10px;
                cursor: pointer;
                border: 1px solid #ccc;
            }

            .plan-options input[type="radio"] {
                margin-right: 8px;
            }

            .btn-main,
            .btn-submit {
                width: 100%;
                padding: 16px;
                font-size: 16px;
                background-color: #ff7a00;
                color: #fff;
                border: none;
                border-radius: 12px;
                cursor: pointer;
                font-weight: 600;
            }

            .btn-submit:disabled {
                background-color: #ccc;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />

        <div id="app" class="membership-container">
            <div class="membership-header">
                <h2>🐾 멍냥꽁냥 멤버십 가입 - Step 2</h2>
                <p>회원 정보를 확인하고 결제를 진행해주세요.</p>
            </div>

            <!-- ✅ 회원 정보 확인 -->
            <div class="info-box" v-if="!confirmed">
                <h3>🙋 회원 정보 확인</h3>
                <ul class="info-list">
                    <li><strong>이름:</strong> {{ userInfo.userName }}</li>
                    <li><strong>아이디:</strong> {{ userInfo.userId }}</li>
                    <li><strong>닉네임:</strong> {{ userInfo.nickName }}</li>
                    <li><strong>이메일:</strong> {{ userInfo.email }}</li>
                    <li><strong>연락처:</strong> {{ userInfo.phoneNumber }}</li>
                    <li><strong>주소:</strong> {{ userInfo.address }}</li>
                </ul>
                <button class="btn-main" @click="confirmed = true">확인</button>
            </div>

            <!-- ✅ 결제 수단 선택 -->
             <!-- 멤버십 중복 체크.... -->
            <div class="payment-box" v-if="confirmed">
                <h3>💳 결제 옵션 선택</h3>
                <div class="plan-options">
                    <label><input type="radio" name="plan" v-model="selectedPlan" value="1"> 1개월</label>
                    <label><input type="radio" name="plan" v-model="selectedPlan" value="6"> 6개월</label>
                    <label><input type="radio" name="plan" v-model="selectedPlan" value="12"> 12개월</label>
                </div>
                <button class="btn-submit" :disabled="!selectedPlan" @click="submitPayment">가입하고 결제하기</button>
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
                console.error('IMP is not loaded properly');
            }

            const app = Vue.createApp({
                data() {
                    return {
                        userInfo: {},
                        sessionId: "${sessionId}",
                        confirmed: false,
                        membershipType: "1",
                        selectedPlan: "",
                    };
                },
                computed: {

                },
                methods: {
                    fnUserInfo() {
                        let self = this;
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
                                amount = 100;
                                label = "6개월 멤버십";
                                break;
                            case "12":
                                amount = 129000;
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
                                console.log("결제 정보 >>> ", rsp);

                                self.fnAddMembership(rsp);
                                location.href = "/membership/main.do";

                            } else {
                                alert("결제에 실패했습니다.");
                                console.log("결제 정보 >>> ", rsp.error_msg);
                            }
                        }
                        )
                    },
                    fnAddMembership: function (rsp) {
                        var self = this;
                        // console.log("nparmap",nparmap);
                        var nparmap = {
                            userId: self.userInfo.userId,
                            membershipType: self.membershipType,
                            expirationDate: self.expirationDate
                        };
                        console.log("nparmap",nparmap);
                        $.ajax({
                            url: "/membership/addmember.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("멤버십 정보 저장 여부 >>> ", data.result);
                                self.membershipId = data.membershipId;
                                console.log("fnAddMembership >> self.membershipId >>> ", self.membershipId);
                                // DB 저장 후 후원ID 가져오기
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

                        console.log("paymentMethod >>> ", paymentMethod);
                        console.log("fnPaymentHistory >> self.membershipId >>> ", self.membershipId);

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
                            donationId : null,
                            membershipId: self.membershipId,
                            userId: self.userInfo.userId,
                            usedPoint : null
                        };
                        console.log("nparmap",nparmap);
                        $.ajax({
                            url: "/payment.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("결제 정보 저장 여부 >>> ", data.result);
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