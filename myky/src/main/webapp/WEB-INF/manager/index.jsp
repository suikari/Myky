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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
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
		
		/* 전체 카드 그리드 */
		.stats-cards {
		    margin-top: 20px;
		}
		
		/* 카드 스타일 */
		.stat-card {
		    background-color: #ffffff;
		    border-radius: 16px;
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
		    transition: transform 0.2s ease;
		}
		.stat-card:hover {
		    transform: translateY(-3px);
		}
		
		/* 아이콘 원형 배경 */
		.stat-icon {
		    width: 48px;
		    height: 48px;
		    border-radius: 50%;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    margin: 0 auto;
		    font-size: 20px;
		    color: white;
		}
		
		/* 색상 클래스 */
		.bg-blue { background-color: #c7dfff; color: #2563eb; }
		.bg-yellow { background-color: #fff7da; color: #eab308; }
		.bg-red { background-color: #fee2e2; color: #dc2626; }
		.bg-purple { background-color: #ede9fe; color: #7c3aed; }
		
		/* 숫자와 텍스트 */
		.stat-number {
		    font-weight: bold;
		    font-size: 20px;
		    color: #111827;
		}
		.stat-label {
		    font-size: 14px;
		    color: #6b7280;
		}
		
		
		/* 추가된 카드 스타일 */
		.bg-green {
		    background-color: #d1fae5;
		    color: #10b981;
		}
		
		.bg-orange {
		    background-color: #fff7ed;
		    color: #fb923c;
		}
		
		/* 카드 숫자 크기 조정 */
		.stat-number {
		    font-weight: bold;
		    font-size: 22px;
		    color: #111827;
		}
		
		.stat-label {
		    font-size: 14px;
		    color: #6b7280;
		}
		
		/* 카드 hover 효과 */
		.stat-card:hover {
		    transform: translateY(-5px);
		    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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
            <div class=" main-content">
                <h2>통계</h2>


				<div class="row stats-cards">
				  <div class="col-md-3 col-sm-6 mb-4" v-for="(item, index) in stats" :key="index">
				    <div class="card stat-card text-center p-3">
				      <div :class="['stat-icon', item.bg]">
				        <i :class="item.icon"></i>
				      </div>
				      <div class="stat-number mt-2">{{ item.number }}</div>
				      <div class="stat-label">{{ item.label }}</div>
				    </div>
				  </div>
				</div>


				
				<!-- 추가된 카드: 이달의 판매 금액과 후원 금액 -->
				<div class="row mt-4">
				  <div class="col-md-6 mb-4">
				    <div class="card stat-card text-center p-3">
				      <div class="stat-icon bg-green">
				        <i class="bi bi-cash-stack"></i>
				      </div>
				      <div class="stat-number mt-2">{{saletot}}</div>
				      <div class="stat-label">이달의 판매 금액</div>
				    </div>
				  </div>
				  <div class="col-md-6 mb-4">
				    <div class="card stat-card text-center p-3">
				      <div class="stat-icon bg-orange">
				        <i class="bi bi-hand-thumbs-up-fill"></i>
				      </div>
				      <div class="stat-number mt-2">$1,500</div>
				      <div class="stat-label">이달의 후원 금액</div>
				    </div>
				  </div>
				</div>

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


        </div>


    </div>

	</div>
     <jsp:include page="/WEB-INF/common/footer.jsp"/>

    
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
                         donationtot : "",
                         
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
                    fnMainList : function() {
                    	var self = this;
                    	var nparmap = {
                    	};
                    	$.ajax({
                    		url: "/admin/mainList.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log("main",data);
                    			
                    			self.stats[0].number = data.donationCnt;
                    			self.stats[1].number = data.productcnt;
                    			self.stats[2].number = data.paycnt;
                    			self.stats[3].number = data.userCnt;
							
                    			for (var i= 0 ; i < data.Pay.length ; i++ ){
                        			self.saletot += parseInt(data.Pay[i].amount);
                    			}
                    			
                    			for (var i= 0 ; i < data.Donation.length ; i++ ){
                    				self.donationtot += parseInt(data.Donation[i].amount);
                    			}
                    				
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
                	self.fnMainList();

                	
                }
            });
            
            app.mount("#app");
            
    </script>
