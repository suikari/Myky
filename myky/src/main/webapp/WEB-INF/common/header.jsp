<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
 -->	<script src="/js/main.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		
    <style>
		    
		/* 전체 레이아웃 스타일 */
		#header {
		    position: sticky;
		    top: 0;
		    z-index: 1000; /* 다른 요소 위에 표시되도록 */
		    border-bottom: 3px solid #e76f51;
		    background-color: #ffbc7b;		    
		}
		.top-bar-main {
			background-color: #f4a261;
		}
		
		/* 상단바 스타일 */
		.top-bar {
		    display: flex;
		    justify-content: flex-end;
		    margin : auto;
		    max-width : 1024px;
		    font-size: 14px;
		    color: #fff;
		}
		
		.top-bar a {
		    color: #fff;
		    text-decoration: none;
		    margin: 0 8px;
		}
		
		.top-bar a:hover {
		    text-decoration: underline;
		}
		
		/* 헤더 스타일 */
		.header {
		    display: flex;
		    align-items: center;
		    justify-content: space-between;
		    margin : auto;
		    max-width : 1024px;
		}
		
		.logo {
		    height: 80px;
		}
		
		/* 네비게이션 메뉴 스타일 */
		.menu {
		    display: flex;
		    gap: 20px;
		}
		
		.menu .dropdown {
		    position: relative;
		}
		
		.menu a {
		    color: #5d4037;
		    font-size: 16px;
		    text-decoration: none;
		    font-weight: bold;
		}
		
		.menu a:hover {
		    color: #e76f51;
		}
		
		/* 드롭다운 메뉴 스타일 */
		.dropdown-menu {
		    display: none;
		    position: absolute;
		    top: 100%;
		    left: 0;
		    background-color: #ffb997;
		    padding: 10px;
		    border-radius: 5px;
		    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
		}
		
		.dropdown-menu ul {
		    list-style: none;
		    padding: 0;
		    margin: 0;
		}
		
		.dropdown-menu li {
		    padding: 5px 0;
		}
		
		.dropdown-menu a {
		    color: #5d4037;
		    font-size: 14px;
		}
		
		.menu .dropdown:hover .dropdown-menu {
		    display: block;
		}
		
		/* 로그인 버튼 스타일 */
		.login {
		    background-color: #e76f51;
		    color: white;
		    padding: 8px 15px;
		    border-radius: 5px;
		    cursor: pointer;
		    font-size: 14px;
		    font-weight: bold;
		}
		
		.login:hover {
		    background-color: #d3543f;
		}
		
		/* 아이콘 스타일 */
		.icons {
		    display: flex;
		    gap: 15px;
		    font-size: 20px;
		}
		
		.icons .icon {
		    cursor: pointer;
		    color: #5d4037;
		}
		
		.icons .icon:hover {
		    color: #e76f51;
		}

	        /* 전체 네비게이션 바 */
        .nav-container {
            display: flex;
            gap: 15px;
            padding: 10px 20px;
            background-color: #f8f9fa;
            border-bottom: 2px solid #ddd;
        }

        /* 각 카테고리 메뉴 */
        .dropdown {
            position: relative;
        }
        .dropdown > a {
            text-decoration: none;
            color: #333;
            font-size: 16px;
            font-weight: bold;
            padding: 10px 15px;
            display: block;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .dropdown > a:hover {
            background-color: #e3e3e3;
        }

        /* 드롭다운 메뉴 */
        .dropdown-menu {
            position: absolute;
            top: 100%;
            left: 0;
            width: 180px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            display: none;
            z-index: 100;
        }

        /* 마우스 오버 시 드롭다운 표시 */
        .dropdown:hover .dropdown-menu {
            display: block;
        }

        /* 하위 메뉴 스타일 */
        .dropdown-menu ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .dropdown-menu li {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .dropdown-menu li:last-child {
            border-bottom: none;
        }
        .dropdown-menu a {
            text-decoration: none;
            color: #333;
            font-size: 14px;
            display: block;
        }
        .dropdown-menu a:hover {
            background-color: #f5f5f5;
        }

        /* 반응형 - 모바일에서 네비게이션 정렬 */
        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                align-items: flex-start;
            }
            .dropdown-menu {
                width: 100%;
            }
        }
        
        
        /*슬라이드 추가*/
        
        .search-container {
		  position: relative;
		  display: inline-block;
		  width:100%;
		}
		
		.search-icon {
		  background: none;
		  border: none;
		  font-size: 20px;
		  cursor: pointer;
		}
		
		.search-box {
		  position: absolute;
		  z-index : 999;
		  top: 0;
		  width:100%;
		  background: white;
		  padding: 10px;
		  border-radius: 5px;
		  box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
		  transition: all 0.3s ease-in-out;
		    text-align: center;
		  
		}
		
		.slide-enter-active, .slide-leave-active {
		  transition: transform 0.3s ease-out, opacity 0.3s ease-out;
		}
		
		.slide-enter-from {
		  transform: translateY(-50px);
		  opacity: 0;
		}
		
		.slide-leave-to {
		  transform: translateY(-50px);
		  opacity: 0;
		}




.search-container {
  width: 100%;
  margin: 20px auto;
  text-align: center;
  position: relative;
  background: white;
  border-radius: 8px;
}

.search_box {
  display: flex;
  align-items: center;
  background: #f1f1f1;
  border-radius: 8px;
  padding: 15px;
}

.search-input {
  flex-grow: 1;
  border: none;
  background: transparent;
  outline: none;
  font-size: 16px;
}

.search-button {
  background: none;
  border: none;
  cursor: pointer;
}

.popular-search {
  background: #f5f5f5;
  padding: 20px;
  margin-top: 10px;
  border-radius: 8px;
}

.close-button {
  position: absolute;
  top: -25px;
  right: 9px;
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #888;
}

.title {
  font-size: 18px;
  margin-bottom: 10px;
}

.keyword-list {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
}

.keyword {
  background: white;
  padding: 8px 12px;
  border-radius: 16px;
  font-size: 14px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
				      <input type="text" placeholder="검색어를 입력해주세요" v-model="searchQuery" @keyup.enter="fnSearch('')"   class="search-input" />
				      <button @click="fnSearch('')" class="search-button">🔍</button>
				    </div>
				    <div class="popular-search">
				      <h3 class="title">인기 검색어</h3>
				      <div class="keyword-list">
				        <span v-for="keyword in searchList" @Click="fnSearch(keyword.SearchTerm)" class="keyword">{{keyword.SearchTerm}}</span>
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
	            | <a href="/orders">주문조회</a> 
	            | <a href="/board/list.do?category=A">공지사항</a> 
	            <a v-if="sessionRole == 'ADMIN' " href="/manager/main.do"> | 관리자콘솔</a> 
	            | <a href="/member/logout.do">로그아웃</a>
	        </div>
        </div>
        
        <header class="header">
            <a href="/main.do"> <img class="logo" src="/img/logo.png" alt="로고"> </a>
            
            <!-- 네비게이션 메뉴 -->
            <nav class="menu">
                <div class="dropdown" v-for="menu in categories" >
                    <a :href="menu.menuUrl">{{ menu.categoryName }}</a>
                    <div v-if="menu.children && menu.children.length" class="dropdown-menu">
                        <ul>
                            <li v-for="subMenu in menu.children" >
                                <a :href="subMenu.menuUrl">{{ subMenu.categoryName }}</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            
            <div class="icons">
                <span class="icon">💎</span>
		    	<span @click="toggleSearch" class="search-icon">🔍</span>
                <span @click="myPage" class="icon">👤</span>
                <span @click="myCart" class="icon">🛒</span>
            </div>
            
        </header>
    </div>

    <script>
            const headerApp = Vue.createApp({
                data() {
                    return {
                    	categories: [ ],
                        sessionId   : '${sessionId}' || '' ,
                        sessionName : '${sessionName}',
                        sessionRole : '${sessionRole}',
                        searchList : {},
                        showSearch: false,
                        searchQuery: '',
                    };
                },
                methods: {
                	fnMenuList (){
                		
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
                	fnSearchList () {
                		
                		var self = this;
                        var nparmap = { };
                        
                       	$.ajax({
                    		url: "/admin/searchList.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log("12",data);
                    			self.searchList = data.Search;

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
                    	
                    	if ( query != '' ){
                    		self.searchQuery = query;
                    	}
                    	
                        console.log("검색어:", self.searchQuery);
                      
                      if ( self.searchQuery === '' ) {
                    	  alert("검색어를 입력해주세요.")
                    	  return;
                      }
	                  	var nparmap = {
	                  			user_id : self.sessionId,
	                  			keyword : self.searchQuery
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
                  	
                      
                         location.href = "/product/list.do?searchOption=search&keyword="+this.searchQuery;                  	
                      // 여기에 검색 로직 추가 가능 (API 호출 등)
                    },
                    myPage: function(){
                    	console.log("user");
                    	location.href = "/user/mypage.do";

                    },
                    myCart: function(){
                    	console.log("cart");
                    	location.href = "/cart/list.do";

                    },
                    
                },
                mounted() {
                	let self = this;
                	self.fnMenuList();
                	self.fnSearchList();

                	
                	//console.log(self.sessionId);
                	//console.log(self.sessionName);
                	//console.log(self.sessionRole);

                }
            });
            
            headerApp.mount("#header");
    </script>
</body>
</html>
