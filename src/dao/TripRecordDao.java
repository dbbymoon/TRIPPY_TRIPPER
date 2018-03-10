package dao;

import java.util.List;
import java.util.Map;
import model.TripRecord;

public interface TripRecordDao {

	// 기본 CRUD
	public int insertTripRecord(TripRecord tripRecord);

	public int updateTripRecord(TripRecord tripRecord);

	public int deleteTripRecord(int recordSeq);

	public TripRecord selectOneTripRecord(int recordSeq);

	public List<TripRecord> selectAllTripRecord();

	// 추가메서드 : 메서드 기능 주석 달아주세요

	// 게시글 파일 추가
	public int insertAttach(Map<String, String> params);

	// 게시글 개수 조회
	public int getCount();

	// Diary에 내가 작성한 글 모두 조회
	public List<TripRecord> selectAllByMemberId(String memberId);

	// 내가 가진 id로 Seq 조회하기
	public List<Integer> selectAllRecordSeq(String memberId);

	// 내가 가진 id로 recordSecret이 'public'인 게시글의 Seq 조회하기
	public List<Integer> selectAllRecordSeqByPublic(String memberId);
	
}
