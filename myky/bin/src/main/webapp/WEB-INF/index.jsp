<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<script src="js/swiper8.js"></script>
	
    <style>
    
   

    </style>
</head>
<body>
     <jsp:include page="common/header.jsp"/>
 


    <div id="app" class="container">



        <main class="content">

			<!-- Vue에서 렌더링할 Swiper 영역 -->
			<div ref="swiperContainer" class="swiper">
			    <div class="swiper-wrapper">
			        <img v-for="img in slides" :src="img" class="swiper-slide" />
			    </div>
			    <div class="swiper-pagination"></div>
			    <div class="swiper-button-next"></div>
			    <div class="swiper-button-prev"></div>
			</div>
			
            <section class="section-grid">
			      <section class="shortcut-grid">
				    <div class="shortcut-item">
				        <a href="/navi/main.do" >
				            <img src="img/quick/menu_black.png" alt="아이콘1">
				            <span>병원찾기</span>
				        </a>
				    </div>
				    <div class="shortcut-item">
				        <a href="#">
				            <img src="img/quick/menu_white.png" alt="아이콘2">
				            <span>건강식품구매</span>
				        </a>
				    </div>
				    <div class="shortcut-item">
				        <a href="#">
				            <img src="img/quick/menu.png" alt="아이콘3">
				            <span>매거진</span>
				        </a>
				    </div>
				    <div class="shortcut-item">
				        <a href="#">
				            <img src="img/quick/menu_toggle.png" alt="아이콘4">
				            <span>자가진단챗봇</span>
				        </a>
				    </div>
				</section>
				
			    <div class="board-container">
                       <div class="board-title">게시판1</div>
                       <div v-for="post in freeposts" class="post-item">
                           <div>{{ post.title }}</div>
                           <div class="post-content">{{ post.content }}</div>
                       </div>
                                             
                </div>			  
                
                <div class="board-container">
	                    <div class="board-title">게시판2</div>
	                    <div v-for="post in qnposts" class="post-item">
	                        <div>{{ post.title }}</div>
	                        <div class="post-content">{{ post.content }}</div>
	                    </div>
                </div>
                

                
            </section>

            <section class="best-products">
                     <div class="best-product-container">
                        <div class="best-product-title">베스트 상품</div>
                        <div class="product-list">
                            <div v-for="product in displayedProducts" :key="product.id" class="product-card">
                                <div class="product-image">{{ product.image }}</div>
                                <div class="product-name">{{ product.name }}</div>
                                <div class="product-price">{{ product.price }}원</div>
                            </div>
                        </div>
                        <div class="navigation">
                            <button class="nav-button" @click="prevPage" :disabled="currentPage === 0">이전</button>
                            <button class="nav-button" @click="nextPage" :disabled="currentPage >= maxPage">다음</button>
                        </div>
                    </div>
            </section>
        </main>

    </div>


     <jsp:include page="common/footer.jsp"/>

    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                    	slides : [
                            'img/banner/banner1.PNG',
                            'img/banner/banner2.PNG',
                            'img/banner/banner3.PNG'
                        ],
                        freeposts : [
                            { id: 1, title: "첫 번째 게시글", content: "이것은 첫 번째 게시글 내용입니다." },
                            { id: 2, title: "두 번째 게시글", content: "Vue 3을 활용한 게시판 예제입니다." },
                            { id: 3, title: "세 번째 게시글", content: "JSP 환경에서도 Vue를 쉽게 사용할 수 있습니다." }
                        ],
                        qnposts : [
                            { id: 1, title: "첫 번째 게시글", content: "이것은 두 번째 게시판 게시글 내용입니다." },
                            { id: 2, title: "두 번째 게시글", content: "Vue 3을 활용한 게시판 예제2입니다." },
                            { id: 3, title: "세 번째 게시글", content: "HTML 환경에서도 Vue를 쉽게 할수있습니다. " }
                        ],
                        products: [
                            { id: 1, name: "상품 A", price: 25000, image: "이미지 A" },
                            { id: 2, name: "상품 B", price: 32000, image: "이미지 B" },
                            { id: 3, name: "상품 C", price: 15000, image: "이미지 C" },
                            { id: 4, name: "상품 D", price: 27000, image: "이미지 D" },
                            { id: 5, name: "상품 E", price: 20000, image: "이미지 E" },
                            { id: 6, name: "상품 F", price: 18000, image: "이미지 F" },
                            { id: 7, name: "상품 G", price: 31000, image: "이미지 G" },
                            { id: 8, name: "상품 H", price: 29000, image: "이미지 H" }
                        ],
                        currentPage: 0,
                        itemsPerPage: 5,
                        code : ""
                        
                    
                    };
                },
                computed: {
                    maxPage() {
                        return Math.ceil(this.products.length / this.itemsPerPage) - 1;
                    },
                    displayedProducts() {
                        const start = this.currentPage * this.itemsPerPage;
                        return this.products.slice(start, start + this.itemsPerPage);
                    }
                },
                methods: {
                	prevPage() {
                        if (this.currentPage > 0) this.currentPage--;
                    },
                    nextPage() {
                        if (this.currentPage < this.maxPage) this.currentPage++;
                    },
                    kakaotest : function() {
                    	var self = this;
                    	var nparmap = {
                    		code : self.code
                    	};
                    	$.ajax({
                    		url: "member/kakao.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log(data);
                    		}
                    	});
                    },
                    fntest : function() {
                    	var self = this;
                    	var nparmap = {
                    	};
                    	$.ajax({
                    		url: "board/list.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log(data);
                    		}
                    	});
                    	
                    }
                    
                },
                mounted() {
                	let self = this;
                	
                	this.$nextTick(() => {
                        new Swiper(this.$refs.swiperContainer, {
                            loop: true, // 반복
                            autoplay: {
                                delay: 2500,
                                disableOnInteraction: false, // 사용자가 버튼을 눌러도 자동 재생 유지
                            },
                            slidesPerView: "auto", // 자동 너비 조절
                            spaceBetween: 10, // 슬라이드 간격
                            pagination: {
                                el: ".swiper-pagination",
                                clickable: true,
                            },
                            navigation: {
                                nextEl: ".swiper-button-next",
                                prevEl: ".swiper-button-prev",
                            },
                        });
                    });
                	
                	
                	const queryParams = new URLSearchParams(window.location.search);
                	self.code = queryParams.get('code') || ''; 
                	
                	if ( self.code != '') { 
                		self.kakaotest();
                    	//console.log(self.code);
						
                	}
                	self.fntest();
                }
            });

            app.mount("#app");
        });
    </script>
