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
        <link rel="stylesheet" href="/css/user/user.css" />

        <title>search password page</title>

    </head>
    <style>
        
    </style>

    <body>
        <!-- 오류 '//' 해결필요 -->
        <jsp:include page="../common/header.jsp" />

        <div id="app" class="container">
            <div class="password-reset-container">
                <div v-if="authFlg == false" class="auth-form">
                    <div class="form-group">
                        <label for="userId" class="form-label">아이디:</label>
                        <input id="userId" v-model="userId" class="form-input" type="text" />
                    </div>
                    <div class="form-group">
                        <button @click="fnAuth()" class="auth-btn">비밀번호 변경</button>
                        <button @click="fnExit()" class="auth-btn2">취소</button>
                    </div>
                </div>

                <div v-else class="new-password-form">
                    <div class="form-group">
                        <label for="pwd" class="form-label">새로운 비밀번호:</label>
                        <input id="pwd" v-model="pwd" class="form-input" type="password" />
                    </div>
                    <div class="form-group">
                        <label for="pwdCheck" class="form-label">새로운 비밀번호 확인:</label>
                        <input id="pwdCheck" v-model="pwdCheck" class="form-input" type="password" />
                    </div>
                    <div class="form-group">
                        <button @click="fnNewPwd()" class="save-btn">수정 저장</button>
                        <button @click="fnExit()" class="save-btn2">수정 취소</button>
                    </div>
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
                            alert("수정저장");
                            location.href = "/user/login.do";
                        }
                    });
                },

                fnIdFind: function () {
                    location.href = "/user/findid.do";
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
                            if (data.count != 0) {
                                //alert("검색되는 아이디");

                                IMP.certification({
                                    channelKey: "channel-key-0fe7e059-c386-47fa-bf62-63f6bf973879",
                                    merchant_uid: "merchant" + new Date().getTime(),
                                }, function (rsp) {
                                    if (rsp.success) {
                                        alert("인증성공");
                                        self.authFlg = true;
                                    } else {
                                        alert(rsp.error_msg);

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
                        location.href = "/user/mypage.do"
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