<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 사용후기</title>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/vue@3.2.37/dist/vue.global.prod.js"></script>
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
                max-width: 1000px;
                margin: 40px auto;
                padding: 20px;
            }

            h2 {
                text-align: center;
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 30px;
            }

            .form-box {
                border: 1px solid #ddd;
                padding: 20px;
            }

            .form-group {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }

            .form-group label {
                width: 120px;
                font-weight: bold;
            }

            .form-group input[type="text"],
            .form-group input[type="file"] {
                flex: 1;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .rating-label {
                display: block;
                font-weight: bold;
                font-size: 16px;
                color: #000;
                margin-bottom: 6px;
            }

            .star-rating .stars {
                display: inline-block;
            }

            .star-rating .star {
                font-size: 24px;
                cursor: pointer;
                color: #eee;
                transition: color 0.2s;
                user-select: none;

            }

            .star-rating .star.filled {
                color: #f5b301;
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
                background-color: #000;
                color: white;
            }

            .btn-cancel {
                background-color: #eee;
                color: #333;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />
        <div id="app" class="container">
            <h2>리뷰 수정</h2>
            <div class="form-box">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" v-model="title">
                </div>
                <div class="form-group star-rating">
                    <label class="rating-label" for="rating">별점</label>
                    <div class="stars" :key="rating">
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
                    <button class="btn-cancel" @click="fnCancel">취소</button>
                    <button class="btn-submit" @click="fnEdit">등록</button>
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
                        rating : "",
                        reviewId: "",
                    }
                },
                computed: {

                },
                methods: {
                    fnGetReview(){
                        var self = this;
                        var nparmap = {
                            reviewId : self.reviewId,
                            option : "UPDATE"
                        };
                        $.ajax({
                            url:"/product/getReview.dox",
                            dataType:"json",	
                            type : "POST", 
                            data : nparmap,
                            success : function(data) { 
                                console.log(data);
                                self.productId = data.info.productId,
                                self.title = data.info.title,
                                self.reviewText = data.info.reviewText,
                                self.rating = data.info.rating
                                self.fnQuill();
                            }
                        });
                    },
                    fnEdit() {
                        var self = this;
                        var nparmap = {
                            reviewId: self.reviewId, 
                            title: self.title,
                            reviewText: self.reviewText,
                            userId: self.sessionId,
                            rating : self.rating,
                            productId : self.productId
                        };
                        $.ajax({
                            url: "/product/reviewEdit.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("1",data);
                                if (data.result == "success") {
                                    alert("수정 완료.");

                                    if ($("#file1")[0].files.length > 0) {
                                        var form = new FormData();
                                        for (let i = 0; i < $("#file1")[0].files.length; i++) {
                                            form.append("file1", $("#file1")[0].files[i]);
                                        }
                                        form.append("reviewId", self.reviewId); 
                                        self.upload(form); 
                                    
                                } else {
                                    console.log("2", self.productId);
                                        location.href = "/product/view.do?productId=" +  self.productId;
                                }
                            }else{
                                console.log("3","3");
                                    location.href = "/product/view.do?productId=" +  self.productId;
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
                                console.log("4","4");
                                location.href = "/product/view.do?productId=" +  self.productId;
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
                        quill.root.innerHTML = self.reviewText;
                        // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
                        quill.on('text-change', function () {
                            self.reviewText = quill.root.innerHTML;
                        });
                    }
                },
                mounted() {
                    let self = this;
                    const params = new URLSearchParams(window.location.search);
                    self.productId = params.get("productId") || "";
                    self.reviewId = params.get("reviewId") || "";
                    self.fnGetReview();
                }
            });
            app.mount("#app");
        });
    </script>