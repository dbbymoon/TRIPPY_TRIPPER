package service;

import java.util.List;
import java.util.Map;

import model.Companion;
import model.Matching;
import model.TMember;

public interface ICompanionService {
	//새로운 동행 게시글 등록
	public int insertCompanion(Companion companion, Matching matching);
	
	//모든 동행 게시글 또는 검색한 동행 게시글 가져오기
	public List<Companion> getAllCompanionList(Map<String, Object> params);
	
	//동행 게시글의 수 구하기
	public int getCompanionListCount();
	
	//게시글 번호로 게시글 조회하기
	public Companion selectCompanionByNum (int companionSeq);
	
	//게시글 수정하기
	public int updateCompanion(Companion companion);
	
	//게시글 삭제하기
	public int deleteCompanion(int companionSeq);
	
	//동행인 리스트 얻기
	public List<Map<String, Object>> getGowithList(int companionSeq);
}
