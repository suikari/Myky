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
        
    </style>
</head>
<body>
    <div id="header">
        <div class="top-bar-main">
        	<div class="top-bar">
	            <a href="/register">회원가입</a> 
	            | <a href="/user/login.do">로그인</a> 
	            | <a href="/orders">주문조회</a> 
	            | <a href="/notices">공지사항</a> 
	            <!-- | <a href="/logout">로그아웃</a>  -->
	        </div>
        </div>
        
        <header class="header">
            <a href="/main.do"> <img class="logo" src="/img/logo.png" alt="로고"> </a>
            
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
                        ],
                        sessionId : '${sessionId}',
                        sessionName : '${sessionName}',
                        sessionRole : '${sessionRole}',
                    };
                },
                methods: {
                    fnLogin() {
                        window.location.href = "/user/login.do";
                    }
                },
                mounted() {
                	let self = this;
                	console.log(self.sessionId);
                	console.log(self.sessionName);
                	console.log(self.sessionRole);

                }
            });
            
            headerApp.mount("#header");
        });
    </script>
</body>
</html>
