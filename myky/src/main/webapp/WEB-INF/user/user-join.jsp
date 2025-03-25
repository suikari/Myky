<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>join page</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }

    .container {
        width: 80%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .label {
        font-size: 16px;
        font-weight: bold;
        margin-bottom: 8px;
        display: inline-block;
    }

    /* 아이디 섹션 */
    .user-id-section {
        margin-bottom: 20px;
    }

    .input-field {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    .btn-check {
        padding: 8px 16px;
        font-size: 14px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .btn-check:hover {
        background-color: #45a049;
    }

    /* 비밀번호 섹션 */
    .password-section,
    .password-confirm-section,
    .name-section,
    .nickname-section,
    .address-section,
    .email-section,
    .phone-section,
    .birthdate-section,
    .gender-section {
        margin-bottom: 20px;
    }

    /* 전화번호 입력 섹션 */
    .phone-section .phone-select,
    .phone-section .phone-input {
        display: inline-block;
        width: 32%;
        padding: 10px;
        margin-top: 5px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    .btn-phone-check {
        padding: 8px 16px;
        font-size: 14px;
        background-color: #FF5722;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .btn-phone-check:hover {
        background-color: #e64a19;
    }

    /* 성별 라디오 버튼 */
    .gender-section input[type="radio"] {
        margin-right: 10px;
    }

    /* 정보 저장 버튼 */
    .btn-submit {
        padding: 12px 24px;
        font-size: 16px;
        background-color: #2196F3;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
    }

    .btn-submit:hover {
        background-color: #1976D2;
    }

    /* 주소 검색 버튼 */
    .btn-address-search {
        padding: 8px 16px;
        font-size: 14px;
        background-color: #FFC107;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .btn-address-search:hover {
        background-color: #ff9800;
    }

    /* 모바일 스타일을 고려한 반응형 디자인 */
    @media (max-width: 768px) {
        .container {
            width: 90%;
            padding: 15px;
        }

        .input-field,
        .btn-check,
        .btn-submit,
        .btn-phone-check,
        .btn-address-search {
            width: 100%;
            box-sizing: border-box;
        }

        .phone-section .phone-select,
        .phone-section .phone-input {
            width: 32%;
        }
    }


        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />
    
        <div id="app" class="container">
            <div class="user-id-section">
                <template v-if="!idFlg">
                    <label for="userId" class="label">아이디 :</label>
                    <input id="userId" class="input-field user-id" v-model="user.userId">
                    <span><button class="btn-check" @click="fnIdChecked()">중복체크</button></span>
                </template>
                <template v-else>
                    <label for="userId" class="label">아이디 :</label>
                    <input id="userId" class="input-field user-id" v-model="user.userId" disabled>
                </template>
            </div>
    
            <div class="password-section">
                <label for="password" class="label">비밀번호 :</label>
                <input id="password" class="input-field password" type="password" v-model="user.pwd">
            </div>
    
            <div class="password-confirm-section">
                <label for="passwordCheck" class="label">비밀번호 확인 :</label>
                <input id="passwordCheck" class="input-field password-check" type="password" v-model="user.pwdCheck">
            </div>
    
            <div class="name-section">
                <label for="userName" class="label">이름 :</label>
                <input id="userName" class="input-field name" v-model="user.userName">
            </div>
    
            <div class="nickname-section">
                <template v-if="!nickFlg">
                    <label for="nickName" class="label">닉네임 :</label>
                    <input id="nickName" class="input-field nickname" v-model="user.nickName">
                </template>
                <template v-else>
                    <label for="nickName" class="label">닉네임 :</label>
                    <input id="nickName" class="input-field nickname" v-model="user.nickName" disabled>
                </template>
                <button class="btn-check" @click="fnNickChecked()">중복체크</button>
            </div>
    
            <div class="address-section">
                <label for="address" class="label">주소 :</label>
                <input id="address" class="input-field address" v-model="user.address" disabled>
                <button class="btn-address-search" @click="fnSearchAddr()">주소검색</button>
            </div>
    
            <div class="email-section">
                <label for="email" class="label">이메일 :</label>
                <input id="email" class="input-field email" v-model="user.email">
            </div>
    
            <div class="phone-section">
                <label for="phone" class="label">연락처 :</label>
                <select id="phone" class="input-field phone-select" v-model="selectNum">
                    <option value="010">010</option>
                    <option value="011">011</option>
                    <option value="017">017</option>
                </select>
                <span>
                    -<input class="phone-input" v-model="num1" style="width: 40px;">
                    -<input class="phone-input" v-model="num2" style="width: 40px;">
                </span>
                <button class="btn-phone-check" @click="numCheck()">인증버튼</button>
            </div>
    
            <div class="birthdate-section">
                <label for="birthDate" class="label">생년월일 :</label>
                <input id="birthDate" class="input-field birthdate" v-model="user.birthDate">
            </div>
    
            <div class="gender-section">
                <label class="label">성별:</label>
                <input type="radio" name="gender" value="M" v-model="user.gender">남성
                <input type="radio" name="gender" value="F" v-model="user.gender">여성
                <input type="radio" name="gender" value="N" v-model="user.gender">비공개
            </div>
    
            <button class="btn-submit" @click="fnJoin1()">정보 저장</button>
        </div>
    
        <jsp:include page="/WEB-INF/common/footer.jsp" />
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
                            userName: "",
                            pwd: "",
                            address: "",
                            nickName: "",
                            phoneNumber: "",
                            birthDate: "",
                            gender: "M",
                            email:"",
                            agreeYn:"${map.agree2}",
                            phoneYn:"${map.agree3}",
                            emailYn:"${map.agree4}"
                        },
                        selectNum: "010",
                            num1: "",
                            num2: "",
                        idFlg: false,
                        nickFlg: false,
                        authFlg: false,
                        pwdCheck: ""

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
                        if (self.user.pwd.length < 8 || self.user.pwd.length > 20) {
                            alert("비밀번호는 최소 8~20글짜로 입력바랍니다.(특수문자,영문,숫자 포함)");
                            return;
                        }
                        if (self.user.pwd != self.user.pwdCheck || self.user.pwd == "") {
                            alert("비밀번호가 일치하지 않습니다.");
                            return;
                        }
                        if (self.user.userName == "") {
                            alert("이름을 입력해주십시오.");
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
                        if (self.num1.length != 4 || self.num2.length != 4) {
                            alert("전화번호는 4자리씩 입력바랍니다.");
                            return;
                        }
                        self.user.phoneNumber = self.selectNum + self.num1 + self.num2;

                        if (!self.authFlg) {
                            alert("문자인증 바랍니다.");
                            return;
                        }

                        console.log(self.user);
                        var nparmap = self.user;
                         // 파라미터에 해쉬맵(user)로 묶어서 보내는 방법도 있다
                        $.ajax({
                        	url:"/user/join.dox",
                        	dataType:"json",	
                        	type : "POST", 
                        	data : nparmap,
                        	success : function(data) { 
                        		console.log(data);
                                alert("가입을 축하드립니다");
                                location.href="/user/login.do";
                        	}
                        });
                    },
                    fnIdChecked: function () {
                        var self = this;
                        if (self.user.userId.length < 4 || self.user.userId.length > 16) {
                            alert("아이디는 최소 4~16글짜로 입력바랍니다.");
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
                                console.log(data);
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
                    fnNickChecked : function(){
                        var self = this;
                        if (self.user.nickName.length > 8 || self.user.nickName =="") {
                            alert("닉네임은 한글 8글짜 이하로 입력가능합니다.");
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
                                console.log(data);
                                if (data.count == 0) { 
                                    alert("사용 가능한 닉네임입니다");
                                    self.nickFlg = true;

                                } else {
                                    alert("중복된 닉네임입니다");
                                }
                            }
                        });
                    },
                    numCheck : function () {
                        var self = this;
                        alert("인증되었습니다(임시)");
                        self.authFlg = true;
                        console.log(self.authFlg);
                    },
                    // fnView: function (userId) {
                    //     pageChange("/user/info.do", { userId: userId });

                    // },
                    fnSearchAddr: function () {
                        window.open("/addr.do", "addr", "width=300, height=500")
                    },
                    fnResult: function (roadFullAddr, roadAddrPart1, addrDetail, engAddr,zipNo) {
                        let self = this;
                        self.user.address = roadFullAddr + ', ' +zipNo;

                        console.log(roadFullAddr);
                        console.log(roadAddrPart1);
                        console.log(addrDetail);
                        console.log(engAddr);
                        console.log(zipNo);
                    }
                },
                mounted() {
                    window.vueObj=this; //obj를 선언해야 주소가 들어간다
                    console.log(this.user.agreeYn);
                    console.log(this.user.phoneYn);
                    console.log(this.user.emailYn);
                }
            });

            app.mount("#app");
        });
    </script>