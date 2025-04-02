<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>상품 상세보기</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            body {
                font-family: 'Noto Sans KR', sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                background-color: #ffffff;
            }

            .container {
                max-width: 1100px;
                margin: 20px auto;
                padding: 20px;
                background: transparent;
                border-radius: 0;
                box-shadow: none;
                display: block;
                flex-wrap: wrap;
                position: relative;
            }

            .product-detail {
                display: flex;
                flex-wrap: nowrap;
                justify-content: space-between;
                width: 100%;
                align-items: flex-start;
            }

            .product-image-container {
                flex: 1 1 40%;
                max-width: 60%;
                text-align: left;
                margin-right: 40px;
                margin-top: 30px;
            }

            .product-image-container img {
                width: 450px;
                height: 460px;
                object-fit: cover;
                border: 1px solid #000;
                border-radius: 5px;
                box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.1);
            }

            .product-image-thumbNails {
                display: flex;
                justify-content: left;
                margin-top: 10px;
            }

            .product-image-thumbNails img {
                width: 100px;
                height: 100px;
                object-fit: cover;
                margin: 5px;
                cursor: pointer;
                border-radius: 5px;
                border: 1px solid transparent;
                transition: all 0.3s;
            }

            .product-image-thumbNails img:hover {
                border: 2px solid #f08008;
            }

            .product-info {
                flex: 1 1 60%;
                max-width: 60%;
                padding: 20px;
            }

            .product-info h1 {
                font-size: 26px;
                margin-top: 10px;
                margin-bottom: 50px;
                font-weight: bold;
                color: #333;
            }

            .detail-product-info .original-price {
                text-decoration: line-through;
                color: #999;
                font-size: 18px;
                margin-bottom: 4px;
            }

            .detail-product-info .discount-price {
                color: #d32f2f;
                font-size: 22px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .product-info p {
                font-size: 13px;
                color: #666;
                margin-bottom: 15px;
                font-weight: bold;
            }


            /* 수량 */
            .purchase-section {
                margin-top: 20px;
            }

            .qty-box {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 20px;
            }

            .qty-controller {
                display: flex;
                align-items: center;
                border: 1px solid #ccc;
                border-radius: 4px;
                overflow: hidden;
                width: fit-content;
                background-color: #fff;
            }

            .qty-btn {
                width: 36px;
                height: 36px;
                background-color: #fff;
                border: none;
                font-size: 18px;
                cursor: pointer;
                border-right: 1px solid #ccc;
            }

            .qty-btn:last-child {
                border-left: 1px solid #ccc;
                border-right: none;
            }

            .qty-input {
                width: 50px;
                height: 36px;
                text-align: center;
                border: none;
                font-size: 16px;
            }

            .qty-btn:hover {
                background-color: #f0f0f0;
            }

            .shipping-note {
                font-size: 12px;
                color: #777;
                margin-top: -10px;
                margin-bottom: 10px;
            }

            .remove-btn {
                background: none;
                border: none;
                font-size: 18px;
                cursor: pointer;
                color: #999;
            }

            .remove-btn:hover {
                color: #333;
            }

            .confirmed-box {
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 12px 16px;
                background-color: #fafafa;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
                margin-bottom: 10px;
            }

            .confirmed-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-weight: bold;
                font-size: 16px;
                margin-bottom: 10px;
            }

            .product-name {
                font-weight: bold;
            }

            .remove-btn {
                background: none;
                border: none;
                font-size: 18px;
                cursor: pointer;
            }

            .price-display {
                font-size: 18px;
                font-weight: bold;
                margin-top: 10px;
            }

            .total-price {
                margin-top: 20px;
                font-size: 20px;
                text-align: right;
                font-weight: bold;
            }

            .select-btn {
                height: 34px;
                padding: 0 10px;
                border: 1px solid #ccc;
                background-color: #f3f3f3;
                border-radius: 4px;
                cursor: pointer;
                white-space: nowrap;
            }

            .select-btn:disabled {
                background-color: #ddd;
                color: #666;
                cursor: not-allowed;
            }

            /* 장바구니 + 구매 */
            .action-buttons {
                display: flex;
                gap: 10px;
            }

            .cart-btn {
                flex: 1;
                height: 45px;
                font-size: 16px;
                background-color: #fff;
                border: 1px solid #000;
                cursor: pointer;
            }

            .buy-btn {
                flex: 1;
                height: 45px;
                font-size: 16px;
                background-color: red;
                color: white;
                border: none;
                cursor: pointer;
            }



            /* 상세보기 */
            .notice-section h2 {
                font-size: 24px;
                font-weight: 700;
                color: #222;
                margin-bottom: 10px;
                display: inline-block;
                position: relative;
                padding-left: 10px;
            }

            .notice-section h2::before {
                content: \"📘\";
                position: absolute;
                left: 0;
                top: 0;
            }

            .notice-section .sub-title {
                font-size: 15px;
                font-style: italic;
                color: #888;
                padding-left: 12px;
                margin-top: 6px;
                margin-bottom: 24px;
                border-left: 3px solid #d0d0d0;
            }

            .notice-badge {
                display: inline-block;
                background-color: #00b894;
                color: #fff;
                font-weight: bold;
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 14px;
                margin-bottom: 20px;
            }

            .notice-card {
                background-color: #f9f9f9;
                padding: 20px 25px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: 0 1px 4px rgba(0, 0, 0, 0.06);
            }

            .notice-img {
                width: 100%;
                max-width: 600px;
                margin-top: 15px;
                border-radius: 10px;
            }

            /* 멤버십 상세보기 */
            .vip-membership-section {
                background: linear-gradient(to right, #1e1e1e, #000);
                color: #fff;
                padding: 60px 20px;
                text-align: center;
                border-radius: 14px;
                margin: 40px auto;
                max-width: 1000px;
                box-shadow: 0 0 30px rgba(255, 215, 0, 0.1);
                cursor: pointer;
            }

            .vip-subtitle {
                font-size: 13px;
                color: #ffdd57;
                font-weight: bold;
                margin-bottom: 10px;
                letter-spacing: 1px;
            }

            .vip-header h2 {
                font-size: 26px;
                font-weight: 700;
                line-height: 1.5;
                color: #ccc;
            }

            .vip-header h2 span {
                color: #ffe600;
                font-weight: 900;
                font-size: 30px;
            }

            .vip-description {
                margin-top: 15px;
                font-size: 15px;
                color: #ccc;
            }

            .vip-benefit-cards {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-top: 40px;
                flex-wrap: wrap;
            }

            .vip-card {
                background: #111;
                padding: 25px 20px;
                border-radius: 12px;
                width: 280px;
                box-shadow: 0 0 10px rgba(255, 215, 0, 0.07);
                border: 1px solid rgba(255, 255, 255, 0.08);
                transition: transform 0.3s ease;
            }

            .vip-card:hover {
                transform: translateY(-5px);
            }

            .vip-card h4 {
                font-size: 18px;
                margin-bottom: 10px;
                color: #ffd700;
            }

            .vip-card p {
                font-size: 14px;
                color: #ddd;
            }

            .join-btn {
                margin-top: 40px;
                background-color: #ffd700;
                color: #000;
                border: none;
                padding: 12px 30px;
                font-weight: bold;
                border-radius: 6px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .join-btn:hover {
                background-color: #e6c200;
            }

            /* 배송 관련 */
            .shipping-warning-section {
                background: #fff8e1;
                padding: 50px 20px;
                border-radius: 12px;
                max-width: 1000px;
                margin: 60px auto;
                text-align: center;
                color: #333;
                box-shadow: 0 0 12px rgba(255, 204, 0, 0.2);
                cursor: pointer;
            }

            .shipping-warning-section .vip-subtitle {
                font-size: 14px;
                color: #d08900;
                font-weight: bold;
                margin-bottom: 6px;
            }

            .shipping-warning-section .warning-title {
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .warning-desc {
                font-size: 15px;
                color: #666;
                margin-bottom: 30px;
            }

            .warning-cards {
                display: flex;
                justify-content: center;
                gap: 30px;
                flex-wrap: wrap;
            }

            .warning-card {
                background-color: #fff3cd;
                border-left: 5px solid #ffcc00;
                padding: 20px 25px;
                border-radius: 10px;
                width: 100%;
                max-width: 450px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                text-align: left;
            }

            .warning-card h4 {
                font-size: 18px;
                color: #d08900;
                margin-bottom: 10px;
            }

            .warning-card p {
                font-size: 14px;
                color: #444;
                line-height: 1.6;
            }

            .warning-card .sub-text {
                margin-top: 8px;
                font-size: 13px;
                color: #999;
                font-style: italic;
            }

            /* 제품 관련 */
            .product-info-section {
                background-color: #f5f6fa;
                padding: 60px 20px;
                border-radius: 14px;
                max-width: 1000px;
                margin: 60px auto;
                text-align: center;
                color: #333;
            }

            .product-info-header .vip-subtitle {
                font-size: 14px;
                color: #007bff;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .product-info-header h2 {
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .product-info-header .info-desc {
                font-size: 15px;
                color: #666;
                margin-bottom: 30px;
            }

            .product-info-card {
                background-color: #fff;
                padding: 30px 25px;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                text-align: left;
                max-width: 800px;
                margin: 0 auto 40px auto;
            }

            .product-info-card p {
                font-size: 15px;
                color: #444;
                line-height: 1.8;
                margin-bottom: 16px;
            }

            .product-info-card .sub-text {
                color: #999;
                font-size: 13px;
                font-style: italic;
            }

            .product-event-img {
                width: 100%;
                max-width: 400px;
                margin: 0 auto;
                display: block;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            }

            /* ================================
   🎁 이벤트 사은품 안내 Section
================================== */
            .event-gift-section {
                background-color: #fffdf5;
                padding: 60px 20px;
                margin: 60px auto;
                border-radius: 12px;
                max-width: 1000px;
                box-shadow: 0 4px 12px rgba(255, 204, 0, 0.1);
            }

            .event-gift-wrap {
                display: flex;
                align-items: center;
                gap: 40px;
                flex-wrap: wrap;
                justify-content: center;
            }

            .event-gift-img img {
                width: 320px;
                max-width: 100%;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            }

            .event-gift-text {
                flex: 1;
                min-width: 280px;
                max-width: 500px;
                font-size: 14px;
                color: #444;
                text-align: left;
            }

            .event-gift-text h3 {
                font-size: 20px;
                color: #d08900;
                margin-bottom: 10px;
            }

            .event-gift-text p {
                font-size: 15px;
                margin-bottom: 10px;
                font-weight: 500;
                color: #555;
            }

            .event-gift-text ul {
                padding-left: 20px;
                list-style: disc;
                line-height: 1.8;
            }

            .event-gift-text ul li {
                margin-bottom: 8px;
            }





            /* 탭 부분 */
            .tab-wrapper {
                max-width: 1100px;
                margin: 40px auto;
                font-size: 16px;
            }

            .tab-menu {
                display: flex;
                border-bottom: 1px solid #ccc;
            }

            .tab-item {
                flex: 1;
                text-align: center;
                padding: 14px 0;
                cursor: pointer;
                border: 1px solid #ccc;
                border-bottom: none;
                background-color: transparent;
                color: #888;
            }

            .tab-item.active {
                background-color: #fff;
                color: #000;
                font-weight: bold;
                border-top: 2px solid #000;
                cursor: pointer;
            }

            .tab-content {
                padding: 30px;
                min-height: 200px;
                cursor: pointer;
            }

            /* 상품 후기 영역 */
            .review-section {
                padding: 30px;
                font-family: 'Noto Sans KR', sans-serif;
                background-color: #fff;
                max-width: 1100px;
                margin: 0 auto;
            }

            .review-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .review-header h3 {
                font-size: 20px;
                font-weight: bold;
                margin: 0;
            }

            .review-buttons .btn {
                padding: 6px 14px;
                font-size: 14px;
                border: 1px solid #ccc;
                background-color: white;
                color: #333;
                cursor: pointer;
                border-radius: 4px;
            }

            .review-buttons .btn:hover {
                background-color: #f7f7f7;
            }

            .review-empty {
                text-align: center;
                color: #777;
                font-size: 14px;
                margin-top: 100px;
            }

            .line-review {
                padding: 20px 0;
                border-bottom: 1px solid #e0e0e0;
                font-family: 'Noto Sans KR', sans-serif;
            }

            .line-review-header {
                font-weight: bold;
                color: #333;
                font-size: 16px;
                margin-bottom: 8px;
            }

            .line-review-header .stars {
                color: #ffcc00;
                margin-right: 10px;
            }

            .line-review-body p {
                font-size: 15px;
                color: #444;
                margin-bottom: 10px;
                line-height: 1.6;
            }

            .line-review-footer {
                font-size: 13px;
                color: #888;
                text-align: right;
                margin-top: 5px;
            }

            .review-detail {
                background-color: #f9f9f9;
                padding: 15px;
                text-align: left;
            }

            .review-card {
                border-bottom: 1px solid #ddd;
                padding: 20px 0;
                background-color: transparent;
            }

            .review-card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }

            .star-rating .star {
                display: inline-block;
                font-size: 20px;
                color: #ddd;
                position: relative;
            }

            .star-rating .star.filled::before {
                content: "★";
                color: #FFD700;
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                overflow: hidden;
            }

            .star-rating .star.half::before {
                content: "★";
                color: #FFD700;
                position: absolute;
                left: 0;
                top: 0;
                width: 50%;
                overflow: hidden;
            }

            .review-card-header,
            .review-card-body,
            .review-card-footer {
                padding: 0 10px;
            }

            .rating-text {
                font-size: 14px;
                color: #555;
                margin-left: 8px;
            }

            .review-meta {
                font-size: 13px;
                color: #999;
            }

            .review-card-body {
                margin-top: 10px;
            }

            .review-text {
                font-size: 15px;
                color: #444;
                line-height: 1.6;
                margin-bottom: 10px;
            }

            .review-title {
                font-size: 17px;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }

            .review-image img {
                width: 130px;
                height: 130px;
                object-fit: cover;
                border-radius: 8px;
                border: 1px solid #eee;
            }

            .review-deleted-content {
                padding: 20px 10px;
                text-align: left;
            }

            .review-deleted-content .review-text {
                font-size: 15px;
                color: #999;
                font-style: italic;
                margin: 0;
            }

            .review-card-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 10px;
                font-size: 13px;
                color: #888;
            }

            .review-actions button {
                background-color: transparent;
                border: none;
                color: #007BFF;
                cursor: pointer;
                margin-left: 10px;
                font-size: 13px;
            }

            .review-helpful {
                margin-top: 10px;
                font-size: 14px;
                color: #444;
            }

            .review-helpful button {
                background: none;
                border: 1px solid #28a745;
                color: #28a745;
                padding: 5px 12px;
                border-radius: 20px;
                cursor: pointer;
                margin-right: 8px;
                transition: 0.2s;
                font-size: 14px;
            }

            .review-helpful button:hover {
                background-color: #28a745;
                color: #fff;
            }

            .review-actions button:hover {
                text-decoration: underline;
            }

            /* QnA */
            .qna-header-container {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                border-bottom: 1px solid #ddd;
                padding: 1rem 0;
                margin-bottom: 1rem;
            }

            .qna-title-area {
                flex: 1;
            }

            .qna-title-area h3 {
                margin-bottom: 0.5rem;
            }

            .qna-notice {
                font-size: 0.9rem;
                color: #555;
                line-height: 1.6;
                list-style: disc;
                padding-left: 1.2rem;
            }

            .qna-notice li {
                margin-bottom: 0.3rem;
            }

            .qna-write-btn {
                margin-left: 1.5rem;
            }

            .btn-outline-purple {
                padding: 0.5rem 1rem;
                border: 1px solid #7b61ff;
                background: #fff;
                color: #7b61ff;
                border-radius: 4px;
                font-weight: bold;
                cursor: pointer;
            }

            .btn-outline-purple:hover {
                background: #f3f0ff;
            }

            .qna-list {
                margin-top: 20px;
            }

            .qna-item {
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
            }

            .qna-block {
                background-color: #f9f9f9;
                padding: 15px 20px;
                border-radius: 8px;
                margin-bottom: 10px;
            }

            .qna-block.answer {
                background-color: #fff;
                border-left: 4px solid #7b61ff;
                font-style: italic;
            }

            .qna-label {
                font-weight: bold;
                color: #333;
                margin-bottom: 6px;
                font-size: 14px;
            }

            .answer-label {
                color: #7b61ff;
            }

            .qna-text {
                font-size: 15px;
                line-height: 1.6;
                color: #444;
                margin-bottom: 10px;
            }

            .qna-info {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                gap: 10px;
                font-size: 13px;
                color: #888;
                margin-top: 6px;
            }

            .qna-label {
                font-weight: bold;
                color: #333;
                margin-bottom: 6px;
                font-size: 14px;
            }

            .qna-user-id {
                font-weight: normal;
                color: #555;
                margin-left: 8px;
                font-size: 13px;
            }

            .qna-delete-btn {
                background: none;
                border: none;
                color: #999;
                cursor: pointer;
                font-size: 13px;
                padding: 0;
            }

            .qna-delete-btn:hover {
                color: #d32f2f;
                text-decoration: none;
            }

            .qna-block.pending {
                background-color: #fcfcfc;
                border-left: 4px solid #7b61ff;
                font-style: italic;
                color: #888;
            }

            /* 배송, 교환, 환불 영역 */
            .policy-section {
                padding: 30px;
                max-width: 1100px;
                margin: 0 auto;
            }

            .policy-grid {
                display: flex;
                flex-wrap: wrap;
                gap: 30px 80px;
                justify-content: space-between;
            }

            .policy-box {
                flex: 1 1 45%;
                min-width: 280px;
                font-size: 15px;
                color: #444;
                line-height: 1.7;
            }

            .policy-box h3 {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #222;
            }

            /* 페이징 */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                margin-top: 30px;
            }

            .pagination a {
                text-decoration: none;
                color: #333;
                font-weight: bold;
                padding: 4px 8px;
                border: none;
                border-radius: 0;
                background: none;
                font-size: 15px;
            }

            .pagination a.active {
                color: #000;
                font-weight: 900;
                text-decoration: none;
            }

            /* 페이지 이동 뜨게 */
            .breadcrumb-container {
                width: 100%;
                text-align: right;
                margin-bottom: 10px;
                position: relative;
                top: -10px;
            }

            .breadcrumb {
                display: inline-block;
                font-size: 14px;
                justify-content: flex-start;
                padding-left: 20px;
                padding-right: 20px;
                gap: 6px;
                color: #666;
                cursor: pointer;
                text-decoration: none;
            }

            .breadcrumb a {
                color: #444;
                text-decoration: none;
                font-weight: 500;
                cursor: pointer;
            }

            .breadcrumb a:hover {
                text-decoration: none;
                color: #ff6600;
            }


            .product-image-thumbNails img.active {
                border: 2px solid #000;
                opacity: 1;
            }

            .product-image-thumbNails img {
                opacity: 0.6;
                cursor: pointer;
                transition: opacity 0.3s;
            }

            @media (max-width: 768px) {
                .product-detail {
                    flex-direction: column;
                    align-items: center;
                }

                .product-image-container,
                .product-info {
                    max-width: 100%;
                    text-align: center;
                }
            }

            @media (max-width: 768px) {

                .buy-btn1,
                .buy-btn2 {
                    width: 100%;
                }
            }

            @media (max-width: 768px) {
                .event-gift-wrap {
                    flex-direction: column;
                    text-align: center;
                }

                .event-gift-text {
                    text-align: center;
                }

                .event-gift-text ul {
                    padding-left: 0;
                    list-style: none;
                }

                .event-gift-text ul li::before {
                    content: \"✔ \";
                    color: #d08900;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="../common/header.jsp" />
        <div id="app" class="container">
            <div class="breadcrumb-container">
                <div class="breadcrumb" v-if="info.categoryId">
                    <!-- <a href="/">홈</a> / -->
                    <a href="/product/list.do">전체상품</a> /
                    <a href="javascript:;" @click="goToCategory(largeCategory)">{{ largeCategory }}</a> /
                    <a href="javascript:;" @click="goToSubCategory(info.categoryId)">
                        {{ largeCategory + ' ' + subCategory }}
                    </a> /
                    <a>{{ info.productName }}</a>
                </div>
            </div>

            <!-- 상품 상세 정보 -->
            <section class="product-detail">
                <div class="product-image-container">
                    <template v-if="imgList.length > 0">
                        <img :src="currentImage" alt="대표 이미지" id="mainImage">
                    </template>
                    <template v-else>
                        <img src="../../img/product/product update.png" alt="이미지 없음">
                    </template>

                    <div class="product-image-thumbNails">
                        <img v-for="(img, index) in imgList" :key="index" :src="img.filePath" alt="상품 썸네일"
                            @click="changeImage(img.filePath)" :class="{ active: index === currentImageIndex }">
                    </div>
                </div>
                <div class="product-info">
                    <hr>
                    <h1>{{info.productName}}</h1>
                    <!-- 정상가 (할인 전 가격) -->
                    <div class="detail-product-info">
                        <p class="original-price" v-if="info.discount > 0">
                            정상가: {{ info.price }}원
                        </p>
                        <!-- 멤버십 할인가 -->
                        <p class="discount-price">
                            멤버십 할인가:
                            <strong>{{ discountedPrice}}원</strong>
                            <span v-if="userInfo.membershipFlg !== 'Y'"></span>
                        </p>
                    </div>
                    <p>
                        평균 별점 :
                        <span class="star-rating">
                            <span v-for="n in 5" :key="n" class="star" :class="getStarClass(n)"> ★ </span>
                        </span>
                        <span v-if="averageRating > 0">({{ averageRating }} / 5)</span>
                        <span v-else>별점 없음</span>
                    </p>
                    <p>제조사 : {{ info.manufacturer }}</p>
                    <p>상품코드 : {{ info.productCode }}</p>
                    <p>배송비 : {{ info.shippingFee }}원</p>
                    <div v-if="info.shippingFreeMinimum" class="shipping-note">
                        ({{ info.shippingFreeMinimum }}원 이상 주문 시 무료배송)
                    </div>
                    <p>(최소 주문수량 1개 이상)</p>
                    <p>배송 지역 : 전국 배송 가능</p>
                    <p>배송 기간 : 결제 완료 후 2~3일 이내 출고 (주말/공휴일 제외)</p>
                    <hr>

                    <div class="purchase-section">
                        <!-- 수량 선택 화면 (선택 전만 보임) -->
                        <div v-if="!isSelected" class="qty-box">
                            <span>수량</span>
                            <div class="qty-controller">
                                <button @click="decreaseQty" class="qty-btn">-</button>
                                <input type="text" :value="quantity" readonly class="qty-input" />
                                <button @click="increaseQty" class="qty-btn">+</button>
                            </div>
                            <button @click="confirmQuantity" class="select-btn">선택</button>
                        </div>

                        <div v-if="isSelected">
                            <div class="confirmed-box">
                                <div class="confirmed-header">
                                    <span class="product-name">{{ info.productName }}</span>
                                    <button class="remove-btn" @click="cancelSelection">X</button>
                                </div>
                                <div class="qty-controller">
                                    <button @click="decreaseQty" class="qty-btn">-</button>
                                    <input type="text" :value="quantity" readonly class="qty-input" />
                                    <button @click="increaseQty" class="qty-btn">+</button>
                                </div>
                            </div>
                            <div class="price-display">
                                <strong>총 결제 금액 : {{ formattedPrice }}원</strong>
                            </div>
                        </div>
                        <div class="action-buttons">
                            <button class="cart-btn" @click="fnAddCart()">장바구니</button>
                            <button class="buy-btn" @click="fnBuy()">구매하기</button>
                        </div>
            </section>
            <hr style="margin-top: 70px;">
            <!-- 상세 설명 -->
            <section class="notice-section">
                <h2>📘 멍냥꽁냥 이용 가이드</h2>
                <p class="sub-title">제품 특성, 배송 안내, 사은품 등 구매 전 알아두면 좋은 정보들을 안내드립니다.</p>
                <!-- 멤버십 관련 -->
                <section class="vip-membership-section">
                    <div class="vip-header">
                        <p class="vip-subtitle">🎁 멤버십 혜택 안내</p>
                        <h2>
                            반려인을 위한 프리미엄 혜택,<br>
                            <span>멍냥꽁냥 멤버십</span>으로 누리세요
                        </h2>
                        <p class="vip-description">
                            단순한 할인 그 이상! <strong>멤버십 할인 / 매월 자동 기부 / 포인트 지급</strong>까지<br>
                            반려 생활에 필요한 모든 혜택을 한 번에 제공합니다.
                        </p>
                    </div>
                    <div class="vip-benefit-cards">
                        <div class="vip-card">
                          <h4>💸 전상품 멤버십 할인가 적용</h4>
                          <p>멤버십 회원은 항상 <strong>할인된 가격</strong>으로 구매 가능합니다</p>
                        </div>
                        <div class="vip-card">
                          <h4>🌱 매월 자동 반려동물 후원</h4>
                          <p>회원님의 이름으로 <strong>매달 일정 금액을 유기동물 보호소에 기부</strong>합니다</p>
                        </div>
                        <div class="vip-card">
                          <h4>🎉 매월 5000포인트 지급</h4>
                          <p><strong>포인트 5000P</strong>를 매달 자동으로 받아 쇼핑몰과 게시판,후원에서 바로 사용하세요</p>
                        </div>
                      </div>
                    <button class="join-btn" @click="MembershipJoin">지금 멤버십 가입하기</button>
                </section>
                <hr style="margin-bottom: 70px;">

                <!-- 배송 관련 -->
                <section class="shipping-warning-section">
                    <div class="vip-subtitle">🚛 배송 및 주문 관련 안내</div>
                    <h2 class="warning-title">꼭 확인해주세요!</h2>
                    <p class="warning-desc">정확한 배송과 원활한 쇼핑을 위해 아래 내용을 사전에 꼭 확인 부탁드립니다.</p>

                    <div class="warning-cards">
                        <div class="warning-card">
                            <h4>⏰ 평일 오후 4시 이후 주문</h4>
                            <p>
                                오후 4시 이후 주문 건은 당일 출고가 어려우며,<br>
                                다음 날 출고로 지연됩니다. 이로 인한 <strong>단순 변심 취소는 불가</strong>합니다.
                            </p>
                        </div>

                        <div class="warning-card">
                            <h4>📦 운송장 발급 후 취소 불가</h4>
                            <p>
                                운송장 발급 및 택배사 인계 후에는 <strong>취소 또는 변경이 불가</strong>합니다.<br>
                                반품 시 <strong>왕복 배송비가 부과</strong>되오니, 신중한 구매 부탁드립니다.
                            </p>
                            <p class="sub-text">※ 금요일 오후 4시 이후 주문은 월요일부터 순차 출고됩니다.</p>
                        </div>
                    </div>
                </section>
                <hr style="margin-top: 40px;">


                <!--제품 안내 -->
                <section class="product-info-section">
                    <div class="product-info-header">
                        <p class="vip-subtitle">📢 제품 관련 안내</p>
                        <h2>정확한 이해를 위한 제품 특성 및 주의사항 안내</h2>
                        <p class="info-desc">
                            멍냥꽁냥에서 판매하는 모든 제품은 고객님의 소중한 반려동물을 위한 상품으로,<br>
                            아래 내용을 충분히 숙지하신 후 구매해주시기 바랍니다.
                        </p>
                    </div>
                    <div class="product-info-card">
                        <p>
                            ✅ 본 제품은 제조 시기 및 생산 공정에 따라 <strong>알갱이의 색상, 크기, 모양</strong> 등에 약간의 차이가 발생할 수 있습니다.<br>
                            이는 원재료 수급 및 공정 조건에 따른 <strong>정상적인 현상</strong>이며, 제품의 품질에는 영향을 미치지 않습니다.
                        </p>

                        <p>
                            ✅ 일부 제품(특히 습식, 파우치 제품)의 경우, 내용물의 <strong>점도 및 색상</strong>이 계절 또는 보관 상태에 따라 달라질 수 있습니다.<br>
                            해당 사항은 제품 이상이 아니며, 반품 또는 교환의 사유가 되지 않습니다.
                        </p>

                        <p>
                            ✅ 제품에 포함된 주원료(예: 닭고기, 곡물, 유제품 등)에 따라 <strong>알러지 반응</strong>이 나타날 수 있습니다.<br>
                            반려동물에게 특이체질 또는 과거 알러지 반응 이력이 있다면, 반드시 성분표 확인 후 급여해주세요.
                        </p>

                        <p>
                            ✅ 급여 후 <strong>소화불량, 묽은 변, 식욕 저하</strong> 등의 이상 반응이 있을 경우 급여를 중단하고 수의사 상담을 권장드립니다.
                        </p>

                        <p>
                            ✅ 개봉 후 제품은 밀봉하여 직사광선을 피하고 <strong>서늘하고 건조한 곳</strong>에 보관해주세요.<br>
                            특히 습식 제품은 <strong>냉장 보관 후 빠른 시일 내에 사용</strong> 바랍니다.
                        </p>

                        <p>
                            ✅ 제품 유통기한은 제조일로부터 충분한 여유가 있는 상품으로 출고되며,<br>
                            이벤트나 할인 상품은 상대적으로 유통기한이 짧을 수 있습니다.
                        </p>

                        <p>
                            ✅ 제품 이상이 의심되는 경우 수령 즉시 고객센터로 연락주시면 <strong>신속히 확인 및 대응</strong> 드리겠습니다.
                        </p>

                        <p class="sub-text">
                            ※ 본 안내는 공통 적용되는 사항이며, 각 상품별 추가 상세 정보는 상품 페이지 하단 또는 고객센터를 통해 확인하실 수 있습니다.
                        </p>
                    </div>
                </section>
                <section class="event-gift-section">
                    <div class="event-gift-wrap">
                        <div class="event-gift-img">
                            <img src="../../img/product/eventProduct1.png" alt="이벤트 사은품" />
                        </div>
                        <div class="event-gift-text">
                            <h3>🎁 지금 구매 시 특별 사은품 증정!</h3>
                            <p><strong>멍냥꽁냥 회원을 위한 한정 이벤트!</strong></p>
                            <ul>
                                <li>✔ 이벤트 대상 상품 구매 시 자동 증정</li>
                                <li>✔ 수량 한정, 조기 소진 시 종료</li>
                                <li>✔ 교환/반품 불가 · 종류 랜덤</li>
                                <li>✔ 2025.04.01 ~ 소진 시까지</li>
                            </ul>
                        </div>
                    </div>
                </section>
                <hr style="margin-top: 40px;">
            </section>
            <!-- 탭 UI -->
            <section id="tab-area" class="tab-wrapper">
                <div class="tab-menu">
                    <div v-for="tab in tabs" :key="tab.id" :class="['tab-item', { active: activeTab === tab.id }]"
                        @click="changeTab(tab.id)">
                        {{ tab.label }} {{ tab.cmtcount }}
                    </div>
                </div>

                <div class="tab-content">
                    <!-- 상품 상세정보 -->
                    <div v-if="activeTab === 'detail'">
                        <div v-html="info.description"></div>
                    </div>
                    <!-- 상품 리뷰 -->
                    <div v-else-if="activeTab === 'review'" class="review-section">
                        <div class="review-header">
                            <h3>REVIEW</h3>
                            <div class="review-buttons">
                                <button class="btn" @click="fnReviewWtite()">글쓰기</button>
                            </div>
                        </div>

                        <div v-if="reviewList.length === 0" class="review-empty">
                            현재 게시물이 없습니다
                        </div>
                        <div class="review-card" v-for="review in reviewList" :key="review.reviewId">
                            <!-- 삭제된 리뷰일 경우 -->
                            <div v-if="review.deleteYn === 'Y'" class="review-deleted-content">
                                <p class="review-text">삭제된 리뷰입니다.</p>
                            </div>
                            <div v-else>

                                <div class="review-card-header">
                                    <div class="review-left">
                                        <div class="star-rating">
                                            <span v-for="n in 5" :key="n" class="star"
                                                :class="{ filled: n <= review.rating }">★</span>
                                        </div>
                                        <span class="review-user-id">[{{ review.userId }}]</span>
                                        <span class="rating-text">{{ review.rating ?? 0 }} / 5</span>
                                    </div>
                                </div>
                                <div class="review-card-body">
                                    <h4 class="review-title" v-if="review.title">{{ review.title }}</h4>
                                    <p class="review-text" v-html="review.reviewText"></p>
                                    <div v-if="review.filePath" class="review-image">
                                        <img :src="review.filePath" alt="리뷰 이미지">
                                    </div>
                                </div>
                                <div class="review-card-footer">
                                    <div class="review-helpful">
                                        <button @click="markHelpful(review.reviewId)">도움돼요 👍</button>
                                        <span>{{ review.helpCnt || 0 }}명에게 도움이 되었어요</span>
                                    </div>
                                    <div class="review-actions" v-if="sessionId && sessionId === review.userId">
                                        <button @click.stop="fnEdit(review.reviewId)">수정</button>
                                        <button @click.stop="fnDelete(review.reviewId)">삭제</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="pagination" style="margin-top: 30px;">
                            <a href="javascript:;" v-if="reviewPage > 1" @click="fnReviewPageMove('prev')"> &lt; </a>

                            <a href="javascript:;" v-for="num in reviewPages" :key="num" @click="fnReviewPage(num)"
                                :class="{ active: reviewPage === num }">
                                <span v-if="reviewPage === num">{{ num }}</span>
                                <span v-else>{{ num }}</span>
                            </a>
                            <a href="javascript:;" v-if="reviewPage < reviewPages.length"
                                @click="fnReviewPageMove('next')"> &gt; </a>
                        </div>
                    </div>

                    <!-- 상품 문의 -->
                    <div v-else-if="activeTab === 'qna'" class="qna-section">
                        <div class="qna-header-container">
                            <div class="qna-title-area">
                                <h3>상품문의</h3>
                                <ul class="qna-notice">
                                    <li>구매한 상품의 <strong>취소/반품은 멍냥꽁냥 구매내역</strong>에서 신청 가능합니다.</li>
                                    <li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
                                    <li>해당 상품 자체와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수
                                        있습니다.</li>
                                    <li>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
                                </ul>
                            </div>
                            <div class="qna-write-btn">
                                <button class="btn-outline-purple" @click="fnQna()">문의하기</button>
                            </div>
                        </div>

                        <div v-if="qnaList.length === 0" class="qna-empty">
                            등록된 Q&A가 없습니다.
                        </div>

                        <div v-else class="qna-list">
                            <div class="qna-item" v-for="qna in qnaList" :key="qna.qnaId">
                                <div class="qna-block question">
                                    <div class="qna-label">
                                        질문 <span class="qna-user-id">[{{ qna.userId }}]</span>
                                    </div>
                                    <div class="qna-text" v-html="qna.questionText"></div>
                                    <div class="qna-info">
                                        <span class="qna-date">{{ qna.createdAt }}</span>
                                        <button v-if="qna.userId === sessionId" @click="fnQnaEdit(qna.qnaId)"
                                            class="qna-delete-btn">수정</button>
                                        <button v-if="qna.userId === sessionId" @click="fnQnaDelete(qna.qnaId)"
                                            class="qna-delete-btn">삭제</button>
                                    </div>
                                </div>

                                <!-- 답변 있을 경우 -->
                                <div class="qna-block answer" v-if="qna.answerText">
                                    <div class="qna-label answer-label"> ⤷ 답변 [멍냥꽁냥 관리자]</div>
                                    <div class="qna-text" v-html="qna.answerText"></div>
                                    <div class="qna-info">
                                        <span class="qna-date">{{ qna.answeredAt }}</span>
                                    </div>
                                </div>
                                <!-- 답변이 없는 경우 -->
                                <div class="qna-block answer pending" v-else>
                                    <div class="qna-label answer-label">⤷ 답변 [멍냥꽁냥 관리자]</div>
                                    <div class="qna-text">관리자가 답변을 준비 중입니다.</div>
                                </div>
                            </div>
                            <div class="pagination" style="margin-top: 30px;">
                                <a href="javascript:;" v-if="qnaPage > 1" @click="fnQnaPageMove('prev')">&lt;</a>
                                <a href="javascript:;" v-for="num in qnaPages" :key="num" @click="fnQnaPage(num)"
                                    :class="{ active: qnaPage === num }">
                                    <span v-if="qnaPage === num">{{ num }}</span>
                                    <span v-else>{{ num }}</span>
                                </a>
                                <a href="javascript:;" v-if="qnaPage < qnaPages.length"
                                    @click="fnQnaPageMove('next')">&gt;</a>
                            </div>
                        </div>
                    </div>
                    <!-- 배송, 교환, 환불 설명 -->
                    <div v-else-if="activeTab === 'policy'" class="policy-section">
                        <div class="policy-grid">
                            <div class="policy-box">
                                <h3>PAYMENT INFO</h3>
                                <p>
                                    고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수 있습니다.<br>
                                    확인 과정에서 도난 카드의 사용이나 타인의 명의의 주문등 정상적인 주문이 아니라고 판단될 경우<br>
                                    임의로 주문을 보류 또는 취소할 수 있습니다.
                                </p>
                                <p>
                                    무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹,텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.
                                </p>
                                <p>
                                    주문시 입력한 입금자명과 실제입금자의 성며이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며<br>
                                    입금되지 않은 주문은 자동취소 됩니다.
                                </p>
                            </div>
                            <div class="policy-box">
                                <h3>DELIVERY INFO</h3>
                                <p>
                                    배송 방법 : 택배<br>
                                    배송 지역 : 전국지역<br>
                                    배송 비용 : 2000원<br>
                                    배송 기간 : 2일 ~ 5일<br>
                                    배송 안내 : 산간벽지나 도서지방은 별도의 추가금액이 발생할 수 있습니다.
                                </p>
                            </div>
                            <div class="policy-box">
                                <h3>EXCHANGE INFO</h3>
                                <p>
                                    <strong>교환 및 반품 주소</strong><br>
                                    [10246] 인천광역시 부평구 경원대로 1366, [스테이션타워 7층] 멍냥꽁냥<br><br>

                                    <strong>교환 및 반품이 가능한 경우</strong><br>
                                    - 계약내용에 관한 서면을 받은 날부터 7일 이내<br>
                                    - 공급받은 상품 및 용역의 내용이 표시/광고 내용과 다를 경우<br><br>

                                    <strong>교환 및 반품이 불가능한 경우</strong><br>
                                    - 소비자에게 책임이 있는 사유<br>
                                    - 시간 경과에 의해 재판매가 곤란한 경우 등
                                </p>
                            </div>
                            <div class="policy-box">
                                <h3>SERVICE INFO</h3>
                                <p>
                                    - 고객센터: 1234-5678<br>
                                    - 운영시간: 평일 09:00 ~ 18:00 (점심시간 12:00 ~ 13:00)<br>
                                    - 토/일/공휴일 휴무
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </body>

    </html>
    <script>


        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        productId: "",
                        sessionId: "${sessionId}",
                        userInfo: {
                            "membershipFlg": "Y"
                        }, //사용자 정보 가져오기
                        info: {},
                        imgList: [],
                        mainImage: '',
                        quantity: 1,
                        isSelected: false,
                        selectedReviewId: null,
                        alreadyClicked: {},
                        averageRating: 0,
                        currentImageIndex: 0,
                        autoSlideInterval: null,

                        //탭 관련
                        tabs: [
                            { id: 'detail', label: '상세정보', cmtcount: "" },
                            { id: 'review', label: '상품후기 ', cmtcount: 0 },
                            { id: 'qna', label: '상품문의 ', cmtcount: "" },
                            { id: 'policy', label: '배송/교환/환불 안내', cmtcount: "" }
                        ],
                        activeTab: 'detail',

                        //상품 리뷰 페이징
                        reviewList: [],
                        reviewPage: 1,
                        reviewPageSize: 5,
                        reviewTotal: 0,
                        reviewPages: [],
                        deleteYn: "Y",

                        // 상품 문의..
                        qnaList: [],
                        qnaPage: 1,
                        qnaPageSize: 5,
                        qnaTotal: 0,
                        qnaPages: []
                    };
                },
                computed: {
                    // 총 상품 금액 (상품 가격 × 수량)
                    totalProductPrice() {
                        const result = this.info.price * this.quantity;
                        console.log("📦 총 상품 금액:", result);
                        return result;
                    },
                    isFreeShipping() {
                        const condition = this.totalProductPrice >= this.info.shippingFreeMinimum;
                        console.log("🚚 무료배송 조건:", this.totalProductPrice, ">=", this.info.shippingFreeMinimum, "→", condition);
                        return condition;
                    },
                    shippingCost() {
                        const cost = this.isFreeShipping ? 0 : this.info.shippingFee;
                        console.log("💸 배송비 적용:", cost);
                        return cost;
                    },
                    totalPrice() {
                        const total = this.totalProductPrice + this.shippingCost;
                        console.log("💰 총 결제 금액:", total);
                        return total;
                    },
                    formattedPrice() {
                        return this.totalPrice.toLocaleString();
                    },
                    discountedPrice() {
                        return Math.floor(this.info.price * (1 - this.info.discount / 100));
                    },

                    categoryParts() {
                        if (!this.info.categoryId) return [];
                        return this.info.categoryId.split(',');
                    },
                    largeCategory() {
                        return this.categoryParts[0] || '';
                    },
                    subCategory() {
                        return this.categoryParts[1] || '';
                    },
                    breadcrumbState() {
                        if (!this.info || !this.info.categoryId) {
                            return "all";  // 전체상품용
                        }
                        return "categorized";  // 카테고리 있음
                    },
                    searchOptionFromCategory() {
                        switch (this.largeCategory) {
                            case '강아지':
                                return 'dog';
                            case '고양이':
                                return 'cat';
                            case '영양제':
                                return 'pet';
                            default:
                                return 'all';
                        }
                    },
                    currentImage() {
                        return this.imgList.length > 0 ? this.imgList[this.currentImageIndex].filePath : '';
                    },
                },
                methods: {
                    //상품 보여주기
                    fnProduct() {
                        var self = this;
                        var nparmap = { productId: self.productId };
                        $.ajax({
                            url: '/product/get.dox',
                            dataType: 'json',
                            type: 'POST',
                            data: nparmap,
                            success: function (data) {
                                console.log(data);

                                if (data.result != "success") {
                                    if (this.productId == "") {
                                        alert("상품을 불러올수 없습니다.");
                                        location.href = "/product/list.do";
                                    }
                                }
                                self.info = data.info;
                                self.imgList = data.imgList;
                                self.reviewList = data.reviewList || [];
                                self.mainImage = self.info.filePath || '../../img/product/product update.png';
                                self.imgList.push({ filePath: "../../img/product/Official Product.jpg" });
                            },
                        });
                    },
                    goToCategory() {
                        let self = this;
                        localStorage.removeItem("page");
                        location.href = "/product/list.do?searchOption=" + self.searchOptionFromCategory;
                    },
                    goToSubCategory() {
                        let self = this;
                        var category = this.largeCategory;
                        var subcategory = self.subCategory;
                        localStorage.removeItem("page");
                        if (category && subcategory) {
                            location.href = "/product/list.do?searchOption=" + this.searchOptionFromCategory + "&keyword=" + subcategory;
                        } else {
                            alert("카테고리 정보가 부족합니다.");
                        }
                    },
                    // 클릭된 이미지로 메인 이미지 변경
                    changeImage(filePath) {

                        const index = this.imgList.findIndex(img => img.filePath === filePath);
                        if (index !== -1) {
                            this.currentImageIndex = index;
                            this.stopAutoSlide(); // 클릭 시 자동 슬라이드 멈추고
                            this.startAutoSlide(); // 다시 시작 (선택 사항)
                        }
                    },
                    startAutoSlide() {
                        this.autoSlideInterval = setInterval(() => {
                            this.currentImageIndex = (this.currentImageIndex + 1) % this.imgList.length;
                        }, 1500); // 3초마다 이미지 변경
                    },
                    stopAutoSlide() {
                        clearInterval(this.autoSlideInterval);
                    },
                    beforeDestroy() {
                        this.stopAutoSlide();
                    },

                    //리뷰 보여주기
                    fnReviewList() {
                        const self = this;
                        const nparmap = {
                            productId: self.productId,
                            page: (self.reviewPage - 1) * self.reviewPageSize,
                            pageSize: self.reviewPageSize
                        };
                        $.ajax({
                            url: "/product/reviewList.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log("11", data);
                                self.reviewList = data.reviewList;
                                self.tabs[1].cmtcount = data.totalCount;
                                self.reviewPages = Array.from({ length: Math.ceil(data.totalCount / self.reviewPageSize) }, (_, i) => i + 1);

                                // ⭐ 평균 별점 계산
                                const validReviews = self.reviewList.filter(r => !isNaN(r.rating) && Number(r.rating) > 0 && r.deleteYn !== 'Y');
                                const totalRating = validReviews.reduce((sum, r) => sum + Number(r.rating), 0);
                                self.averageRating = validReviews.length > 0
                                    ? (totalRating / validReviews.length).toFixed(1)
                                    : 0;
                            }
                        });
                    },
                    //별점
                    getStarClass(index) {
                        const rating = this.averageRating;
                        if (rating >= index) {
                            return "filled";
                        } else if (rating >= index - 0.5) {
                            return "half";
                        } else {
                            return "";
                        }
                    },
                    //리뷰 도움체크
                    markHelpful(reviewId) {
                        if (this.alreadyClicked[reviewId]) return;

                        const self = this;
                        $.ajax({
                            url: "/product/reviewHelpCnt.dox",
                            type: "POST",
                            data: { reviewId: reviewId },
                            dataType: "json",
                            success: function (data) {
                                if (data.result === "success") {
                                    alert("리뷰가 도움이 되었다고 표시되었습니다!");
                                    self.fnReviewList();
                                    self.alreadyClicked[reviewId] = true;
                                } else if (data.result === "fail") {
                                    alert(data.message || "이미 추천한 리뷰입니다.");
                                }
                            }
                        });
                    },
                    //상품 리뷰 페이징
                    fnReviewPage(num) {
                        this.reviewPage = num;
                        this.fnReviewList();
                    },
                    fnReviewPageMove(direction) {
                        if (direction === 'prev' && this.reviewPage > 1) {
                            this.reviewPage--;
                        } else if (direction === 'next' && this.reviewPage < this.reviewPages.length) {
                            this.reviewPage++;
                        }
                        this.fnReviewList();
                    },
                    //상품 리뷰 글쓰기
                    fnReviewWtite: function () {
                        let self = this;
                        if (!self.sessionId || self.sessionId === "") {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do"; // ← 로그인 페이지 경로
                            return;
                        }
                        location.href = "/product/review.do?productId=" + self.productId;
                    },
                    //개인 리뷰 삭제
                    fnDelete: function (reviewId) {
                        var self = this;
                        if (!confirm("정말 삭제하시겠습니까?")) {
                            return;
                        }
                        var nparmap = {
                            userId: self.sessionId,
                            reviewId: reviewId
                        };
                        $.ajax({
                            url: "/product/reviewRemove.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                if (data.result == "success") {
                                    alert("삭제가 완료되었습니다");
                                    location.href = "/product/view.do?productId=" + self.productId;
                                } else {
                                    alert("삭제에 실패했습니다.");
                                }
                            }
                        });
                    },
                    //개인 리뷰 수정
                    fnEdit: function (reviewId) {
                        let self = this;
                        location.href = "/product/reviewEdit.do?productId=" + self.productId + "&reviewId=" + reviewId;
                    },
                    //유저 아이디 정보 가져오기
                    fnUserInfo() {
                        var self = this;
                        console.log("sessionId >>> ", self.sessionId);
                        var nparmap = {
                            userId: self.sessionId
                        };
                        $.ajax({
                            url: "/user/info.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("userInfo >>> ", data.user);
                                self.userInfo = data.user;
                            }
                        });
                    },
                    //장바구니
                    fnAddCart() {
                        const self = this;
                        const priceToAdd = self.userInfo.membershipFlg === 'Y' ? self.discountedPrice : self.info.price;

                        const nparmap = {
                            productId: self.productId,
                            sessionId: self.sessionId,
                            userId: self.userInfo.userId,
                            quantity: self.quantity,
                            price: priceToAdd,
                            option: "",
                            checkYn: "N"
                        };
                        $.ajax({
                            url: "/cart/addProduct.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                alert("장바구니에 상품이 담겼습니다.");
                            }
                        });
                    },
                    //선택한 상품만 장바구니로
                    fnBuy: function () {
                        const self = this;
                        const nparmap = {
                            userId: self.userInfo.userId,
                            checkYn: "N"
                        };
                        $.ajax({
                            url: "/cart/AllCheckYn.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                self.fnAddBuy();
                            }
                        });
                    },
                    //선택한 상품을 즉시 구매페이지로
                    fnAddBuy() {
                        const self = this;
                        const priceToAdd = self.userInfo.membershipFlg === 'Y' ? self.discountedPrice : self.info.price;
                        const nparmap = {
                            productId: self.productId,
                            sessionId: self.sessionId,
                            userId: self.userInfo.userId,
                            quantity: self.quantity,
                            price: priceToAdd,
                            option: "instant",
                            checkYn: "Y"
                        };
                        $.ajax({
                            url: "/cart/addProduct.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                location.href = "/cart/order.do";
                            }
                        });
                    },
                    changeTab(tabId) {
                        let self = this;
                        self.activeTab = tabId;
                        if (tabId === 'review') {
                            self.fnReviewList();
                        } else if (tabId === 'qna') {
                            self.fnQnaList();
                        }
                    },
                    //수량 감소
                    increaseQty() {
                        this.quantity++;
                    },
                    //수량 증가
                    decreaseQty() {
                        if (this.quantity > 1) {
                            this.quantity--;
                        }
                    },
                    //수량 확인
                    confirmQuantity() {
                        this.isSelected = true;
                        // 필요하면 서버에 확정된 수량 보내기 or 알림 띄우기 가능
                    },
                    cancelSelection() {
                        this.isSelected = false;
                        this.quantity = 1;
                    },
                    //QnA 목록 보여주기
                    fnQnaList() {
                        let self = this;
                        let nparmap = {
                            productId: self.productId,
                            page: (self.qnaPage - 1) * self.qnaPageSize,
                            pageSize: self.qnaPageSize
                        };
                        self.qnaList = [];
                        $.ajax({
                            url: "/product/qnaList.dox",
                            type: "POST",
                            data: nparmap,
                            dataType: "json",
                            success: function (data) {
                                console.log("QNA 불러오기 성공:", data);
                                self.qnaList = data.list;
                                self.qnaTotal = data.totalCount;
                                self.qnaPages = Array.from(
                                    { length: Math.ceil(data.totalCount / self.qnaPageSize) },
                                    (_, i) => i + 1
                                );
                                self.tabs[2].cmtcount = data.totalCount;
                            }
                        });
                    },
                    fnQnaPage(num) {
                        this.qnaPage = num;
                        this.fnQnaList();
                    },
                    fnQnaPageMove(direction) {
                        if (direction === 'prev' && this.qnaPage > 1) {
                            this.qnaPage--;
                        } else if (direction === 'next' && this.qnaPage < this.qnaPages.length) {
                            this.qnaPage++;
                        }
                        this.fnQnaList();
                    },
                    //QnA 글쓰기 이동
                    fnQna() {
                        let self = this;
                        if (!self.sessionId || self.sessionId === "") {
                            alert("로그인 후 이용해주세요.");
                            location.href = "/user/login.do";
                            return;
                        }
                        location.href = "/product/qnawrite.do?productId=" + self.productId;
                    },
                    //QnA 글 삭제
                    fnQnaDelete(qnaId) {
                        if (!confirm("정말 삭제하시겠습니까?")) return;

                        const self = this;
                        $.ajax({
                            url: "/product/qnaDelete.dox",
                            type: "POST",
                            data: {
                                qnaId: qnaId,
                                userId: self.sessionId
                            },
                            dataType: "json",
                            success: function (data) {
                                if (data.result === "success") {
                                    alert("삭제되었습니다.");
                                    self.fnQnaList();
                                } else {
                                    alert(data.message || "삭제에 실패했습니다.");
                                }
                            }
                        });
                    },
                    //QnA 글 수정
                    fnQnaEdit(qnaId) {
                        let self = this;
                        location.href = "/product/qnaEdit.do?qnaId=" + qnaId + "&productId=" + self.productId;
                    },
                    //멤버십 이동
                    MembershipJoin() {
                        alert("멤버십 가입 페이지로 이동합니다!");
                        location.href = "/membership/main.do"; 
                    },  
                },
                mounted() {
                    const params = new URLSearchParams(window.location.search);
                    this.productId = params.get("productId") || "";

                    if (this.productId == "") {
                        alert("상품을 불러올수 없습니다.");
                        location.href = "/product/list.do";
                    }

                    let self = this;
                    self.fnProduct();
                    self.fnReviewList();
                    self.fnUserInfo();
                    self.fnQnaList();

                }
            });

            app.mount("#app");
        });
    </script>