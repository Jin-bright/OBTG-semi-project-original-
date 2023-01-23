package com.sh.obtg.share.model.service;

import static com.sh.obtg.common.JdbcTemplate.close;
import static com.sh.obtg.common.JdbcTemplate.commit;
import static com.sh.obtg.common.JdbcTemplate.getConnection;
import static com.sh.obtg.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.sh.obtg.share.model.dao.ShareDao;
<<<<<<< HEAD
import com.sh.obtg.share.model.dto.ShareAttachment;
=======
>>>>>>> branch 'master' of https://github.com/incheol789/OBTG-semi-project.git
import com.sh.obtg.share.model.dto.ShareBoard;

public class ShareService {
	
	private ShareDao shareDao = new ShareDao();

<<<<<<< HEAD
	public int insertShare(ShareBoard share) {
		Connection conn = getConnection();
		int result = 0;
		try {
			try {
				result = shareDao.insertShare(conn, share);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			int ShareNo = shareDao.selectLastShareNo(conn);
			
			// 첨부파일 등록
			List<ShareAttachment> attachments = share.getAttachments();
			if(!attachments.isEmpty()) {
				for(ShareAttachment attach : attachments) {
					attach.setBoardNo(ShareNo);
					result = shareDao.insertAttachment(conn, attach);
				}
			}
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
=======
	public static int insertShare(ShareBoard share) {
		return 0;
>>>>>>> branch 'master' of https://github.com/incheol789/OBTG-semi-project.git
	}
	
}
