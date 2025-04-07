<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회사 정보</title>
    
    <style>
    
		/* 사이드바 */
		.sidebar {
		    background-color: #ffffff;
		    padding: 25px 20px;
		    border-radius: 16px;
		    height: 100%;
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
		}
		
		.sidebar h3 {
		    color: #0d6efd;
		    font-weight: bold;
		    margin-bottom: 30px;
		}
		
		.sidebar .nav-link {
		    color: #4b5563;
		    font-size: 15px;
		    padding: 10px 15px;
		    border-radius: 8px;
		    margin-bottom: 8px;
		    transition: 0.2s;
		}


		/* 하위 메뉴 */
		.submenu {
		    list-style: none;
		    padding-left: 20px;
		    margin-top: 5px;
		    display: none;
		}

		.submenu .submenu-item {
		    font-size: 14px;
		    padding: 5px 10px;
		    color: #4b5563;
		    cursor: pointer;
		}

		.submenu .submenu-item:hover {
		    background-color: #f0f8ff;
		    border-radius: 5px;
		}

		/* 활성화된 경우 하위 메뉴 표시 */
		.nav-item.active .submenu {
		    display: block;
		}
		
				
		.sidebar .nav-link.active,
		.sidebar .nav-link:hover {
		    background-color: #e0edff;
		    color: #0d6efd;
		    font-weight: 600;
		}
		
		.submenu-item.active{
		    background-color: #e0edff;
		    color: #0d6efd;
		    font-weight: 600;
		}
		
    </style>
    
</head>
<body>
    <div id="side" class="side col-3">
        <!-- Sidebar -->
        <div class="sidebar">
            <h3>멍냥꽁냥 관리자</h3>
            <ul class="nav flex-column">
                <li class="nav-item" :class="{ active: menu === 'stat' }"  >
                    <a @click="fnchange('stat','1')" class="nav-link"  :class="{ active: menu === 'stat' }" href="#">통계</a>
                    <ul class="submenu">
                        <li @click="fnchange('stat','1')" class="submenu-item" :class="{ active: submenu === '1' }">요약 통계</li>
                        <li @click="fnchange('stat','2')" class="submenu-item" :class="{ active: submenu === '2' }">접속자 통계</li>
                        <li @click="fnchange('stat','3')" class="submenu-item" :class="{ active: submenu === '3' }">판매량 통계</li>
                    </ul>
                </li>
                <li class="nav-item" :class="{ active: menu === 'board' }">
                    <a @click="fnchange('board','1')" class="nav-link" :class="{ active: menu === 'board' }" href="#">게시판 관리</a>
                    <ul class="submenu">
                        <li @click="fnchange('board','1')" class="submenu-item" :class="{ active: submenu === '1' }">게시글 관리</li>
                        <li @click="fnchange('board','2')" class="submenu-item" :class="{ active: submenu === '2' }">댓글 관리</li>
                        <li @click="fnchange('board','3')" class="submenu-item" :class="{ active: submenu === '3' }">수의사 게시판</li> 
                        <li @click="fnchange('board','4')" class="submenu-item" :class="{ active: submenu === '4' }">상품 리뷰/문의</li>       
                    </ul>
                </li>
                <li class="nav-item" :class="{ active: menu === 'product' }">
                    <a @click="fnchange('product','1')" class="nav-link" :class="{ active: menu === 'product' }" href="#">상품 관리</a>
                    <ul class="submenu">
                        <li @click="fnchange('product','1')" class="submenu-item" :class="{ active: submenu === '1' }">상품 목록</li>
                        <li @click="fnchange('product','2')" class="submenu-item" :class="{ active: submenu === '2' }"> 주문 관리</li>
<!--                    <li @click="fnchange('product','3')" class="submenu-item" :class="{ active: submenu === '3' }"> 카테고리 관리</li>--> 
                	</ul>
                </li>
                <li class="nav-item" :class="{ active: menu === 'member' }">
                    <a @click="fnchange('member','1')" class="nav-link" :class="{ active: menu === 'member' }" href="#">회원 관리</a>
                    <ul class="submenu">
                        <li @click="fnchange('member','1')" class="submenu-item" :class="{ active: submenu === '1' }">회원 관리</li>
                        <li @click="fnchange('member','2')" class="submenu-item" :class="{ active: submenu === '2' }">멤버쉽 관리</li>
						<li @click="fnchange('member','3')" class="submenu-item" :class="{ active: submenu === '3' }">수의사 관리</li>
						<li @click="fnchange('member','4')" class="submenu-item" :class="{ active: submenu === '4' }">제휴사 관리</li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    
    <script>
        const side = Vue.createApp({
            data() {
                return {
                	menu : "",
                	submenu : "",
                };
            },
            methods: {
            	
                fnchange(menu, submenu) {
                   location.href="/manager/main.do?menu="+ menu + "&submenu=" + submenu;
                },
                
            },
            mounted() {
            	let self = this;
                const params = new URLSearchParams(window.location.search);
                
                self.menu = params.get("menu") || "stat";
                self.submenu = params.get("submenu") || "1";

            	
            }
            
            
            
        });
        
        side.mount('#side');
    </script>
</body>
</html>

