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



        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />



        <div id="app" class="container">

            <template v-if="editFlg==false">
                <div>
                    유저아이디 : {{user.userId}}
                </div>
                <div>
                    이름 : {{user.userName}}
                </div>
                <div>
                    닉네임 : {{user.nickName}}
                </div>
                <div>
                    이메일 : {{user.email}}
                </div>
                <div>
                    전화번호 : {{user.phoneNumber}}
                </div>
                <div>
                    전화번호 : {{user.birthDate}}
                </div>
                <div>
                    주소 : {{user.address}}
                </div>
                <div>
                    <button @click="fnEdit()">정보 수정</button>
                    <button @click="fnExit()">뒤로</button>
                </div>
            </template>

            <template v-else>
                <div>
                    아이디 : {{user.userId}}
                </div>
                <div>
                    이름 : <input type="text" :value="user.userName">
                </div>
                <div>
                    닉네임 : <input type="text" :value="user.nickName">
                </div>
                <div>
                    이메일 : <input type="text" :value="user.email">
                </div>
                <div>
                    전화번호 : <input type="text" :value="user.phoneNumber">
                </div>
                <div>
                    주소 : <input type="text" :value="user.address">
                </div>
                <div>
                    <button @click="fnSave()">저장</button>
                    <button @click="fnExit()">뒤로</button>
                </div>
            </template>


        </div>


        <jsp:include page="/WEB-INF/common/footer.jsp" />


    </body>

    </html>
    <script>


        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        userId: "${map.userId}",
                        user: {},
                        editFlg: false
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

                    fnSave  : function() {
                        var self = this;
                        var nparmap = self.user;
                        console.log(self.user.userName);
                        // $.ajax({
                        //     url: "/user/info.dox",
                        //     dataType: "json",
                        //     type: "POST",
                        //     data: nparmap,
                        //     success: function (data) {
                        //         console.log(data);
                        //         self.user = data.user;
                        //     }
                        // });
                    },

                    fnEdit: function () {
                        let self = this;
                        self.editFlg = true;
                    },
                    fnExit: function () {
                        location.href = "/user/myPage.do";
                    }

                },
                mounted() {
                    let self = this;
                    self.fnInfo();
                }
            });

            app.mount("#app");
        });
    </script>