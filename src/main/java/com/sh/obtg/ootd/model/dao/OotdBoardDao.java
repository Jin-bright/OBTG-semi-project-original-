package com.sh.obtg.ootd.model.dao;

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


import com.sh.obtg.ootd.model.dto.OotdAttachment;
import com.sh.obtg.ootd.model.dto.OotdBoard;
import com.sh.obtg.ootd.model.dto.OotdBoardComment;
import com.sh.obtg.ootd.model.dto.Style;
import com.sh.obtg.ootd.model.exception.OotdBoardException;

public class OotdBoardDao {
	//최초 설정 
	Properties prop = new Properties();
	
	public OotdBoardDao() {
		System.out.println("왜?");
		String path = OotdBoardDao.class.getResource("/sql/ootd/ootdBoard-query.properties").getPath(); // 이게 빌드패스 경로래 -- 절대경로 
		System.out.println("path : " + path);
		try {
			prop.load( new FileReader(path));
		} catch (IOException e) {
			System.out.println("path 오류 ");
			e.printStackTrace();
		}
		System.out.println("[ootdboard-query 준비완료] + prop ");
	}

	// result = ootdBoardDao.insertBoard(conn, ootdBoard); //**트랜잭션1	
	public int insertBoard(Connection conn, OotdBoard ootdBoard) {
		String sql = prop.getProperty("insertBoard");
		int result =0;
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, ootdBoard.getOotdWriter());
			pstmt.setString(2, ootdBoard.getStyleNo().toString());
			pstmt.setString(3, ootdBoard.getOOTDTitle());
			pstmt.setString(4, ootdBoard.getOOTDContents());
			pstmt.setString(5, ootdBoard.getOOTDTop());
			pstmt.setString(6, ootdBoard.getOOTDBottom());
			pstmt.setString(7, ootdBoard.getOOTDShoes());
			pstmt.setString(8, ootdBoard.getOOTDEtc());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new OotdBoardException("ootd 게시판 > 게시글 등록 오류", e);
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
			throw new OotdBoardException("ootd게시판 > 게시글번호 조회 오류!", e);
		}
		return boardNo;
	}

//첨부파일넣기 - dml 
//insertAttach = insert into attachment(no, board_no, original_filename, renamed_filename) values (seq_board_no.nextval,?,?,?)
	public int insertAttachment(Connection conn, OotdAttachment attach) {
		String sql = prop.getProperty("insertAttachment");
		int result = 0; 
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){ 
			pstmt.setInt(1, attach.getBoardNo());
			pstmt.setString(2, attach.getOriginalFilename());
			pstmt.setString(3, attach.getRenamedFilename());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new OotdBoardException("ootd게시판 > 첨부파일 등록 오류!", e);
		}
		
		return result;
	}

// dql 사진목록 출력하기 
// 쿼리 : 	
	public List<OotdAttachment> selectOotdList(Connection conn,  Map<String, Integer> param) {
		String sql = prop.getProperty("selectOotdList");
		List<OotdAttachment> ootdAttachments = new ArrayList<>();
		try( PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, param.get("start"));
			pstmt.setInt(2, param.get("end"));
			
			try( ResultSet rset = pstmt.executeQuery()){
				
				while(rset.next()) {
					OotdAttachment ootdAttachment = new OotdAttachment();
					
					ootdAttachment.setAttachNo( rset.getInt("attach_no"));
					ootdAttachment.setBoardNo( rset.getInt("board_no"));
					ootdAttachment.setOriginalFilename(rset.getString("original_filename"));
					ootdAttachment.setRenamedFilename(rset.getString("renamed_filename"));
					ootdAttachment.setRegDate( rset.getDate("reg_date"));
					
					ootdAttachments.add(ootdAttachment);					
				}
			}
			
		} catch (SQLException e) {
			throw new OotdBoardException(" 전체 사진 목록 가져오기 실패!", e); 
		}
		
		return ootdAttachments;
	}
	
// 전체페이지수조회 dql - select count(*) from OOTD_attachment  
	public int getTotalCount(Connection conn) {
		String sql = prop.getProperty("getTotalCount");
		int totalCount = 0;
		
		try( PreparedStatement pstmt = conn.prepareStatement(sql);
				 ResultSet rset = pstmt.executeQuery(); ){
				 
			 if(rset.next()) {
				 totalCount = rset.getInt(1);
			 }
						
		}catch (SQLException e) {
			throw new OotdBoardException(" 전체 ootd 게시판 게시글 수 가져오기 실패!", e); 
		}
		
		return totalCount;
	}

	
	
// 모든 ootd 첨부파일 가져오기 select * from 	ootd_attachment 
	public List<OotdAttachment> viewOotdAttachment(Connection conn, Map<String, Object> param) {
		String sql = prop.getProperty("selectOotdList");
		List<OotdAttachment> ootdAttachments = new ArrayList<>();
		
		int page = (int)param.get("page");
		int limit = (int)param.get("limit");
		int start = (page -1) * limit + 1;
		int end = page * limit;
		
		try( PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			try( ResultSet rset = pstmt.executeQuery()){
				
				while(rset.next()) {
					OotdAttachment ootdAttachment = new OotdAttachment();
					
					ootdAttachment.setAttachNo( rset.getInt("attach_no"));
					ootdAttachment.setBoardNo( rset.getInt("board_no"));
					ootdAttachment.setOriginalFilename(rset.getString("original_filename"));
					ootdAttachment.setRenamedFilename(rset.getString("renamed_filename"));
					ootdAttachment.setRegDate( rset.getDate("reg_date"));
					
					ootdAttachments.add(ootdAttachment);					
				}
			}
			
		} catch (SQLException e) {
			throw new OotdBoardException(" 전체 사진 목록 가져오기 실패!", e); 
		}
		
		return ootdAttachments;
	}

	//조회수 올리기 
	public int updateReadCount(Connection conn, int no) {
		String sql = prop.getProperty("updateReadCount");
		int result = 0;
		
		try( PreparedStatement pstmt = conn.prepareStatement(sql) ){
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new OotdBoardException("조회수 증가 오류!", e);
		}
		return result;
	}

// 게시글 한건조회 - board !
	public OotdBoard selectOneBoard(Connection conn, int no) {
		String sql = prop.getProperty("selectOneBoard");
		OotdBoard ootdboard = null;
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, no);
			
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					ootdboard = new OotdBoard();
					
					ootdboard.setOotdNo( rset.getInt("OOTD_no"));
					ootdboard.setOotdWriter( rset.getString("OOTD_writer"));
					ootdboard.setStyleNo(Style.valueOf( rset.getString("style_no") ));
					ootdboard.setOOTDTitle(rset.getString("OOTD_title"));
					ootdboard.setOOTDContents( rset.getString("OOTD_contents"));
					ootdboard.setOOTDReadCount( rset.getInt("OOTD_read_count"));
					ootdboard.setOOTDRegDate( rset.getDate("OOTD_reg_date") );
					ootdboard.setOOTDTop( rset.getString("OOTD_top"));
					ootdboard.setOOTDBottom( rset.getString("OOTD_bottom"));
					ootdboard.setOOTDShoes( rset.getString("OOTD_shoes"));
					ootdboard.setOOTDEtc(rset.getString("OOTD_etc") );
				}
			}
			
		} catch (Exception e) {
			throw new OotdBoardException(" ootd 게시글 한건 조회 오류!", e);
		}
		
		return ootdboard;
	}

// 게시글 한건조회 - board 에서 첨부파일! ( boardNo랑 매칭되는거 )
	public List<OotdAttachment> selectAttachmentByBoardNo(Connection conn, int boardNo) {
		String sql = prop.getProperty("selectAttachmentByBoardNo"); // select * from ootd_Attachment where board_no = ?
		List<OotdAttachment> ootdAttachments = new ArrayList<>();
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, boardNo);
			
			try(ResultSet rset = pstmt.executeQuery()){
				while(rset.next()) {
					OotdAttachment attach = handleAttachmentResultSet(rset);
					ootdAttachments.add(attach);
				}
			}
			
		} catch (Exception e) {
			throw new OotdBoardException("게시글 한건-첨부파일 조회 오류!", e);
		}
		
		return ootdAttachments;
	}
	
	
	private OotdAttachment handleAttachmentResultSet(ResultSet rset) throws SQLException {
		OotdAttachment attach = new OotdAttachment();
		attach.setAttachNo( rset.getInt("attach_no"));
		attach.setBoardNo(rset.getInt("board_no"));
		attach.setOriginalFilename(rset.getString("original_filename"));
		attach.setRenamedFilename(rset.getString("renamed_filename"));
		attach.setRegDate(rset.getDate("reg_date"));
		return attach;
	}


//댓글조회하기 - 	
	public List<OotdBoardComment> selectBoardCommentList(Connection conn, int boardNo) {
		String sql = prop.getProperty("selectBoardCommentList");
		List<OotdBoardComment>  comments = new ArrayList<>();
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, boardNo);
			try(ResultSet rset = pstmt.executeQuery()){
				while( rset.next()) {
			
					OotdBoardComment bc = new OotdBoardComment();
					bc.setCmtNo(rset.getInt("cmt_no"));
					bc.setBoardNo( rset.getInt("board_no"));
					bc.setMemberId( rset.getString("member_id"));
					bc.setCmtLevel(rset.getInt("cmt_level"));
					bc.setCmtContent( rset.getString("cmt_content"));
					bc.setCmtRegDate(rset.getDate("cmt_reg_date"));
					bc.setCommentRef(rset.getInt("comment_ref"));
					comments.add(bc);
				}
			}//
		} catch (Exception e) {
			throw new OotdBoardException("댓글조회오류!", e);
		}		
		return comments;
	}
	
// 댓글 등록 
//주의 : comment_ref 컬럼값 셋팅시 , 0이면 setInt 안되서 setObject 사용해서 0이면 null을 대입할수있도록 한다 
//쿼리 : insert into board_comment values(seq_board_comment_no.nextval,?,?,?,?,default,?) where boardNo = ? 
	public int insertBoardComment(Connection conn, OotdBoardComment boardComment) {
		String sql = prop.getProperty("insertBoardComment");
		int result = 0;
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, boardComment.getBoardNo());
			pstmt.setString(2,boardComment.getMemberId());
			pstmt.setInt(3, boardComment.getCmtLevel() );
			pstmt.setString(4, boardComment.getCmtContent() ); //  board_no
			pstmt.setObject(5, (boardComment.getCommentRef() == 0) ?  null : boardComment.getCommentRef()  ); //   comment_ref number

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new OotdBoardException("댓글 등록 오류!", e);
		}
		return result;	

	}

	public int boardCommentDelete(Connection conn, int no) {
		String sql = prop.getProperty("boardCommentDelete");
		int result = 0;
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new OotdBoardException("댓글 삭제 오류!", e);
		}
		return result;
	}
}

	
	



