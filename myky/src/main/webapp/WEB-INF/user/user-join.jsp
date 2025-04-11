<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>join page</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <script src="/js/vue3b.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <link rel="stylesheet" href="/css/user/user.css" />
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            html,
            body {
                height: 100%;
                font-family: 'Segoe UI', sans-serif;
            }

            /* 전체 2단 레이아웃 */
            .signup-layout {
                display: flex;
                height: 100vh;
            }

            /* 왼쪽 이미지 */
            .signup-visual {
                flex: 1;
                background: url('../../img/userProfile/회원가입용 사진2.jpg') no-repeat center center;
                background-size: cover;
            }

            /* 오른쪽 회원가입 폼 */
            .signup-form {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #f9f9f9;
                overflow-y: auto;
            }

            .join-container {
                max-width: 1280px;
                width: 100%;
                margin: auto;
                padding: 78px 200px;
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            }

            .section {
                margin-bottom: 24px;
            }

            .input-underline {
                width: 100%;
                padding: 10px 5px;
                font-size: 15px;
                border: none;
                border-bottom: 2px solid #ddd;
                outline: none;
                transition: border-color 0.3s;
                background-color: transparent;
            }

            .input-underline:focus {
                border-bottom-color: #4a90e2;
            }

            .inline-group {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .inline-btn {
                white-space: nowrap;
                padding: 10px 16px;
                font-size: 14px;
                background-color: rgb(110, 158, 255);
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .inline-btn:hover {
                background-color: rgb(0, 80, 255);
            }

            .label {
                font-weight: 600;
                margin-bottom: 6px;
                display: block;
                font-size: 14px;
                color: #333;
            }

            .radio-group {
                display: flex;
                gap: 20px;
                margin-top: 10px;
            }

            .btn-submit {
                width: 100%;
                padding: 14px;
                background-color: rgb(110, 158, 255);
                color: white;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-submit:hover {
                background-color: rgb(0, 80, 255);
            }

            .btn-main {
                margin-top: 10px;
                width: 100%;
                padding: 14px;
                background-color: #ccc;
                color: #333;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-main:hover {
                background-color: #aaa;
            }
        </style>
    </head>

    <body>

        <div id="app" class="signup-layout">
            <!-- 이미지 영역 -->
            <div class="signup-visual"></div>

            <!-- 폼 영역 -->
            <div class="signup-form">
                <div class="join-container">
                    <div class="section">
                        <label class="label">아이디</label>
                        <div class="inline-group">
                            <input class="input-underline" v-model="user.userId" :disabled="idFlg"
                                placeholder="영문, 숫자 포함 4~16자.">
                            <button class="inline-btn" v-if="!idFlg" @click="fnIdChecked()">중복체크</button>
                        </div>
                    </div>

                    <div class="section">
                        <label class="label">비밀번호</label>
                        <input class="input-underline" type="password" v-model="user.pwd"
                            placeholder="영문, 숫자, 특수문자 포함 8~20자 조합.">
                    </div>

                    <div class="section">
                        <label class="label">비밀번호 확인</label>
                        <input class="input-underline" type="password" v-model="user.pwdCheck">
                    </div>

                    <div class="section">
                        <label class="label">이름</label>
                        <input class="input-underline" v-model="user.userName"
                            placeholder="한글 또는 영문 입력. EX)김철수,brianKim">
                    </div>

                    <div class="section">
                        <label class="label">닉네임</label>
                        <div class="inline-group">
                            <input class="input-underline" v-model="user.nickName" :disabled="nickFlg"
                                placeholder="한글,영문,숫자 포함 1~8자.">
                            <button class="inline-btn" v-if="!nickFlg" @click="fnNickChecked()">중복체크</button>
                        </div>
                    </div>

                    <div class="section">
                        <label class="label">주소</label>
                        <div class="inline-group">
                            <input class="input-underline" v-model="user.address" disabled>
                            <button class="inline-btn" @click="fnSearchAddr()">주소검색</button>
                        </div>
                    </div>

                    <div class="section">
                        <label class="label">이메일</label>
                        <div class="inline-group">
                            <input class="input-underline" v-model="user.email" :disabled="emailFlg"
                                placeholder="이메일 입력">
                            <button class="inline-btn" v-if="!emailFlg" @click="fnEmailChecked()">인증번호</button>
                        </div>
                        <div class="inline-group" v-if="showVerification" style="margin-top: 10px;">
                            <input class="input-underline" v-model="authCode" placeholder="인증번호 입력">
                            <button class="inline-btn" @click="verifyCode">확인</button>
                        </div>
                        <p v-if="message" style="margin-top: 8px; color: #4a90e2;">{{ message }}</p>
                    </div>

                    <div class="section">
                        <label class="label">연락처</label>
                        <div class="inline-group">
                            <select class="input-underline" v-model="selectNum">
                                <option>010</option>
                                <option>011</option>
                                <option>017</option>
                            </select>
                            <input class="input-underline" v-model="num1" placeholder="1234" style="width: 80px;">
                            <input class="input-underline" v-model="num2" placeholder="5678" style="width: 80px;">
                        </div>
                    </div>

                    <div class="section">
                        <label class="label">생년월일</label>
                        <input class="input-underline" v-model="user.birthDate" placeholder="생년월일 8자리 혹은 미입력">
                    </div>

                    <div class="section">
                        <label class="label">성별</label>
                        <div class="radio-group">
                            <label><input type="radio" v-model="user.gender" value="M"> 남성</label>
                            <label><input type="radio" v-model="user.gender" value="F"> 여성</label>
                            <label><input type="radio" v-model="user.gender" value="N"> 비공개</label>
                        </div>
                    </div>

                    <button class="btn-submit" @click="fnJoin1()">회원가입</button>
                    <button class="btn-main" @click="fnMain()">취소</button>
                </div>
            </div>
        </div>

    </body>

    </html>
    <script>
        // vue 문법이 아니므로 밖으로 빼서 넣기
        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            //일단 다 받고 필요한거 꺼내쓰기
            window.vueObj.fnResult(roadFullAddr, roadAddrPart1, addrDetail, engAddr, zipNo);
        }



        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        user: { // 이렇게 맵으로 선언해서 한꺼번에 갖고 가기 쉽다
                            userId: "",
                            userName: "" || "${map.name}",
                            pwd: "",
                            address: "",
                            nickName: "",
                            phoneNumber: "",
                            birthDate: "",
                            gender: "M",
                            email: "" || "${map.email}",
                            agreeYn: "${map.agreeList}",
                            phoneYn: "${map.agreeSms}",
                            emailYn: "${map.agreeEmail}"
                        },
                        selectNum: "010",
                        num1: "",
                        num2: "",
                        idFlg: false,
                        nickFlg: false,
                        // authFlg: false,
                        pwdCheck: "",
                        emailFlg: false,
                        authCode: "",
                        showVerification: false,
                        message: "",
                        emailPattern: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, // 이메일 유효성 검사 정규식
                        passwordPattern: /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,20}$/,  // 정규식 적용
                        nickPattern: /^(?![0-9]+$)[가-힣a-zA-Z0-9]+$/, // 닉네임 유효성 검사 정규식
                        userNamePattern: /^[가-힣a-zA-Z]+$/,
                        idPattern: /^(?!\d+$)[a-zA-Z\d]{4,16}$/

                    };
                },
                computed: {

                },
                methods: {
                    fnJoin1() {
                        var self = this;

                        if (self.idFlg == false) {
                            alert("아이디를 중복체크 해주십시오.");
                            return;
                        }

                        if (!this.passwordPattern.test(self.user.pwd)) {
                            alert("비밀번호는 8~20자의 영문, 숫자, 특수문자를 포함해야 합니다.");
                            return false;
                        }

                        if (self.user.pwd != self.user.pwdCheck || self.user.pwd == "") {
                            alert("비밀번호가 일치하지 않습니다.");
                            return;
                        }
                        if (self.user.userName == "") {
                            alert("이름을 입력해주십시오.");
                            return;
                        }
                        if (!self.userNamePattern.test(self.user.userName)) {
                            alert("이름은 한글 또는 영문만 입력할 수 있습니다. EX)김철수,brianKim");
                            return;
                        }
                        if (self.nickFlg == false) {
                            alert("닉네임을 중복체크 해주십시오.");
                            return;
                        }
                        if (self.user.address == "") {
                            alert("주소를 입력해주십시오.");
                            return;
                        }
                        if (!self.emailFlg) {
                            alert("메일 인증 바랍니다.");
                            return;
                        }
                        if (self.num1.length != 4 || self.num2.length != 4) {
                            alert("전화번호는 4자리씩 입력바랍니다.");
                            return;
                        }
                        self.user.phoneNumber = self.selectNum + self.num1 + self.num2;
                        if (self.user.birthDate.length != 8 && self.user.birthDate.length != 0) {
                            alert("생년월일 8자리 혹은 미입력으로 진행해주십시오. ex)20050130");
                            return;
                        } else if (self.user.birthDate != "") {
                            // 연, 월, 일 분리
                            const year = parseInt(self.user.birthDate.substring(0, 4), 10);
                            const month = parseInt(self.user.birthDate.substring(4, 6), 10);
                            const day = parseInt(self.user.birthDate.substring(6, 8), 10);

                            // 날짜 유효성 검사
                            const date = new Date(year, month - 1, day);
                            if (
                                !(date.getFullYear() === year &&
                                    date.getMonth() === month - 1 &&
                                    date.getDate() === day)
                            ) {
                                alert("생년월일 8자리가 유효하지 않습니다. 재입력 바랍니다. ex)20050130");
                                return;
                            }
                        }

                        var nparmap = self.user;
                        // 파라미터에 해쉬맵(user)로 묶어서 보내는 방법도 있다
                        $.ajax({
                            url: "/user/join.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                alert("가입을 축하드립니다");
                                location.href = "/user/login.do";
                            }
                        });
                    },
                    fnIdChecked: function () {
                        var self = this;
                        if (self.user.userId.length < 4 || self.user.userId.length > 16) {
                            alert("아이디는 최소 4~16글자로 입력바랍니다.");
                            return;
                        }
                        if (!self.idPattern.test(self.user.userId)) {
                            alert('아이디는 영문, 숫자 조합만 사용할 수 있습니다.');
                            return;
                        }

                        var nparmap =
                        {
                            userId: self.user.userId,
                        }; // 유저아이디 하나만 보내기
                        $.ajax({
                            url: "/user/check.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.count == 0) {
                                    alert("사용 가능한 아이디입니다");
                                    self.idFlg = true;
                                    self.user.userId.disabled = true;
                                } else {
                                    alert("중복된 아이디입니다");
                                }
                            }
                        });
                    },
                    fnNickChecked: function () {
                        var self = this;
                        if (self.user.nickName.length > 8 || self.user.nickName == "") {
                            alert("닉네임은 한글,영문, 숫자 포함 8글자 이하로 입력가능합니다.");
                            return;
                        }
                        if (!self.nickPattern.test(self.user.nickName)) {
                            alert('닉네임은 한글, 영문, 숫자만 사용할 수 있습니다.');
                            return;
                        }

                        var nparmap =
                        {
                            nickName: self.user.nickName
                        };
                        $.ajax({
                            url: "/user/nickCheck.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.count == 0) {
                                    alert("사용 가능한 닉네임입니다");
                                    self.nickFlg = true;

                                } else {
                                    alert("중복된 닉네임입니다");
                                }
                            }
                        });
                    },
                    fnSearchAddr: function () {
                        window.open("/addr.do", "addr", "width=300, height=500")
                    },
                    fnResult: function (roadFullAddr, roadAddrPart1, addrDetail, engAddr, zipNo) {
                        let self = this;
                        self.user.address = roadFullAddr + ', ' + zipNo;

                    },

                    fnEmailChecked: function () {
                        var self = this;
                        if (!self.user.email) {
                            this.message = "이메일을 입력하세요.";
                            return;
                        }

                        if (!this.emailPattern.test(self.user.email)) {
                            this.message = "유효한 이메일 형식을 입력하세요.";
                            return;
                        }

                        var nparmap =
                        {
                            email: self.user.email
                        };
                        $.ajax({
                            url: "/user/emailCheck.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.count == 0) {
                                    self.sendEmailAuth();


                                } else {
                                    alert("중복된 이메일입니다");
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
                                body: JSON.stringify({ email: this.user.email })
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
                                body: JSON.stringify({ email: this.user.email, code: this.authCode })
                            });

                            const result = await response.json();
                            if (result.success) {
                                this.message = "이메일 인증이 완료되었습니다!";
                                this.showVerification = false;
                                this.emailFlg = true;
                            } else if (result.success2) {
                                this.message = "인증시간이 만료되었습니다. 인증코드를 다시 신청하십시오!";
                                this.showVerification = false;
                            } else {
                                this.message = "인증번호가 일치하지 않습니다.";
                            }
                        } catch (error) {
                            this.message = "서버 오류 발생.";
                        }
                    },
                    fnMain: function () {
                        location.href = "/main.do";
                    }
                },
                mounted() {
                    let self = this;
                    window.vueObj = this; //obj를 선언해야 주소가 들어간다
                    if (self.user.email != "") {
                        self.emailFlg = true;
                    }




                }
            });

            app.mount("#app");
        });
    </script>