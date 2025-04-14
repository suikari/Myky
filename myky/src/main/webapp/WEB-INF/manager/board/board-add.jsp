<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }

        #app {
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #333;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 20px;
            box-sizing: border-box;
            background-color: #fff;
            transition: border-color 0.3s ease;
        }

        input:focus, textarea:focus {
            border-color: #1a73e8;
            outline: none;
        }

        button {
            padding: 12px 24px;
            font-size: 14px;
            font-weight: bold;
            background-color: #202060;
            color: #fca311;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
                background-color: #fca311;
                color: #202060;
        }
    </style>
    
    
</head>
<body>
 

    <div id="board" class="container">
        <div>
            <label>제목</label>
            <input v-model="title">
            <input type="file" id="file1" name="file1" accept=".jpg, .png" multiple>
        </div>
            <label>내용</label>
        <div style="width: 500px;">
            <div id="editor" style="height: 300px;"></div>
        </div>
        <div>
            <button @click="fnSave">저장</button>
        </div>
    </div>


    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const board = Vue.createApp({
                data() {
                    return {
                       title : "",
                       content : "",
                       sessionId : "${sessionId}",
                       boardId : "",                   
                    };
                },
                computed: {

                },
                methods: {
                    fnSave(){
                        let self = this;
                        let nparmap = {
                            title : self.title,
                            content : self.content,
                            userId : self.sessionId,
                        }
                        $.ajax({
				    	    url:"/board/add.dox",
				    	    dataType:"json",	
				    	    type : "POST", 
				    	    data : nparmap,
				    	    success : function(data) { 
				    	    	//console.log(data);
                                alert("저장되었습니다.")

                                if( $("#file1")[0].files.length > 0){
                                    var form = new FormData();
                                    for(let i=0; i<$("#file1")[0].files.length; i++){
                                        form.append( "file1",  $("#file1")[0].files[i]);
                                    }
                                    form.append( "boardId", data.boardId); // 임시 pk
                                    self.upload(form); 
                                    location.href="/board/list.do"
                                } else {
                                    location.href="/board/list.do"
                                }
                            }
				        });
                    },
                     //파일업로드
                    upload : function(form){
                    	var self = this;
                    	 $.ajax({
                    		 url : "/fileUpload.dox"
                    	   , type : "POST"
                    	   , processData : false
                    	   , contentType : false
                    	   , data : form
                    	   , success:function(response) { 
                        
                    	   }	           
                       });
                    }
                
                },
                mounted() {
                    let self = this;                	
                	var quill = new Quill('#editor', {
                    theme: 'snow',
                    modules: {
                        toolbar: [
                            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                            ['bold', 'italic', 'underline'],
                            [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                            ['link', 'image'],
                            ['clean'],
                            [{ 'color': [] }, { 'background': [] }],  
                        ]
                    }
                });
                    quill.on('text-change', function() {
                        self.content = quill.root.innerHTML;
                    });
                }
            });

            board.mount("#board");
        });
    </script>
