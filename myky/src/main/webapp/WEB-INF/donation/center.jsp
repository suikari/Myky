<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>동물보호소 소개 페이지</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	
    <style>
    
.centerContainer {
    width: 1280px;
    font-family: Arial, sans-serif;
    margin: 20px auto;
    padding: 100px 0;
    text-align: center;
}

#boardTitle {
    margin: 20px 0;
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

.listContainer {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    padding: 20px;
}

.centerCard {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 15px;
    width: 280px;
    text-align: center;
    transition: transform 0.3s;
}

.centerCard:hover {
    transform: scale(1.05);
}

.centerImg {
    width: 100%;
    height: 180px;
    object-fit: cover;
    border-radius: 10px;
}

.centerName {
    font-size: 18px;
    font-weight: bold;
    margin: 10px 0;
    color: #444;
}

.centerAddr, .centerTel, .centerIntro {
    font-size: 14px;
    color: #666;
    margin: 5px 0;
}

div .donationBtn {
    display: inline-block;
    margin-top: 10px;
    margin-right: 10px;
    padding: 8px 15px;
    background-color: #FFBC7B;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    transition: background 0.3s;
    cursor: pointer;
}

div .donationBtn:hover {
    background-color: #FFA145;
}


    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/common/header.jsp" />
    <!-- 헤더 -->
    
    <div id="app" class="centerContainer">
        <div id="boardTitle"><h2>동물보호소 소개</h2></div>
		<div class="listContainer">
            <div class="centerCard" v-for="item in centerList">
                <img class="centerImg" :src="item.imageUrl">
                <p class="centerName">{{item.centerName}}</p>
                <p class="centerAddr">{{item.address}}</p>
                <p class="centerTel">{{item.tel}}</p>
                <p class="centerIntro">{{item.description}}</p>
                <div>
                    <a class="donationBtn" @click="fnCenterSite(item.websiteUrl)">사이트 방문</a>
                    <a class="donationBtn" @click="fnSelectCenter(item.centerId)">후원하기</a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/common/footer.jsp"/>
    <!-- 푸터 -->
    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        sessionId:"${sessionId}",
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
                            url:"/center/list.dox",
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
                        pageChange("/donation.do",{centerId:centerId});
                    },
                    fnCenterSite:function(websiteUrl){
                        // console.log(websiteUrl); >> url 정상 출력 확인
                        window.open(websiteUrl,"_blank");
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
