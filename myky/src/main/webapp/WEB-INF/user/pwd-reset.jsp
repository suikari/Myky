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
                    <div class="section">
                        <label class="form-label">이메일: </label>
                        <div class="inline-group">
                            <input class="form-input" v-model="email" :disabled="emailFlg">
                            <!-- <button class="inline-btn" v-if="!emailFlg" @click="fnEmailChecked()">인증번호</button> -->
                        </div>
                        <div class="inline-group" v-if="showVerification">
                            <input class="input-underline" v-model="authCode" placeholder="인증번호 입력">
                            <button class="inline-btn" @click="verifyCode">확인</button>
                        </div>
                        <p v-if="message" style="margin-top: 8px; color: #4a90e2;">{{ message }}</p>
                    </div>
                    <div class="form-group">
                        <button @click="fnEmailChecked()" class="auth-btn">비밀번호 변경</button>
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
                    pwdCheck: "",
                    email: "",
                    emailFlg: false,
                    authCode: "",
                    showVerification: false,
                    message: "",
                    passwordPattern: /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/,  // 정규식 적용

                };
            },
            methods: {
                fnNewPwd() {
                    var self = this;
                    if (self.pwd != self.pwdCheck || self.pwd == "") {
                        alert("비밀번호 확인해주십시오");
                        return;
                    }

                    if (!self.passwordPattern.test(self.pwd)) {
                        alert("비밀번호는 8~20자의 영문, 숫자, 특수문자를 포함해야 합니다.");
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
                            alert("수정 저장되었습니다.");
                            if (userId = "${map.userId}") {
                                location.href = "/user/mypage.do"
                            } else {
                                location.href = "/user/login.do";
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
                },

                fnEmailChecked: function () {
                    var self = this;
                    if (!self.email) {
                        alert("이메일을 입력하세요.");
                        return;
                    }

                    var nparmap =
                    {
                        userId: self.userId,
                        email: self.email
                    };
                    $.ajax({
                        url: "/user/emailCheck.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            if (data.count != 0) {
                                self.sendEmailAuth();


                            } else {
                                alert("아이디와 이메일이 일치하는 정보가 없습니다.");
                                return;
                            }
                        }
                    });
                },

                async sendEmailAuth() {
                    let self = this;
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
                            alert("이메일 인증이 완료되었습니다!");
                            this.message = "이메일 인증이 완료되었습니다!";
                            this.authFlg = true;
                        } else if (result.success2) {
                            this.message = "인증시간이 만료되었습니다. 인증코드를 다시 신청하십시오!";
                            this.showVerification = false;
                        } else {
                            this.message = "인증번호가 일치하지 않습니다.";
                        }
                    } catch (error) {
                        this.message = "서버 오류 발생.";
                    }
                }
                // ,
                // 카카오톡 인증용 추후 개발
                // fnIdFind: function () {
                //     location.href = "/user/findid.do";
                // },
                // fnAuth: function () {
                //     var self = this;
                //     var nparmap = {
                //         userId: self.userId
                //     };
                //     $.ajax({
                //         url: "/user/searchId.dox",
                //         dataType: "json",
                //         type: "POST",
                //         data: nparmap,
                //         success: function (data) {
                //             if (data.count != 0) {
                //                 //alert("검색되는 아이디");

                //                 IMP.certification({
                //                     channelKey: "channel-key-0fe7e059-c386-47fa-bf62-63f6bf973879",
                //                     merchant_uid: "merchant" + new Date().getTime(),
                //                 }, function (rsp) {
                //                     if (rsp.success) {
                //                         alert("인증성공");
                //                         self.authFlg = true;
                //                     } else {
                //                         alert(rsp.error_msg);

                //                     }

                //                 });


                //             } else {
                //                 alert("검색한 아이디가 없습니다.");
                //                 return;
                //             }
                //         }
                //     });
                // },
            },
            mounted() {
                var self = this;
            }
        });
        app.mount('#app');
    </script>