<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멤버십 가입 - 본인확인 및 결제</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            .info-section {
                margin-bottom: 30px;
            }

            .info-section h2 {
                font-size: 20px;
                margin-bottom: 15px;
            }

            .info-box {
                background: #f9f9f9;
                padding: 20px;
                border-radius: 12px;
                border: 1px solid #ddd;
                font-size: 15px;
            }

            .info-item {
                margin-bottom: 10px;
            }
            .payment-section {
    margin-top: 40px;
    margin-bottom: 30px;
}

.payment-section h2 {
    font-size: 20px;
    margin-bottom: 15px;
}

.payment-options label {
    display: block;
    margin-bottom: 10px;
    font-size: 15px;
    cursor: pointer;
}

.btn-submit {
    width: 100%;
    padding: 14px;
    font-size: 16px;
    background-color: #ff7a00;
    color: white;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 20px;
}

.btn-submit:disabled {
    background-color: #ccc;
    cursor: not-allowed;
}

        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />



        <div id="app" class="container">
            <div class="info-section">
                <h2>🙋 회원 정보 확인</h2>
                <div class="info-box">
                    <div class="info-item"><strong>이름:</strong> {{ userInfo.userName }}</div>
                    <div class="info-item"><strong>아이디:</strong> {{ userInfo.userId }}</div>
                    <div class="info-item"><strong>닉네임:</strong> {{ userInfo.nickName }}</div>
                    <div class="info-item"><strong>이메일:</strong> {{ userInfo.email }}</div>
                    <div class="info-item"><strong>연락처:</strong> {{ userInfo.phoneNumber }}</div>
                    <div class="info-item"><strong>주소:</strong> {{ userInfo.address }}</div>
                </div>
            </div>

            <div class="payment-section">
                <h2>💳 결제 수단 선택</h2>
                <div class="payment-options">
                    <label>
                        <input type="radio" value="card" v-model="paymentMethod" />
                        신용카드
                    </label>
                    <label>
                        <input type="radio" value="kakaopay" v-model="paymentMethod" />
                        카카오페이
                    </label>
                    <label>
                        <input type="radio" value="naverpay" v-model="paymentMethod" />
                        네이버페이
                    </label>
                </div>
            </div>

            <!-- 가입 버튼 -->
            <button class="btn-submit" @click="submitMembership" :disabled="!paymentMethod"> 가입하고 결제하기 </button>

        </div>


        <jsp:include page="/WEB-INF/common/footer.jsp" />


    </body>

    </html>
    <script>

        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        userInfo: { userId: "${userId}" },
                        sessionId: "${sessionId}",
                        paymentMethod: ""
                    };
                },
                computed: {

                },
                methods: {
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

                    submitMembership() {
                        const self = this;
                        if (!self.paymentMethod) {
                            alert("결제 수단을 선택해주세요.");
                            return;
                        }

                        const nparmap = {
                            userId: self.userInfo.userId,
                            paymentMethod: self.paymentMethod
                        };

                        $.ajax({
                            url: "/membership/join.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                if (data.result === "success") {
                                    alert("멤버십 가입이 완료되었습니다!");
                                    location.href = "/membership/main.do";
                                } else {
                                    alert("가입 처리 중 오류가 발생했습니다.");
                                }
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