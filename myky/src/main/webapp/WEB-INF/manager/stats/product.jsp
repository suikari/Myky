<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
           
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
		    margin-bottom: 10px;
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


    </style>
    
</head>
<body>

    <div id="app" class="dashboard-container col-9">
       
            <!-- Main Content1 -->
            <div class=" main-content">
                <h2>통계</h2>

                <div class="card">
                    <div class="card-header">
                        <h5>시간대별 & 날짜별 접속자</h5>
                    </div>
                    <div class="card-body chart-container">
                        <div id="chart_bar"></div>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5>날짜별 접속자</h5>
                    </div>
                    <div class="card-body chart-container">
						<div id="chart_bar2"></div>
                    </div>
                </div>
                
                


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


        </div>
    
</body>
</html>

<script>
    
   
            const app = Vue.createApp({
            	 data() {
                     return {
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
                         stats: [
                             { icon: 'bi bi-heart-fill', number: "..", label: '이달의 후원 수', bg: 'bg-blue' },
                             { icon: 'bi bi-box-fill', number: "..", label: '등록 상품 수', bg: 'bg-yellow' },
                             { icon: 'bi bi-bag-fill', number: "..", label: '이달의 상품 판매량', bg: 'bg-red' },
                             { icon: 'bi bi-briefcase-fill', number: "..", label: '이달의 등록자 현황', bg: 'bg-purple' }
                         ],
                         saletot : 0,
                         donationtot : 0,
                         
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
                	
                },
                mounted() {
                	let self = this;
                	const params = new URLSearchParams(window.location.search);
                    
                    self.menu = params.get("menu") || "stat";
                    self.submenu = params.get("submenu") || "1";
                    
                	self.fnList();

                	
                }
            });
            
            app.mount("#app");
            
    </script>
