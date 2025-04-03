<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멤버십 가입 페이지</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            .container {
                max-width: 600px;
                margin: 40px auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 12px;
                background-color: #fafafa;
                font-family: sans-serif;
            }

            h2 {
                margin-bottom: 20px;
                font-size: 24px;
            }

            input,
            select {
                width: 100%;
                margin-bottom: 15px;
                padding: 10px;
                font-size: 16px;
                border-radius: 8px;
                border: 1px solid #ccc;
            }

            label {
                font-weight: bold;
            }

            .terms {
                margin: 10px 0;
            }

            .btn-submit {
                width: 100%;
                padding: 12px;
                font-size: 18px;
                background-color: #5c8df6;
                color: white;
                border: none;
                border-radius: 10px;
                cursor: pointer;
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
            <h2>멤버십 가입하기</h2>

            <form @submit.prevent="fnjoin">
                <div>
                    <label for="name">이름</label>
                    <input type="text" id="name" v-model="name" required>
                </div>
            
                <div>
                    <label for="email">이메일</label>
                    <input type="email" id="email" v-model="email" required>
                </div>
            
                <div>
                    <label for="phone">휴대폰 번호</label>
                    <input type="text" id="phone" v-model="phone" required>
                </div>
            
                <div>
                    <label for="payment">결제 방식</label>
                    <select id="payment" v-model="paymentMethod" required>
                        <option value="" disabled>결제 방식을 선택하세요</option>
                        <option value="card">신용카드</option>
                        <option value="kakaopay">카카오페이</option>
                        <option value="naverpay">네이버페이</option>
                    </select>
                </div>
            
                <div class="terms">
                    <label><input type="checkbox" v-model="agree"> 이용약관에 동의합니다. (필수)</label>
                </div>
            
                <button type="submit" class="btn-submit" :disabled="!agree">가입하기</button>
            </form>
            


        </div>


        <jsp:include page="/WEB-INF/common/footer.jsp" />


    </body>

    </html>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        name: '',
                        email: '',
                        phone: '',
                        paymentMethod: '',
                        agree: false
                    };
                },
                computed: {

                },
                methods: {
                    fnjoin() {
                        var self = this;
                        var nparmap = {
                            name: self.name,
                            email: self.email,
                            phone: self.phone,
                            paymentMethod: self.paymentMethod
                        };

                        if (!self.agree) {
                            alert("이용약관에 동의해주세요.");
                            return;
                        }

                        $.ajax({
                            url: "/membership/join.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("멤버십 가입 완료:", data);
                                alert("가입이 완료되었습니다!");
                                // location.href = "/membership/complete.do"; // 완료 페이지로 이동해도 좋음
                            },
                            error: function () {
                                alert("서버 오류가 발생했습니다.");
                            }
                        });
                    }



                },
                mounted() {
                    let self = this;


                }
            });

            app.mount("#app");
        });
    </script>