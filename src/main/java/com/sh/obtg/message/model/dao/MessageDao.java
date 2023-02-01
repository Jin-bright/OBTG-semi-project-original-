package com.sh.obtg.message.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import com.sh.obtg.message.model.dto.Message;
import com.sh.obtg.message.model.exception.MessageException;

public class MessageDao {

	//최초 설정 
	Properties prop = new Properties();
	
	public MessageDao() {

		String path = MessageDao.class.getResource("/sql/message/message-query.properties").getPath();
		try {
			prop.load( new FileReader(path));
		} catch (IOException e) {
			System.out.println("path 오류 ");
			e.printStackTrace();
		}
		System.out.println("[ ●message-query 준비완료 ]" + prop );

	}

	//1. dml - insert 메세지 넣기 
/**
 *     no number,
    title varchar2(50),
    sender varchar2(50),
    receiver varchar2(50) not null,
    content varchar2(1000) not null,
    reg_date date default sysdate,	
 */
	public int insertMessage(Connection conn, Message message) {
		String sql = prop.getProperty("insertMessage");
		int result = 0;

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, message.getMessageTitle());
			pstmt.setString(2, message.getMessageSender());
			pstmt.setString(3, message.getMessageReceiver());
			pstmt.setString(4, message.getMessageContent());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MessageException();
			
		}
		return result;
	}

}
