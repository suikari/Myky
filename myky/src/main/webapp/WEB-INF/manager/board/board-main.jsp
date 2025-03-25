<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>

	<style> 
	
			/* 게시판 탭 기본 스타일 */
			.board-tab {
			    padding: 12px 20px;
			    font-size: 14px;
			    font-weight: bold;
			    border-radius: 5px;
			    cursor: pointer;
			    transition: background 0.3s ease, transform 0.2s ease;
			    text-align: center;
			    min-width: 130px;
			    color: white;
			}
			
			/* 개별 색상 */
			.free-board {
			    background-color: #007bff; /* 기본 부트스트랩 primary 색상 */
			}
			
			.notice-board {
			    background-color: #dc3545; /* 부트스트랩 danger 색상 */
			}
			
			.vet-board {
			    background-color: #28a745; /* 부트스트랩 success 색상 */
			}
			
			/* 호버 효과 */
			.board-tab:hover {
			    opacity: 0.8;
			}
			
			/* 클릭 효과 */
			.board-tab:active {
			    transform: scale(0.95);
			}
			
	</style> 

</head>
<body>
 


    <div id="boardMain" class="container">


    

                     <jsp:include page="/WEB-INF/manager/board/board-add.jsp"/>

    </div>



    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const boardMain = Vue.createApp({
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

            boardMain.mount("#boardMain");
        });
    </script>
