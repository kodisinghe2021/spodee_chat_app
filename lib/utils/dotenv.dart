String BASE_URL = "https://17c9-124-43-78-89.ngrok-free.app";
String WS_URL = "ws://17c9-124-43-78-89.ngrok-free.app/ws";
String wsSubscribe(String chatRoomId) =>
    "/topic/" + chatRoomId + ".public.messages";
String CREATE_CHAT_ROOM = "/api/chatroom";
String ADD_MEMBER_TO_CHAT = "/api/chatroom/participant";
String SEND_MESSAGE = "/api/messages";
String GET_MESSAGES = "/api/messages";
String REGISTER_USER = "/api/user/register";
String GET_USER = "/api/user";
String GET_USER_BY_MOBILE = "/by-mobile/";
