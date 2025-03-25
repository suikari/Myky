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
    <h2>상품 사용후기</h2>
    <div class="form-box">
      <div class="form-group">
        <label for="title">제목</label>
        <input type="text" id="title" v-model="title">
      </div>
      <div class="form-group">
        <label>첨부파일1</label>
        <input type="file" id="file1" name="file1" accept=".jpg,.png">
      </div>
      <div class="form-group">
        <label>첨부파일2</label>
        <input type="file" id="file2" name="file2" accept=".jpg,.png">
      </div>
      <div class="form-group">
        <label>첨부파일3</label>
        <input type="file" id="file3" name="file3" accept=".jpg,.png">
      </div>
      <div class="form-group">
        <label>내용</label>
        <div style="flex: 1;">
          <div id="editor" class="editor-container"></div>
        </div>
      </div>
      <div class="button-box">
        <button class="btn-cancel" @click="fnCancel">취소</button>
        <button class="btn-submit" @click="fnSave">등록</button>
      </div>
    </div>
  </div>
  <jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>
  <script>
   
      const app = Vue.createApp({
        data() {
          return {
            title: "",
            reviewText: "",
            sessionRole: "${sessionRole}",
            productId: "${map.productId}",
            quill: null
          }
        },
        methods: {
          fnSave() {
            var self = this;
				var nparmap = {
                    title : self.title,
                    reviewText : self.reviewText,
                    sessionRole : self.sessionRole
                };
				$.ajax({
					url:"/product/add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if(data.result == "success"){
							alert("글쓰기 완료.");

                            if($("#file1")[0].files.length > 0){
                                var form = new FormData();
                                // form.append( "file1",  $("#file1")[0].files[0]);
                                for(let i=0; i<$("#file1")[0].files.length; i++){
                                    form.append( "file1",  $("#file1")[0].files[i]);
                                }
                                form.append( "reviewId",  data.reviewId); // 임시 pk 
                                self.upload(form);     //파일의 데이터가 크면 업로드 중간에 페이지 이동이 될수 있으니 주의!
                            }
						}else{
                            location.href = "/product/list.do";
                        }
					}
				});
          },
          //파일 업로드
          upload : function(form){
                var self = this;
                $.ajax({
                    url : "/Review/fileUpload.dox",
                    type : "POST",
                    processData : false,
                    contentType : false,
                    data : form,
                    success:function(response) { 
                        location.href = "/product/list.do";
                    }	           
                });
            },
            fnCancel : function() {
                pageChange("/product/view.do", {productId : this.productId});
            }
        },
        mounted() {
          this.quill = new Quill('#editor', {
            theme: 'snow',
            modules: {
              toolbar: [
                [{ header: [1, 2, false] }],
                ['bold', 'italic', 'underline'],
                [{ list: 'ordered' }, { list: 'bullet' }],
                ['link', 'image'],
                ['clean']
              ]
            }
          });
          quill.on('text-change', function() {
                self.contents = quill.root.innerHTML;
            });
        }
    }); 
    app.mount("#app");

</script>
