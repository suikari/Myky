<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>user info</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <link rel="stylesheet" href="/css/user/user.css" />
        <style>

        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />



        <div id="app">
            <div class="user-info-container">
                <template v-if="editFlg==false">
                    <div class="user-info-box">
                        <div class="user-info-label">유저아이디 :</div>
                        <div class="user-info-value">{{user.userId}}</div>
                    </div>
                    <div class="user-info-box">
                        <div class="user-info-label">이름 :</div>
                        <div class="user-info-value">{{user.userName}}</div>
                    </div>
                    <div class="user-info-box">
                        <div class="user-info-label">닉네임 :</div>
                        <div class="user-info-value">{{user.nickName}}</div>
                    </div>
                    <div class="user-info-box">
                        <div class="user-info-label">이메일 :</div>
                        <div class="user-info-value">{{user.email}}</div>
                    </div>
                    <div class="user-info-box">
                        <div class="user-info-label">생년월일 :</div>
                        <div class="user-info-value">{{user.birthDate}}</div>
                    </div>
                    <div class="user-info-box">
                        <div class="user-info-label">연락처 :</div>
                        <div class="user-info-value">{{user.phoneNumber}}</div>
                    </div>
                    <div class="user-info-box">
                        <div class="user-info-label">주소 :</div>
                        <div class="user-info-value">{{user.address}}</div>
                    </div>
                    <div class="user-info-box">
                        <div class="user-info-label">성별 :</div>
                        <div class="user-info-value">
                            <span v-if="user.gender == 'M'">남자</span>
                            <span v-if="user.gender == 'F'">여자</span>
                            <span v-if="user.gender == 'N'">비공개</span>
                        </div>
                    </div>
                    <div class="user-info-box">
                        <div class="user-info-label">SNS 수신:</div>
                        <div class="user-info-value">
                            <span v-if="user.phoneYn == 'Y'">동의</span>
                            <span v-else>미동의</span>
                        </div>
                    </div>
                    <div class="user-info-box">
                        <div class="user-info-label">이메일 수신:</div>
                        <div class="user-info-value">
                            <span v-if="user.emailYn == 'Y'">동의</span>
                            <span v-else>미동의</span>
                        </div>
                    </div>
                    <div class="user-info-btn-group">
                        <!-- 왼쪽 버튼 그룹 -->
                        <div class="user-info-btn-group-left">
                            <button class="user-info-btn" @click="fnEdit()">정보 수정</button>
                            <button class="user-info-btn" @click="fnPwd()">비밀번호 변경</button>
                        </div>

                        <!-- 오른쪽 버튼 (뒤로) -->
                        <div class="user-info-btn-group-right">
                            <button class="user-info-btn cancel" @click="fnExit()">뒤로</button>
                        </div>
                </template>



                <!-- 수정 칸 -->
                <template v-else>
                    <br>
                    <div class="profile-container">
                        <template v-if="!picFlg">
                            <span v-if="user.profileImage=='' ||user.profileImage==null">
                                <img src="/img/userProfile/Default-Profile-Picture.jpg" alt="프로필 이미지"
                                    class="profile-pic">
                            </span>
                            <span v-else>
                                <img :src="user.profileImage" alt="" class="profile-pic">
                            </span>
                        </template>
                        <template v-else>
                            <img :src="this.previewImage" alt="" class="profile-pic">
                        </template>
                    </div>

                    <div class="profile-btn-group">
                        <div class="file-upload">
                            <input type="file" id="file1" name="file1" accept=".jpg, .png" @change="uploadImage">
                            <label for="file1" class="custom-file-label">프로필 업로드</label>
                        </div>
                        <label @click="fnDeletePic()" class="custom-file-label">프로필 사진 삭제</label>
                    </div>



                    <div class="user-info-box2">
                        <div class="user-info-label">이름 :</div>
                        <input type="text" v-model="user.userName" class="user-info-input">
                    </div>

                    <div class="user-info-box">
                        <div class="user-info-label">닉네임 :</div>
                        <template v-if="!nickFlg">
                            <input type="text" v-model="user.nickName" class="user-info-input" disabled>
                            <button class="user-info-btn" @click="fnEditNick()">닉네임 변경</button>
                        </template>
                        <template v-else>
                            <input type="text" v-model="user.nickName" class="user-info-input">
                            <button class="user-info-btn" @click="fnNickChecked()">저장</button>
                            <button class="user-info-btn cancel" @click="fnExitNick()">취소</button>
                        </template>
                    </div>


                    <div class="user-info-box2">

                        <template v-if="emailFlg">
                            <label for="email" class="user-info-label">이메일 :</label>
                            <input id="email" class="user-info-input" v-model="user.email" disabled>
                            <button class="user-info-btn" @click="sendEmailEdit()">이메일 변경</button>
                        </template>

                        <template v-else>
                            <label for="email" class="user-info-label">이메일 :</label>
                            <input id="email" class="user-info-input" v-model="user.email" placeholder="이메일을 입력하세요"
                                class="user-info-input" />
                            <button class="user-info-btn" @click="fnEmailChecked">인증번호 받기</button>
                            <button class="user-info-btn" @click="sendEmailCancel()">인증 취소</button>
                        </template>
                    </div>

                    <div v-if="showVerification" class="user-info-box2">
                        <label for="email" class="user-info-label">인증번호:</label>
                        <input id="email" v-model="authCode" placeholder="인증번호 입력" class="user-info-input" />
                        <button class="user-info-btn" @click="verifyCode">인증 확인</button>
                    </div>

                    <div class="user-info-box2">
                        <div class="user-info-label">생년월일 :</div>
                        <input type="text" v-model="user.birthDate" class="user-info-input">
                    </div>

                    <div class="user-info-box2">
                        <div class="user-info-label">연락처 :</div>
                        <template v-if="!phoneFlg">
                            <div class="user-info-value">{{user.phoneNumber}}</div>
                            <button class="user-info-btn" @click="fnEditPhone()">연락처 변경</button>
                        </template>
                        <template v-else>
                            <select v-model="selectNum" class="user-info-input small">
                                <option value="010">010</option>
                                <option value="011">011</option>
                                <option value="017">017</option>
                            </select>
                            <input v-model="num1" class="user-info-input small">
                            <input v-model="num2" class="user-info-input small">
                            <button class="user-info-btn" @click="phoneSave()">변경</button>
                            <button class="user-info-btn cancel" @click="fnExitPhone()">취소</button>
                        </template>
                    </div>

                    <div class="user-info-box">
                        <div class="user-info-label">주소 :</div>
                        <input type="text" v-model="user.address" class="user-info-input" disabled>
                        <button class="user-info-btn" @click="fnSearchAddr()">주소검색</button>
                    </div>

                    <div class="user-info-box">
                        <div class="user-info-label">성별 :</div>
                        <div class="user-info-value">
                            <input type="radio" name="gender" value="M" v-model="user.gender"> 남성
                            <input type="radio" name="gender" value="F" v-model="user.gender"> 여성
                            <input type="radio" name="gender" value="N" v-model="user.gender"> 비공개
                        </div>
                    </div>

                    <div class="user-info-box">
                        <div class="user-info-label">SNS 수신 :</div>
                        <div class="user-info-value">
                            <input type="radio" name="sns" value="Y" v-model="user.phoneYn"> 동의
                            <input type="radio" name="sns" value="N" v-model="user.phoneYn"> 미동의
                        </div>
                    </div>

                    <div class="user-info-box">
                        <div class="user-info-label">이메일 수신 :</div>
                        <div class="user-info-value">
                            <input type="radio" name="email" value="Y" v-model="user.emailYn"> 동의
                            <input type="radio" name="email" value="N" v-model="user.emailYn"> 미동의
                        </div>
                    </div>

                    <div class="user-info-btn-group">
                        <button class="user-info-btn" @click="fnSave()">저장</button>
                        <button class="user-info-btn cancel" @click="fnExit()">뒤로</button>
                    </div>
                </template>
            </div>
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
                        userId: "${map.userId}",
                        user: {},
                        editFlg: false,
                        phoneFlg: false,
                        nickFlg: false,
                        authFlg: true,
                        originalNick: "",
                        originalPhone: "",
                        selectNum: "010",
                        num1: "",
                        num2: "",
                        previewImage: "",
                        picFlg: false,
                        emailPattern: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, // 이메일 유효성 검사 정규식
                        nickPattern: /^[가-힣a-zA-Z0-9]+$/, // 닉네임 유효성 검사 정규식
                        userNamePattern: /^[가-힣a-zA-Z]+$/,
                        emailFlg: true,
                        showVerification: false,
                        message: "",
                        authCode: "",
                        originalEmail: "",



                    };
                },
                computed: {

                },
                methods: {
                    fnInfo() {
                        var self = this;
                        var nparmap = {
                            userId: self.userId
                        };
                        $.ajax({
                            url: "/user/info.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.user = data.user;
                            }
                        });
                    },

                    fnSave: function () {
                        var self = this;
                        if (!self.authFlg) {
                            alert("닉네임 저장 혹은 취소 바랍니다.");
                            return;
                        }

                        if (self.user.userName == "") {
                            alert("이름을 입력해주십시오.");
                            return;
                        }

                        if (!self.userNamePattern.test(self.user.userName)) {
                            alert("이름은 한글 또는 영문만 입력할 수 있습니다.");
                            return;
                        }

                        if (self.user.profileImage == null) {
                            self.user.profileImage = "";
                        }

                        if (!self.emailFlg) {
                            alert("이메일 인증 혹은 취소를 해주십시오.");
                            return;
                        }

                        if (self.user.birthDate == null) {
                            self.user.birthDate = "";
                        }

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
                            const today = new Date(); // 이 줄을 추가!

                            if (
                                !(date.getFullYear() === year &&
                                    date.getMonth() === month - 1 &&
                                    date.getDate() === day)
                            ) {
                                alert("생년월일 8자리가 유효하지 않습니다. 재입력 바랍니다. ex)20050130");
                                return;
                            }
                                // 시험 해봐야 할 것들
                                if (date > today) {
                                alert("미래의 날짜는 생년월일로 사용할 수 없습니다.");
                                return;
                            }

                            if (year < 1900) {
                                alert("1900년 이후의 생년월일만 입력 가능합니다.");
                                return;
                            }
                            // 시험 해봐야 할 것들

                        }

                        var nparmap = self.user


                        $.ajax({
                            url: "/user/update.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                alert("수정 완료");

                                if ($("#file1")[0].files.length > 0) {
                                    var form = new FormData();
                                    //form.append( "file1",  $("#file1")[0].files[0]);
                                    for (let i = 0; i < $("#file1")[0].files.length; i++) {
                                        form.append("file1", $("#file1")[0].files[i]);
                                    }
                                    form.append("userId", data.userId); // 임시 pk
                                    self.upload(form);
                                } else {
                                    location.reload();
                                }


                            }
                        });
                    },

                    //파일 업로드
                    upload: function (form) {
                        var self = this;
                        $.ajax({
                            url: "/user/fileUpload.dox",
                            type: "POST",
                            processData: false,
                            contentType: false,
                            data: form,
                            success: function (response) {
                                location.reload()
                            }
                        });
                    },

                    fnEdit: function () {
                        let self = this;
                        self.editFlg = true;
                    },
                    fnExit: function () {
                        location.href = "/user/mypage.do";
                    },
                    fnPwd: function () {
                        let self = this;
                        pageChange("/user/resetpwd.do", { userId: self.user.userId });

                    },

                    fnEditNick: function () {
                        let self = this;
                        if (confirm("닉네임을 변경하시겠습니까?")) {
                            self.originalNick = self.user.nickName; // 현재 이름 저장
                            self.nickFlg = true;
                            self.authFlg = false;
                        } else {
                            return;
                        }
                    },
                    fnEditPhone: function () {
                        let self = this;
                        if (confirm("연락처를 새로 변경하시겠습니까?")) {
                            self.originalPhone = self.user.phoneNumber; // 현재 이름 저장
                            self.phoneFlg = true;
                        } else {
                            return;
                        }
                    },

                    fnExitNick: function () {
                        let self = this;
                        self.user.nickName = self.originalNick; // 원래 이름 복원
                        self.nickFlg = false;
                        self.authFlg = true;
                    },

                    fnExitPhone: function () {
                        let self = this;
                        self.user.phoneNumber = self.originalPhone; // 원래 이름 복원
                        self.phoneFlg = false;

                    },

                    fnNickChecked: function () {
                        var self = this;
                        if (self.user.nickName.length > 8 || self.user.nickName == "") {
                            alert("닉네임은 한글 8글짜 이하로 입력가능합니다.");
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
                                    self.nickFlg = false;
                                    self.authFlg = true;

                                } else {
                                    alert("중복된 닉네임입니다");
                                }
                            }
                        });
                    },

                    phoneSave: function () {
                        var self = this;
                        if (self.num1.length != 4 || self.num2.length != 4) {
                            alert("전화번호는 4자리씩 입력바랍니다.");
                            return;
                        }
                        self.user.phoneNumber = self.selectNum + self.num1 + self.num2;
                        alert("변경되었습니다");
                        self.phoneFlg = false;
                    },

                    fnSearchAddr: function () {
                        window.open("/addr.do", "addr", "width=300, height=500")
                    },
                    fnResult: function (roadFullAddr, roadAddrPart1, addrDetail, engAddr, zipNo) {
                        let self = this;
                        self.user.address = roadFullAddr + ', ' + zipNo;

                    },
                    //사진 미리보기
                    uploadImage(event) {
                        let self = this;
                        self.picFlg = true;
                        const file = event.target.files[0];
                        if (file) {
                            const reader = new FileReader();
                            reader.onload = (e) => {
                                // 단순히 미리보기를 위해 Base64 데이터 URL을 저장
                                this.previewImage = e.target.result;
                            };
                            reader.readAsDataURL(file);
                        }
                    },
                    fnDeletePic: function () {
                        let self = this;
                        if (confirm("프로필 사진을 삭제하시겠습니까?")) {
                            self.previewImage = "";
                            self.user.profileImage = "";
                            self.picFlg = false;
                            document.getElementById("file1").value = ""; // 파일 선택 필드 초기화


                        } else {
                            return;
                        }

                    },

                    fnEmailChecked: function () {
                        var self = this;
                        if (!self.user.email) {
                            alert("이메일을 입력하세요.");
                            return;
                        }

                        if (!this.emailPattern.test(self.user.email)) {
                            alert("유효한 이메일 형식을 입력하세요.");
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
                        alert("인증번호를 전송 했습니다.");


                        try {
                            const response = await fetch("/email/send-auth-code", {
                                method: "POST",
                                headers: { "Content-Type": "application/json" },
                                body: JSON.stringify({ email: this.user.email }),
                            });

                            const result = await response.json();
                            if (result.success) {
                                this.showVerification = true;
                                alert("인증번호가 발송되었습니다.");
                            } else {
                                alert("이메일 발송 실패.");
                            }
                        } catch (error) {
                            alert("서버 오류 발생");

                        }
                    },

                    async verifyCode() {
                        if (!this.authCode) {
                            return;
                        }

                        try {
                            const response = await fetch("/email/verify-auth-code", {
                                method: "POST",
                                headers: { "Content-Type": "application/json" },
                                body: JSON.stringify({ email: this.user.email, code: this.authCode }),
                            });

                            const result = await response.json();
                            if (result.success) {
                                alert("이메일 인증이 완료되었습니다!");
                                this.showVerification = false;
                                this.emailFlg = true;
                            } else if (result.success2) {
                                alert("인증시간이 만료되었습니다. 인증코드를 다시 신청하십시오!");
                                this.showVerification = false;
                            } else {
                                alert("인증번호가 일치하지 않습니다.");
                            }
                        } catch (error) {
                            alert("서버 오류 발생.");

                        }
                    },
                    sendEmailEdit: function () {
                        let self = this;
                        self.originalEmail = self.user.email;
                        self.emailFlg = false;
                    },
                    sendEmailCancel: function () {
                        let self = this;
                        self.user.email = self.originalEmail;
                        self.emailFlg = true;
                        self.showVerification = false;
                    }

                },
                mounted() {
                    window.vueObj = this; //obj를 선언해야 주소가 들어간다
                    let self = this;
                    self.fnInfo();

                }
            });

            app.mount("#app");
        });
    </script>