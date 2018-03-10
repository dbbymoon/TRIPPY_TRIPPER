package dao;

import java.util.List;
import java.util.Map;

import model.Itinerary;

public interface ItineraryDao {

//기본 CRUD
   public int insertItinerary(Itinerary itinerary);
   public int updateItinerary(Itinerary itinerary);
   public int deleteItinerary(int itinerarySeq);
   public Itinerary selectOneItinerary(int itinerarySeq);
   public List<Itinerary> selectAllItinerary();
   

//추가메서드 : 메서드 기능 주석 달아주세요
   
   // getCount() : 여행 계획 개수 조회
   public int getCount();
   
   // selectAllMyItinerary() : 내 여행 목록 가져오기 distinct tourName
   public List<Itinerary> selectAllMyItinerary(String memberId);
   // selectMyItinerary() : 내 여행 목록 가져오기 , 해당 여행 계획 이름
   public List<Itinerary> selectMyItinerary(Map<String,Object> params);
   // selectMyItineraryinDate() : 내 여행 목록 가져오기, 해당 여행 계획 이름, 날짜
   public List<Itinerary> selectMyItineraryinDate(Map<String,Object> params);
   public List<Itinerary> selectMyItineraryforMyInfo(Map<String,Object> params);
   
   
   //일정 편집
   public int insertBase(Map<String,Object> params);
   // insertTour() : TOUR 일정 추가
   public int insertTour(Map<String,Object> params);
   // updateTour() : TOUR 일정 수정
   public int updateTour(Map<String,Object> params);
   // insertTransit() : TRANSPORT 일정 추가 (TRANSPORTATION = 'TRANSIT')
   public int insertTransit(Map<String,Object> params);
   // insertWalkOrDrive() : TRANSPORT 일정 추가 (TRANSPORTATION = 'WALK' or 'DRIVE')
   public int insertWalkOrDrive(Map<String,Object> params);
   // deleteTransit() : TRANSPORT 일정 내용만 삭제 (TRANSPORTATION ='TRANSIT')
   public int deleteTransit(int itinerarySeq);
   // deleteWalkOrDrive() : TRANSPORT 일정 내용만 삭제 (TRANSPORTATION ='WALK' or 'DRIVE')
   public int deleteWalkOrDrive(int itinerarySeq);
   // updateTransit() : TRANSPORT 일정 수정 (TRANSPORTATION ='TRANSIT') >> 내용만 삭제된 일정에 업데이트
   public int updateTransit(Map<String,Object> params);
   // updateWalkOrDrive() : TRANSPORT 일정 수정(TRANSPORTATION ='WALK' or 'DRIVE')>> 내용만 삭제된 일정에 업데이트
   public int updateWalkOrDrive(Map<String,Object> parmas);
   // deleteMyPlan() : 여행 전체 삭제
   public int deleteMyPlan(Map<String,Object> params);
}