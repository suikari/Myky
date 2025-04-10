<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_1@1.0/font.css">
        <title>회사 정보</title>
        <style>
    .top-image {
        position: relative; /* 부모 div를 상대적으로 설정 */
        display: flex;
        justify-content: center;
        align-items: center; /* 수직 중앙 정렬 */
        width: 1280px; /* 고정 너비 */
        height: 700px; /* 높이는 원하는 크기로 설정 */
        background-image: url('/img/intro/intro1.jpg');
        background-size: cover;
        background-position: center;
        margin: 0 auto; /* 이미지가 페이지 중앙에 오도록 설정 */
    }
    .middle-image {
        position: relative; /* 부모 div를 상대적으로 설정 */
        display: flex;
        justify-content: center;
        align-items: center; /* 수직 중앙 정렬 */
        width: 1280px; /* 고정 너비 */
        height: 700px; /* 높이는 원하는 크기로 설정 */
        background-image: url('/img/intro/intro2.jpg');
        background-size: cover;
        background-position: center;
        margin: 0 auto; /* 이미지가 페이지 중앙에 오도록 설정 */
    }

    .topintroTitle1 {
        transform: translate(-470px, -120px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 35px; /* 글씨 크기 */
        font-weight: 450;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
        text-align: center; /* 텍스트 가운데 정렬 */
        width: 100%; /* 텍스트가 중앙에 위치하도록 너비 설정 */
        top: 40%; /* 첫 번째 줄 텍스트 위치 */
    }

    .middleintroTitle1 {
        transform: translate(210px, -190px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 20px; /* 글씨 크기 */
        font-weight: 450;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
        text-align: center; /* 텍스트 가운데 정렬 */
        width: 100%; /* 텍스트가 중앙에 위치하도록 너비 설정 */
        top: 40%; /* 첫 번째 줄 텍스트 위치 */
    }

    .middleintroTitle2 {
        transform: translate(210px, -90px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 20px; /* 글씨 크기 */
        font-weight: 450;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
        text-align: center; /* 텍스트 가운데 정렬 */
        width: 100%; /* 텍스트가 중앙에 위치하도록 너비 설정 */
        top: 40%; /* 첫 번째 줄 텍스트 위치 */
    }

    .middleintroTitle3 {
        transform: translate(178px, 0px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 20px; /* 글씨 크기 */
        font-weight: 450;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
        text-align: center; /* 텍스트 가운데 정렬 */
        width: 100%; /* 텍스트가 중앙에 위치하도록 너비 설정 */
        top: 40%; /* 첫 번째 줄 텍스트 위치 */
    }

    .middleintroTitle4 {
        transform: translate(175px, 85px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 20px; /* 글씨 크기 */
        font-weight: 450;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
        text-align: center; /* 텍스트 가운데 정렬 */
        width: 100%; /* 텍스트가 중앙에 위치하도록 너비 설정 */
        top: 40%; /* 첫 번째 줄 텍스트 위치 */
    }

    .topintroContent1 {
        font-weight: 450;
        transform: translate(-225px, -60px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 20px; /* 글씨 크기 */
        text-align: center; /* 텍스트 가운데 정렬 */
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
    }

    .topintroContent2 {
        transform: translate(-290px, 50px);
        position: absolute;
        color: white;
        font-size: 15px; /* 글씨 크기 설정 */
        text-align: left; /* 왼쪽 정렬 */
        line-height: 1.6; /* 줄 간격을 적당히 설정 */
        font-weight: normal;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
        padding: 10px; /* 텍스트 주변에 여백 추가 */
        border-radius: 8px; /* 경계선 둥글게 설정 */
    }
    .middleintroContent1{
        font-weight: 450;
        transform: translate(310px, -200px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 15px; /* 글씨 크기 */
        text-align: center; /* 텍스트 가운데 정렬 */
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
    }

    .middleintroContent2{
        font-weight: 450;
        transform: translate(320px, -100px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 15px; /* 글씨 크기 */
        text-align: center; /* 텍스트 가운데 정렬 */
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
    }

    .middleintroContent3{
        font-weight: 450;
        transform: translate(347px, -15px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 15px; /* 글씨 크기 */
        text-align: center; /* 텍스트 가운데 정렬 */
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
    }

    .middleintroContent4{
        font-weight: 450;
        transform: translate(320px, 70px);
        position: absolute; /* 텍스트를 이미지 위에 올리기 위해 위치 설정 */
        color: white; /* 글씨 색 */
        font-size: 15px; /* 글씨 크기 */
        text-align: center; /* 텍스트 가운데 정렬 */
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6); /* 그림자 효과 */
    }
</style>

        
        <body>
            <jsp:include page="/WEB-INF/common/header.jsp" />
        
            <div id="app">
                <div class="top-image">
                    <div class="topintroTitle1">
                        멍냥꽁냥
                    </div>
                    <div class="topintroContent1">
                        우리의 목표는 반려동물과 사람이 함께 더 행복한 세상을 만드는 것입니다.
                    </div>
                    <div class="topintroContent2">
                        "당신의 반려동물, 우리의 가족처럼"
                        <br>저희는 반려동물을 사랑하는 사람들을 위한 통합 플랫폼입니다.
                        <br>반려동물 용품 쇼핑부터 전문 수의사 상담, 그리고 내 주변 동물병원 검색까지!
                        <br>한 곳에서 모두 해결할 수 있는 편리한 서비스를 제공합니다.
                    </div>
                </div>
                <div class="middle-image">
                    <div class="middleintroTitle1">
                        믿을 수 있는 반려동물 용품 쇼핑
                    </div>
                    <div class="middleintroContent1">
                        엄선된 제품만을 제공하여, 아이들의 건강과 행복을 최우선으로 생각합니다.
                    </div>
                    <div class="middleintroTitle2">
                        동물 보호소를 위한 기부 플랫폼
                    </div>
                    <div class="middleintroContent2">
                        구매 시 일부 금액을 보호소에 기부하거나, 직접 기부에 참여하실 수 있습니다.
                    </div>
                    <div class="middleintroTitle3">
                        수의사 1:1 상담 게시판
                    </div>
                    <div class="middleintroContent3">
                        궁금한 점이 있다면 언제든지 수의사에게 질문하고, 신뢰할 수 있는 답변을 받아보세요.
                    </div>
                    <div class="middleintroTitle4">
                        내 주변 동물병원 찾기
                    </div>
                    <div class="middleintroContent4">
                        가까운 동물병원을 손쉽게 찾아, 위급한 순간에도 빠르게 대처할 수 있습니다.
                    </div>
                </div>
            </div>
        
            <jsp:include page="/WEB-INF/common/footer.jsp" />
        </body>
        

    <script>
        const app = Vue.createApp({
            data() {
                return {
                   
                };
            },
            computed: {
                


            }



            ,
            methods: {
                fnIntro() {
                   

                    $.ajax({
                        url: "/common/companyIntro.do",
                        type: "POST",
                        dataType: "json",
                        success: (data) => {
                            this.list = data.list;
                        }
                    });
                }
            },
            mounted() {
               
            }
        });

        app.mount('#app');
    </script>