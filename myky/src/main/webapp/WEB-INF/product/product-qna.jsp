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
        <link rel="stylesheet" href="/css/product/product.css" />
        <style>

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

                        if (!self.title || self.title.trim() === "") {
                            alert("제목을 입력해주세요.");
                            return;
                        }
                        if (!self.questionText || self.questionText.trim() === "" || self.questionText === "<p><br></p>") {
                            alert("문의 내용을 입력해주세요.");
                            return;
                        }
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