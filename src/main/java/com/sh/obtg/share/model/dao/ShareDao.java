package com.sh.obtg.share.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.sh.obtg.share.model.dto.ShareAttachment;
import com.sh.obtg.share.model.dto.ShareBoard;
import com.sh.obtg.share.model.exception.ShareException;

public class ShareDao {
	

	private Properties prop = new Properties();
	
	public ShareDao() {
		String path = ShareDao.class.getResource("/sql/share/share-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("ShareDao 쿼리 로드 완료! - " + prop);
	}

	public int insertShare(Connection conn, ShareBoard share) {
		String sql = prop.getProperty("insertShare");
		int result = 0;
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, share.getShareTitle());
			pstmt.setString(2, share.getMember_id());
			pstmt.setString(3, share.getShareContent());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new ShareException("게시글 등록 오류!", e);
		}
		return result;
	}

	public int selectLastShareNo(Connection conn) {
		String sql = prop.getProperty("selectLastShareNo");
		int ShareNo = 0;
		try(
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
		){
			if(rset.next())
				ShareNo = rset.getInt(1);
		} catch (SQLException e) {
			throw new ShareException("게시글 번호 조회 오류!", e);
		}
		
		return ShareNo;
	}

	public int insertAttachment(Connection conn, ShareAttachment attach) {
		String sql = prop.getProperty("insertAttachment");
		int result = 0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, attach.getBoardNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new ShareException("첨부파일 등록 오류!", e);
		}
		return result;
	}

}
