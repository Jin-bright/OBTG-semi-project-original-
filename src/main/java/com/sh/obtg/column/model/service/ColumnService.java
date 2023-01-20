package com.sh.obtg.column.model.service;

import static com.sh.obtg.common.JdbcTemplate.*;
import java.sql.Connection;

import com.sh.obtg.column.model.dao.ColumnDao;
import com.sh.obtg.column.model.dto.Column;

public class ColumnService {
	private ColumnDao columnDao = new ColumnDao();
	
	public int insertColumn(Column column) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = columnDao.insertColumn(conn, column);
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
