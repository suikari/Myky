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

		/* 테이블 스타일 */
		.member-table {
		    width: 100%;
		}

		.member-table th {
		    background-color: #f1f5f9;
		    font-weight: 600;
		    color: #475569;
		}

		.member-table td {
		    color: #374151;
		    font-size: 14px;
		}

		/* 회원 상태 뱃지 */
		.status-active {
		    background-color: #d1fae5;
		    color: #10b981;
		    padding: 5px 10px;
		    border-radius: 10px;
		    font-size: 12px;
		    font-weight: 600;
		}

		.status-inactive {
		    background-color: #fee2e2;
		    color: #dc2626;
		    padding: 5px 10px;
		    border-radius: 10px;
		    font-size: 12px;
		    font-weight: 600;
		}

		/* 버튼 스타일 */
		.btn-edit {
		    background-color: #0d6efd;
		    color: white;
		    border: none;
		    padding: 5px 10px;
		    border-radius: 5px;
		}

		.btn-delete {
		    background-color: #dc3545;
		    color: white;
		    border: none;
		    padding: 5px 10px;
		    border-radius: 5px;
		}
    </style>
    
</head>
<body>

    <div id="app" class="dashboard-container col-9">
       
         <!-- Main Content1 -->
         <div class=" main-content">
                <h2>회원 관리</h2>


				<div class="card p-3">
	                <div class="card-header">등록된 회원</div>
	                
	                <table class="table member-table">
	                    <thead>
	                        <tr>
	                            <th>번호</th>
	                            <th>이름</th>
								<th>닉네임</th>
	                            <th>이메일</th>
	                            <th>가입일</th>
	                            <th>상태</th>
								<th>멤버쉽<th>
	                            <th>관리</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <tr v-for="(member, index) in members" :key="member.id">
	                            <td>{{ index + 1 }}</td>
	                            <td>{{ member.userName }}</td>
								<td>{{ member.nickName }}</td>								
	                            <td>{{ member.email }}</td>
	                            <td>{{ member.createdAt }}</td>
	                            <td>
	                                <span :class="member.DeleteYn === 'N' ? 'status-active' : 'status-inactive'">
	                                    {{ member.DeleteYn === 'N' ? '회원' : '탈퇴회원' }}
	                                </span>
	                            </td>
								<td>
								    <span :class="member.membershipType ? 'status-active' : 'status-inactive'">
								        {{ member.membershipType ? '멤버쉽' : '일반회원' }}
								    </span>
								</td>
	                            <td>
	                                <button class="btn-edit me-2">수정</button>
	                                <button class="btn-delete">삭제</button>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	            </div>



        </div>
    </div>
    
</body>
</html>

<script>
    
   
            const app = Vue.createApp({
            	 data() {
                     return {
						menu : '',
						submenu : '',  
						members : []
               
                     };
                 },
                computed: {

                },
                methods: {
                	fnMainList : function() {
                    	var self = this;
                    	var nparmap = {
                    	};
                    	$.ajax({
                    		url: "/admin/memberList.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log("main",data);
								self.members = data.User;
                    			                    				
                    		}
                    	});
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
