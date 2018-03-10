package service;

import java.util.List;
import java.util.Map;

import model.Companion;
import model.Matching;

public interface IMatchingService {
	//동행버튼(goWith)가 눌렸을 때 동행 목록에 추가하는 메서드
	public int insertMatching(Matching matching);
	//matching 정보를 삭제하는 메서드
	public int deleteMatching(int companionSeq);
	//matching 타입을 를 수정하는 메서드
	public int updateMatching(Matching matching);
	//아이디로만 조회하는 메서드
	public List<Matching> selectOneById(String memberId);
	//아이디와 매칭 타입으로 검색하는 메서드
	public List<Companion> selectAllByIdAndType(Matching matching);
	//아이디와 글번호로 삭제
	public int deleteMatchingbyIdAndSeq(Matching matching);
}
