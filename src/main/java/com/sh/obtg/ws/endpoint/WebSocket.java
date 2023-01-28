package com.sh.obtg.ws.endpoint;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
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
import com.sh.obtg.notification.model.dto.Notification;
import com.sh.obtg.ws.MessageType;
import com.sh.obtg.ws.config.WebSocketConfigurator;


@ServerEndpoint(value = "/websocket", configurator = WebSocketConfigurator.class)
public class WebSocket {

	public static Map<String, Session> clientMap = Collections.synchronizedMap(new HashMap<>());
	
	@OnOpen
	public void onOpen(EndpointConfig config, Session session) {
		Map<String, Object> userProp = config.getUserProperties();
		String memberId = (String) userProp.get("memberId");
		List<Notification> notiList = (List<Notification>)userProp.get("notiList");
		
		// 우리서버에 누가 접속하고 있는지 관리
		clientMap.put(memberId, session);
		
		// session설정맵에 사용자아이디 추가 (close때 사용)
		Map<String, Object> sessionUserProp = session.getUserProperties();
		sessionUserProp.put("memberId", memberId);
		
		if((!notiList.isEmpty()) && notiList != null) {
			sessionUserProp.put("notiList", notiList);
			getNotiList(notiList, session);
		}
		
	}
	
	// 알림 내역 꺼내기
	private void getNotiList(List<Notification> notiList, Session session) {
		for(Notification noti : notiList) {
			Map<String, Object> data = new HashMap<>();
			System.out.println("다시 돌아오니?");
			data.put("receiver", noti.getReceiver());
			data.put("messageType", MessageType.NOTIFICATION);
			data.put("message", noti.getMessage());
			data.put("datetime", noti.getDatetime());
			System.out.println("데이타까지 왔니?" + data);
			onMessage(new Gson().toJson(data), session);
		}
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
