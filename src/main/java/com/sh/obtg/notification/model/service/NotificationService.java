package com.sh.obtg.notification.model.service;

import static com.sh.obtg.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.sh.obtg.notification.model.dao.NotificationDao;
import com.sh.obtg.notification.model.dto.Notification;

public class NotificationService {
	private NotificationDao notificationDao = new NotificationDao();

	/**
	 * 알림 있는지 확인
	 * @param memberId
	 * @return
	 */
	public List<Notification> selectNotiList(String receiver) {
		Connection conn = getConnection();
		List<Notification> notiList = notificationDao.selectNotiList(conn, receiver);
		close(conn);
		return notiList;
	}
}
