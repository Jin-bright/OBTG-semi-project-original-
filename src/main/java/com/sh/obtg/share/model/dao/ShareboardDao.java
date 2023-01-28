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

//게시글 한개 조회  dql  - select * from share_board where share_no = ? 
		public ShareBoard selectOneBoard(Connection conn, int no) {
			String sql = prop.getProperty("selectOneBoard");
			ShareBoard shareBoard = null;
			try(PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setInt(1, no);
				
				try(ResultSet rset = pstmt.executeQuery()){
					while(rset.next()) {
						shareBoard = new ShareBoard();
						
						shareBoard.setShareNo(no);
						shareBoard.setMemberId(rset.getString("member_id"));
						shareBoard.setShareTitle(rset.getString("SAHRE_TITLE"));
						shareBoard.setShareContent( rset.getString("SAHRE_CONTENT"));
						shareBoard.setShareReadCount(rset.getInt("SAHRE_READ_COUNT"));
						shareBoard.setShareRegDate(rset.getDate("SAHRE_REG_DATE"));
						shareBoard.setShareBuyDate(rset.getDate("SHARE_BUY_DATE"));
						shareBoard.setShareProductStatus(rset.getString("SHARE_PRODUCT_STATUS"));
						shareBoard.setShareCategory(rset.getString("SHARE_CATEGORY"));
						shareBoard.setShareState(rset.getString("SHARE_STATE"));
						shareBoard.setStyleNo( Style.valueOf( rset.getString("style")));
						
					}
				}
				
			} catch (Exception e) {
				throw new ShareBoardException(" share 게시글 한건 조회 오류!", e);
			}
			
			return shareBoard;
		}
//boardno로 첨부파일 테이블 조회 
		public List<ShareAttachment> selectAttachmentByBoardNo(Connection conn, int no) {
			String sql = prop.getProperty("selectAttachmentByBoardNo"); // select * from ootd_Attachment where board_no = ?
			List<ShareAttachment> shareAttachments = new ArrayList<>();
			try(PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setInt(1, no);
				
				try(ResultSet rset = pstmt.executeQuery()){
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
				
			} catch (Exception e) {
				throw new ShareBoardException("share 게시글 한건-(첨부파일테이블) 조회 오류!", e);
			}
			
			return shareAttachments;
		}

//update readcount 
		public int updateReadCount(Connection conn, int no) {
			String sql = prop.getProperty("updateReadCount");
			int result = 0;
			
			try( PreparedStatement pstmt = conn.prepareStatement(sql) ){
				pstmt.setInt(1, no);
				result = pstmt.executeUpdate();
			} catch (SQLException e) {
				throw new ShareBoardException("조회수 증가 오류!", e);
			}
			return result;
		}

//게시글 업데이트 - update 
//updateBoard = update share_board set sahre_title=?, sahre_content=?, share_buy_date=?, share_product_status=?, share_category=?, share_state = ?, style = ? where share_no = ?
		public int updateBoard(Connection conn, ShareBoard shareBoard) {
			String sql = prop.getProperty("updateBoardp");
			int result = 0;
			
			try(PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setString(1, shareBoard.getShareTitle() );
				pstmt.setString(2, shareBoard.getShareContent());
				pstmt.setDate(3, shareBoard.getShareBuyDate());
				pstmt.setString(4, shareBoard.getShareProductStatus());
				pstmt.setString(5, shareBoard.getShareCategory());
				pstmt.setString(6, shareBoard.getShareState() );
				pstmt.setString(7, shareBoard.getStyleNo().toString() );
				pstmt.setInt(8, shareBoard.getShareNo());
				
				result = pstmt.executeUpdate();
			}catch (SQLException e) {
				throw new ShareBoardException("게시물(글) 수정 오류!", e);
			}
			return result;
			
		}

//updateAttachment = update share_attachment set original_filename = ? , renamed_filename = ? where board_no = ?
		public int updateAttachment(Connection conn, ShareAttachment attach) {
			String sql = prop.getProperty("updateAttachment");
			int result = 0;

			try(PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setString(1, attach.getOriginalFilename());
				pstmt.setString(2,attach.getRenamedFilename());
				pstmt.setInt(3,attach.getBoardNo());
			
				result = pstmt.executeUpdate();
			}catch (SQLException e) {
				throw new ShareBoardException("게시물( 첨부파일 ) 수정 오류!", e);
			}
			return result;
		}

		public int deleteBoard(Connection conn, int no) {
			String sql = prop.getProperty("deleteBoard");
			int result = 0 ;
			
			try(PreparedStatement pstmt = conn.prepareStatement(sql)){ 
				pstmt.setInt(1, no);
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				throw new ShareBoardException("게시물( only ) 삭제 오류!", e);
			}
			
			return result;
		}

		// 좋아요 조회
		public int selectShareLike(Connection conn, Map<String, Object> param) {
			// select count(*) from SHARE_Likes where board_no = ? and member_id = ?
			String sql = prop.getProperty("selectShareLike");
			int likeCnt = 0;
			int boardNo = (int)param.get("boardNo");
			String memberId = (String)param.get("memberId");
			
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setInt(1, boardNo);
				pstmt.setString(2, memberId);
				
				try (ResultSet rset = pstmt.executeQuery()) {
					while(rset.next()) {
						likeCnt = rset.getInt(1);
					}
				}
				
			} catch (SQLException e) {
				throw new ShareBoardException("👻좋아요 조회 오류👻", e);
			}
			
			return likeCnt;
		}

		// 좋아요 입력(추가)
		public int insertShareLike(Connection conn, Map<String, Object> param) {
			// insert into SHARE_Likes values (seq_ootd_likes_no.nextval, ?, ?)
			String sql = prop.getProperty("insertShareLike");
			int result = 0;
			int boardNo = (int)param.get("boardNo");
			String memberId = (String)param.get("memberId");
			
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setInt(1, boardNo);
				pstmt.setString(2, memberId);
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				throw new ShareBoardException("👻좋아요 입력 오류👻", e);
			}
			
			return result;
		}

		// 좋아요 삭제
		public int deleteShareLike(Connection conn, int no) {
			// delete SHARE_Likes where board_no = ?
			String sql = prop.getProperty("deleteShareLike");
			int result = 0;
			
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setInt(1, no);
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				throw new ShareBoardException("👻좋아요 삭제 오류👻", e);
			}
			
			return result;
		}	
		
}
