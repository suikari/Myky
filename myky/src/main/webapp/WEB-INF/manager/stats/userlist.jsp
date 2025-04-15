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

        .date-picker-container {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-bottom: 20px;
        }
        .date-picker {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    
</head>

<body>

    <div id="app" class="dashboard-container col-9">
       
            <!-- Main Content1 -->
            <div class=" main-content">
                <h2>통계</h2>

	            <div class="date-picker-container">
	            	<input id="date-picker" class="date-picker" style="display:none;"/>
	            	
	                <label for="year">연도:</label>
	                <select id="year" v-model="selectedYear" @change="fnList">
	                    <option v-for="year in years" :value="year">{{ year }}</option>
	                </select>
	                
	                <label for="month">월:</label>
	                <select id="month" v-model="selectedMonth" @change="fnList">
	                    <option v-for="month in months" :value="month">{{ month }}</option>
	                </select>
	                
	                <label for="time">시간 :</label>
	                <select id="time" v-model="selectedTime" @change="fnList">
					    <option value="">전체</option>
					    <option v-for="time in times" :value="time">{{ time }}시</option>
					</select>
	            </div>
	            
                <div class="card">
                    <div class="card-header">
                        <h5>시간대별 접속자</h5>
                    </div>
                    <div class="card-body chart-container">
						<div v-if="optionsB.series[0].data.length === 0">검색 결과가 없습니다.</div>
						<!-- v-show로 차트를 숨기고, 데이터가 있으면 차트를 렌더링 -->
						<div id="chart_bar" v-show="optionsB.series[0].data.length > 0"></div> <!-- 차트가 있을 경우 차트 렌더링 -->
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5>날짜별 접속자</h5>
                    </div>
                    <div class="card-body chart-container">
						<div v-if="optionsBD.series[0].data.length === 0">검색 결과가 없습니다.</div>
						<div id="chart_bar2" v-show="optionsBD.series[0].data.length > 0"></div>
                    </div>
                </div>
               
                <div class="card">
                    <div class="card-header">
                        <h5>브라우저별 접속자</h5>
                    </div>
                    <div class="card-body chart-container">
						<div v-if="optionsP.series.length === 0">검색 결과가 없습니다.</div>
						<div id="chart_per" v-show="optionsP.series.length > 0"></div>
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
                         selectedYear: new Date().getFullYear(),
                         selectedMonth: new Date().getMonth() + 1,
                         selectedTime: "",
                         years: Array.from({ length: 10 }, (_, i) => new Date().getFullYear() - i),
                         months: Array.from({ length: 12 }, (_, i) => i + 1),
                         times: Array.from({ length: 24 }, (_, i) => i),  // 0~23
                         optionsP: { series: [], chart: { width: 380, type: 'pie' }, labels: [], responsive: [{ breakpoint: 480, options: { chart: { width: 200 }, legend: { position: 'bottom' } } }] },
                         optionsB: { series: [{ data: [] }], chart: { type: 'bar', height: 350 }, plotOptions: { bar: { borderRadius: 4, horizontal: true } }, dataLabels: { enabled: false }, xaxis: { categories: [] } },
                         optionsBD: { series: [{ data: [] }], chart: { type: 'bar', height: 350 }, plotOptions: { bar: { borderRadius: 4, horizontal: true } }, dataLabels: { enabled: false }, xaxis: { categories: [] } },
						 chartInstances: {
						     pie: null,
						     bar: null,
						     bar2: null
						 }
						 
                     };
                 },
                computed: {

                },
                methods: {
                	fnList : function() { 
                        var self = this;
                        var nparmap = {  
                        		year  : self.selectedYear,
                        		month : self.selectedMonth,
                        		hour  : self.selectedTime
                        };
                        $.ajax({
                            url: "/admin/LogList.dox",  // 서버 주소 수정 (http:// 포함)
                            dataType: "json",
                            type: "POST", // GET, POST
                            data: nparmap,   // 서버로 보낼 데이터
                            success: function(data) {
								//console.log(data);

								  // 📌 기존 데이터 초기화
								 self.optionsP.series = [];
					             self.optionsP.labels = [];
					             self.optionsB.series[0].data = [];
					             self.optionsB.xaxis.categories = [];
					             self.optionsBD.series[0].data = [];
					             self.optionsBD.xaxis.categories = [];

					             // 🔹 새로운 데이터 추가
					             if (data.Browser) {
					                 data.Browser.forEach(item => {
					                     self.optionsP.series.push(item.visitCount);
					                     self.optionsP.labels.push(item.userAgentBrowser);
					                 });
					             }

					             if (data.Time) {
					                 data.Time.forEach(item => {
					                     self.optionsB.series[0].data.push(item.visitCount);
					                     self.optionsB.xaxis.categories.push(item.visitHour);
					                 });
					             }

					             if (data.Date) {
					                 data.Date.forEach(item => {
					                     self.optionsBD.series[0].data.push(item.visitCount);
					                     self.optionsBD.xaxis.categories.push(item.visitDate);
					                 });
					             }

					             // ✅ 차트 업데이트 (데이터 로딩 후 실행)
					                 self.updateChart("pie", self.optionsP);
					                 self.updateChart("bar", self.optionsB);
					                 self.updateChart("bar2", self.optionsBD);
                            }

                        });

                        

                    },
                    updateChart(chartKey, options) {
                        // 1. 차트가 존재하면 완전히 제거
                        if (this.chartInstances[chartKey]) {
                            this.chartInstances[chartKey].destroy();
                            this.chartInstances[chartKey] = null;
                        }

                        // 2. nextTick 사용: DOM이 완전히 렌더링된 후 차트 생성
                        this.$nextTick(() => {
                            let chartElementId =
                                chartKey === "pie"
                                    ? "#chart_per"
                                    : chartKey === "bar"
                                    ? "#chart_bar"
                                    : "#chart_bar2";

                            // 3. 차트 엘리먼트가 존재할 때만 새로 생성
                            const el = document.querySelector(chartElementId);
                            if (el) {
                                this.chartInstances[chartKey] = new ApexCharts(el, options);
                                this.chartInstances[chartKey].render();
                            } else {
                                //console.warn("차트 DOM이 없습니다:", chartElementId);
                            }
                        });
                    } 	
                	
                },
                mounted() {
                	let self = this;
                	const params = new URLSearchParams(window.location.search);
                    
                    self.menu = params.get("menu") || "stat";
                    self.submenu = params.get("submenu") || "1";
                    
                    flatpickr("#date-picker", {
                        dateFormat: "Y-m-d",
                        defaultDate: new Date(),
                        onChange: function(selectedDates, dateStr) {
                            self.selectedDate = dateStr;
                            self.fnList();
                        }
                    });
                    
                	self.fnList();

                	
                }
            });
            
            app.mount("#app");
            
    </script>
