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
                    <button class="btn-cancel" @click="fnCancel()">수정 취소</button>
                    <button class="btn-submit" @click="fnEdit()">문의 수정</button>
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
                    fnGetQna() {
                        var self = this;
                        var nparmap = {
                            qnaId: self.qnaId,
                            option: "UPDATE"
                        };
                        $.ajax({
                            url: "/product/getQna.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.productId = data.info.productId,
                                self.title = data.info.title,
                                self.questionText = data.info.questionText,
                                self.fnQuill();
                            }
                        });
                    },
                    fnEdit() {
                        var self = this;
                        var nparmap = {
                            qnaId: self.qnaId,
                            title: self.title,
                            questionText: self.questionText,
                            userId: self.sessionId,
                            productId: self.productId
                        };
                        $.ajax({
                            url: "/product/qnaEdit.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.result == "success") {
                                    alert("수정 완료.");
                                    location.href = "/product/view.do?productId=" +  self.productId;
                                }
                            }
                        });
                    },
                    //취소
                    fnCancel: function () {
                        location.href = "/product/view.do?productId=" +  this.productId;
                    },
                    fnQuill() {
                        let self = this;
                        var quill = new Quill('#editor', {
                            theme: 'snow',
                            modules: {
                                toolbar: [
                                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                                    ['bold', 'italic', 'underline'],
                                    [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                                    ['link', 'image'],
                                    ['clean'],
                                    [{ 'color': [] }, { 'background': [] }]
                                ]
                            }
                        });
                        quill.root.innerHTML = self.questionText;
                        // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
                        quill.on('text-change', function () {
                            self.questionText = quill.root.innerHTML;
                        });
                    }
                },
                mounted() {
                    let self = this;
                    const params = new URLSearchParams(window.location.search);
                    self.productId = params.get("productId") || "";
                    self.qnaId = params.get("qnaId") || "";
                    self.fnGetQna();

                }
            });

            app.mount("#app");
        });
    </script>