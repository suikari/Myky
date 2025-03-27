<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
            <!-- 카카오 인증용 임포트 -->
            <script src="https://code.jquery.com/jquery-3.7.1.js" 
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
            <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
            <!-- 카카오 인증용 임포트 -->
             
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <title>search password page</title>
        <!-- 비밀번호를 찾을 아이디 입력 받기
 비밀번호 찾기 버튼 클릭 시 인증 페이지 호출
인증 성공 시 새로운 비밀번호 입력받아서 db에 저장
-> 비밀번호 확인까지
인증 실패 시 '인증실패 했습니다' -->
    </head>
    <style>
        /* 전체 컨테이너 스타일 */
        .password-reset-container {
            max-width: 450px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }

        .form-input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-input:focus {
            border-color: #007BFF;
            outline: none;
        }

        /* 비밀번호 찾기 버튼 스타일 */
        .auth-btn,
        .save-btn,
        .auth-btn2,
        .save-btn2 {
            width: 45%;
            margin-left: 10px;
            padding: 12px;
            font-size: 16px;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .auth-btn {
            background-color: #28a745;
        }

        .auth-btn:hover {
            background-color: #218838;
        }

        .auth-btn2 {
            background-color: #be8905;
        }

        .auth-btn2:hover {
            background-color: #8d6803;
        }

        .save-btn {
            background-color: #007BFF;
        }

        .save-btn:hover {
            background-color: #0056b3;
        }

        .save-btn2 {
            background-color: #c30690;
        }

        .save-btn2:hover {
            background-color: #6d0469;
        }

        /* 모바일 반응형 스타일 */
        @media (max-width: 500px) {
            .password-reset-container {
                padding: 20px;
            }

            .form-label {
                font-size: 12px;
            }

            .form-input {
                font-size: 14px;
            }

            .auth-btn,
            .save-btn {
                font-size: 14px;
            }
        }
    </style>

    <body>
        <!-- 오류 '//' 해결필요 -->
        <jsp:include page="../common/header.jsp" />

        <div id="app" class="container password-reset-container">
            <div v-if="authFlg == false" class="auth-form">
                <div class="form-group">
                    <label for="userId" class="form-label">아이디:</label>
                    <input id="userId" v-model="userId" class="form-input" type="text">
                </div>
                <div class="form-group">
                    <button @click="fnAuth()" class="auth-btn">비밀번호 변경</button>
                    <button @click="fnExit()" class="auth-btn2">취소</button>
                </div>
                <button @click="fnIdFind()" class="auth-btn2">아이디 찾기</button>
            </div>

            <div v-else class="new-password-form">
                <div class="form-group">
                    <label for="pwd" class="form-label">새로운 비밀번호:</label>
                    <input id="pwd" v-model="pwd" class="form-input" type="password">
                </div>
                <div class="form-group">
                    <label for="pwdCheck" class="form-label">새로운 비밀번호 확인:</label>
                    <input id="pwdCheck" v-model="pwdCheck" class="form-input" type="password">
                </div>
                <div class="form-group">
                    <button @click="fnNewPwd()" class="save-btn">수정 저장</button>
                    <button @click="fnExit()" class="save-btn2">수정 취소</button>
                </div>
            </div>
        </div>

        <jsp:include page="/WEB-INF/common/footer.jsp" />
    </body>

    </html>
    <script>
        const userCode = "imp05720184";
        // userCode = 나(사업자)를 인증할 수 있는 코드
        IMP.init(userCode);
        const app = Vue.createApp({
            data() {
                return {
                    userId: "${map.userId}",
                    authFlg: false,
                    pwd: "",
                    pwdCheck: ""

                };
            },
            methods: {
                fnNewPwd() {
                    var self = this;
                    if (self.pwd != self.pwdCheck || self.pwd == "") {
                        alert("비밀번호 확인바람");
                        return;
                    }
                    var nparmap = {
                        userId: self.userId, //보낼떄 qqq로 보내면 sql-user.xml에서도 qqq로 받아야함
                        pwd: self.pwd
                    };
                    $.ajax({
                        url: "/user/searchPwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            alert("수정저장");
                            location.href = "/user/login.do";
                        }
                    });
                },

                fnIdFind: function () {
                    location.href = "/user/findId.do";
                },
                fnAuth: function () {
                    var self = this;
                    var nparmap = {
                        userId: self.userId
                    };
                    $.ajax({
                        url: "/user/searchId.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log(data);
                            if (data.count != 0) {
                                //alert("검색되는 아이디");

                                IMP.certification({
                                    channelKey: "channel-key-0fe7e059-c386-47fa-bf62-63f6bf973879",
                                    merchant_uid: "merchant" + new Date().getTime(),
                                }, function (rsp) {
                                    if (rsp.success) {
                                        alert("인증성공");
                                        console.log(rsp);
                                        console.log(self.authFlg);
                                        self.authFlg = true;
                                    } else {
                                        alert(rsp.error_msg);
                                        console.log(rsp);

                                    }

                                });


                            } else {
                                alert("검색한 아이디가 없습니다.");
                                return;
                            }
                        }
                    });



                },
                fnExit: function () {
                    if (userId = "${map.userId}") {
                        location.href = "/user/myPage.do"
                    } else {
                        location.href = "/user/login.do";
                    }
                }
            },
            mounted() {
                var self = this;
            }
        });
        app.mount('#app');
    </script>