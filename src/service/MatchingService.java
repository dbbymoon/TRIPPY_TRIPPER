package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CompanionDao;
import dao.MatchingDao;
import model.Companion;
import model.Matching;

@Service
public class MatchingService implements IMatchingService{

	@Autowired
	private MatchingDao matchingDao;
	@Autowired
	private CompanionDao companionDao;
	
	@Override
	//동행버튼(goWith)이 눌렸을 때 동행 목록에 추가하는 메서드
	public int insertMatching(Matching matching) {
		int result = 0;
	
		if(matchingDao.selectOneByIdAndSeq(matching)==null) {
			if(matchingDao.insertMatching(matching)>0) {
				result = 1;
			}
		}
		return result;
	}


	@Override
	//글이 삭제될 때 매칭도 함께 삭제 할 메서드
	public int deleteMatching(int companionSeq) {
		return matchingDao.deleteMatching(companionSeq);
	}


	@Override
	//매칭 상태를 수정하는 메서드
	public int updateMatching(Matching matching) {
		int result = 0;
		if(matching.getMatchingType().equals("allow")) {
			matching.setMatchingType("2");
			
		}else if(matching.getMatchingType().equals("cancel")) {
			matching.setMatchingType("1");
		}
		
		if(matchingDao.updateMatching(matching) >0) {
			Companion companion = new Companion();
			
//			System.out.println("글 번호  : "+matching.getCompanionSeq());
//			System.out.println("매칭된 사람의 수 : "+matchingDao.countMatching(matching));
			
			companion.setCompanionSeq(matching.getCompanionSeq());	//글 번호
			companion.setCompanionDeterminNum(matchingDao.countMatching(matching)); //matching상태가 2인 사람수를 카운트
			companionDao.updateCountMaching(companion);
			
			result = 1;
		}
		return result;
	}

	@Override
	//아이디로만 조회하는 메서드
	public List<Matching> selectOneById(String memberId) {
		return matchingDao.selectOneById(memberId);
	}


	@Override
	//아이디와 매칭 타입으로 조회하는 메서드
	//아이디와 매칭 타입으로 조회해서 해당 글번호와 + 나의 매칭 타입을 함께 Map으로 저장해야한다.
	public List<Companion> selectAllByIdAndType(Matching matching) {
		//아이디와 매칭 타입으로 조회
		List<Matching> mList = matchingDao.selectByIdAndType(matching);
		//글 정보를 저장할 List
		List<Companion> companionList = new ArrayList<Companion>();
		
		//매칭 리스트에서 하나씩 들고와서 글번호로 동행글 조회해서 두 정보를 하나의 Map에 담기
		for(Matching m : mList) {
			//해당 글의 번호
			int companionSeq = m.getCompanionSeq();
			Companion companion = companionDao.selectOneCompanion(companionSeq);
			//CompanionList에 담음
			companionList.add(companion);
		}
		
		return companionList;
	}


	@Override
	// 아이디와 글 번호로 삭제
	public int deleteMatchingbyIdAndSeq(Matching matching) {
		int result = 0;
		if(matchingDao.deleteMatchingByIdAndSeq(matching) > 0) {
			result = 1;
		}
		return result;
	}
}
