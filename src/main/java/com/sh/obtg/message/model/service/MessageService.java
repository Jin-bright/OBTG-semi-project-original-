package com.sh.obtg.message.model.service;

import static com.sh.obtg.common.JdbcTemplate.*;

import java.sql.Connection;

import com.sh.obtg.message.model.dao.MessageDao;
import com.sh.obtg.message.model.dto.Message;

public class MessageService {
	
	private MessageDao messageDao = new MessageDao();

	//1. message 테이블에 넣기 
	public int insertMessage(Message message) {
		Connection conn = getConnection(); 
		int result = 0;
		try {
			result = messageDao.insertMessage( conn ,message );
			commit(conn);
		}catch (Exception e) {
			rollback(conn);
		}finally {
			close(conn);
		}
		return result;
	}

	
	

}
