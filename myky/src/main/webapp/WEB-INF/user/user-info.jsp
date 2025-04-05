<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>유저 정보</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            /* 전체 컨테이너 */
            .user-info-container {
                max-width: 600px;
                margin: 30px auto;
                padding: 20px;
                border-radius: 10px;
                background: #f9f9f9;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            /* 프로필 컨테이너 작업 */

            .profile-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                /* 가운데 정렬 */
                margin-right: 15px;
            }

            .profile-pic {
                width: 150px;
                height: 150px;
                background: gray;
                border-radius: 100%;
            }

            .profile-container button {
                margin-top: 10px;
                padding: 5px 10px;
                border: none;
                background: #007bff;
                color: white;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
            }

            .profile-container button:hover {
                background: #0056b3;
            }

            /* 개별 항목 스타일 */
            .user-info-box {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 12px;
                border-bottom: 1px solid #ddd;
            }

            .user-info-box2 {
                display: flex;
                align-items: center;
                justify-content: left;
                padding: 12px;
                gap: 10px;
                border-bottom: 1px solid #ddd;
            }

            /* 라벨 (항목 제목) 스타일 */
            .user-info-label {
                font-weight: bold;
                color: #333;
            }

            /* 값 (텍스트 데이터) 스타일 */
            .user-info-value {
                color: #666;
            }

            /* 입력 필드 스타일 */
            .user-info-input {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                width: 60%;
            }

            /* 작은 입력 필드 (전화번호) */
            .user-info-input.small {
                width: 75px;
                text-align: left;
            }

            /* 버튼 스타일 */
            .user-info-btn {
                background: #4CAF50;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 5px;
                cursor: pointer;
                transition: 0.3s;
            }

            .user-info-btn:hover {
                background: #45a049;
            }

            /* 취소 버튼 (빨간색) */
            .user-info-btn.cancel {
                background: #f44336;
            }

            .user-info-btn.cancel:hover {
                background: #d32f2f;
            }

            /* 버튼 그룹 정렬 */
            .user-info-btn-group {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            /* 왼쪽 버튼 그룹 */
            .user-info-btn-group-left {
                display: flex;
                gap: 10px;
                /* 버튼 간격 */
            }

            /* 오른쪽 버튼 (뒤로) */
            .user-info-btn-group-right {
                margin-left: auto;
                /* 자동 마진으로 오른쪽 정렬 */
            }

            /* 파일 업로드 버튼 감추기 */
            .file-upload input[type="file"] {
                display: none;
            }

            /* 사용자 정의 업로드 버튼 스타일 */
            .custom-file-label {
                display: inline-block;
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                text-align: center;
                transition: background-color 0.3s;
            }

            /* 마우스 호버 효과 */
            .custom-file-label:hover {
                background-color: #45a049;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />



        <div id="app" class="user-info-container">
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
                    <div class="user-info-label">SNS 수신동의 :</div>
                    <div class="user-info-value">
                        <span v-if="user.phoneYn == 'Y'">수신</span>
                        <span v-else>미수신</span>
                    </div>
                </div>
                <div class="user-info-box">
                    <div class="user-info-label">이메일 수신동의 :</div>
                    <div class="user-info-value">
                        <span v-if="user.emailYn == 'Y'">수신</span>
                        <span v-else>미수신</span>
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
                        <img :src="user.profileImage" alt="" class="profile-pic">
                    </template>
                    <template v-else>
                        <img :src="this.previewImage" alt="" class="profile-pic">
                    </template>
                </div>

                <div class="file-upload">
                    <input type="file" id="file1" name="file1" accept=".jpg, .png" @change="uploadImage">
                    <label for="file1" class="custom-file-label">프로필 업로드</label>
                </div>
                <div>
                    <button class="custom-file-label" @click="fnDeletePic()">프로필 사진 삭제</button>
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

                <!-- <div class="user-info-box2">
                    <div class="user-info-label">이메일 :</div>
                    <input type="text" v-model="user.email" class="user-info-input">
                    <button @click="sendEmailAuth">인증번호 받기</button>
                </div> -->

                <div class="user-info-box2">
                    <template v-if="!emailFlg">
                        <label for="email" class="user-info-label">이메일 :</label>
                        <input id="email" class="user-info-input" v-model="user.email" placeholder="이메일을 입력하세요" class="user-info-input" />
                        <button class="user-info-btn" @click="sendEmailAuth">인증번호 받기</button>
                    </template>
                

                    <template v-else>
                        <label for="email" class="user-info-label">이메일 :</label>
                        <input id="email" class="user-info-input" v-model="user.email" disabled>
                    </template>
                </div>
                    <div v-if="showVerification">
                        <input type="text" v-model="authCode" placeholder="인증번호 입력" class="user-info-input"/>
                        <button class="user-info-btn" @click="verifyCode">인증 확인</button>
                    </div>

                    <p v-if="message">{{ message }}</p>
                
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
                    <div class="user-info-label">SNS 수신동의 :</div>
                    <div class="user-info-value">
                        <input type="radio" name="sns" value="Y" v-model="user.phoneYn"> 수신
                        <input type="radio" name="sns" value="N" v-model="user.phoneYn"> 미수신
                    </div>
                </div>

                <div class="user-info-box">
                    <div class="user-info-label">이메일 수신동의 :</div>
                    <div class="user-info-value">
                        <input type="radio" name="email" value="Y" v-model="user.emailYn"> 수신
                        <input type="radio" name="email" value="N" v-model="user.emailYn"> 미수신
                    </div>
                </div>

                <div class="user-info-btn-group">
                    <button class="user-info-btn" @click="fnSave()">저장</button>
                    <button class="user-info-btn cancel" @click="fnExit()">뒤로</button>
                </div>
            </template>


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
                        emailFlg: false,
                        showVerification: false,
                        message: "",
                        authCode: ""


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
                        console.log(self.userId);
                        $.ajax({
                            url: "/user/info.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
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
                            alert("이름을 1자 이상 적어주십시오.");
                            return;
                        }
                        if (self.user.profileImage == null) {
                            self.user.profileImage = "";
                        }
                        if (self.user.email == null) {
                            self.user.email = "";
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
                            if (
                                !(date.getFullYear() === year &&
                                    date.getMonth() === month - 1 &&
                                    date.getDate() === day)
                            ) {
                                alert("생년월일 8자리가 유효하지 않습니다. 재입력 바랍니다. ex)20050130");
                                return;
                            }
                        }

                        var nparmap = self.user

                        console.log(nparmap);
                        $.ajax({
                            url: "/user/update.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                alert("수정 완료");
                                console.log(data);

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

                        console.log(roadFullAddr);
                        console.log(roadAddrPart1);
                        console.log(addrDetail);
                        console.log(engAddr);
                        console.log(zipNo);
                    },
                    //사진 미리보기
                    uploadImage(event) {
                        let self = this;
                        self.picFlg = true;
                        console.log(self.picFlg);
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

                    async sendEmailAuth() {
                        let self = this;
                        if (!self.user.email) {
                            alert("이메일을 입력하세요.");
                            return;
                        }

                        if (!this.emailPattern.test(self.user.email)) {
                            alert("유효한 이메일 형식을 입력하세요.");
                            return;
                        }
                        this.message = "인증번호를 전송 중...";
                        alert("인증번호를 전송 했습니다.");


                        try {
                            const response = await fetch("/email/send-auth-code", {
                                method: "POST",
                                headers: { "Content-Type": "application/json" },
                                body: JSON.stringify({ email: this.user.email })
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