package com.sh.obtg.member.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.sh.obtg.member.model.dto.Gender;
import com.sh.obtg.member.model.dto.Member;
import com.sh.obtg.member.model.dto.MemberRole;
import com.sh.obtg.member.model.exception.MemberException;
import com.sh.obtg.ootd.model.dto.OotdBoard;
import com.sh.obtg.ootd.model.dto.Style;
import com.sh.obtg.share.model.dto.ShareBoard;

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
	

	public int updatePassword(Connection conn, Member member) {
		int result = 0;
		String sql = prop.getProperty("updatePassword");
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getMemberId());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new MemberException("비밀번호 수정 오류!", e);
		}
		return result;
	}
	

	public int updateMemberRole(Connection conn, String memberId, String memberRole) {
		String sql = prop.getProperty("updateMemberRole");
		int result = 0;
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberRole);
			pstmt.setString(2, memberId);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new MemberException("관리자 회원권한수정 오류",e);
		}
		
		return result;
	}
	public List<Member> searchMember(Connection conn, Map<String, String> param) {
		List<Member> members = new ArrayList<>();
		String searchType = param.get("searchType"); // member_id | member_name | gender
		String searchKeyword = param.get("searchKeyword");
		String sql = prop.getProperty("searchMember"); // select * from member where # like ?
		sql = sql.replace("#", searchType);
		System.out.println(sql);
		
		// 1. PreaparedStatement 객체 생성 & 미완성쿼리 값대입
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, "%" + searchKeyword + "%"); 
			// 2. 실행 & ResultSet 반환
			try(ResultSet rset = pstmt.executeQuery()){				
				// 3. ResultSet -> List<Member>
				while(rset.next())
					members.add(handleMemberResultSet(rset));
			}
		} catch (SQLException e) {
			throw new MemberException("관리자 회원검색 오류", e);
		}
		
		return members;
	}
	public List<Member> selectAllMember(Connection conn, Map<String, Object> param) {
		String sql = prop.getProperty("selectAllMember"); // select * from (select row_number() over(order by enroll_date desc) rnum, m.* from member m) where rnum between ? and ?
		List<Member> members = new ArrayList<>();
		int page = (int) param.get("page");
		int limit = (int) param.get("limit");
		int start = (page - 1) * limit + 1; 
		int end = page * limit;
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			try(ResultSet rset = pstmt.executeQuery();){
				
				while(rset.next()) {
					Member member = handleMemberResultSet(rset);
					members.add(member);
				}
			}
			
			
		} catch (SQLException e) {
			throw new MemberException("관리자 회원목록조회 오류!", e);
		}
				
		return members;
	}
	public int selectTotalCount(Connection conn) {
		String sql = prop.getProperty("selectTotalCount"); // select count(*) from member
		int totalCount = 0;
		
		try(
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();	
		){
			while(rset.next())
				totalCount = rset.getInt(1); // 컬럼인덱스
	
		} catch (SQLException e) {
			throw new MemberException("전체 사용자수 조회 오류", e);
		}	
		
		return totalCount;
	}	
	public int deleteMemberAD(Connection conn, String memberId) {
		String sql = prop.getProperty("deleteMemberAD");
		int result = 0;
		
		try(PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, memberId);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw new MemberException("회원 추방에 실패했습니다.", e);
		}
		return result;
	}
	public int updateMember(Connection conn, Member member) {
		String sql = prop.getProperty("updateMember");
		int result = 0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, member.getStyle());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getPhone());
			pstmt.setDate(5, member.getBirthday());
			pstmt.setString(6, member.getNickname());
			pstmt.setString(7, member.getGender().name());
			pstmt.setString(8, member.getIntroduce());
			pstmt.setString(9, member.getOriginal());
			pstmt.setString(10, member.getRenamed());
			pstmt.setString(11, member.getMemberId());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new MemberException("회원정보 수정 오류", e);
		}
		return result;
	}
	public int insertMember(Connection conn, Member member) {
		String sql = prop.getProperty("insertMember");
		int result = 0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getStyle());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getPassword());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getPhone());
			pstmt.setDate(7, member.getBirthday());
			pstmt.setString(8, member.getNickname());
			pstmt.setString(9, member.getGender().name());
			pstmt.setString(10, member.getIntroduce());
			pstmt.setString(11, member.getOriginal());
			pstmt.setString(12, member.getRenamed());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new MemberException("회원가입오류", e);
		}
		
		return result;
	}
	public int deleteMember(Connection conn, String memberId) {
		int result = 0;
		String sql = prop.getProperty("deleteMember");

		try(PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, memberId);
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			throw new MemberException("회원탈퇴 오류", e);
		}

		return result;
	
}
	// 내가 쓴 ootd 게시글 수
	public int selectMyOotdPostCnt(Connection conn, String memberId) {
		// select count(*) from ootd_board where ootd_writer = ?
		String sql = prop.getProperty("selectMyOotdPostCnt");
		int count = 0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next())
					count = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			throw new MemberException("👻내가 쓴 ootd 게시글 수 조회 오류👻", e);
		}
		
		return count;
	}
	
	// 내가 쓴 share 게시글 수
	public int selectMySharePostCnt(Connection conn, String memberId) {
		// select count(*) from share_board where member_id = ?
		String sql = prop.getProperty("selectMySharePostCnt");
		int count = 0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next())
					count = rset.getInt(1);
			}
			
		} catch (SQLException e) {
			throw new MemberException("👻내가 쓴 share 게시글 수 조회 오류👻", e);
		}
		
		return count;
	}
	
	// 내가 쓴 ootd글 조회
	public List<OotdBoard> selectMyOotdPost(Connection conn, String memberId, Map<String, Object> param) {
		// select * from ootd_board where ootd_writer = ?
		String sql = prop.getProperty("selectMyOotdPost");
		List<OotdBoard> ootdBoardList = new ArrayList<>();
		int page = (int)param.get("page");
		int limit = (int)param.get("limit");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			pstmt.setInt(2, page);
			pstmt.setInt(3, limit);
			
			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					OotdBoard ob = new OotdBoard();
					ob.setOotdNo( rset.getInt("OOTD_no"));
					ob.setOOTDTitle(rset.getString("OOTD_title"));
					ob.setOOTDReadCount( rset.getInt("OOTD_read_count"));
					ob.setOOTDRegDate( rset.getDate("OOTD_reg_date") );
					ootdBoardList.add(ob);
				}
			}
			
		} catch (SQLException e) {
			throw new MemberException("👻내가 쓴 ootd 게시물 조회 오류👻", e);
		}
		
		return ootdBoardList;
	}
	
	// 내가 쓴 share글 조회
	public List<ShareBoard> selectMySharePost(Connection conn, String memberId, Map<String, Object> param) {
		// where member_id = ? and rnum between ? and ?
		String sql = prop.getProperty("selectMySharePost");
		List<ShareBoard> shareBoardList = new ArrayList<>();
		int page = (int)param.get("page");
		int limit = (int)param.get("limit");
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, memberId);
			pstmt.setInt(2, page);
			pstmt.setInt(3, limit);

			try (ResultSet rset = pstmt.executeQuery()) {
				while(rset.next()) {
					ShareBoard sb = new ShareBoard();
					sb.setShareNo(rset.getInt("SHARE_no"));
					sb.setShareTitle(rset.getString("SAHRE_TITLE"));
					sb.setShareReadCount(rset.getInt("SAHRE_READ_COUNT"));
					sb.setShareRegDate(rset.getDate("SAHRE_REG_DATE"));
					sb.setShareState(rset.getString("SHARE_STATE"));
					shareBoardList.add(sb);
				}
				
			}
			
		} catch (SQLException e) {
			throw new MemberException("👻내가 쓴 share 게시물 조회 오류👻", e);
		}
		
		return shareBoardList;
	}
}
