<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        #app {
            padding-bottom: 120px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        /* 공지사항 제목 */
        .section-header {
            /* background-color: #202060; */
            color: #202060;
            font-weight: bold;
            height: 70px;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
            align-items: center;
            justify-content: center;
            display: flex;
            align-items: left; /* 세로 중앙 정렬 */
            justify-content: left; /* 가로 중앙 정렬 */
            font-size: 40px;
            margin-top: 80px;
            width: 100%;
            max-width: 1000px;
        } 
        .section-headerDown {
            color: #333;
            font-weight: bold;
            text-align: left;
            margin-top: -10px;
            width: 100%;
            max-width: 1000px;
        }
        .search-wrapper {
            width: 90%;
            margin: 20px auto;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            flex-wrap: wrap;
        }
        .search-left,
        .search-right {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 3px;
        }
        .search-left select,
        .search-left input,
        .search-left button,
        .search-right select {
            height: 38px;
            font-size: 14px;
            border-radius: 6px;
            padding: 0 12px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        .search-left input {
            width: 220px;
            background-color: #f0f0f0;
            border: 2px solid #202060;
            border-radius: 30px;
            transition: all 0.3s ease;
        }
        .search-left input:focus {
            background-color: #fff;
            border-color: #fca311;
        }
        .search-left button {
            background-color: #202060;
            color: #fca311;
            border: none;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .search-left button:hover {
            background-color: #fca311;
            color: #202060;
        }
        .table-wrapper {
            width: 90%;
            margin: 30px auto;
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
        }
        th {
            background-color: #202060;
            color: #fca311;
            padding: 12px;
            font-weight: 600;
            font-size: 15px;
        }
        td {
            padding: 12px;
            font-size: 14px;
            color: #333;
            background-color: #fafafa;
        }
        tr:nth-child(even) td {
            background-color: #f0f0f0;
        }
        a {
            color: #202060;
            font-weight: bold;
            text-decoration: none;
            margin: 0 6px;
        }
        a:hover {
            color: #fca311;
            text-decoration: underline;
        }
        button.button {
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            background-color: #202060;
            color: #fca311;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }
        button.button:hover {
            background-color: #fca311;
            color: #202060;
        }
        .buttonMargin{
            margin-bottom: 100px;
        }
        div {
            text-align: center;
        }
        span {
            margin: 0 4px;
            font-weight: bold;
            cursor: pointer;
            color: #202060;
        }
        span.current-page {
            color: #fca311;
            text-decoration: underline;
            cursor: default;
        }
        span:hover {
            text-decoration: underline;
        }
        .custom-hr {
            width: 1000px;
            max-width: 100%;
            border: none;
            border-top: 1px solid #ccc;
            margin-top: 10px;
            margin-bottom: 70px;
            width: 100%;
        }
        .setCss {
            width: 100%;
            max-width: 1000px;

        }
        .cmtCountColor {
            color: #fca311;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 
    <div id="app" class="container">

        <div class="section-header">
            FAQ
        </div>
        <div class="section-headerDown">
            자주 묻는 질문
        </div>    
        <div class="setCss"></div>
        <hr class="custom-hr">

        <div>
            <button class="button">이용방법</button>
            <button class="button">교환/반품</button>
            <button class="button">계정</button>
            <button class="button">상품관련</button>
            <button class="button">배송</button>
            <button class="button">결제관리</button>
        </div>

        <table class="table-wrapper">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <!-- <th>작성자</th> -->
                <th>작성일</th> 
                <!-- <th>조회수</th> -->
            </tr>
            <tr v-for="(item, index) in list">
                <template v-if="item.isDeleted == 'N'">
                    <td>{{item.boardId}}</td>
                    <td><a href="javascript:;" @click="fnView(item.boardId)">{{item.title}}
                        <span v-if="parseInt(item.commentCount) > 0 && category == 'F'" class="cmtCountColor">({{item.commentCount}})</span>
                        </a></td>
                        <td>{{item.createdAt}}</td>
                    <!-- <td>{{item.nickName}}</td>
                    <td>{{item.cnt}}</td> -->
                </template>
                <!-- <table>
                    <tr>
                        <th></th>
                    </tr>
                </table> -->
            </tr>
        </table>

    </div>


	<jsp:include page="/WEB-INF/common/footer.jsp"/>

    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                       
                    
                    };
                },
                computed: {

                },
                methods: {

                },
                mounted() {
                	
                	
                }
            });

            app.mount("#app");
        });
    </script>
