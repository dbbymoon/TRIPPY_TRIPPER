package dao;

import java.util.List;
import java.util.Map;

import model.TMember;


public interface TMemberDao {

	//기본 CRUD
	public int insertMember(TMember tMember);
	public int updateMember(TMember tMember);
	public int deleteMember(String memberId);
	public TMember selectOneMember(String memberId);
	public List<TMember> selectAllMember();
	
	// 이메일로 회원 조회
	public TMember selectOneMemberByEmail(String memberEmail);
	// join Detail - Profile
	public int updateMemberForProfile(TMember tMember);
	// join Detail
	public int updateMemberForJoin(TMember tMember);
	// 첨부파일 첨부를 위한 메서드
	public int insertAttach(Map<String, Object> params);
	
	
}
