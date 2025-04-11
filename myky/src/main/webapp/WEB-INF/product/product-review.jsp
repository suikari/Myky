<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 사용후기</title>
        <script src="https://cdn.jsdelivr.net/npm/vue@3.2.37/dist/vue.global.prod.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        <link rel="stylesheet" href="/css/product/product.css" />
        <style>

        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />
        <div id="app" class="container">
            <h2>멍냥꽁냥 상품 사용후기</h2>
            <div class="form-box">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" v-model="title">
                </div>
                <div class="form-group star-rating">
                    <label class="rating-label" for="rating">별점</label>
                    <div class="stars">
                        <span v-for="star in 5" :key="star" class="star" :class="{ filled: star <= rating }"
                            @click="rating = star">★</span>
                    </div>
                </div>
                <div class="form-group">
                    <label>첨부파일1</label>
                    <input type="file" id="file1" name="file1" accept=".jpg,.png">
                </div>
                <div class="form-group">
                    <label>내용</label>
                    <div style="flex: 1;">
                        <div id="editor" class="editor-container"></div>
                    </div>
                </div>
                <div class="button-box">
                    <button class="btn-cancel" @click="fnCancel()">리뷰 취소</button>
                    <button class="btn-submit" @click="fnSave()">리뷰 등록</button>
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
                        reviewText: "",
                        rating: 1,
                        reviewId: ""
                    }
                },
                computed: {

                },
                methods: {
                    fnSave() {
                        var self = this;
                        if (!self.rating || self.rating < 1 || self.rating > 5) {
                            alert("별점을 1점 이상 선택해주세요.");
                            return;
                        }
                        if (!self.title || self.title.trim() === "") {
                            alert("제목을 입력해주세요.");
                            return;
                        }

                        if (!self.reviewText || self.reviewText.trim() === "" || self.reviewText === "<p><br></p>") {
                            alert("내용을 입력해주세요.");
                            return;
                        }

                        var nparmap = {
                            title: self.title,
                            reviewText: self.reviewText,
                            userId: self.sessionId,
                            rating: self.rating,
                            productId: self.productId
                        };
                        $.ajax({
                            url: "/product/add.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.result == "success") {
                                    alert("리뷰 작성 완료.");

                                    if ($("#file1")[0].files.length > 0) {
                                        var form = new FormData();
                                        for (let i = 0; i < $("#file1")[0].files.length; i++) {
                                            form.append("file1", $("#file1")[0].files[i]);
                                        }
                                        form.append("reviewId", data.reviewId);
                                        self.upload(form);

                                    } else {
                                        location.href = "/product/view.do?productId=" + self.productId;
                                    }
                                } else {
                                    location.href = "/product/view.do?productId=" + self.productId;
                                }

                            }
                        });
                    },
                    //파일 업로드
                    upload: function (form) {
                        var self = this;
                        $.ajax({
                            url: "/Review/fileUpload.dox",
                            type: "POST",
                            processData: false,
                            contentType: false,
                            data: form,
                            success: function (response) {
                                location.href = "/product/list.do";
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
                        self.reviewText = quill.root.innerHTML;
                    });
                }
            });
            app.mount("#app");
        });
    </script>