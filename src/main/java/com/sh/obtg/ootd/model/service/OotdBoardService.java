package com.sh.obtg.ootd.model.service;

import static com.sh.obtg.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.sh.obtg.ootd.model.dao.OotdBoardDao;
import com.sh.obtg.ootd.model.dto.OotdAttachment;
import com.sh.obtg.ootd.model.dto.OotdBoard;
import com.sh.obtg.ootd.model.dto.OotdBoardComment;

 public class OotdBoardService {
	private OotdBoardDao ootdBoardDao = new OotdBoardDao();
	
	
	// 1. ootdBoard게시판에 글 등록 하는거 - insert - dml 
	public int insertOotdBoard(OotdBoard ootdBoard) {
		Connection conn = getConnection();
		int result = 0;
		try {
			//게시글 등록은 변경없음 
			result = ootdBoardDao.insertBoard(conn, ootdBoard); //**트랜잭션1
			
			
			//방금 등록된 board.no컬럼값을 조회 - 시퀀스 객체의 현재값 
			int boardNo = ootdBoardDao.selectLastBoardNo(conn); // select seq_board_no.currval from dual //**트랜잭션2
			System.out.println("  boardNo : " +  boardNo );
			
			ootdBoard.setOotdNo(boardNo);//생성된 pk를 board객체에 다시 주입
			
			//첨부파일 등록은 반복문을 통해 여러번 처리되어야됨 
			List<OotdAttachment> ootdAttachments = ootdBoard.getOotdAttachments();
			
			if( !ootdAttachments.isEmpty() ) {
				for(OotdAttachment attach : ootdAttachments) {
					attach.setBoardNo(boardNo); //fk값 셋팅 필요 
					result = ootdBoardDao.insertAttachment(conn,attach);
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
	}

// dql  - page 에 나올 리스트 구하기    --- ( 5개씩은 나중에  )
	public List<OotdAttachment> selectOotdList(Map<String, Integer> param) {
		Connection conn = getConnection();
		List<OotdAttachment> ootdAttachments =  ootdBoardDao.selectOotdList(conn, param);
		close(conn);
		return ootdAttachments;
	}

	
// 전체 ootd 게시물 수(첨부파일 테이블) 조회 dql - select count(*) from OOTD_attachment 
	public int getTotalCount() {
		Connection conn = getConnection();
		int totalCount = ootdBoardDao.getTotalCount(conn);
		close(conn);
		return totalCount;
	}

// 모든 ootd 첨부파일 가져오기 select * from 	ootd_attachment 
	public List<OotdAttachment> viewOotdAttachment(Map<String, Object> param) {
		Connection conn = getConnection();
		List<OotdAttachment> ootdAttachments = ootdBoardDao.viewOotdAttachment(conn, param);
		close(conn);
		
		return ootdAttachments;
	}

//게시물 하나하나씩 조회하기
	
	public OotdBoard selectOneBoard(int no, boolean hasRead) {
		Connection conn = getConnection();
		//조회수 증가시키기 
		
		if(!hasRead) updateReadCount(no, conn);
		
			
	//	updateReadCount(no,conn);
		
		OotdBoard ootdboard  = ootdBoardDao.selectOneBoard(conn, no);
		List<OotdAttachment> ootdAttachments = ootdBoardDao.selectAttachmentByBoardNo(conn, no);
		ootdboard.setOotdAttachments( ootdAttachments);
		close(conn);
		
		return ootdboard;
	}
	
	private void updateReadCount(int no, Connection conn) {
		try {	
			int result = ootdBoardDao.updateReadCount(conn, no);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}
		
	}

	//댓글 조회하기 - select - dql 
	public List<OotdBoardComment> selectBoardCommentList(int boardNo) {
		Connection conn = getConnection();
		List<OotdBoardComment> comments = ootdBoardDao.selectBoardCommentList( conn, boardNo);
		close(conn);
		return comments;
	}
	// 댓글 등록 
//쿼리 : insert into OOTD_board_comment values(seq_OOTD_board_comment_no.nextval,?,?,?,?,?,default)
	public int insertBoardComment(OotdBoardComment boardComment) {
		Connection conn = getConnection();
		int result = 0;
		try{
			result = ootdBoardDao.insertBoardComment( conn, boardComment );
			commit(conn);
		}catch( Exception e) {
			rollback(conn);
			throw e;
		}finally {
			close(conn);
		}
		return result;
	}

	//댓글 삭제
	public int boardCommentDelete(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = ootdBoardDao.boardCommentDelete(conn, no);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}finally{
			close(conn);
		}
		
		return result;
	}

	// 업데이트 게시판에서 
	public OotdBoard selectOneBoard(int no) {
		return selectOneBoard(no, true); //true로 해야지 조회수증가안됨 

	}

}