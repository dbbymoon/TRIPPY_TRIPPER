package dao;

import java.util.List;
import java.util.Map;

import model.Companion;

public interface CompanionDao {
	
	//기본 CRUD
	public int insertCompanion(Companion companion);
	public int updateCompanion(Companion companion);
	public int deleteCompanion(int companionSeq);
	public Companion selectOneCompanion(int companionSeq);
	public List<Companion> selectAllCompanion(Map<String, Object> params);
	
	//추가메서드 : 메서드 기능 주석 달아주세요
	//동행 게시글 개수 조회
	public int getCount();
	
	//매칭된 동행인의 수를 카운트 하는 메서드
	public void updateCountMaching(Companion companion);
	
	//myPage에서 프로필 사진을 수정하면 companion에서도 프로필을 수정해야 함
	public void updateCompanionForProfile(Companion companion);
	
	//아이디로 글 삭제
	public void deleteCompanionById(String memberId);
}
