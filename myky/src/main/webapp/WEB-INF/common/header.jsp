<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<script src="/js/vue3b.js"></script>
    <script src="/js/main.js"></script>
	
		<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	
	
    <style>
    
		/* 헤더 스타일 */
		.header {
		    display: flex;
		    align-items: center;
		    justify-content: space-between;
		    background-color: #ffbc7b; /* 주황색 배경 */
		    padding: 10px 20px;
		    color: white;
		}
		
		/* 로고 스타일 */
		.logo {
		    height: 50px;
		}
		
		/* 네비게이션 메뉴 스타일 */
		.menu {
		    display: flex;
		    gap: 20px;
		}
		
		.menu a {
		    color: white;
		    text-decoration: none;
		    font-weight: bold;
		}
		
		/* 드롭다운 메뉴 스타일 */
		.dropdown {
		    position: relative;
		}
		
		.dropdown-menu {
		    display: none;
		    position: absolute;
		    top: 100%;
		    left: 0;
		    background: white;
		    border-radius: 5px;
		    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
		    z-index: 10;
		}
		
		.dropdown:hover .dropdown-menu {
		    display: block;
		}
		
		.dropdown-menu ul {
		    list-style: none;
		    padding: 0;
		    margin: 0;
		}
		
		.dropdown-menu li {
		    padding: 10px;
		    white-space: nowrap;
		}
		
		.dropdown-menu a {
		    color: black;
		    text-decoration: none;
		    font-size: 14px;
		}
		
		.dropdown-menu li:hover {
		    background: #f3f3f3;
		}
		
		/* 로그인 버튼 스타일 */
		.login {
		    cursor: pointer;
		    background: white;
		    color: #f7931e;
		    padding: 5px 15px;
		    border-radius: 5px;
		    font-weight: bold;
		}
		
		.top-bar {
				    background-color: #ffa145; /* 주황색 배경 */
		
		}

    </style>
</head>
<body>
    <div id="header">
        <div class="top-bar">
            <a href="/register">회원가입</a> |
            <a href="/login">로그인</a> |
            <a href="/orders">주문조회</a> |
            <a href="/notices">공지사항</a> |
            <a href="/logout">로그아웃</a>
        </div>
        
        <header class="header">
            <img class="logo" src="/img/logo.png" alt="로고">
            
            <!-- 네비게이션 메뉴 -->
            <nav class="menu">
                <div class="dropdown" v-for="menu in categories" :key="menu.menuId">
                    <a :href="menu.menuUrl">{{ menu.menuName }}</a>
                    <div v-if="menu.children && menu.children.length" class="dropdown-menu">
                        <ul>
                            <li v-for="subMenu in menu.children" :key="subMenu.menuId">
                                <a :href="subMenu.menuUrl">{{ subMenu.menuName }}</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div @click="fnLogin" class="login">로그인</div>
            
            <div class="icons">
                <span class="icon">💎</span>
                <span class="icon">🔍</span>
                <span class="icon">👤</span>
                <span class="icon">🛒</span>
            </div>
            
        </header>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const headerApp = Vue.createApp({
                data() {
                    return {
                        categories: [
                            { 
                                menuId: 1, menuName: "강아지용품", menuUrl: "#", 
                                children: [
                                    { menuId: 101, menuName: "장난감", menuUrl: "#" },
                                    { menuId: 102, menuName: "사료", menuUrl: "#" },
                                    { menuId: 103, menuName: "간식", menuUrl: "#" }
                                ]
                            },
                            { 
                                menuId: 2, menuName: "고양이용품", menuUrl: "#",
                                children: [
                                    { menuId: 201, menuName: "스크래처", menuUrl: "#" },
                                    { menuId: 202, menuName: "캣타워", menuUrl: "#" },
                                    { menuId: 203, menuName: "간식", menuUrl: "#" }
                                ]
                            },
                            { 
                                menuId: 2, menuName: "보호소 소개", menuUrl: "#",
                                children: [
                                    { menuId: 201, menuName: "스크래처", menuUrl: "#" },
                                    { menuId: 202, menuName: "캣타워", menuUrl: "#" },
                                    { menuId: 203, menuName: "간식", menuUrl: "#" }
                                ]
                            },
                            { 
                                menuId: 2, menuName: "고양이용품", menuUrl: "#",
                                children: [
                                    { menuId: 201, menuName: "스크래처", menuUrl: "#" },
                                    { menuId: 202, menuName: "캣타워", menuUrl: "#" },
                                    { menuId: 203, menuName: "간식", menuUrl: "#" }
                                ]
                            }
                        ]
                    };
                },
                methods: {
                    fnLogin() {
                        window.location.href = "/user/login.do";
                    }
                }
            });
            
            headerApp.mount("#header");
        });
    </script>
</body>
</html>
