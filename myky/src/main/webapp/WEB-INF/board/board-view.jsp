<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>자유게시판</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->

        <style>
            #viewPage {
                max-width: 1000px;
                margin: 40px auto;
                padding: 40px;
                background-color: #fff;
                border-radius: 10px;
                font-family: 'Noto Sans KR', sans-serif;
            }

            #viewPage .view-header {
                font-size: 36px;
                font-weight: bold;
                color: #202060;
                margin-bottom: 10px;
            }

            #viewPage .view-sub {
                color: #333;
                font-weight: bold;
                font-size: 16px;
                margin-bottom: 30px;
            }

            #viewPage .view-label {
                font-size: 25px;
                font-weight: bold;
                color: #202060;
                margin-top: 40px;
                margin-bottom: 10px;
                max-width: 1000px;
                align-items: center;
            }

            .view-labelContent {
                height: 500px;
                text-align: center;
                align-items: center;
            }

            #viewPage .view-box {
                border: 2px solid #202060;
                font-weight: bold;
                border-radius: 6px;
                padding: 15px;
                background-color: #fdfdfd;
                font-size: 16px;
                line-height: 1.8;
                color: #333;
                word-break: break-word;
                white-space: pre-wrap;
                align-items: center;
            }

            .view-boxContent {
                border: 1px solid #202060;
                border-radius: 6px;
                padding: 15px;
                background-color: #fdfdfd;
                font-size: 16px;
                line-height: 1.8;
                color: #333;
                word-break: break-word;
                white-space: pre-wrap;
                min-height: 500px;
                text-align: center;
                align-items: center;
            }

            #viewPage .view-files {
                margin-top: 10px;
                width: 100%;
                max-width: 1000px;
                text-align: center;
                align-items: center;
            }

            #viewPage .file-link {
                color: #202060;
                font-weight: bold;
                text-decoration: none;
                margin-right: 10px;
                display: inline-block;
                align-items: center;
                text-align: center;
            }

            .view-files {
                margin-bottom: 20px;
                color: #202060;
                border: 1px solid #202060;
                border-radius: 6px;
                padding: 15px;
                text-align: center;
                align-items: center;
            }

            #viewPage .file-link:hover {
                color: #fca311;
            }

            .custom-hr {
                width: 1000px;
                max-width: 100%;
                border: none;
                border-top: 1px solid #ccc;
                margin-top: 10px;
                margin-bottom: 40px;
                width: 100%;

                max-width: 1000px;
            }

            .button {
                padding: 10px 20px;
                font-size: 14px;
                font-weight: bold;
                background-color: #202060;
                color: #fca311;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                width: fit-content;
            }

            .cmtButton {
                padding: 5px 10px;
                font-size: 14px;
                font-weight: bold;
                background-color: #202060;
                color: #fca311;
                border-radius: 6px;
                cursor: pointer;
                width: fit-content;
                margin-inline-end: auto;
                border: none;
            }

            .cmtButtonBox {
                border-radius: 6px;
                max-width: 1000px;
                margin-top: 20px;
                margin-bottom: 5px;
                /* border : none; */
                border: 1px solid #202060;
            }

            .cmtButton2 {
                padding: 5px 10px;
                font-size: 14px;
                font-weight: bold;
                background-color: #c0c0c0;
                color: #353535;
                border-radius: 6px;
                cursor: pointer;
                width: fit-content;
                margin-inline-end: auto;
                border: none;
                margin: 1px;
            }

            .cmtInput {
                max-width: 400px;
                width: 100%;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 8px;
            }

            .cmtTextBox {
                border-radius: 6px;
                border: 1px solid #f7f7f8;
                background-color: #f5f5f5;
                max-width: 1000px;
                width: 100%;
                margin: 5px;
                padding: 5px;
                margin-bottom: 5px;
            }

            .Button:hover {
                background-color: #fca311;
                color: #202060;
            }

            .FileDownload {
                color: #202060;
                text-decoration: none;
                font-weight: bold;
            }

            .FileDownload:hover {
                color: #fca311;
            }

            .buttonMargin {
                margin-top: 30px;
                margin-bottom: 30px;
            }

            .link-container {
                position: relative;
                display: inline-block;
            }

            .preview-image {
                display: none;
                position: absolute;
                top: -19px;
                left: 250px;
                width: 150px;
                height: auto;
                border: 1px solid #ededed;
                background-color: white;
                padding: 5px;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
                z-index: 100;
            }

            .link-container:hover .preview-image {
                display: block;
            }

            .view-boxContent img {
                max-width: 70%;
                height: auto;
                display: block;
                margin: 10px auto;
                border-radius: 6px;
            }

            .cmt2button {
                margin-right: 10px;
                color: #888;
                font-size: 15px;
                cursor: pointer;
            }

            .likeButton2 {
                width: 40px;
                height: 40px;
            }

            .likeButton {
                background-color: white;
                border: none;
                color: #202060;
                cursor: pointer;
            }

            .like-button-wrapper {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
                gap: 20px;
            }
        </style>

    </head>

    <body>
        <jsp:include page="../common/header.jsp" />

        <div id="app" class="container">
            <div id="viewPage">

                <div class="view-header" v-if="category == 'F'">
                    VIEW
                </div>
                <div class="view-header" v-if="category == 'A'">
                    NOTICE VIEW
                </div>
                <div class="view-sub" v-if="category == 'F'">
                    여러분의 이야기를 들려주세요.
                </div>
                <div class="view-sub" v-if="category == 'A'">
                    새 소식을 알려드립니다<div class="f"></div>
                </div>
                <hr class="custom-hr">
                <div class="view-label">
                    TITLE
                </div>
                <div class="view-box">
                    <a style="font-size:20px">{{info.title}}</a>
                    <!-- 날짜 표시 여기 넣기 -->
                    <div style="color: #fca311;">작성자: {{info.nickName}}</div>
                    <div style="font-size: 13px; color: #888; margin-top: 10px; margin-bottom: 0px;">
                        작성일: ( {{ info.updatedTime }} ) 조회수: ( {{info.cnt}} )
                    </div>
                </div>


                <div class="view-label">CONTENT</div>
                <div class="view-boxContent" v-html="info.content"></div>
                <!-- 좋아요, 싫어요 버튼 -->
                <div class="like-button-wrapper">
                    <template v-if="likeStatus">
                        <button @click="likeButton('like','M')" class="likeButton">
                            <img src="../img/buttonImg/smileClick.png" class="likeButton2" alt="좋아요" />
                            <span>{{ info.likes }}</span>
                        </button>
                    </template>
                    <template v-else>
                        <button @click="likeButton('like','P')" class="likeButton">
                            <img src="../img/buttonImg/smilenon.png" class="likeButton2" alt="좋아요" />
                            <span>{{ info.likes }}</span>
                        </button>
                    </template>

                    <template v-if="dislikeStatus">
                        <button @click="likeButton('dislike','M')" class="likeButton">
                            <img src="../img/buttonImg/dislikeClick.png" class="likeButton2" alt="싫어요" />
                            <span>{{ info.dislikes }}</span>
                        </button>
                    </template>
                    <template v-else>
                        <button @click="likeButton('dislike','P')" class="likeButton">
                            <img src="../img/buttonImg/dislikenon.png" class="likeButton2" alt="싫어요" />
                            <span>{{ info.dislikes }}</span>
                        </button>
                    </template>
                </div>
                <div class="view-label">첨부파일</div>
                <div class="view-files">
                    <div v-for="item in fileList">
                        <div class="link-container">
                            <a :href="item.filePath" download class="FileDownload">{{item.fileName}}
                                <span class="FileDownload"> ({{ Math.ceil(item.fileSize/1024)}} kb) </span></a>
                            <div v-if="isImageFile(item.fileName)">
                                <img :src="item.filePath" :alt="item.fileName" class="preview-image">
                            </div>
                        </div>
                    </div>
                </div>
                <table>
                </table>
                <!-- 댓글 입력 -->
                <div v-if="category == 'F'">
                    <table>
                        <tr v-if="cmtList.commentId != null">
                            <div v-for="item in cmtList" :key="item.commentId">
                                <div class="cmtTextBox">

                                    <!-- 수정 중인 경우 -->
                                    <div v-if="editCommentId == item.commentId">
                                        <div style="font-weight: bold; margin-bottom: 3px;">{{ item.nickName }}</div>
                                        <input v-model="editContent" class="cmtInput" />

                                        <div style="display: flex; gap: 5px;">
                                            <button class="cmtButton2"
                                                @click="fnCommentUpdate(item.commentId)">저장</button>
                                            <button class="cmtButton2" @click="editCommentId = ''">취소</button>
                                        </div>
                                    </div>
                                    <!-- 일반 댓글 보기 -->
                                    <div v-else>
                                        <!-- 유저 아이디 -->
                                        <template v-if="item.isDeleted == 'Y'">
                                            <div style="font-weight: bold; margin-bottom: 3px;"></div>
                                            <!-- 댓글 내용 -->
                                            <div style="margin-bottom: 5px;">삭제된 댓글입니다.</div>
                                        </template>
                                        <template v-else>
                                            <div style="font-weight: bold; margin-bottom: 3px;">{{ item.nickName }}
                                            </div>

                                            <!-- 댓글 내용 -->
                                            <div style="margin-bottom: 5px;">{{ item.content }}</div>
                                        </template>
                                    </div>


                                    <!-- 날짜 / 버튼들 -->
                                    <div
                                        style="display: flex; align-items: center; gap: 10px; font-size: 13px; color: #888;">
                                        <span>{{ item.updatedTime }}</span>

                                        <!-- 답글 -->
                                        <div v-if="sessionId">
                                            <a class="cmt2button" @click="fnReply(item.commentId)">답글 달기</a>

                                            <!-- 수정/삭제 -->
                                            <template v-if="item.isDeleted == 'N'">
                                                <template v-if="sessionId == item.userId">
                                                        <button class="cmtButton2" @click="fnCommentEdit(item)">수정</button>
                                                </template>
                                                <template v-if="sessionId == item.userId || sessionRole == 'ADMIN'">
                                                    <button class="cmtButton2" @click="fnCommentRemove(item.commentId)">❌</button>
                                                </template>
                                            </template>
                                        </div>
                                    </div>

                                </div>

                                <!-- 대댓글 입력창 -->
                                <div v-if="replyFormId === item.commentId" style="margin-left: 30px;">
                                    <input class="cmtInput" v-model="replyContent" placeholder="대댓글 입력" />
                                    <button class="cmtButton2" @click="fnReplySave(item.commentId)">등록</button>
                                    <button class="cmtButton2" @click="replyFormId = ''">취소</button>
                                </div>

                                <!-- 대댓글 반복 -->
                                <div v-for="reply in item.replies || []" :key="reply.commentId"
                                    style="margin-left: 30px;">
                                    <div v-if="editCommentId === reply.commentId">
                                        <div style="font-weight: bold; margin-bottom: 3px;">{{ reply.nickName }}</div>
                                        <input v-model="editContent" />
                                        <button class="cmtButton2" @click="fnCommentUpdate(reply.commentId)">저장</button>
                                        <button class="cmtButton2" @click="editCommentId = ''">취소</button>
                                    </div>
                                    <div v-else>
                                        <div v-if="reply.isDeleted == 'Y'">
                                            <div style="margin-bottom: 10px;">삭제된 댓글입니다.</div>
                                        </div>
                                        <div v-else>
                                            <div style="font-weight: bold; margin-bottom: 3px;">{{ reply.nickName }}</div>
                                            <div style="margin-bottom: 5px;">{{ reply.content }}</div>
                                            <div
                                                style="display: flex; align-items: center; gap: 10px; font-size: 13px; color: #888;">
                                                <span>{{ reply.updatedTime }}</span>
                                                <template v-if="sessionId === reply.userId">
                                                    <button class="cmtButton2" @click="fnCommentEdit(reply)">수정</button>
                                                </template>
                                                <template v-if="sessionId === reply.userId || sessionRole === 'ADMIN'">
                                                    <button class="cmtButton2" @click="fnCommentRemove(reply.commentId)">❌</button>
                                                </template>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        </tr>
                    </table>

                    <table class="cmtButtonBox" v-if="sessionId">
                        <tr>
                            <th style="margin-right: 10px;"> 댓글 </th>
                            <td>
                                <textarea style="width: 430px" v-model="content" cols="60" rows="5"></textarea>
                            </td>
                            <td>
                                <button class="button" @click="fnCommentSave">저장</button>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="buttonMargin" style="display: flex; gap: 5px;">
                    <template v-if="sessionId == info.userId">
                        <button class="button" @click="fnEdit()">수정</button>
                    </template>
                    <template v-if="sessionId == info.userId || sessionRole == 'ADMIN'">    
                        <button class="button" @click="fnRemove()">삭제</button>
                    </template>
                    <button class="button" @click="fnBack(info)">뒤로가기</button>
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
                        boardId: "${map.boardId}",
                        info: {},
                        page: "${param.page}",
                        sessionId: "${sessionId}",
                        sessionRole: "${sessionRole}",
                        userId: {},
                        nickName: "",
                        content: "",
                        commentId: "",
                        cmtList: [],
                        editCommentId: "",
                        editContent: "",
                        fileList: [],
                        category: "",
                        imageExtensions: [
                            // 일반적으로 많이 쓰는 확장자
                            'jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp',

                            // 벡터 이미지
                            'svg', 'eps', 'ai',

                            // 고화질/전문 이미지
                            'tiff', 'tif', 'heic', 'heif', 'raw', 'cr2', 'nef', 'orf', 'sr2',

                            // 애니메이션/움짤
                            'apng', 'mng',

                            // 아이콘/스프라이트 등
                            'ico', 'icns',

                            // 기타/특수 확장자
                            'jfif', 'pjpeg', 'pjp', 'avif', 'emf', 'wmf'
                        ],
                        replyFormId: "",       // 어떤 댓글에 답글을 다는지
                        replyContent: "",      // 대댓글 내용
                        editReplyId: "",
                        editReplyContent: "",
                        updatedTime: "",
                        createdTime: "",

                        likeStatus: false,  // 좋아요 상태
                        dislikeStatus: false,  // 싫어요 상태
                        status: "",
                        likes: "",
                        dislikes: "",

                    };
                },
                computed: {
                    size(fileSize) {
                        console.log("1", fileSize);
                        let size = Math.ceil(parseInt(fileSize) / 1024);

                        return parseInt(size);

                    }
                },
                methods: {
                    fnView() {
                        var self = this;
                        var nparmap = {
                            boardId: self.boardId,
                            option: "View",
                            category: self.category,
                        };
                        $.ajax({
                            url: "/board/view.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.result != 'success') {
                                    alert("잘못된 주소입니다.");
                                    location.href = "/board/boardList.do";
                                }
                                console.log("댓글", data);
                                self.info = data.info
                                self.cmtList = data.cmtList;
                                self.fileList = data.fileList;
                            }
                        });
                        self.fnlikestatus();
                    },
                    fnlikestatus() {
                        var self = this;

                        var nparmap = {
                            boardId: self.boardId,
                            userId: self.sessionId,
                        };
                        $.ajax({
                            url: "/board/likeStatus.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("7979", data);

                                if (data.result == "success") {

                                    if (data.listStatus.status == "like") {
                                        self.likeStatus = true;
                                    } else {
                                        self.likeStatus = false;
                                    }

                                    if (data.listStatus.status == "dislike") {
                                        self.dislikeStatus = true;
                                    } else {
                                        self.dislikeStatus = false;
                                    }
                                } else {
                                    self.likeStatus = false;
                                    self.dislikeStatus = false;
                                }

                            }
                        });
                    },
                    fnBack: function (info) {
                        let self = this;
                        location.href = "/board/list.do?category=" + self.category;

                    },
                    fnEdit: function () {
                        var self = this;
                        location.href = "/board/edit.do?boardId=" + self.boardId + "&category=" + self.category;
                    },
                    fnRemove: function () {
                        var self = this;
                        var nparmap = {
                            boardId: self.boardId,
                            category: self.category,
                        };

                        if (!confirm("정말 삭제하시겠습니까?")) {
                            alert("취소되었습니다.");
                            return;
                        }

                        $.ajax({
                            url: "/board/remove.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                location.href = "/board/list.do?category=" + self.category;
                                alert("삭제되었습니다!");
                            }
                        });
                    },
                    fnCommentEdit(item) {
                        let self = this;
                        self.editCommentId = item.commentId;
                        self.editContent = item.content;
                        console.log(self.editContent);
                        var nparmap = {
                            commentId: item.commentId
                        };
                    },
                    fnCommentUpdate(commentId) {
                        var self = this;
                        var nparmap = {
                            commentId: commentId,
                            boardId: self.boardId,
                            userId: self.userId,
                            content: self.editContent,

                        };
                        $.ajax({
                            url: "/board/comment/update.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                alert("수정됐습니다!");
                                self.editCommentId = "";
                                self.fnView();
                            }
                        });
                    },
                    fnCommentRemove(commentId) {
                        let self = this;
                        console.log(commentId);
                        var nparmap = {
                            commentId: commentId
                        };
                        if (!confirm("정말 삭제하시겠습니까?")) {
                            alert("취소되었습니다.");
                            return;
                        }
                        $.ajax({
                            url: "/board/CommentRemove.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                alert("삭제되었습니다");
                                self.fnView();
                            }
                        });
                    },
                    fnCommentSave() {
                        let self = this;
                        var nparmap = {
                            boardId: self.boardId,
                            userId: self.sessionId,
                            content: self.content,
                        };
                        $.ajax({
                            url: "/board/CommentAdd.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                alert("등록되었습니다");
                                self.fnView();
                                self.content = "";
                            }
                        });
                    },
                    isImageFile(fileName) {
                        let self = this;

                        const ext = fileName.split('.').pop().toLowerCase();
                        return self.imageExtensions.includes(ext);
                    },
                    fnReplySave(parentCommentId) {
                        let self = this;
                        let nparmap = {
                            boardId: self.boardId,
                            userId: self.sessionId,
                            content: self.replyContent,
                            parentCommentId: parentCommentId
                        };
                        $.ajax({
                            url: "/board/ReplyAdd.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function () {
                                alert("등록되었습니다");
                                self.replyContent = "";
                                self.replyFormId = "";
                                self.fnView(); // 다시 댓글 전체 불러오기
                            }
                        });
                    },
                    fnReply(commentId) {
                        let self = this;
                        console.log(commentId);
                        if (self.replyFormId == commentId) {
                            self.replyFormId = "";
                            return;
                        }

                        self.replyFormId = commentId;
                    },
                    likeButton(status, PM) {
                        let self = this;
                        let finalstatus = 0;
                        if (PM == 'M') {
                            finalstatus = -1;
                        } else {
                            finalstatus = 1;
                        }
                        var nparmap = {
                            boardId: self.boardId,
                            userId: self.sessionId,
                            status: status,
                            likes: self.likes,
                            dislikes: self.dislikes,
                            finalstatus: finalstatus
                        };

                        if (self.sessionId == null || self.sessionId == "") {
                            alert("로그인후 이용해 주세요.");
                            return;
                        }

                        if (self.likeStatus) {
                            if (status == 'dislike') {
                                // alert("");
                                return;
                            }
                        }

                        if (self.dislikeStatus) {
                            if (status == 'like') {
                                // alert("");
                                return;
                            }
                        }

                        if (PM == 'M') {

                            $.ajax({
                                url: "/board/removelikeCnt.dox",
                                dataType: "json",
                                type: "POST",
                                data: nparmap,
                                success: function (data) {
                                    console.log("eee", data);
                                    self.fnlikestatus();
                                }
                            });

                        } else {

                            $.ajax({
                                url: "/board/addlikeCnt.dox",
                                dataType: "json",
                                type: "POST",
                                data: nparmap,
                                success: function (data) {
                                    console.log("eee", data);
                                    self.fnlikestatus();
                                }
                            });

                        }

                        $.ajax({
                            url: "/board/addlikeCntBoard.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.fnView();

                            }
                        });

                    },


                },
                mounted() {
                    let self = this;
                    const params = new URLSearchParams(window.location.search);
                    self.boardId = params.get("boardId") || "";
                    self.category = params.get("category") || "F";


                    self.fnView();
                }
            });

            app.mount("#app");
        });
    </script>