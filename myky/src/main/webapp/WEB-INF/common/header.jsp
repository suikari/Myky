<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<script src="/js/vue3b.js"></script>
		<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	
	<link rel="stylesheet" href="/css/main.css">
	
    <style>
    </style>
</head>
<body>
    <div id="header" >
        <header class="header">
            <img class="logo" src="/img/medi.png" alt="로고">
           
            <!-- 카테고리 메뉴 -->
            <nav class="flex gap-2 menu">
                <div class="dropdown" v-for="menu in categories" >
                    <a :href="menu.menuUrl">{{ menu.menuName }}</a>
                    <div v-if="menu.children && menu.children.length" class="dropdown-menu w-40 p-2">
                        <ul >
                            <li  v-for="subMenu in menu.children" :key="subMenu.menuId"  class="p-2 hover:bg-gray-100">
                                <a href="#">{{ subMenu.menuName }}</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        
            <div class="login">로그인</div>
        </header>

    </div>
</body>
</html>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const header = Vue.createApp({
                data() {
                    return {
                    	categories: [
                            { 
                                menuId: 1, menuName: "의류", menuUrl: "#", 
                                children: [
                                    { menuId: 101, menuName: "강아지", menuUrl: "#" },
                                    { menuId: 102, menuName: "고양이", menuUrl: "#" },
                                    { menuId: 103, menuName: "ETC", menuUrl: "#" }
                                ] 
                            },
                            { 
                                menuId: 2, menuName: "장난감", menuUrl: "#",
                                children: [
                                    { menuId: 201, menuName: "11", menuUrl: "#" },
                                    { menuId: 202, menuName: "22", menuUrl: "#" },
                                    { menuId: 203, menuName: "33", menuUrl: "#" }
                                ]
                            },
                            { 
                                menuId: 3, menuName: "식품", menuUrl: "#",
                                children: [
                                    { menuId: 301, menuName: "영양제", menuUrl: "#" },
                                    { menuId: 302, menuName: "사료", menuUrl: "#" },
                                    { menuId: 303, menuName: "간식", menuUrl: "#" }
                                ]
                            }
                        ]
                    };
                },
                methods: {
                },
                mounted() {
                }
            });

            header.mount("#header");
        });
    </script>