package com.sh.obtg.ws.endpoint;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.sh.obtg.ws.MessageType;


@ServerEndpoint(value = "/websocket")
public class WebSocket {

	public static Map<String, Session> clientMap = Collections.synchronizedMap(new HashMap<>());
	
	@OnOpen
	public void onOpen(EndpointConfig config, Session session) {
		Map<String, Object> userProp = config.getUserProperties();
		String memberId = (String) userProp.get("memberId");
		// List<Notification> noti = (List<Notification>)userProp.get("noti");
		
		// 우리서버에 누가 접속하고 있는지 관리
		clientMap.put(memberId, session);
		
		// session설정맵에 사용자아이디 추가 (close때 사용)
		Map<String, Object> sessionUserProp = session.getUserProperties();
		sessionUserProp.put("memberId", memberId);
		
//		if(noti != null) {
//			sessionUserProp.put("noti", noti);
//			getNoti(noti, session);
//		}
		
	}
	
	@OnMessage
	public void onMessage(String msg, Session session){
		System.out.println("msg@onMessage = " + msg);
		
		// 넘어온 msg(json)를 Map.class 형식으로 변환
		Map<String, Object> data = new Gson().fromJson(msg, Map.class);
		
		MessageType messageType = MessageType.valueOf((String) data.get("messageType"));
	
		switch(messageType) {
		case NOTIFICATION :
			System.out.println("여기옴?");
			if(session != null) {
				Basic basic = session.getBasicRemote();
				try {
					basic.sendText(new Gson().toJson(data));// json 문자열로 변환되어서 던짐	
				} catch (IOException e) {
					e.printStackTrace();
				} 
			}
		}
	}
	
	@OnError
	public void onError(Throwable e) {
		e.printStackTrace(); // 에러방지
	}
	
	@OnClose
	public void onClose(Session session) {
		Map<String, Object> sessionUserProp = session.getUserProperties();
		String memberId = (String) sessionUserProp.get("memberId");
		
		// 웹소켓 세션 관리 맵에서 제거
		clientMap.remove(memberId);
	}	
}
