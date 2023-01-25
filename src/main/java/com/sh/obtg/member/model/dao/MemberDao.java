package com.sh.obtg.member.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.util.Properties;

import com.sh.obtg.member.model.dto.Member;

public class MemberDao {
	private Properties prop = new Properties();
	
	public MemberDao() {
		String path = MemberDao.class.getResource("/sql/member/member-query.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch(IOException e) {
			e.printStackTrace();
		}
		System.out.println("[query load 완료!]" + prop);
	}
	public Member selectOneMember(Connection conn, String memberId) {
		String sql = prop.getProperty("selectOneMember");
		
		return null;
	}

}
