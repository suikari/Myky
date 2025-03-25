<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
       
    <!-- ApexCharts CSS -->
    <link href="https://cdn.jsdelivr.net/npm/apexcharts@3.35.3/dist/apexcharts.css" rel="stylesheet">

    <!-- Vue 3 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/vue@3.2.31/dist/vue.global.js"></script>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    
    <!-- Vue 3 Script -->
    <script src="https://cdn.jsdelivr.net/npm/apexcharts@3.35.3"></script>
    
    <!-- Quill CDN -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    
    
     <style>
		/* 전체 대시보드 배경 */
		.dashboard-container {
		    background-color: #f8fafd;
		    min-height: 100vh;
		    padding: 30px 20px;
		    font-family: 'Segoe UI', sans-serif;
		}
		

		
		/* 메인 콘텐츠 */
		.main-content {
		    padding: 10px 30px;
		}
		
		/* 카드 공통 */
		.card {
		    border: none;
		    border-radius: 20px;
		    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.04);
		    background-color: #ffffff;
		}
		
		.card-header {
		    background-color: transparent;
		    font-weight: 600;
		    font-size: 18px;
		    border-bottom: none;
		    padding: 20px;
		}
		
		/* 차트 높이 조절 */
		.chart-container {
		    padding: 0 20px 20px;
		}
		
		/* 리스트 및 테이블 */
		.list-group-item {
		    border: none;
		    padding: 12px 20px;
		    font-size: 14px;
		    color: #374151;
		}
		
		/* 테이블 */
		.table th {
		    background-color: #f1f5f9;
		    font-weight: 600;
		    color: #475569;
		}
		
		.table td {
		    color: #374151;
		    font-size: 14px;
		}
		
		/* Priority 뱃지 */
		.priority-low {
		    background-color: #dbeafe;
		    color: #2563eb;
		    padding: 5px 10px;
		    border-radius: 9999px;
		    font-size: 12px;
		    font-weight: 600;
		}
		
		.priority-medium {
		    background-color: #fef9c3;
		    color: #ca8a04;
		    padding: 5px 10px;
		    border-radius: 9999px;
		    font-size: 12px;
		    font-weight: 600;
		}
		
		.priority-high {
		    background-color: #fee2e2;
		    color: #dc2626;
		    padding: 5px 10px;
		    border-radius: 9999px;
		    font-size: 12px;
		    font-weight: 600;
		}
		
		/* 제품 판매 카드 내 아이콘 원 */
		.product-sales-icon {
		    width: 36px;
		    height: 36px;
		    background-color: #fef2f2;
		    border-radius: 50%;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    color: #ef4444;
		    font-weight: bold;
		    font-size: 20px;
		}
    </style>
    
</head>
<body>
     <jsp:include page="/WEB-INF/common/header.jsp"/>
 

	<div class="row">
    <jsp:include page="/WEB-INF/manager/common/side.jsp"/>


    <div id="app" class="container col-9">
       
        <div class="row">


            <!-- Main Content1 -->
            <div v-if="title == '1' " class=" main-content">
                <h2>Dashboard</h2>

                <!-- Profit & Expenses Chart -->
                <div class="card">
                    <div class="card-header">
                        <h5>시간대별 & 날짜별 접속자</h5>
                    </div>
                    <div class="card-body chart-container">
                        <div id="chart_bar"></div>
                        <div id="chart_bar2"></div>
                    </div>
                </div>

                <!-- Traffic Distribution -->
                <div class="card">
                    <div class="card-header">
                        <h5>브라우저별 접속자</h5>
                    </div>
                    <div class="card-body chart-container">
                   		<div id="chart_per"></div>
                    </div>
                </div>

                <!-- Product Sales -->
                <div class="card">
                    <div class="card-header">
                        <h5>Product Sales</h5>
                    </div>
                    <div class="card-body chart-container">
                    </div>
                </div>

                <!-- Upcoming Schedules -->
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Upcoming Schedules</h5>
                        <ul class="list-group">
                            <li class="list-group-item">09:30 AM - Payment received from John Doe of $385.90</li>
                            <li class="list-group-item">10:00 AM - New sale recorded #ML-3467</li>
                            <li class="list-group-item">12:00 PM - Payment made to Michael of $64.95</li>
                        </ul>
                    </div>
                </div>

                <!-- Top Paying Clients -->
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Top Paying Clients</h5>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Id</th>
                                    <th>Assigned</th>
                                    <th>Name</th>
                                    <th>Priority</th>
                                    <th>Budget</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Sunil Joshi</td>
                                    <td>Web Designer</td>
                                    <td>Low</td>
                                    <td>$3.9k</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Andrew McDownland</td>
                                    <td>Project Manager</td>
                                    <td>Medium</td>
                                    <td>$24.5k</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Main Content2 -->
            <div v-if="title == '2' " class="col-9 main-content">
                <h2>게시판 관리</h2>
                    
                     <jsp:include page="/WEB-INF/manager/board/board-main.jsp"/>
                
            </div>

             <!-- Main Content3 -->
             <div v-if="title == '3' " class="col-9 main-content">
                <h2>UI Componsents</h2>
            </div>

            <!-- Main Content4 -->
            <div v-if="title == '4' " class="col-9 main-content">
                <h2>UI Componsents</h2>
            </div>       

        </div>


    </div>

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
                	let self = this;
                	
         
                	
                }
            });
            

            app.mount("#app");
        });
    </script>
