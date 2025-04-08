<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html lang="ko">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="0">

		<title>Vue3 레이아웃 예제</title>
		<script src="/js/vue3b.js"></script>
		<!-- 	<script src="https://unpkg.com/mitt/dist/mitt.umd.js"></script>
 -->
		<script src="/js/main.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
		
		<link rel="stylesheet" type="text/css" href="/css/main.css" />
		
		<style>

			.diamond.premium {
				color: gold;
			}
			
			.diamond.basic {
				color: gray;
			}

		</style>
	</head>

	<body>
		<div id="header">


			<transition name="slide">
				<div v-if="showSearch" class="search-box">
					<div class="search-container">
						<button class="close-button" @click="toggleSearch">&times;</button>
						<div class="search_box">
							<input type="text" placeholder="검색어를 입력해주세요" v-model="searchQuery"
								@keyup.enter="fnSearch('')" class="search-input" />
							<button @click="fnSearch('')" class="search-button">🔍</button>
						</div>
						<div class="popular-search">
							<h3 class="title">인기 검색어</h3>
							<div class="keyword-list">
								<span v-for="keyword in searchList" @Click="fnSearch(keyword.SearchTerm)"
									class="keyword">{{keyword.SearchTerm}}</span>
							</div>
						</div>
					</div>
				</div>
			</transition>

			<div class="top-bar-main">
				<div v-if="!sessionName" class="top-bar">
					<a href="/user/consent.do">회원가입</a>
					| <a @click="fnLogin"> 로그인</a>
					| <a href="/board/list.do?category=A">공지사항</a>
				</div>

				<div v-else class="top-bar">
					<span>{{sessionName}} 님 환영합니다! </span>
					 <a href="/order/orderList.do">주문조회</a>
					| <a href="/board/list.do?category=A">공지사항</a>
					<a v-if="sessionRole == 'ADMIN' " href="/manager/main.do">| 관리자콘솔</a>
					| <a href="/member/logout.do">로그아웃</a>
				</div>
			</div>

			<header class="header">
				<a href="/main.do"> <img class="logo" src="/img/logo.png" alt="로고"> </a>

				<!-- 네비게이션 메뉴 -->
				<nav class="menu">
					<div class="dropdown" v-for="menu in categories">
						<a v-if="menu.del == 'N'" :href="menu.menuUrl">{{ menu.categoryName }}</a>
						<div v-if="menu.children && menu.children.length" class="dropdown-menu">
							<ul>
								<li v-for="subMenu in menu.children">
									<a :href="subMenu.menuUrl">{{ subMenu.categoryName }}</a>
								</li>
							</ul>
						</div>
					</div>
				</nav>

				<div v-show="membershipReady" class="icons">
					<!-- 다이아 아이콘 (isMembership에 따라 색상 다르게) -->
					
					<span @click="toggleSearch" class="icon bi-search"></span>
					
					<span @click="myPage" class="icon bi-person"></span>
					
					<span @click="myCart" class="icon bi-cart"></span>
					
					<!-- 알림 아이콘 -->
					<span @click="showNotifications" class="icon bi-bell notification-icon">
					  <span v-if="unreadCount > 0" class="noti-badge">{{ unreadCount }}</span>
					</span>
					
					<!-- 알림 드롭다운 -->
					<div v-show="showNotificationPanel" class="notification-dropdown">
					  <p>🔔 알림</p>
					
					  <ul class="notification-list">
					    <li
					      v-for="n in sortedNotifications"
					      :key="n.id"
					      :class="['notification-item', n.readYn === 'Y' ? 'read' : 'unread']"
					      @click="ReadNotifications(n)"
					    >
					      <div class="noti-content">
					        <span class="noti-message">{{ n.message }}</span>
					        <span class="noti-time">{{ formatTime(n.createdAt) }}</span>
					      </div>
					    </li>
					
					    <li v-if="sortedNotifications.length === 0" class="notification-item read">
					      <div class="noti-content">
					        <span class="noti-message">새 알림이 없습니다.</span>
					      </div>
					    </li>
					  </ul>
					</div>
					
					<span  @click="myMembership" class="icon" :class="isMembership ? 'bi-gem mem_premium' : 'bi-gem mem_basic'">
					</span>
						
				</div>

			</header>
		</div>

		<script>
			const headerApp = Vue.createApp({
				data() {
					return {
						categories: [],
						sessionId: '${sessionId}' || '',
						sessionName: '${sessionName}',
						sessionRole: '${sessionRole}',
						searchList: {},
						showSearch: false,
						searchQuery: '',
					    googleInfo: [],
                        email: "",
                        isMembership : false,
                        showNotificationPanel : false,
                		notifications: [],
                		membershipReady: false, 
					};
				},
				computed: {
					sortedNotifications() {
						// 읽지 않은 알림을 먼저 정렬
						return this.notifications.slice().sort((a, b) => a.readYn - b.readYn);
					},
					unreadCount() {
					    return this.notifications.filter(n => n.readYn === 'N').length;
					}
				},
				methods: {
					fnMenuList() {

						var self = this;
						var nparmap = { productId: self.productId };
						$.ajax({
							url: '/menuList.dox',
							dataType: 'json',
							type: 'POST',
							data: nparmap,
							success: function (data) {
								console.log(data);

								const map = new Map();
								const result = [];

								data.list.forEach(list => {
									map.set(list.categoryId, { ...list, children: [] });
								});


								//console.log(map);

								data.list.forEach(list => {
									if (list.parentId == null) {
										result.push(map.get(list.categoryId));
									} else {
										const parent = map.get(list.parentId);
										if (parent) {
											parent.children.push(map.get(list.categoryId));  // 자식 메뉴 추가
										}
									}
								});

								console.log(result);


								self.categories = result;

							},
						});


					},
					fnSearchList() {

						var self = this;
						var nparmap = {};

						$.ajax({
							url: "/admin/searchList.dox",
							dataType: "json",
							type: "POST",
							data: nparmap,
							success: function (data) {
								console.log("12", data);
								self.searchList = data.Search;

							}

						});
					},
					fnNotiList() {

						var self = this;
						var nparmap = {userId : self.sessionId };

						$.ajax({
							url: "/Notification.dox",
							dataType: "json",
							type: "POST",
							data: nparmap,
							success: function (data) {
								console.log("132", data);
								self.notifications = data.list;

							}

						});
					},
					
					fnLogin() {
						//window.location.href = "/user/login.do";
						//window.location.href = "/user/login.do?redirect=" + encodeURIComponent(window.location.pathname);
						window.location.href = "/user/login.do?redirect=" + encodeURIComponent(window.location.pathname + window.location.search);
					},
					toggleSearch() {
						this.showSearch = !this.showSearch;
					},
					fnSearch(query) {
						let self = this;

						if (query != '') {
							self.searchQuery = query;
						}

						console.log("검색어:", self.searchQuery);

						if (self.searchQuery === '') {
							alert("검색어를 입력해주세요.")
							return;
						}
						var nparmap = {
							user_id: self.sessionId,
							keyword: self.searchQuery
						};
						$.ajax({
							url: "/insertSearch.dox",
							dataType: "json",
							type: "POST",
							data: nparmap,
							success: function (data) {
								console.log(data);
							}
						});


						location.href = "/product/list.do?searchOption=search&keyword=" + this.searchQuery;
						// 여기에 검색 로직 추가 가능 (API 호출 등)
					},
					myPage: function () {
						console.log("user");
						location.href = "/user/mypage.do";

					},
					myCart: function () {
						console.log("cart");
						location.href = "/cart/list.do";

					},
					myMembership: function () {
						console.log("membership");
						location.href = "/membership/main.do";

					},
					fnGoogle() {
						var self = this;
						var nparmap = {
						};
						$.ajax({
							url: "/user/google-user.dox", // 얘한테 요청함 'controller'에게 요청
							dataType: "json",
							type: "POST",
							data: nparmap,
							success: function (data) {
								if (data.info == null ||data.info == "") {
									console.log("구글 정보 없음1");
									return;
								}else{
									self.googleInfo = data.info;
									console.log(self.googleInfo);
									self.fnGoogleAuth();
								}
							}
						});
					},
					fnGoogleAuth() {
						var self = this;
						var nparmap = {
							email: self.googleInfo.email
							
						};

						if (sessionStorage.getItem("socialLoginConfirmed")) { 
							return;
						}

						$.ajax({
							url: "/user/socialEmail.dox", // 얘한테 요청함 'controller'에게 요청
							dataType: "json",
							type: "POST",
							data: nparmap,
							success: function (data) {
								console.log(data);
								console.log("구글 카운트:", data); //fail1
								sessionStorage.setItem("socialLoginConfirmed", "true"); // ✅ 확인 후 다시 안 뜨게 저장

								if((data.result == "fail1")){
									return;
								} else {
									if (data.count > 0) {
										alert(data.user.userName + "님 환영해요!");
										location.reload();
									} else {
										console.log("구글 카운트:", data.count);
										if (confirm("이 사이트를 이용하시려면 회원가입이 필요합니다. 회원가입하시겠습니까?")) {
											//sessionStorage.setItem("socialLoginConfirmed", "true"); 
											//location.href = "/user/consent.do";

											pageChange("/user/consent.do", {email : self.googleInfo.email, name : self.googleInfo.name});
											
										}
									}
								}

							}
						});
					},
					showNotifications() {
						this.showNotificationPanel = !this.showNotificationPanel;
					},
					ReadNotifications(item) {
						let self = this;
						var nparmap = {
								id: item.id,
						};
						
						$.ajax({
							url: "/updateNoti.dox",
							dataType: "json",
							type: "POST",
							data: nparmap,
							success: function (data) {
								//console.log("12322",data);
								
								  if (item.boardId) {
								    location.href = '/board/view.do?boardId='+ item.boardId;
								  } else if (item.vetBoardId) {
								    location.href = '/board/vetBoardView.do?vetBoardId='+ item.vetBoardId;
								  } else if (item.orderId) {
									location.href = '/order/orderList.do?orderId='+ item.orderId;
								  }
								self.fnNotiList();
							}
						});
							
						
						
					},
					formatTime(dateStr) {
					      try {
					        const target = new Date(dateStr.replace(' ', 'T'));

					        if (isNaN(target.getTime())) {
					          console.warn("❗ 유효하지 않은 날짜:", dateStr);
					          return '';
					        }

					        const now = new Date();
					        const diffSec = Math.floor((now - target) / 1000);

					        if (diffSec < 60) return '방금 전';
					        
					        if (diffSec < 3600) return Math.floor(diffSec / 60)  + '분 전';
					        
					        if (diffSec < 86400) return Math.floor(diffSec / 3600) + '시간 전';
					        
					        return Math.floor(diffSec / 86400)+'일 전';
					        
					      } catch (e) {
					        console.error("❗ formatTime 에러:", e);
					        return '';
					      }
				  },
				  fnMemberShipInfo() {
                      var self = this;
                      var nparmap = {
                          userId: self.sessionId

                      };
                      console.log("파라", nparmap);
                      $.ajax({
                          url: "/user/memberShip.dox",
                          dataType: "json",
                          type: "POST",
                          data: nparmap,
                          success: function (data) {
                              console.log("데이타 카운트", data.count);
                              if (data.count > 0) {
                                  self.isMembership = true;
                                  self.membershipReady = true; 
                              } else {
                            	  self.isMembership = false;
                            	  self.membershipReady = true;
                              }

                          }
                      });
                  },


			},
				mounted() {
					let self = this;
					self.fnMenuList();
					self.fnSearchList();
					self.fnGoogle();
					
					if (self.sessionId != '') {
						self.fnNotiList();
						self.fnMemberShipInfo();
					} else {
                  	  self.membershipReady = true;
					}
					//console.log(self.sessionId);
					//console.log(self.sessionName);
					//console.log(self.sessionRole);

				}
			});

			headerApp.mount("#header");
		</script>
	</body>

	</html>