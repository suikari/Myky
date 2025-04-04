<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .dashboard-container { background-color: #f8fafd; min-height: 100vh; padding: 30px 20px; font-family: 'Segoe UI', sans-serif; }
        .main-content { padding: 10px 30px; }
        .card { border-radius: 20px; box-shadow: 0 6px 16px rgba(0, 0, 0, 0.04); background-color: #ffffff; margin-bottom: 10px; padding: 20px; }
        .filters { display: flex; align-items: center; gap: 10px; margin-bottom: 20px; flex-wrap: wrap; }
        .filters input { width: 160px; }
    </style>
</head>
<body>
    <div id="app" class="dashboard-container container  col-9">
        <div class="main-content">
            <h2>상품 판매 통계</h2>
            <div class="filters">
                <input type="date" v-model="startDate" class="form-control">
                <span>~</span>
                <input type="date" v-model="endDate" class="form-control">
                <button @click="fetchSalesData" class="btn btn-primary">조회</button>
            </div>
            <div class="card">
                <h3>요약</h3>
                <p><strong>총 매출:</strong> {{ totalSales.toLocaleString() }}원</p>
                <p><strong>총 주문 수:</strong> {{ totalOrders }}건</p>
                <p><strong>평균 주문 금액:</strong> {{ averageOrder.toLocaleString() }}원</p>
            </div>
            <div class="card">
                <h3>상품별 판매량</h3>
                <div id="salesChart"></div>
            </div>
        </div>
    </div>
    <script>
        const app = Vue.createApp({
            data() {
                return {
                    startDate: '', 
                    endDate: '',   
                    totalSales: 0,
                    totalOrders: 0,
                    averageOrder: 0,
                    salesData: []
                };
            },
            computed:{

            },            
            methods: {
                fetchSalesData() {
                    let self = this;
                    var nparmap = {  
                    		startDate: self.startDate, 
                    		endDate: self.endDate
                    };
                    
                    $.ajax({
                        url: "/admin/BestSellProduct.dox",
                        type: "POST",
                        dataType: "json",
                        data: nparmap,
                        success: function (data) {
                        	console.log(data);

							self.totalSales = data.Order[0].totalSales || 0;
                            self.totalOrders = data.Order[0].totalOrders || 0;
                            self.averageOrder = data.Order[0].averageOrder || 0;
                            self.salesData = data.Product || [];
                            self.renderChart();
                        }
                    });
                },
                renderChart() {
                    let options = {
                    	    chart: { 
                    	        type: 'bar', 
                    	        height: 350, 
                    	        toolbar: { show: false } // 툴바 숨김 (공간 절약)
                    	    },
                    	    series: [{ 
                    	        name: '판매량', 
                    	        data: this.salesData.map(item => item.totalSold) 
                    	    }],
                    	    xaxis: { 
                    	        categories: this.salesData.map(item => item.productName),
                    	        labels: {
                    	            rotate: 0, // 가로 정렬
                    	            style: {
                    	                whiteSpace: 'break-spaces', // 자동 줄바꿈
                    	                fontSize: window.innerWidth < 600 ? '10px' : '12px' // 화면 크기에 따라 폰트 크기 조정
                    	            },
                    	            formatter: function(value) {
                    	                return window.innerWidth < 600 && value.length > 6 
                    	                    ? value.substring(0, 6) + "..." 
                    	                    : (value.length > 6 ? value.substring(0, 6) + "..." : value);
                    	                // 화면 작으면 6자 제한, 크면 10자 제한
                    	            },
                    	            hideOverlappingLabels: true // 너무 많으면 자동 숨김
                    	        }
                    	    },
                    	    responsive: [{
                    	        breakpoint: 600,
                    	        options: {
                    	            xaxis: {
                    	                labels: { show: false } // 모바일 화면에서는 X축 레이블 숨김
                    	            }
                    	        }
                    	    }]
                    };
                    if (this.chartInstance) {
                        this.chartInstance.updateOptions(options);
                    } else {
                        this.chartInstance = new ApexCharts(document.querySelector("#salesChart"), options);
                        this.chartInstance.render();
                    }
                },
                getFormattedDate(date) {
                    const offset = date.getTimezoneOffset();
                    const localDate = new Date(date.getTime() - (offset * 60 * 1000));
                    return localDate.toISOString().slice(0, 10);
                },
            },
            mounted() {
                
                const today = new Date();
                const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
                const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);

                this.startDate = this.getFormattedDate(firstDay);
                this.endDate = this.getFormattedDate(lastDay);

                this.fetchSalesData();
            }
        });
        app.mount("#app");
    </script>
</body>
</html>