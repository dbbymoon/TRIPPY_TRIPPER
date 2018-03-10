package dao;

import java.util.List;

import model.Matching;

public interface MatchingDao {
	
	//기본 CRUD
	public int insertMatching(Matching matching);
	public int updateMatching(Matching matching);
	public int deleteMatching(int companionSeq);
	public List<Matching> selectAllMatchingBySeq(int companionSeq);
	public List<Matching> selectAllMatching();
	
	//아이디와 글 번호로 동일인 조회
	public Matching selectOneByIdAndSeq(Matching matching);
	//해당 글에 매칭된 사람의 수를 반환하는 메서드
	public int countMatching(Matching matching);
	//아이디로 삭제
	public int deleteMatchingById(String memberId);
	//아이디로만 조회
	public List<Matching> selectOneById(String memberId);
	//아이디와 매칭 타입으로 조회
	public List<Matching> selectByIdAndType(Matching matching);
	//아이디와 글번호로 삭제
	public int deleteMatchingByIdAndSeq(Matching matching);
}
