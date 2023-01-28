package com.sh.obtg.report.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import com.sh.obtg.report.model.dto.Report;
import com.sh.obtg.report.model.exception.ReportException;

public class ReportDao {

private Properties prop = new Properties();
	
	public ReportDao() {
		String path = ReportDao.class.getResource("/sql/report/report-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("Column 쿼리 로드 완료! - " + prop);
	}

	public int insertReport(Connection conn, Report report) {
		// insert into report(report_no, reported_userId, board_no, report_reason) values ((select max(no) + 1 from noti), ?, ?, ?)
		String sql = prop.getProperty("insertReport");
		int result = 0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, report.getReportedUserId());
			pstmt.setInt(2, report.getBoardNo());
			pstmt.setString(3, report.getReportReason().name());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new ReportException("👻신고 접수 오류👻", e);
		}
		
		return result;
	}
}
