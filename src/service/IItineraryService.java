package service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import model.Itinerary;

public interface IItineraryService {

//1. 일정 조회
   //bringMyItinerary(String memberId) : 내 여행 일정 목록 조회 (select box의 option에 띄우기 위해 : distinct tourName)
   public List<Itinerary> bringMyItinerary(String memberId);
   //bringMyItinerary(String memberId,String tourName) : 내 여행 목록 중 해당 이름의 여행 일정 조회 
   public List<Itinerary> bringMyItinerary(String memberId,String tourName);
   //bringMyItinerary(String memberId,String tourName,Date tourDate) : 내 여행 목록 중 해당 이름,해당 날짜의 여행 일정 조회 
   public List<Itinerary> bringMyItinerary(String memberId,String tourName,Date tourDate);
   //showMyItinerary(String memberId,String tourName) : myInfo - myItinerary에서 조회할 내 여행
   public List<Itinerary> showMyItinerary(String memberId,String tourName);
   
//2. 일정 편집
   //addBase() : BASE 
   public int addBase(Itinerary itinerary);
   //addTour() : TOUR 일정 추가
   public int addTour(String memberId,String tourName,Date departureDate,Date endDate,Date tourDate,String tourSpot,String spotLink,String tourMemo,String itineraryType);
   //modifyTour() : TOUR 일정 수정
   public boolean modifyTour(int itinerarySeq, String memberId, String tourSpot,String spotLink, String tourMemo);
   //deleteTour() : TOUR 일정 삭제
   public boolean deleteTour(int itinerarySeq);
   //addTour() : TRANSPORT 일정 추가
   public int addTransport(Itinerary itinerary) throws Exception;
   //modifyTransport() : TRANSPORT일정 수정
   public boolean modifyTransport(Itinerary itinerary);
   //deleteTransport() : TRANSPORT 일정 삭제
   public boolean deleteTransport(int itinerarySeq);
   //dropTransport() : TRANSPORT 일정 아예 삭제하기
   public boolean dropTransport(int itinerarySeq);
   
//3. 여행 전체 편집
   //deleteMyPlan() : 여행 전체 삭제
   public boolean deleteMyPlan(String memberId,String tourName);

   
//4. 길찾기
   //getDirections() : 길찾기 결과 요청
   public List<Map<String,Object>> getDirections(String start,String fin) throws Exception;
   

   
}