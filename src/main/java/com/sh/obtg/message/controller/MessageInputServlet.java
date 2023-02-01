package com.sh.obtg.message.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.obtg.message.model.dto.Message;
import com.sh.obtg.message.model.service.MessageService;

/**
 * Servlet implementation class MessageInputServlet
 */
@WebServlet("/chat/MessageMain")
public class MessageInputServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MessageService messageService = new MessageService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	//1. 사용자입력값 처리 
		int no = 0;
		try {
			no = Integer.parseInt(request.getParameter("no"));
			String receiver = request.getParameter("receiver");
			String sender = request.getParameter("sender");
			String msgContent = request.getParameter("msgContent");
		
		
			String msgTitle = "제목없음";
			if(request.getParameter("msgTitle") != null) {
				msgTitle = request.getParameter("msgTitle");
			}; //default title 설정
			//2업무로직 
			// insert into message values(se ,?,?,?,?,default)
			
			Message message = new Message();
			message.setMessageReceiver(receiver);
			message.setMessageSender(sender);
			message.setMessageTitle(msgTitle);
			message.setMessageContent(msgContent);		
			
			int result = messageService.insertMessage(message);
			System.out.println("메세지 input 성공여부 " + result );
			
			response.sendRedirect(request.getContextPath()+"/share/shareView?no="+no);

		}catch (Exception e) {
			request.getSession().setAttribute("msg", "게시글 등록중 오류가 발생했습니다." );
			e.printStackTrace();
	    	response.sendRedirect(request.getContextPath()+"/share/shareView?no="+no);
		}			
	}//


}

/**
    private int messageNO;
	private String messageTitle;
	private String messageSender;
	private String messageReceiver;
	private String messageContent;
	private Date messageRegdate;
	
	/**
create table message (
no number,
title varchar2(50),
sender varchar2(50),
receiver varchar2(50) not null,
content varchar2(1000) not null,
reg_date date default sysdate,
constraint pk_message_no primary key(no),
constraint fk_message_sender foreign key(sender) references member (member_id) on delete set null
);
**/

