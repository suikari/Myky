<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <script src="/js/page-change.js"></script> -->
        <title>Vue3 레이아웃 예제</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>



        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />



        <div id="app" class="container">
            <div>
                <template v-if="!idFlg">
                    아이디 : <input v-model="user.userId">
                    <span><button @click="fnIdChecked()" >중복체크</button></span>
                </template>
                <template v-else>
                    아이디 : <input v-model="user.userId" disabled>
                </template>
                <!-- <button @click="fnView(user.userId)">상세정보가기(임시)</button> -->

            </div>
            <div>
                비밀번호 : <input type="password" v-model="user.pwd">
            </div>
            <div>
                비밀번호 확인 : <input type="password" v-model="user.pwdCheck">
            </div>
            <div>
                이름 : <input v-model="user.userName">
            </div>
            <div>
                <template v-if="!nickFlg">
                    닉네임 : <input v-model="user.nickName">
                </template>
                <template v-else>
                    닉네임 : <input v-model="user.nickName" disabled>
                </template>

                <button @click="fnNickChecked()">중복체크</button>
            </div>
            <div>
                주소 : <input v-model="user.address" disabled>
                <button @click="fnSearchAddr()">주소검색</button>
            </div>
            <div>
                이메일 : <input v-model="user.email">
            </div>
            <div>
                연락처: 
                <select v-model = "selectNum">
                    <option value="010">010</option>
                    <option value="011">011</option>
                    <option value="017">017</option>
                </select>
                <span>
                    -<input v-model="num1" style="width: 40px;">
                    -<input v-model="num2" style="width: 40px;">
                </span>
                <button @click="numCheck()">인증버튼</button>
            </div>

            <div>
                생년월일 : <input v-model="user.birthDate">
            </div>

            <div>
                성별:
                <input type="radio" name="gender" value="M" v-model="user.gender">남성
                <input type="radio" name="gender" value="F" v-model="user.gender">여성
                <input type="radio" name="gender" value="N" v-model="user.gender">비공개
            </div>

            <button @click="fnJoin1()">정보 저장</button>
        </div>


        <jsp:include page="/WEB-INF/common/footer.jsp" />


    </body>

    </html>
    <script>
        // vue 문법이 아니므로 밖으로 빼서 넣기
        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            //일단 다 받고 필요한거 꺼내쓰기
            window.vueObj.fnResult(roadFullAddr, roadAddrPart1, addrDetail, engAddr);
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
                            email:""
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
                    fnResult: function (roadFullAddr, roadAddrPart1, addrDetail, engAddr) {
                        let self = this;
                        self.user.address = roadFullAddr;

                        console.log(roadFullAddr);
                        console.log(roadAddrPart1);
                        console.log(addrDetail);
                        console.log(engAddr);
                    }
                },
                mounted() {
                    window.vueObj=this; //obj를 선언해야 주소가 들어간다
                }
            });

            app.mount("#app");
        });
    </script>