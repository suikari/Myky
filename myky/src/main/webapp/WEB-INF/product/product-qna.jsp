<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멍냥꽁냥 상품 문의</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>

        <style>
            body {
                font-family: 'Noto Sans KR', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #fff;
            }

            .container {
                max-width: 800px;
                margin: 50px auto;
                padding: 30px;
            }

            h2 {
                text-align: center;
                font-size: 26px;
                font-weight: bold;
                margin-bottom: 30px;
                color: #333;
            }

            .form-box {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 30px;
                background-color: white;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                font-size: 15px;
                /* color: #333; */
            }

            .form-group input[type="text"] {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                box-sizing: border-box;
            }

            .editor-container {
                height: 300px;
                border: 1px solid #ccc;
            }

            .button-box {
                margin-top: 30px;
                text-align: center;
            }

            .button-box button {
                padding: 10px 20px;
                font-weight: bold;
                margin: 0 10px;
                border: none;
                cursor: pointer;
            }

            .btn-submit {
                background-color: #7b61ff;
                color: white;
                margin-left: 10px;
            }

            .btn-submit:hover {
                background-color: #6a54e2;
            }

            .btn-cancel {
                background-color: #eee;
                color: #333;
            }

            .btn-cancel:hover {
                background-color: #ddd;
            }
        </style>



        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />
        <div id="app" class="container">
            <h2>멍냥꽁냥 상품 문의</h2>
            <div class="form-box">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" v-model="title">
                </div>

                <div class="form-group">
                    <label>내용</label>
                    <div style="flex: 1;">
                        <div id="editor" class="editor-container"></div>
                    </div>
                </div>

                <div class="button-box">
                    <button class="btn-cancel" @click="fnCancel()">문의 취소</button>
                    <button class="btn-submit" @click="fnSave()">문의 등록</button>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/common/footer.jsp" />


    </body>

    </html>
    <script>


        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        sessionId: "${sessionId}",
                        productId: "",
                        title: "",
                        questionText: "",
                        qnaId: ""
                    };
                },
                computed: {

                },
                methods: {
                    fnSave() {
                        var self = this;
                        var nparmap = {
                            title: self.title,
                            questionText: self.questionText,
                            userId: self.sessionId,
                            productId: self.productId
                        };
                        $.ajax({
                            url: "/product/qna.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                if (data.result == "success") {
                                    alert("문의 등록 완료");
                                    location.href = "/product/view.do?productId=" + self.productId;
                                }

                            }
                        });
                    },
                    fnCancel: function () {
                        location.href = "/product/view.do?productId=" + this.productId;
                    }
                },
                mounted() {
                    let self = this;
                    const params = new URLSearchParams(window.location.search);
                    self.productId = params.get("productId") || "";


                    var quill = new Quill('#editor', {
                        theme: 'snow',
                        modules: {
                            toolbar: [
                                [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                                ['bold', 'italic', 'underline'],
                                [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                                ['link', 'image'],
                                ['clean'],
                                [{ 'color': [] }, { 'background': [] }],
                            ]
                        }
                    });
                    quill.on('text-change', function () {
                        self.questionText = quill.root.innerHTML;
                    });
                }
            });

            app.mount("#app");
        });
    </script>