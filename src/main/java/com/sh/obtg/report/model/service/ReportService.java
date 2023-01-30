package com.sh.obtg.report.model.service;

import static com.sh.obtg.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.sh.obtg.report.model.dao.ReportDao;
import com.sh.obtg.report.model.dto.Report;

public class ReportService {
	private ReportDao reportDao = new ReportDao();
	
	// 신고 접수
	public int insertReport(Report report) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = reportDao.insertReport(conn, report);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		}
		
		return result;
	}

	// 신고 내역 조회
	public List<Report> selectReportList(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Report> reports = reportDao.selectReportList(conn, param);
		close(conn);
		return reports;
	}

	public int selectTotalCount() {
		Connection conn = getConnection();
		int totalCount = reportDao.selectTotalCount(conn);
		close(conn);
		return totalCount;
	}

}
