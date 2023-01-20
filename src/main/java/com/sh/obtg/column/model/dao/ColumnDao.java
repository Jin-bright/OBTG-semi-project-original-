package com.sh.obtg.column.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Properties;

import com.sh.obtg.column.model.dto.Column;
import com.sh.obtg.column.model.exception.ColumnException;

public class ColumnDao {

	private Properties prop = new Properties();
	
	public ColumnDao() {
		String path = ColumnDao.class.getResource("/sql/column/column-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("Column 쿼리 로드 완료! - " + prop);
	}
	
	/**
	 * 컬럼 저장
	 * @param conn
	 * @param column
	 * @return
	 */
	public int insertColumn(Connection conn, Column column) {
		// insert into obtg_column values (seq_column_no.nextval, ?, ?, ?, ?, ?, default, default)
		String sql = prop.getProperty("insertColumn");
		int result = 0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, column.getWriter());
			pstmt.setString(2, column.getTitle());
			pstmt.setString(3, column.getContent());
			pstmt.setString(4, column.getOriginalFilename());
			pstmt.setString(5, column.getRenamedFilename());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new ColumnException("컬럼 저장 오류", e);
		}	
		return result;
	}

}
