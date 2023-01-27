package com.sh.obtg.share.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.sh.obtg.share.model.dto.ShareAttachment;
import com.sh.obtg.share.model.dto.ShareBoard;
import com.sh.obtg.share.model.dto.Style;
import com.sh.obtg.share.model.exception.ShareBoardException;

public class ShareboardDao {
	
	//최초 설정 
	Properties prop = new Properties();
	
	public ShareboardDao() {
		String path = ShareboardDao.class.getResource("/sql/share/shareBoard-query.properties").getPath(); // 이게 빌드패스 경로래 -- 절대경로 
		System.out.println("path : " + path);
		try {
			prop.load( new FileReader(path));
		} catch (IOException e) {
			System.out.println("path 오류 ");
			e.printStackTrace();
		}
		System.out.println("[ShareBoard-Query 준비완료] + prop ");
	}

// **트랜잭션1	
// insertShareBoard = insert into SHARE_board values(seq_SHARE_board_no.nextval,?,?,?,default,default,?,?,?,?,?)
	
	public int insertShareBoard(Connection conn, ShareBoard shareBoard) {
		String sql = prop.getProperty("insertShareBoard");
		int result =0;
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, shareBoard.getMemberId());
			pstmt.setString(2, shareBoard.getShareTitle());
			pstmt.setString(3, shareBoard.getShareContent());
			pstmt.setDate(4, shareBoard.getShareBuyDate());
			pstmt.setString(5, shareBoard.getShareProductStatus());
			pstmt.setString(6, shareBoard.getShareCategory());
			pstmt.setString(7, shareBoard.getShareState());
			pstmt.setString(8, shareBoard.getStyleNo().toString());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new ShareBoardException("ootd 게시판 > 게시글 등록 오류", e);
		}
		return result;
	
	}
	
	// ★시퀀스 번호 채번 - dql - select seq_board_no.currval from dual 
		public int selectLastBoardNo(Connection conn) {
			String sql = prop.getProperty("selectLastBoardNo");
			int boardNo = 0;
			
			try(
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rset = pstmt.executeQuery()){
				
				if(rset.next()) {
					boardNo = rset.getInt(1);
				}
				
			} catch (SQLException e) {
				throw new ShareBoardException(" share 게시판 > 게시글번호 조회 오류!", e);
			}
			return boardNo;
		}
		
// 첨부파일넣기 - dml 
// insertAttach = insert into attachment(no, board_no, original_filename, renamed_filename) values (seq_board_no.nextval,?,?,?)
// insertAttachment = insert into SHARE_attachment(attach_no, board_no, original_filename, renamed_filename) values (seq_ootd_attachment_no.nextval,?,?,?)

		public int insertAttachment(Connection conn, ShareAttachment attach) {
			String sql = prop.getProperty("insertAttachment");
			int result = 0; 
			
			try(PreparedStatement pstmt = conn.prepareStatement(sql)){ 
				pstmt.setInt(1, attach.getBoardNo());
				pstmt.setString(2, attach.getOriginalFilename());
				pstmt.setString(3, attach.getRenamedFilename());
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				throw new ShareBoardException("ootd게시판 > 첨부파일 등록 오류!", e);
			}
			
			return result;
		}

	
//모든 share첨부파일 가져오기 		
		public List<ShareAttachment> viewShareAttachment(Connection conn, Map<String, Object> param) {
			String sql = prop.getProperty("viewShareAttachment");
			List<ShareAttachment> shareAttachments = new ArrayList<>();
			
			int page = (int)param.get("page");
			int limit = (int)param.get("limit");
			int start = (page -1) * limit + 1;
			int end = page * limit;
			
			try( PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				try( ResultSet rset = pstmt.executeQuery()){
					
					while(rset.next()) {
						ShareAttachment shareAttachment = new ShareAttachment();
						
						shareAttachment.setAttachNo( rset.getInt("attach_no"));
						shareAttachment.setBoardNo( rset.getInt("board_no"));
						shareAttachment.setOriginalFilename(rset.getString("original_filename"));
						shareAttachment.setRenamedFilename(rset.getString("renamed_filename"));
						shareAttachment.setRegDate( rset.getDate("reg_date"));
						
						shareAttachments.add(shareAttachment);					
					}
				}
				
			} catch (SQLException e) {
				throw new ShareBoardException(" 전체 사진 목록 가져오기 실패!", e); 
			}
			
			return shareAttachments;
		}
		
		
// 전체페이지수조회 dql - select count(*) from share_attachment  
		public int getTotalCount(Connection conn) {
			String sql = prop.getProperty("getTotalCount");
			int totalCount = 0;
			
			try( PreparedStatement pstmt = conn.prepareStatement(sql);
					 ResultSet rset = pstmt.executeQuery(); ){
					 
				 if(rset.next()) {
					 totalCount = rset.getInt(1);
				 }
							
			}catch (SQLException e) {
				throw new ShareBoardException(" 전체 ootd 게시판 게시글 수 가져오기 실패!", e);
			}
			return totalCount;
		}

//모든 share 게시물 가져오기 	
		public List<ShareBoard>  viewShareBoard(Connection conn, Map<String, Object> param) {
			String sql = prop.getProperty("viewShareBoard");
			List<ShareBoard> shareboards = new ArrayList<>();
			
			int page = (int)param.get("page");
			int limit = (int)param.get("limit");
			int start = (page -1) * limit + 1;
			int end = page * limit;
			
			try( PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				try( ResultSet rset = pstmt.executeQuery()){
					
					while(rset.next()) {
						ShareBoard shareBoard = new ShareBoard();
						
						shareBoard.setShareNo(rset.getInt("share_no"));
						shareBoard.setMemberId(rset.getString("member_id"));
						shareBoard.setShareTitle(rset.getString("SAHRE_TITLE"));
						shareBoard.setShareContent(rset.getString("sahre_content"));
						shareBoard.setShareBuyDate(rset.getDate("SHARE_BUY_DATE"));
						shareBoard.setShareProductStatus(rset.getString("SHARE_PRODUCT_STATUS"));
						shareBoard.setShareCategory(rset.getString("SHARE_CATEGORY"));
						shareBoard.setShareState(rset.getString("SHARE_STATE") );
						shareBoard.setStyleNo( Style.valueOf( rset.getString("style")));
						
						shareboards.add(shareBoard);					
					}
				}
				
			} catch (SQLException e) {
				throw new ShareBoardException(" 전체 사진 게시물 목록 가져오기 실패! - only 목록만", e); 
			}
			
			return shareboards;
		}

}
