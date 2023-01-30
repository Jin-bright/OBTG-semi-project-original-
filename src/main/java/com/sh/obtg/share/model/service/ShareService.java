package com.sh.obtg.share.model.service;

import static com.sh.obtg.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.sh.obtg.share.model.dao.ShareboardDao;
import com.sh.obtg.share.model.dto.ShareAttachment;
import com.sh.obtg.share.model.dto.ShareBoard;
import com.sh.obtg.share.model.dto.ShareBoardAndAttachment;


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


	// update용 게시물 하나 조회 
	public ShareBoard selectOneBoard(int no) {
		return selectOneBoard(no, true); //조회수 증가안되게 하고 하나 게시물 가져옴
	}


	//게시글 update - dml 트랜잭션 처리 필요 
	public int updateBoard(ShareBoard shareBoard) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// 1. board 수정
			result = shareBoardDao.updateBoard(conn, shareBoard);
			
			// 2.attachment에 등록 (== 수정업데이트 ) 
			List<ShareAttachment> attachments = shareBoard.getShareAttachments(); //하나 받아와서 
			System.out.println("**attachments 정보 : "  + attachments );
			if(!attachments.isEmpty()) {
				for(ShareAttachment attach : attachments) {
					result = shareBoardDao.updateAttachment(conn, attach); // attachment update 
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

//첨부파일 share no로 조회 
	public List<ShareAttachment> selectAttachmentByBoardNo(int no) {
		Connection conn = getConnection();
		List<ShareAttachment> attachment  = shareBoardDao.selectAttachmentByBoardNo(conn, no);
		
		return attachment;
	}

// 게시글 지우기 
	public int deleteBoard(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {	
			result = shareBoardDao.deleteBoard(conn, no);
			commit(conn);
		}catch(Exception e) {
			rollback(conn);
			throw e;
		}
		
		return result;
	}

	// 좋아요 조회
	public int selectShareLike(Map<String, Object> param) {
		Connection conn = getConnection();
		int likeCnt = shareBoardDao.selectShareLike(conn, param);
		close(conn);
		return likeCnt;
	}

	// 좋아요 입력(추가)
	public int insertShareLike(Map<String, Object> param) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = shareBoardDao.insertShareLike(conn, param);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}
		
		return result;
	}

	// 좋아요 삭제
	public int deleteShareLike(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = shareBoardDao.deleteShareLike(conn, no);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}
		
		return result;
	}


	// keyword로 검색 조인쿼리
	public List<ShareBoardAndAttachment> searchShareBykeyWord(Map<String, String> param) {
		Connection conn = getConnection();
		List<ShareBoardAndAttachment> shareBoardAndAttachments = shareBoardDao.searchShareBykeyWord(conn, param);
		close(conn);
		return shareBoardAndAttachments;
	}
	
}
