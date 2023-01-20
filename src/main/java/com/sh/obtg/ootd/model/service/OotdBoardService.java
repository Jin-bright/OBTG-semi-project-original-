package com.sh.obtg.ootd.model.service;

import com.sh.obtg.ootd.model.dao.OotdBoardDao;
import com.sh.obtg.ootd.model.dto.OotdAttachment;
import com.sh.obtg.ootd.model.dto.OotdBoard;

import static com.sh.obtg.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;



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

}
