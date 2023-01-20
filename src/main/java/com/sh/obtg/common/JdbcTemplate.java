package com.sh.obtg.common;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * 
 * static 자원을 사용하는 jdbc 공용클래스
 *
 */
public class JdbcTemplate {
	
	private static String driverClass;
	private static String url; // 지갑 
	private static String user;
	private static String password;
	
	static {
		// /build/classes/datasource.properties 내용 불러오기
		// / -> /build/classes
		final String datasourceConfigPath = JdbcTemplate.class.getResource("/datasource.properties").getPath();
		System.out.println( "**이건성공했니 ? " + datasourceConfigPath);
		Properties prop = new Properties();
		try {
			prop.load(new FileReader(datasourceConfigPath));
			driverClass = prop.getProperty("driverClass");
			url = prop.getProperty("url");
			user = prop.getProperty("user");
			password = prop.getProperty("password");
		} catch (IOException e) {
			e.printStackTrace();
		};
		
		try {
			// 1. driver class 등록 : 프로그램 실행시 최초 1회만 처리
			Class.forName(driverClass);
			System.out.println("★driver class 연결 성공  : " + driverClass );
		} catch (ClassNotFoundException e) {
			System.out.println("★driver class 연결 실패ㅠㅠ  : " + driverClass );

			e.printStackTrace();
		}
	}

	public static Connection getConnection() {
		// 2. Connection객체 생성(autoCommit false처리)
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(url, user, password);
			conn.setAutoCommit(false);
		} catch (Exception e) {
			System.out.println("★ conn 연결 실패ㅠㅠ  : " + conn );

			e.printStackTrace();
		}
		return conn;
	}

	public static void commit(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void rollback(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(Connection conn) {
		try {
			if(conn != null && !conn.isClosed())
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}

	/**
	 * Statement는 PreparedStatement의 부모 인터페이스이다.
	 * @param stmt
	 */
	public static void close(Statement stmt) {
		try {
			if(stmt != null && !stmt.isClosed())
				stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
	
	public static void close(ResultSet rset) {
		try {
			if(rset != null && !rset.isClosed())
				rset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
	
}
