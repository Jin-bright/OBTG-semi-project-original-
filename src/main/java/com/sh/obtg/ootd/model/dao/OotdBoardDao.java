package com.sh.obtg.ootd.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.sh.obtg.ootd.model.dto.OotdAttachment;
import com.sh.obtg.ootd.model.dto.OotdBoard;
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


	
	


}
