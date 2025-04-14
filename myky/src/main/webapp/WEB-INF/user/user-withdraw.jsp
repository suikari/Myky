<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>withdraw popUp</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <script src="/js/vue3b.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: rgba(0, 0, 0, 0.05);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            #app {
                background: #fff;
                padding: 20px;
                width: 400px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            h3,
            h4 {
                color: #333;
            }

            div {
                margin: 15px 0;
                line-height: 1.5;
            }

            input[type="password"] {
                padding: 10px;
                width: 80%;
                border: 1px solid #ccc;
                border-radius: 25px;
            }

            button {
                background: rgb(110, 158, 255);
                color: white;
                border: none;
                padding: 10px 15px;
                margin: 5px;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.3s;
            }
            

            button:hover {
                background: rgb(0, 80, 255);
            }

            button:nth-child(2) {
                background: #6c757d;
            }

            button:nth-child(2):hover {
                background: #5a6268;
            }

            .error-message {
                color: red;
                font-weight: bold;
            }

            .success-message {
                color: green;
                font-weight: bold;
            }
        </style>
    </head>

    <body>



        <div id="app" class="container">
            <template v-if="!quitFlg">
                <h3>탈퇴 시 주의사항</h3>
                <div>
                    회원 탈퇴 시 보유한 적립금은 삭제되며,
                    동일한 아이디나 SNS 계정으로 재가입할 수 없습니다.
                    정말로 탈퇴 하시겠습니까?
                </div>

                <button @click=fnQuit()>예</button>
                <button @click=fnClose()>아니오</button>
            </template>

            <template v-else>
                <div>
                    <span v-if="!authFlg">
                        <h4>비밀번호를 입력해주세요</h4>
                        <div v-if="noAuthFlg" style="color: red;">비밀번호가 일치하지 않습니다.</div>
                        비밀번호: <input type="password" v-model="pwd">
                        <button @click=fnAuth()>인증하기</button>
                        <div>
                            <button @click=fnClose()>뒤로가기</button>
                        </div>
                    </span>
                    <span v-else>
                        <h4>그동안 멍냥꽁냥을 사랑해주셔서 감사합니다.</h4>
                        <h4 style="color: green;">인증 완료</h4>
                        <div>
                            <button @click=fnWithdraw()>탈퇴하기</button>
                            <button @click=fnClose()>뒤로가기</button>
                        </div>
                    </span>
                </div>

            </template>
        </div>




    </body>

    </html>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        userId: "${sessionId}",
                        quitFlg: false,
                        authFlg: false,
                        noAuthFlg: false,
                        pwd: ""

                    };
                },
                computed: {

                },
                methods: {
                    fnWithdraw() {
                        var self = this;
                        var nparmap = {
                            userId: self.userId
                        };
                        $.ajax({
                            url: "/user/withdraw.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.count > 0) {
                                    alert("탈퇴되었습니다!");
                                    opener.withdrawBack(); // 탈퇴시 mypage
                                    window.close();
                                }
                            }
                        });
                    },
                    fnClose: function () {
                        window.close();
                    },
                    fnQuit: function () {
                        let self = this;
                        self.quitFlg = true;
                    },
                    fnAuth: function () {
                        var self = this;
                        var nparmap = {
                            userId: self.userId,
                            pwd: self.pwd
                        };
                        $.ajax({
                            url: "/user/IdPwdCheak.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.result == "success") {
                                    self.authFlg = true;
                                    self.noAuthFlg = false;
                                } else {
                                    self.noAuthFlg = true;
                                    return;
                                }
                            }
                        });
                    }
                },
                mounted() {


                }
            });

            app.mount("#app");
        });
    </script>