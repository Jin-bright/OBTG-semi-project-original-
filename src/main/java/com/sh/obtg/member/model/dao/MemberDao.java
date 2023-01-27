package com.sh.obtg.member.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.sh.obtg.member.model.dto.Gender;
import com.sh.obtg.member.model.dto.Member;
import com.sh.obtg.member.model.dto.MemberRole;

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
		Member member = null;
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberId);
			try(ResultSet rset = pstmt.executeQuery()){
				if(rset.next()) {
					member = handleMemberResultSet(rset);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return member;
	}
	
	private Member handleMemberResultSet(ResultSet rset) throws SQLException {
		Member member = new Member();
		member.setMemberId(rset.getString("member_id"));
		member.setStyle(rset.getString("style"));
		member.setName(rset.getString("name"));
		member.setPassword(rset.getString("password"));
		member.setEmail(rset.getString("email"));
		member.setPhone(rset.getString("phone"));
		member.setBirthday(rset.getDate("birthday"));
		member.setEnrollDate(rset.getTimestamp("enroll_date"));
		member.setMemberRole(MemberRole.valueOf(rset.getString("member_role")));
		member.setNickname(rset.getString("nickname"));
		
		System.out.println("[" + rset.getString("gender") + "]");
		member.setGender(rset.getString("gender") != null ? 
				Gender.valueOf(rset.getString("gender")) : null);
		member.setIntroduce(rset.getString("introduce"));
		member.setOriginal(rset.getString("original"));
		member.setRenamed(rset.getString("renamed"));		
		return member;
	}
	

}
