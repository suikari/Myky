<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<script src="js/swiper8.js"></script>
	
    <link rel="stylesheet" href="css/main.css">
    <style>
        .content{
            width: 300px;
            height: 500px;
        }
        table, tr, th, td {
	    text-align: center;
	    border : 2px solid #bbb;
	    border-collapse: collapse;
	    padding : 5px;
	    }
        .textStyle{
                font-weight: bold;
                color : red;
        }
        .button{
            width:60px;
            height: 30px;
            background-color: rgb(16, 16, 65);
            color: rgb(222, 115, 38);
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div id="app" class="container">
            <!-- <div>
                <select v-model="searchOption">
                    <option value="all"> ::전체:: </option>
                    <option value="title"> 제목 </option>
                    <option value="userId"> 작성자 </option>
                </select>
                    <input v-model="keyword" @keyup.enter="fnListView" placeholder="검색어">
                    <button @click="fnListView">검색</button>
            </div>
                <select @change="fnListView" v-model="pageSize" >
                    <option value="5">5개씩</option>
                    <option value="10">10개씩</option>
                    <option value="15">15개씩</option>
                    <option value="20">20개씩</option>
                </select> -->
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
                <tr v-for="(item, index) in list">
                    <td>{{item.boardId}}</td>
                    <td>
                        <a href="javascript:;" @click="fnView(item.boardId)">{{item.title}}</a>
                    </td>
                    <td>{{item.userId}}</td>
                    <td>{{item.createdAt}}</td>
                    <td>{{item.cnt}}</td>
                </tr>
                <tr>
                </tr>
            </table>
            <div v-if="index > 0">
                <a href="javascript:;" @click="fnPageMove('prev')" v-if="page != 1"> < </a>
                <a href="javascript:;" v-for="num in index" @click="fnPage(num)">
                    <span v-if="page == num">{{num}}</span>
                    <span v-else >{{num}}</span>
                </a>
                <a href="javascript:;" @click="fnPageMove('next')"  v-if="page != index">> </a> 
            </div>
            <button class="button" @click="fnAdd">글쓰기</button>

    </div>
    <jsp:include page="../common/footer.jsp"/>

    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                       list : [],
                       boardId : "",
                       index : 0,
                       PageSize : 5,
                       page : 1,
                       searchOption: "",

                    };
                },
                computed: {
                    
                },
                methods: {
                    fnBoardList(){
                        let self= this;

                        let nparmap = {
                            searchOption : self.searchOption,
                            page : (self.page -1) * self.pageSize,
                            pageSize : self.pageSize,
                        };
                    $.ajax({
				    	url:"/board/list.dox",
				    	dataType:"json",	
				    	type : "POST", 
				    	data : nparmap,
				    	success : function(data) { 
				    		console.log(data);
                            self.list = data.board;
                            self.index = Math.ceil(data.count.cnt / self.pageSize);
                            console.log(data.count.cnt);
                        }
				        });
                    },
                    fnAdd : function (){   
                        let self= this;
                        pageChange("/board/edit.do", {});
                    },
                    fnView : function (boardId){
                        let self = this;
                        pageChange("/board/view.do", {boardId : boardId});
                    },
                    fnPage : function (num){
                        let self = this;
                        self.page = num;
                        self.fnBoardList();
                    },
                    fnPageMove : function(direction){
                        let self = this;
                        if (direction == "next"){
                            self.page++;
                        } else {
                            self.page--;
                        }
                        self.fnBoardList();
                    }
                },               
                mounted() {
                	let self = this;
                    self.fnBoardList();
                }
            });
            app.mount("#app");
        });
    </script>
