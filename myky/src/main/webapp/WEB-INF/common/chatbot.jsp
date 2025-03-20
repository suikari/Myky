<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 채팅방</title>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .chat-container {
            width: 100%;
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .chat-header {
            background-color: #007bff;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 20px;
        }

        .chat-box {
            height: 400px;
            padding: 15px;
            overflow-y: auto;
            background-color: #f9f9f9;
            display: flex;
            flex-direction: column;
        }

        .chat-message {
            padding: 10px;
            margin: 5px 0;
            border-radius: 10px;
            max-width: 80%;
            background-color: #f1f1f1;
            align-self: flex-start;
        }

        .chat-message.user {
            background-color: #007bff;
            color: white;
            align-self: flex-end;
        }

        .input-area {
            display: flex;
            padding: 15px;
            border-top: 1px solid #ddd;
        }

        textarea {
            width: 80%;
            height: 50px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            resize: none;
            margin-right: 10px;
            font-size: 16px;
        }

        button {
            padding: 12px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div id="app" class="chat-container">
        <div class="chat-header">
            <h2>챗봇</h2>
        </div>
        <div class="chat-box" ref="chatBox">
            <div v-for="(msg, index) in messages" :key="index" :class="['chat-message', msg.sender]">
                <p>{{ msg.text }}</p>
            </div>
        </div>
        <div class="input-area">
            <textarea v-model="userInput" placeholder="메시지를 입력하세요..." @keyup.enter="sendMessage"></textarea>
            <button @click="sendMessage">전송</button>
        </div>
    </div>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    userInput: "", // 사용자 입력
                    messages: []    // 메시지 리스트
                };
            },
            methods: {
                sendMessage() {
                    var self = this;
                    let userMessage = self.userInput.trim();

                    if (!userMessage) return;

                    // 사용자 메시지 추가
                    self.messages.push({
                        sender: "user",
                        text: userMessage
                    });

                    self.$nextTick(() => {
                        self.scrollToBottom();
                    });

                    // AJAX 요청
                    let nparmap = {
                        input: userMessage
                    };

                    $.ajax({
                        url: "/gemini/chat.dox",
                        type: "GET",
                        data: nparmap, // 입력값 전달
                        success: function(response) {
                            self.messages.push({
                                sender: "bot",
                                text: response
                            });

                            self.$nextTick(() => {
                                self.scrollToBottom();
                            });
                        },
                        error: function(xhr) {
                            self.messages.push({
                                sender: "bot",
                                text: "오류 발생: " + xhr.responseText
                            });

                            self.$nextTick(() => {
                                self.scrollToBottom();
                            });
                        }
                    });

                    // 입력 필드 초기화
                    self.userInput = "";
                },
                scrollToBottom() {
                    const chatBox = this.$refs.chatBox;
                    chatBox.scrollTop = chatBox.scrollHeight;
                }
            },
            updated() {
                this.scrollToBottom();
            }
        });
        app.mount('#app');
    </script>

</body>
</html>
