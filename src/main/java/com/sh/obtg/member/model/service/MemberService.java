package com.sh.obtg.member.model.service;

import static com.sh.obtg.common.JdbcTemplate.*;

import java.sql.Connection;

import com.sh.obtg.member.model.dao.MemberDao;
import com.sh.obtg.member.model.dto.Member;

public class MemberService {
	
	private MemberDao memberDao = new MemberDao();

	public Member selectOneMember(String memberId) {
		Connection conn = getConnection();
		System.out.println(conn);
		Member member = memberDao.selectOneMember(conn, memberId);
		close(conn);
		return member;
	}

}
