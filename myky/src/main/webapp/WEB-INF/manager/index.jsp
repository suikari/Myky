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
        /* Custom styles for Dashboard */
        .dashboard-container {
            background-color: #f0f4f8;
            min-height: 100vh;
            padding: 20px;
        }

        .sidebar {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
        }

        .sidebar h3 {
            color: #3b82f6;
        }

        .sidebar .nav-link {
            color: #333;
            margin-bottom: 10px;
            font-weight: 500;
        }

        .main-content {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card {
            border: none;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #f1f5f9;
            font-weight: bold;
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        .chart-container {
            margin-top: 20px;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .list-group-item {
            border: none;
            padding: 15px;
        }
    </style>
    
</head>
<body>
     <jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="container">
       
        <div class="row">
            <!-- Sidebar -->
            <div class="col-3 sidebar">
                <h3>Spike Admin</h3>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">UI Components</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Auth</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Extra</a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="col-9 main-content">
                <h2>Dashboard</h2>

                <!-- Profit & Expenses Chart -->
                <div class="card">
                    <div class="card-header">
                        <h5>Profit & Expenses</h5>
                    </div>
                    <div class="card-body chart-container">
                        <apexchart type="bar" height="350" :options="profitExpensesChartOptions" :series="profitExpensesChartSeries"></apexchart>
                    </div>
                </div>

                <!-- Traffic Distribution -->
                <div class="card">
                    <div class="card-header">
                        <h5>Traffic Distribution</h5>
                    </div>
                    <div class="card-body chart-container">
                   		<div id="chart"></div>
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
                    	 options : {
                             series: [{
                             data: [400, 430, 448, 470, 540, 580, 690, 1100, 1200, 1380]
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
                             categories: ['South Korea', 'Canada', 'United Kingdom', 'Netherlands', 'Italy', 'France', 'Japan',
                                 'United States', 'China', 'Germany'
                             ],
                             }
                         }
                     };
                 },
                computed: {

                },
                methods: {

                },
                mounted() {
                	let self = this;
                    var chart = new ApexCharts(document.querySelector("#chart"), self.options);
                    chart.render();
                	
                }
            });
            

            app.mount("#app");
        });
    </script>
