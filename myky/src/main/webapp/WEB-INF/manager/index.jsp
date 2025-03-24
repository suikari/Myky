<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
   
   
       
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
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
    
     <style>
		/* 전체 대시보드 배경 */
		.dashboard-container {
		    background-color: #f8fafd;
		    min-height: 100vh;
		    padding: 30px 20px;
		    font-family: 'Segoe UI', sans-serif;
		}
		
		/* 사이드바 */
		.sidebar {
		    background-color: #ffffff;
		    padding: 25px 20px;
		    border-radius: 16px;
		    height: 100%;
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
		}
		
		.sidebar h3 {
		    color: #0d6efd;
		    font-weight: bold;
		    margin-bottom: 30px;
		}
		
		.sidebar .nav-link {
		    color: #4b5563;
		    font-size: 15px;
		    padding: 10px 15px;
		    border-radius: 8px;
		    margin-bottom: 8px;
		    transition: 0.2s;
		}
		
		.sidebar .nav-link.active,
		.sidebar .nav-link:hover {
		    background-color: #e0edff;
		    color: #0d6efd;
		    font-weight: 600;
		}
		
		/* 업그레이드 버튼 */
		.sidebar .btn-upgrade {
		    background-color: #0d6efd;
		    border: none;
		    color: white;
		    font-weight: 600;
		    width: 100%;
		    padding: 12px;
		    border-radius: 12px;
		    margin-top: 30px;
		    box-shadow: 0 4px 10px rgba(13, 110, 253, 0.3);
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
 


    <div id="app" class="container">
       
        <div class="row">
            <!-- Sidebar -->
            <div class="col-3 sidebar">
                <h3>멍냥꽁냥 관리자</h3>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a @click="fnchange('1')" :class="['nav-link', { active: activeTab === '1' }]" class="nav-link " href="#">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a  @click="fnchange('2')"  :class="['nav-link', { active: activeTab === '2' }]" class="nav-link" href="#">UI Components</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Auth</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Extra</a>
                    </li>
                </ul>
            </div>

            <!-- Main Content1 -->
            <div v-if="title == '1' " class="col-9 main-content">
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
                        <apexchart type="line" height="350" :options="productSalesChartOptions" :series="productSalesChartSeries"></apexchart>
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
                                <tr>
                                    <td>3</td>
                                    <td>Christopher Jamil</td>
                                    <td>Project Manager</td>
                                    <td>High</td>
                                    <td>$12.8k</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Main Content2 -->
            <div v-if="title == '2' " class="col-9 main-content">
                <h2>UI Componsents</h2>
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
                    	 title : "1",
                    	 activeTab : "1",
                    	 optionsP : {
                             series: [],
                             chart: {
                             width: 380,
                             type: 'pie',
                             },
                             labels: [],
                             responsive: [{
                             breakpoint: 480,
                             options: {
                                 chart: {
                                 width: 200
                                 },
                                 legend: {
                                 position: 'bottom'
                                 }
                             }
                             }]
                         },
                         optionsB : {
                             series: [{
                             data: []
                             }],
                             chart: {
                             type: 'bar',
                             height: 350
                             },
                             plotOptions: {
                             bar: {
                                 borderRadius: 4,
                                 borderRadiusApplication: 'end',
                                 horizontal: true,
                             }
                             },
                             dataLabels: {
                             enabled: false
                             },
                             xaxis: {
                             categories: [],
                             }
                         },
                         optionsBD : {
                             series: [{
                             data: []
                             }],
                             chart: {
                             type: 'bar',
                             height: 350
                             },
                             plotOptions: {
                             bar: {
                                 borderRadius: 4,
                                 borderRadiusApplication: 'end',
                                 horizontal: true,
                             }
                             },
                             dataLabels: {
                             enabled: false
                             },
                             xaxis: {
                             categories: [],
                             }
                         },
                     };
                 },
                computed: {

                },
                methods: {
                	fnList : function() { 
                        var self = this;
                        var nparmap = { };
                        $.ajax({
                            url: "/admin/LogList.dox",  // 서버 주소 수정 (http:// 포함)
                            dataType: "json",
                            type: "POST", // GET, POST
                            data: JSON.stringify(nparmap),   // 서버로 보낼 데이터
                            contentType: "application/json",
                            success: function(data) {
                                console.log(data);
                                
                                
                                
                                self.optionsP.series = [];
                                self.optionsP.labels = [];
                                for (i=0;i<data.Browser.length;i++) {
                                    self.optionsP.series.push(data.Browser[i].visitCount);
                                    self.optionsP.labels.push(data.Browser[i].userAgentBrowser);
                                }
                                var chart = new ApexCharts(document.querySelector("#chart_per"), self.optionsP);
                                chart.render();
                                
                                
                                self.optionsB.series[0].data = [];
                                self.optionsB.xaxis.categories = [];
                                for (i=0;i<data.Time.length;i++) {
                                    self.optionsB.series[0].data.push(data.Time[i].visitCount);
                                    self.optionsB.xaxis.categories.push(data.Time[i].visitHour);
                                }
                                chart = new ApexCharts(document.querySelector("#chart_bar"), self.optionsB);
                                chart.render();
                                
                                self.optionsBD.series[0].data = [];
                                self.optionsBD.xaxis.categories = [];
                                for (i=0;i<data.Date.length;i++) {
                                    self.optionsBD.series[0].data.push(data.Date[i].visitCount);
                                    self.optionsBD.xaxis.categories.push(data.Date[i].visitDate);
                                }
                                chart = new ApexCharts(document.querySelector("#chart_bar2"), self.optionsBD);
                                chart.render();
                                
                            }

                        });



                    },
                	fnchange(title){
                    	let self = this;
                    	
                    	self.activeTab = title;
                    	self.title = title;
                    	
                    	if (title == 1) {
                        	self.fnList();
                    	}
                    }
                	
                	
                },
                mounted() {
                	let self = this;
                	
                	self.fnList();
                	
                }
            });
            

            app.mount("#app");
        });
    </script>
