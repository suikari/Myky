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
    
    
/**/
.content {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 20px;
}

.slider-wrapper {
    position: relative;
    width: 400px;
    overflow: hidden;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

.slider-container {
    display: flex;
    transition: transform 0.5s ease-in-out;
}

.slide {
    flex: 0 0 100%;
}

.slide-img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
}

.prev-btn, .next-btn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    padding: 10px;
    cursor: pointer;
    border-radius: 50%;
}

.prev-btn { left: 10px; }
.next-btn { right: 10px; }

.indicators {
    position: absolute;
    bottom: 10px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 5px;
}

.indicator {
    width: 10px;
    height: 10px;
    background: #ccc;
    border-radius: 50%;
    cursor: pointer;
    transition: background 0.3s;
}

.indicator.active {
    background: white;
}

.section-grid {
	width:100%;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 15px;
    margin-top: 20px;
    max-width : 1000px;
}

.grid-item {
    padding: 20px;
    text-align: center;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
}

.best-products {
	width : 100%;
	max-width : 1024px;
    margin-top: 30px;
    padding: 40px;
    text-align: center;
    font-size: 1.2em;
    font-weight: bold;
    background: #fff;
    border-radius: 8px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
}

.shortcut-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr); /* 2x2 그리드 */
    gap: 10px; /* 아이콘 간격 */
    width: 200px; /* 원하는 크기로 조정 */
    margin: 20px auto; /* 가운데 정렬 */
}

.shortcut-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: #f5f5f5;
    border-radius: 10px;
    padding: 15px;
    transition: transform 0.2s ease-in-out;
}



.shortcut-item:hover {
    transform: scale(1.1); /* 마우스 호버 시 확대 */
}

.shortcut-item a {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-decoration: none;
    color: #333;
}

.shortcut-item img {
    width: 50px; /* 아이콘 크기 */
    height: 50px;
    margin-bottom: 5px;
}

.shortcut-item span {
    font-size: 14px;
    font-weight: bold;
}



.board-container {
    width: 300px;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 10px;
    margin: 10px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
}
.board-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
    text-align: center;
}
.post-item {
    padding: 8px;
    border-bottom: 1px solid #eee;
    cursor: pointer;
}
.post-item:hover {
    background-color: #f9f9f9;
}
.post-content {
    font-size: 14px;
    color: #666;
}

.product_img {
	width : 100%;
	height : 100%;
}
/**/

        .best-product-container {
            width: 100%;
            max-width: 1000px;
            margin: 20px auto;
            text-align: center;
        }
        .best-product-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .product-list {
            display: flex;
            gap: 10px;
            justify-content: center;
            flex-wrap: wrap;
        }
        .product-card {
            width: calc(20% - 35px); /* 5개 기준 */
            min-width: 150px;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
            text-align: center;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .product-image {
            width: 100%;
            height: 120px;
            background-color: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            color: #777;
            margin-bottom: 10px;
        }
        .product-name {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .product-price {
            font-size: 14px;
            color: #333;
        }
        .navigation {
            margin-top: 15px;
        }
        .nav-button {
            padding: 8px 15px;
            font-size: 14px;
            border: none;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            margin: 0 5px;
        }
        .nav-button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
        @media (max-width: 600px) {
            .product-card {
                width: calc(50% - 10px); /* 작은 화면에서는 2개씩 */
            }
        }
        
        
        
            
   /* Swiper 컨테이너 기본 설정 */
	.swiper {
	    width: 100%;
	    height: 400px; /* 필요에 따라 높이 조절 */
	}
	
	/* Swiper 내부 슬라이드 설정 */
	.swiper-slide {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    font-size: 20px;
	    background: #ddd; /* 배경색 (테스트용) */
	    width: 100% !important; /* 자동으로 조절되도록 설정 */
	}
	
	

        
   

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
				        <a href="/partner/list.do" >
				            <img src="img/quick/menu_black.png" alt="아이콘1">
				            <span>병원찾기</span>
				        </a>
				    </div>
				    <div class="shortcut-item">
				        <a href="/product/list.do">
				            <img src="img/quick/menu_white.png" alt="아이콘2">
				            <span>물품구매</span>
				        </a>
				    </div>
				    <div class="shortcut-item">
				        <a href="/center.do">
				            <img src="img/quick/menu.png" alt="아이콘3">
				            <span>후원하기</span>
				        </a>
				    </div>
				    <div class="shortcut-item">
				        <a href="/cart/list.do">
				            <img src="img/quick/menu_toggle.png" alt="아이콘4">
				            <span>주문조회</span>
				        </a>
				    </div>
				</section>
				
			    <div class="board-container">
                       <div class="board-title">게시판1</div>
                       <div v-for="post in freeposts"  @click="fnView(post.boardId)" class="post-item">
                           <div>{{ post.title }}</div>
                           <div class="post-content">{{ post.createdAt }}</div>
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
                                <div class="product-image">
                                    <template v-if="product.filePath">
				                        <img class="product_img" :src="product.filePath" :alt="product.fileName" @click="fnPView(product.productId)">
				                    </template>
				                    <template v-else>
				                        <img class="product_img" src="../../img/product/product update.png" alt="이미지 없음" @click="fnPView(product.productId)">
				                    </template>
                                </div> 
                                <div class="product-name">{{ product.productName }}</div>
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
                        freeposts : [],
                        qnposts : [
                            { id: 1, title: "첫 번째 게시글", content: "이것은 두 번째 게시판 게시글 내용입니다." },
                            { id: 2, title: "두 번째 게시글", content: "Vue 3을 활용한 게시판 예제2입니다." },
                            { id: 3, title: "세 번째 게시글", content: "HTML 환경에서도 Vue를 쉽게 할수있습니다. " }
                        ],
                        products: [],
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
                    fnboardList : function() {
                    	var self = this;
                    	var nparmap = {
                    			page : 0,
                    			pageSize : 3
                    	};
                    	$.ajax({
                    		url: "board/list.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log(data);
                    			self.freeposts = data.board;

                    		}
                    	});
                    }, 
                    fnProductList : function() {
                    	var self = this;
                    	var nparmap = {
                    			page : 0,
                    			pageSize : 10
                    	};
                    	$.ajax({
                    		url: "/product/list.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log(data);
								self.products = data.list;

                    		}
                    	});
                    },
                    fnDonationList : function() {
                    	var self = this;
                    	var nparmap = {
                    	};
                    	$.ajax({
                    		url: "/donation/info.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log("dona",data);
                    		}
                    	});
                    },
                    
                    
                    kakaotest : function() {
                    	var self = this;
                    	var nparmap = {
                    		code : self.code
                    	};
                    	$.ajax({
                    		url: "user/kakao.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log(data);
                    		}
                    	});
                    },
                    fnView(boardId) {
                        pageChange("/board/view.do", { boardId: boardId });
                    },
                    fnPView(productId) {
                        pageChange("/product/view.do", { productId: productId });
                    },
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
                	
                	if ( self.code != "" ) { 
                		self.kakaotest();
                    	//console.log(self.code);
                	}
                	self.fnboardList();
                	self.fnProductList();
                	self.fnDonationList();

                	

                	
                }
            });

            app.mount("#app");
        });
    </script>
