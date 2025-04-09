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
		

/* 수정 폼 스타일 - 부트스트랩 사용 */
.edit-form {
    display: flex;
    gap: 15px;
    background-color: #f8f9fa;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* 각 입력 요소가 가로로 꽉 차게 하기 위해 col 사용 */
.edit-form .col {
    flex: 1;  /* 모든 항목들이 고르게 넓어지도록 설정 */
}

/* 버튼 영역을 오른쪽 끝에 배치 */
.edit-form .col.d-flex.justify-content-end {
    flex: 0;
}

/* 스위치 토글 크기 */
.form-check-input {
    width: 40px;
    height: 20px;
}
/* 버튼 글자 크기 맞추기 */
.custom-btn {
    font-size: 14px; /* 글자 크기를 텍스트에 맞게 조정 */
    padding: 5px 15px; /* 적당한 여백을 설정 */
    text-align: center;
}

		/* 페이지 버튼 기본 스타일 */
		.board-page-btn {
		    min-width: 40px;
		    padding: 8px 12px;
		    margin: 0 4px;
		    border-radius: 5px;
		    font-size: 14px;
		}
		
		/* 숫자 페이지 버튼 스타일 */
		.board-page-btn:not(.prev-next-btn):not(.active) {
		    background-color: #f1f5f9;
		    color: #374151;
		    border-color: #d1d5db;
		}
		
		/* 현재 페이지 버튼 강조 */
		.board-page-btn.active {
		    background-color: #2563eb;
		    color: white;
		    border-color: #2563eb;
		}
		
		/* 이전/다음 페이지 버튼 스타일 */
		.board-page-btn.prev-next-btn {
		    background-color: #ffffff;
		    color: #374151;
		    border-color: #d1d5db;
		}
		
		.board-page-btn.prev-next-btn:hover {
		    background-color: #f1f5f9;
		    color: #2563eb;
		}
		
		/* 이전/다음 페이지 아이콘 크기 */
		.board-page-btn i {
		    font-size: 18px;
		}
		/* 선택 삭제 버튼 스타일 */
		.board-delete-btn {
		    min-width: 120px;
		    padding: 8px 12px;
		    font-size: 14px;
		    border-radius: 5px;
		}
		
		/* 버튼 비활성화 스타일 */
		.board-delete-btn:disabled {
		    background-color: #e5e7eb;
		    color: #9ca3af;
		    cursor: not-allowed;
		}

    .status-received { color: #555; background-color: #f0f0f0; padding: 4px 8px; border-radius: 4px; }
	.status-shipped { color: #0a58ca; background-color: #e0f0ff; }
	.status-delivered { color: #198754; background-color: #d1e7dd; }
	.status-exchange { color: #6f42c1; background-color: #e9d8fd; }
	.status-exchanged { color: #5c2d91; background-color: #dcd1f7; }
	.status-return { color: #fd7e14; background-color: #ffe5d0; }
	.status-returned { color: #dc3545; background-color: #f8d7da; }
	
		.product-thumb {
		  width: 60px;
		  height: 60px;
		  object-fit: cover;
		}
		
    </style>
    
</head>
<body>
    <div id="app" class="dashboard-container col-9">
        <!-- Main Content -->
        <div class="main-content">
            <h2>주문 관리</h2>
            <div class="card p-3">
                <!-- 검색 및 필터링 -->
                <div class="row g-2 align-items-center mb-3">
                    <div class="col-auto">
                        <select v-model="pageSize" class="form-select board-select" @change="fnMainList">
                            <option value="10">10개씩</option>
                            <option value="50">50개씩</option>
                            <option value="100">100개씩</option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <select v-model="searchOption" class="form-select">
                            <option value="all">전체</option>
                            <option value="phone">연락처</option>
                            <option value="userId">ID</option>
                        </select>
                    </div>
                    <div class="col">
                        <input v-model="keyword" @keyup.enter="fnMainList" class="form-control board-search" placeholder="🔍 검색어 입력" />
                    </div>
                    <div class="col-auto">
                        <button class="btn btn-primary board-search-btn" @click="fnBoardSearch">검색</button>
                    </div>
                </div>
                <!-- 주문 리스트 -->
                <table class="table member-table">
                    <thead>
                        <tr>
                            <th>주문번호</th>
                            <th>구매자 ID</th>
                            <th>총 가격</th>
                            <th>연락처 </th>
                            <th>주문 상태</th>
                            <th>주문일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <template v-for="(order, index) in orders">
                            <tr >
                                <td @click="toggleDetails(order.orderId)">{{ order.orderId }}</td>
                                <td @click="toggleDetails(order.orderId)">{{ order.userId }}</td>
                                <td @click="toggleDetails(order.orderId)">{{ order.totalPrice }}</td>
                                <td @click="toggleDetails(order.orderId)">{{ order.receiverPhone }}</td>
                                <td @click="toggleDetails(order.orderId)">
                                    <span class="status-received" :class="getStatusClass(order.orderStatus)">
							            {{ getStatusLabel(order.orderStatus) }}
							        </span>
                                </td  @click="toggleDetails(order.orderId)">
                                <td @click="toggleDetails(order.orderId)">{{ order.orderedAt }}</td>
                                <td>
                                    <button @click="fnEditOrder(order.orderId)" class="btn-edit me-2">수정</button>
                                </td>
                            </tr>
                            
                            <!-- 토글되는 수정 입력란 -->
							<tr v-if="updateOrderId === order.orderId">
							    <td colspan="7">
							        <div class="edit-form d-flex flex-column gap-3 p-3 border rounded">
							            <!-- 첫 번째 줄: 상품명, 상품코드, 가격 -->
							            <div class="d-flex flex-wrap gap-3">
							                <div class="col-auto">
							                    <label class="form-label">주문상태:</label>
							                    <select v-model="editData.orderStatus" class="form-select">
							                        <option value="paid">주문완료</option>
							                        <option value="cancel">환불신청</option>
							                        <option value="canceled">환불완료</option>
							                    </select>
							                </div>
									        <div class="col-auto d-flex align-items-center">
									            <label for="deleteYn" class="form-label me-2">환불 상태:</label>
									            <div class="form-check form-switch">
									                <input class="form-check-input" type="checkbox" id="deleteYn" v-model="editData.refundStatus" 
									                    true-value="Y" false-value="N">
									            </div>
									        </div>
									        
							                <div class="col-auto ">
							                    <button class="btn btn-primary me-2 custom-btn" @click="fnOrderSave">저장</button>
							                    <button class="btn btn-secondary custom-btn" @click="updateOrderId = null">취소</button>
							                </div>
							                
							            </div>


							        </div>
							    </td>
							</tr>
							
                            <!-- 주문 상세 토글 -->
                            <tr v-if="selectedOrderId === order.orderId">
                                <td colspan="7">
                                    <div class="edit-form p-3 border rounded">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>상품 이미지</th>
                                                    <th>상품명</th>
                                                    <th>주문상태</th>
                                                    <th>운송장번호</th>
                                                    <th>수량</th>
                                                    <th>가격</th>
                                                    <th>관리</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <template  v-for="product in order.orderdetail">
                                                <tr>
                                                    <td>    
                                                    	<img :src="product.filePath" alt="상품 이미지" class="img-thumbnail me-2 product-thumb">
													</td>
                                                    <td>{{ product.productName }}</td>
                                                    <td>
	                                                    <span v-if="order.orderStatus=='cancel' || order.orderStatus=='canceled'  "  class="status-received" :class="getStatusClass(order.orderStatus)">
												            {{ getStatusLabel(order.orderStatus) }}
												        </span>												        
												        <span v-else :class="getStatusClass(product.refundStatus)">
												            {{ getStatusLabel(product.refundStatus) }}
												        </span>
					                           		</td>
					                           	    <td>{{ product.trackingNumber }}</td>
                                                    <td>{{ product.quantity }}</td>
                                                    <td>{{ product.price }} 원</td>
                                                    <td>
					                                    <button @click="fnEditOrderDetail(product)"  class="btn-edit me-2">수정</button>
					                                </td>
                                                </tr>
                                                
                                                <!-- 토글되는 수정 입력란 -->
												<tr v-if="updateOrderDetailId === product.orderDetailId && updateproductId === product.productId">
												    <td colspan="8">
												        <div class="edit-form d-flex flex-column gap-3 p-3 border rounded">
												            <!-- 첫 번째 줄: 상품명, 상품코드, 가격 -->
												            <div class="d-flex flex-wrap gap-3">
												            	<!-- 이름 입력 필드 -->
														        <div class="col">
														            <label for="userName" class="form-label">운송장번호 : </label>
														            <input type="text" id="userName" v-model="editData.trackingNumber" class="form-control">
														        </div>
												                <div class="col-auto">
												                    <label class="form-label">주문상태 : </label>
												                    <select v-model="editData.refundStatus" class="form-select">
												                        <option value="none">주문접수</option>
												                        <option value="shipped">배송중</option>
												                        <option value="delivered">배송완료</option>
												                        <option value="exchange">교환신청</option>
												                        <option value="exchanged">교환완료</option>
												                        <option value="return">반품신청</option>												                        
												                        <option value="returned">반품완료</option>	
												                    </select>
												                </div>														        
												                <div class="col-auto ">
												                    <button class="btn btn-primary me-2 custom-btn" @click="fnOrderDetailSave">저장</button>
												                    <button class="btn btn-secondary custom-btn" @click="updateOrderDetailId = null">취소</button>
												                </div>
												                
												            </div>
					
					
												        </div>
												    </td>
												</tr>
												</template>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </template>
                    </tbody>
                </table>
                <!-- 페이지네이션 -->
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <div class="d-flex justify-content-center">
                        <a class="btn btn-outline-secondary board-page-btn prev-next-btn" href="javascript:;" @click="fnPageMove('prev')" v-if="page != 1">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                        <template v-for="num in index">
                            <a href="javascript:;" @click="fnPage(num)" class="btn btn-outline-secondary board-page-btn" :class="{ 'active': page === num }">
                                {{ num }}
                            </a>
                        </template>
                        <a class="btn btn-outline-secondary board-page-btn prev-next-btn" href="javascript:;" @click="fnPageMove('next')" v-if="index > 0 && page != index">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

<script>
const app = Vue.createApp({
    data() {
        return {
            index: 0,
            orders: [],
            selectedOrderId: null,
            searchOption: 'all',
            page: 1,
            pageSize: 10,
            keyword: '',
            editData: {},
            updateOrderId : '',
            updateOrderDetailId : '',
            updateproductId : '',
        };
    },
    methods: {
        fnMainList() {
            var self = this;
            var params = {
                    searchOption: self.searchOption,
                    page: (self.page - 1) * self.pageSize,
                    pageSize: self.pageSize,
                    keyword: self.keyword,
            };
            $.ajax({
                url: "/admin/selectOrderList.dox",
                dataType: "json",
                type: "POST",
                data: params,
                success: function (data) {
                	console.log("dete",data);
                    self.orders = data.order;
                    self.index = Math.ceil(data.count / self.pageSize);
                }
            });
        },
        toggleDetails(orderId) {
            this.selectedOrderId = this.selectedOrderId === orderId ? null : orderId;
            this.updateOrderId = null;
        },
        fnPage(num) {
            this.page = num;
            this.fnMainList();
        },
        fnPageMove(direction) {
            if (direction === "next") this.page++;
            else this.page--;
            this.fnMainList();
        },
        fnBoardSearch() {
            this.page = 1;
            this.fnMainList();
        },
        getStatusLabel(status) {
            switch (status) {
                // 상품 상태
                case 'none': return '주문접수';
                case 'shipped': return '배송중';
                case 'delivered': return '배송완료';
                case 'exchange': return '교환신청';
                case 'exchanged': return '교환완료';
                case 'return': return '반품신청';
                case 'returned': return '반품완료';

                // 주문 상태
                case 'paid': return '주문완료';
                case 'cancel': return '환불신청';
                case 'canceled': return '환불완료';

                default: return '알수없음';
            }
        },
        getStatusClass(status) {
            switch (status) {
                // 상품 상태
                case 'none': return 'status-received';
                case 'shipped': return 'status-shipped';
                case 'delivered': return 'status-delivered';
                case 'exchange': return 'status-exchange';
                case 'exchanged': return 'status-exchanged';
                case 'return': return 'status-return';
                case 'returned': return 'status-returned';

                // 주문 상태 (겹치는 클래스 사용)
                case 'paid': return 'status-delivered';
                case 'cancel': return 'status-return';
                case 'canceled': return 'status-returned';

                default: return 'status-unknown';
            }
        },
        fnEditOrder(orderId){
        	
        	var self = this;
			self.selectedOrderId = null;

            if (self.updateOrderId === orderId) {
            	self.updateOrderId = null;  // 같은 걸 누르면 닫힘
            	self.updateproductId = null;

            } else {
                const member = self.orders.find(m => m.orderId === orderId);
                self.editData = { ...member };  // 수정할 데이터 채우기
                self.updateOrderId = orderId;

            }
            
        },
		fnEditOrderDetail(orderDetail){
        	var self = this;
			console.log(orderDetail);
			
            if (self.updateOrderDetailId === orderDetail.orderId) {
            	self.updateOrderDetailId = null;  // 같은 걸 누르면 닫힘
            	self.updateproductId = null;  // 같은 걸 누르면 닫힘

            } else {
                //const member = orderDetail.find(m => m.orderDetailId === orderDetail.orderId);
                //self.editData = { ...member };  // 수정할 데이터 채우기
                self.editData = orderDetail;
                self.updateOrderDetailId = orderDetail.orderDetailId;
            	self.updateproductId = orderDetail.productId; 
            }
            
        },
        fnOrderSave() {
            var self = this;
            var params = {
            		orderId : self.updateOrderId,
            		orderStatus : self.editData.orderStatus,
            		refundStatus : self.editData.refundStatus            		
            };
            
            console.log('123',"");
            
            $.ajax({
                url: "/admin/updateOrder.dox",
                dataType: "json",
                type: "POST",
                data: params,
                success: function (data) {
                	console.log("dete",data);
                	alert('수정 완료');
                	self.fnMainList();
                    self.updateOrderId = null; 
                   
                }
            });
           
        },
        fnOrderDetailSave() {
            var self = this;
            var params = {
            		orderId        : self.editData.orderId,
            		orderDetailId  : self.updateOrderDetailId,
            		productId      : self.updateproductId,
            		trackingNumber : self.editData.trackingNumber,
            		refundStatus   : self.editData.refundStatus,
            		message        : '주문 상세상품 정보 변경',
            };
            
            console.log('123',"");
            
            $.ajax({
                url: "/admin/updateOrderDetail.dox",
                dataType: "json",
                type: "POST",
                data: params,
                success: function (data) {
                	console.log("dete",data);
                	alert('수정 완료');
                	self.fnMainList();
                	self.updateOrderDetailId = null;
                	self.updateproductId = null;  
                }
            });
           
        },
    },
    mounted() {
        this.fnMainList();
    }
});
app.mount("#app");
</script>
