package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CompanionDao;
import dao.MatchingDao;
import dao.TMemberDao;
import model.Companion;
import model.Matching;
import model.TMember;

@Service
public class CompanionService implements ICompanionService {

	@Autowired
	private CompanionDao companionDao;

	@Autowired
	private MatchingDao matchingDao;
	
	@Autowired
	private TMemberDao tMemberDao;
	
	@Override
	// 동행 게시글 추가하는 메서드
	public int insertCompanion(Companion companion, Matching matching) {

		int result = 0;

		if (companionDao.insertCompanion(companion) > 0) {
			matching.setCompanionSeq(companion.getCompanionSeq());
			matching.setMatchingType("2");
			matchingDao.insertMatching(matching);
			result = 1;
		}
		return result;
	}

	@Override
	// 모든 동행글 또는 검색한 동행글 가져오는 메서드
	public List<Companion> getAllCompanionList(Map<String, Object> params) {
		return companionDao.selectAllCompanion(params);
	}

	@Override
	// 전체 동행 게시글의 수 구하기
	public int getCompanionListCount() {
		return companionDao.getCount();
	}

	@Override
	// 게시글 번호로 게시글 하나 검색(가져오기)
	public Companion selectCompanionByNum(int companionSeq) {
		return companionDao.selectOneCompanion(companionSeq);
	}

	@Override
	public int updateCompanion(Companion companion) {
		int result = 0;

		if (companionDao.updateCompanion(companion) > 0) {
			result = 1;
		}
		return result;
	}

	@Override
	public int deleteCompanion(int companionSeq) {
		return companionDao.deleteCompanion(companionSeq);
	}

	@Override
	public List<Map<String, Object>> getGowithList(int companionSeq) {
		//Matching 리스트를 가져옴
		
		List<Matching> mList = matchingDao.selectAllMatchingBySeq(companionSeq);
		List<Map<String, Object>> tMemberMatchingList = new ArrayList<Map<String, Object>>();
		
		for(Matching m : mList) {
			//Matching 리스트의 z를 이용해
			//TMember 정보를 가져옴
			//가져온 TMemberList에서 멤버의 프로필(memberProfile), 아이디(memberId)
			//MatchingList의 글번호(companionSeq), 매칭타입(matchingType)을 Map형태로 저장.
			
			Map<String, Object> map = new HashMap<String, Object>();
			Matching matching = new Matching();
			matching.setCompanionSeq(companionSeq);
			matching.setMemberId(tMemberDao.selectOneMember(m.getMemberId()).getMemberId());
			
			map.put("memberProfile", tMemberDao.selectOneMember(m.getMemberId()).getMemberProfile());
			map.put("memberId", tMemberDao.selectOneMember(m.getMemberId()).getMemberId());
			map.put("companionSeq", companionSeq);
			map.put("matchingType", matchingDao.selectOneByIdAndSeq(matching).getMatchingType());
			tMemberMatchingList.add(map);
		}
		
		return tMemberMatchingList;
	}


}
