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
			margin-top:20px;
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

        /* 검색어 순위 리스트 */
        .search-rank-container {
            margin-top: 20px;
        }

        .search-rank-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .search-rank-item {
            padding: 12px 20px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 16px;
            color: #374151;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background-color 0.2s;
        }

        .search-rank-item:hover {
            background-color: #f1f5f9;
        }

        .search-rank-item:last-child {
            border-bottom: none;
        }

        .search-rank-number {
            font-weight: bold;
            color: #2563eb;
            font-size: 18px;
        }

        .search-rank-keyword {
            flex-grow: 1;
            margin-left: 10px;
            font-weight: 500;
            color: #111827;
        }

        .search-rank-count {
            font-size: 14px;
            color: #6b7280;
        }

        /* 로딩 화면 스타일 */
        .loading-overlay {
            position: absolute;
            top: 25px;
            left: 0;
            width: 100%;
            height: 96%;
            background-color: rgba(255, 255, 255, 0.9);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            min-height: 500px;
        }

        .loading-text {
            font-size: 24px;
            color: #2563eb;
            margin-bottom: 20px;
        }

        .dog-container {
            width: 100px;
            height: 100px;
            position: relative;
        }

        .running-dog {
            width: 240px;
            height: 240px;
            background: url('/img/manager/Lodingdog.png') no-repeat center center;
            background-size: contain;
            position: absolute;
            animation: runDog 2s infinite linear;
        }

        @keyframes runDog {
            0% {
                left: -100px;
                transform: scaleX(1);
            }
            49% {
                transform: scaleX(1);
            }
            50% {
                left: 100%;
                transform: scaleX(-1);
            }
            99% {
                transform: scaleX(-1);
            }
            100% {
                left: -100px;
                transform: scaleX(1);
            }
        }

        .dashboard-container {
            position: relative;  /* 추가된 스타일 */
        }
    </style>
    
</head>
<body>

    <div id="app" class="dashboard-container col-9">
        <!-- 로딩 화면 -->
        <div class="loading-overlay" v-if="isLoading">
            <div class="loading-text">로딩중...</div>
            <div class="dog-container">
                <div class="running-dog"></div>
            </div>
        </div>
       
        <!-- Main Content1 -->
        <div class="main-content" v-show="!isLoading">
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
			      <div class="stat-number mt-2">₩ {{ formattedSel }}</div>
			      <div class="stat-label">이달의 판매 금액</div>
			    </div>
			  </div>
			  <div class="col-md-6 mb-4">
			    <div class="card stat-card text-center p-3">
			      <div class="stat-icon bg-orange">
			        <i class="bi bi-hand-thumbs-up-fill"></i>
			      </div>
			      <div class="stat-number mt-2">₩ {{ formattedDonation }}</div>
			      <div class="stat-label">이달의 후원 금액</div>
			    </div>
			  </div>
			</div>


	        <div class="row mt-4">
	            <div class="col-md-6">
	                <div class="card search-rank-container">
	                    <div class="card-header">검색어 순위</div>
	                    <ul class="search-rank-list">
	                        <li class="search-rank-item" v-for="(word, index) in searchRanks" :key="index">
	                            <span class="search-rank-number">{{ index + 1 }}</span>
	                            <span class="search-rank-keyword">{{ word.SearchTerm }}</span>
	                            <span class="search-rank-count">{{ word.SearchCount }}회</span>
	                        </li>
	                        
	                        <li v-if="searchChk">
	                         	<span class="search-rank-number">검색 기록이 없습니다.</span>
	                        </li>
	                    </ul>
	                </div>
	            </div>
	            <div class="col-md-6">
	                <div class="card chart-container">
	               		<div class="card-header" v-show="options.series.length === 0">검색 결과가 없습니다.</div>
						<div id="chart" v-else></div>
	                </div>
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
                    	 isLoading: true,
                    	 stats: [
                             { icon: 'bi bi-heart-fill', number: "..", label: '이달의 후원 수', bg: 'bg-blue' },
                             { icon: 'bi bi-box-fill', number: "..", label: '이달의 상품 등록수', bg: 'bg-yellow' },
                             { icon: 'bi bi-bag-fill', number: "..", label: '이달의 상품 판매량', bg: 'bg-red' },
                             { icon: 'bi bi-briefcase-fill', number: "..", label: '이달의 등록자 현황', bg: 'bg-purple' }
                         ],
                         saletot : 0,
                         donationtot : 0,
                         searchRanks : {},
                         options : {
                                 series: [],
                                 chart: {
                                 height: 350,
                                 type: 'radialBar',
                               },
                               plotOptions: {
                                 radialBar: {
                                   hollow: {
                                     size: '70%',
                                   }
                                 },
                               },
                               labels: ['멤버쉽 가입률'],
                        },
                        year : new Date().getFullYear(),
                        month : new Date().getMonth() + 1,
                        searchChk : false
                     };
                 },
                computed: {
                        formattedSel() {
                            return this.saletot.toLocaleString('ko-KR') + " 원";
                        },
                        formattedDonation() {
                            return this.donationtot.toLocaleString('ko-KR') + " 원";
                        },
                        
                        
                },
                methods: {
                	async fnMainList() {
                    	var self = this;
                    	self.isLoading = true;
                    	
                    	try {
                    		// 모든 AJAX 요청을 Promise로 변환하여 병렬로 실행
                    		await Promise.all([
                    			// 첫 번째 AJAX 요청
                    			new Promise((resolve, reject) => {
                    				$.ajax({
                    					url: "/admin/mainList.dox",
                    					dataType: "json",
                    					type: "POST",
                    					data: { year: self.year, month: self.month },
                    					success: resolve,
                    					error: reject
                    				});
                    			}).then(data => {
                    				console.log("main", data);
                    				if (data.donationCnt) self.stats[0].number = data.donationCnt;
                    				else self.stats[0].number = 0;
                    				
                    				if (data.productcnt) self.stats[1].number = data.productcnt;
                    				else self.stats[1].number = 0;
                    				
                    				if (data.paycnt) self.stats[2].number = data.paycnt;
                    				else self.stats[2].number = 0;
                    				
                    				if (data.userCnt) self.stats[3].number = data.userCnt;
                    				else self.stats[3].number = 0;
							
                    				self.saletot = data.Pay.reduce((sum, item) => sum + parseInt(item.amount), 0);
                    				self.donationtot = data.Donation.reduce((sum, item) => sum + parseInt(item.amount), 0);
                    			}),

                    			// 두 번째 AJAX 요청
                    			new Promise((resolve, reject) => {
                    				$.ajax({
                    					url: "/admin/searchList.dox",
                    					dataType: "json",
                    					type: "POST",
                    					data: { year: self.year, month: self.month },
                    					success: resolve,
                    					error: reject
                    				});
                    			}).then(data => {
                    				console.log("12", data);
                    				if (Array.isArray(data.Search) && data.Search.length > 0) {
                        				self.searchRanks = data.Search;
                    				} else {
                        				self.searchRanks = "";
                    					self.searchChk = true;
                    				}                    			               			
                    			}),

                    			// 세 번째 AJAX 요청
                    			new Promise((resolve, reject) => {
                    				$.ajax({
                    					url: "/admin/membershipVal.dox",
                    					dataType: "json",
                    					type: "POST",
                    					data: { year: self.year, month: self.month },
                    					success: resolve,
                    					error: reject
                    				});
                    			}).then(data => {
                    				console.log("123", data);
                    				if (data.Membership && data.Membership.membershipUserCount !== undefined) {
                    					var per = (parseInt(data.Membership.membershipUserCount) / 
                    						(parseInt(data.Membership.membershipUserCount) + 
                    						 parseInt(data.Membership.nonMembershipUserCount))) * 100;
                    					self.options.series = [per.toFixed(0)];
                    					
                    					setTimeout(() => {
                    						var chart = new ApexCharts(document.querySelector("#chart"), self.options);
                    						chart.render();
                    					}, 0);
                    				} 
                    				
                    			})
                    		]);
                    	} catch (error) {
                    		console.error("데이터 로딩 중 오류 발생:", error);
                    	} finally {
                    		// 모든 데이터 로딩이 완료되면 로딩 화면 숨기기
                    		self.isLoading = false;
                    	}
                    },
                	
                	
                },
                mounted() {
                	let self = this;
                	const params = new URLSearchParams(window.location.search);
                    
                    self.menu = params.get("menu") || "stat";
                    self.submenu = params.get("submenu") || "1";
                    
                	self.fnMainList();
                	

                	
                }
            });
            
            app.mount("#app");
            
    </script>
