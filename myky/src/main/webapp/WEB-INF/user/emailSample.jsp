<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 인증</title>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    
    <style>
        .container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        input, button {
            display: block;
            width: 100%;
            margin-top: 10px;
            padding: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/common/header.jsp"/>

    <div id="app" class="container">
        <h2>이메일 인증</h2>
        <input type="email" v-model="email" placeholder="이메일을 입력하세요" />
        <button @click="sendEmailAuth">인증번호 받기</button>

        <div v-if="showVerification">
            <input type="text" v-model="authCode" placeholder="인증번호 입력" />
            <button @click="verifyCode">인증 확인</button>
        </div>
        <button @click="fnEmailTest">테스트</button>


        <p v-if="message">{{ message }}</p>
    </div>

    <jsp:include page="/WEB-INF/common/footer.jsp"/>
</body>
</html>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const app = Vue.createApp({
        data() {
            return {
                email: "",
                authCode: "",
                showVerification: false,
                message: "",
                emailPattern: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/ // 이메일 유효성 검사 정규식
            };
        },
        methods: {
            fnEmailTest() {
                        var self = this;
                        var nparmap = {

                        };
                        $.ajax({
                            url: "/email/test.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                
                            }
                        });
                    },



            async sendEmailAuth() {
                if (!this.email) {
                    this.message = "이메일을 입력하세요.";
                    return;
                }

                if (!this.emailPattern.test(this.email)) {
                this.message = "유효한 이메일 형식을 입력하세요.";
                return;
            }
            this.message = "인증번호를 전송 중...";

                try {
                    const response = await fetch("/email/send-auth-code", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ email: this.email })
                    });

                    const result = await response.json();
                    if (result.success) {
                        this.showVerification = true;
                        this.message = "인증번호가 발송되었습니다.";
                    } else {
                        this.message = "이메일 발송 실패.";
                    }
                } catch (error) {
                    this.message = "서버 오류 발생.";
                }
            },
            async verifyCode() {
                if (!this.authCode) {
                    this.message = "인증번호를 입력하세요.";
                    return;
                }

                try {
                    const response = await fetch("/email/verify-auth-code", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ email: this.email, code: this.authCode })
                    });

                    const result = await response.json();
                    if (result.success) {
                        this.message = "이메일 인증이 완료되었습니다!";
                    } else {
                        this.message = "인증번호가 일치하지 않습니다.";
                    }
                } catch (error) {
                    this.message = "서버 오류 발생.";
                }
            }
        }
    });

    app.mount("#app");
});
</script>