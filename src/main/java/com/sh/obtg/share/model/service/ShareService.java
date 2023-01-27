package com.sh.obtg.share.model.service;

import static com.sh.obtg.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.sh.obtg.share.model.dao.ShareboardDao;
import com.sh.obtg.share.model.dto.ShareAttachment;
import com.sh.obtg.share.model.dto.ShareBoard;


public class ShareService {
	private ShareboardDao shareBoardDao = new ShareboardDao();

	public int insertShareBoard(ShareBoard shareBoard) {
		Connection conn = getConnection();
		int result = 0;
		try {
			//게시글 등록은 변경없음 
			result = shareBoardDao.insertShareBoard(conn, shareBoard); //**트랜잭션1
			
			
			//방금 등록된 board.no컬럼값을 조회 - 시퀀스 객체의 현재값 
			int boardNo = shareBoardDao.selectLastBoardNo(conn); // select seq_board_no.currval from dual //**트랜잭션2
			System.out.println("  boardNo : " +  boardNo );
			
			shareBoard.setShareNo(boardNo);//생성된 pk를 board객체에 다시 주입
			
			//첨부파일 등록은 반복문을 통해 여러번 처리되어야됨 
			List<ShareAttachment> shareAttachments = shareBoard.getShareAttachments();
			
			if( !shareAttachments.isEmpty() ) {
				for(ShareAttachment attach : shareAttachments) {
					attach.setBoardNo(boardNo); //fk값 셋팅 필요 
					result = shareBoardDao.insertAttachment(conn,attach);
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

	
// 모든 share  첨부파일 가져오기 select * from share_attachment 
	public List<ShareAttachment> viewShareAttachment(Map<String, Object> param) {
		Connection conn = getConnection();
		List<ShareAttachment>  shareAttachments = shareBoardDao.viewShareAttachment(conn, param);
		close(conn);
		
		return shareAttachments;
	}

// 전체 share 게시물 수(첨부파일 테이블) 조회 dql - select count(*) from share_attachment 
	public int getTotalCount() {
		Connection conn = getConnection();
		int totalCount = shareBoardDao.getTotalCount(conn);
		return totalCount;
	}

// 전체 share 게시물 수 조회 dql - select count(*) from share_board 
	public List<ShareBoard> viewShareBoards(Map<String, Object> param) {
		Connection conn = getConnection();
		List<ShareBoard> shareboards = shareBoardDao.viewShareBoard(conn, param);
		close(conn);
		
		return shareboards;
	}


//게시글 한개 조회  dql  - select * from share_board where share_no = ? 
	public ShareBoard selectOneBoard(int no, boolean hasRead) {
		Connection conn = getConnection();

		//조회수 증가시키기 
		if(!hasRead) updateReadCount(no, conn);

		ShareBoard shareBoard  = shareBoardDao.selectOneBoard(conn, no);
		List<ShareAttachment> shareAttachments = shareBoardDao.selectAttachmentByBoardNo(conn, no);
		shareBoard.setShareAttachments(shareAttachments);
		
		close(conn);
		
		return shareBoard; //게시글 한개 
	}
	
	//updateReadCount
	private void updateReadCount(int no, Connection conn) {
		try {	
			int result = shareBoardDao.updateReadCount(conn, no);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}
		
	}
	
}
