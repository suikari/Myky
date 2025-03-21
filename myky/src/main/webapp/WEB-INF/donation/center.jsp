<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>동물보호소 소개 페이지</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<script src="js/swiper8.js"></script>
	
    <link rel="stylesheet" href="css/main.css">
    <style>
    


    </style>
</head>
<body>
    <jsp:include page="common/header.jsp"/>
    <!-- 헤더 -->

    <div id="app" class="container">
        <div id="boardTitle"><h2>동물보호소 소개</h2></div>
		<div class="listContainer">
            <div class="centerCard" v-for="item in centerList">
                <img class="centerImg" :src="item.imageUrl">
                <p class="centerName">{{item.centerName}}</p>
                <p class="centerAddr">{{item.address}}</p>
                <p class="centerTel">{{item.tel}}</p>
                <p class="centerIntro">{{item.description}}</p>
                <div><a @click="fnSelectCenter({{item.centerId}})">후원하기</a></div>
            </div>
        </div>
    </div>

    <jsp:include page="common/footer.jsp"/>
    <!-- 푸터 -->
    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        centerList:[]  
                    
                    };
                },
                computed: {

                },
                methods: {
                    fnGetCenter(){
                        var self = this;
                        var nparmap = {
                            
                        };
                        $.ajax({
                            url:"center.dox",
                            dataType:"json",	
                            type : "POST", 
                            data : nparmap,
                            success : function(data) { 
                                console.log(data);
                                self.centerList = data.list;
                                
                            }
                        });
                    },
                    fnSelectCenter:function(centerId){
                        pageChange("/donete.do",{centerId:centerId});
                    }
                },
                mounted() {
                	var self = this;
                    self.fnGetCenter();
                	
                }
            });

            app.mount("#app");
        });
    </script>
