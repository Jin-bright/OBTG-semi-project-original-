package com.sh.obtg.ws.config;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

import com.sh.obtg.member.model.dto.Member;
import com.sh.obtg.notification.model.dto.Notification;
import com.sh.obtg.notification.model.service.NotificationService;

public class WebSocketConfigurator extends Configurator {
	private NotificationService notificationService = new NotificationService();
	
	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		
		HttpSession session = (HttpSession) request.getHttpSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = null;
		
		if(loginMember != null) {
			memberId = loginMember.getMemberId();
			// 알림 메시지가 있는 경우
			List<Notification> notiList = notificationService.selectNotiList(memberId); 
			System.out.println("notiList = " + notiList);
			
			// 설정맵에 저장 
			// userProperties에는 null이 들어 올 수 없으므로 꼭 if처리 해주자!
			Map<String, Object> userProp = sec.getUserProperties();
			userProp.put("memberId", memberId);
			
			if(!notiList.isEmpty()) {
				System.out.println("설마 널인데 들어오는 건 아니지?" + notiList);
				userProp.put("notiList", notiList);
			}
		}
		
		
	}
	
}
