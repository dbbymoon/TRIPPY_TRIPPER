package service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ItineraryDao;
import model.Itinerary;

@Service
public class ItineraryService implements IItineraryService{

   @Autowired
   private ItineraryDao itineraryDao;
   
   
//1. 조회
   //1.1. bringMyItinerary(String memberId) : 내 여행 일정 목록 조회 (select box의 option에 띄우기 위해 : distinct tourName)
   @Override
   public List<Itinerary> bringMyItinerary(String memberId) {
      // TODO Auto-generated method stub
      return itineraryDao.selectAllMyItinerary(memberId);
   }
   
   //1.2. bringMyItinerary(String memberId,String tourName) : 내 여행 목록 중 해당 이름의 여행 일정 조회 
   @Override
   public List<Itinerary> bringMyItinerary(String memberId, String tourName) {
      // TODO Auto-generated method stub
      Map<String, Object> params = new HashMap<String,Object>();
      params.put("memberId", memberId);
      params.put("tourName", tourName);
      return itineraryDao.selectMyItinerary(params);
   }
   
   //1.3. bringMyItinerary(String memberId,String tourName,Date tourDate) : 내 여행 목록 중 해당 이름,해당 날짜의 여행 일정 조회 
   @Override
   public List<Itinerary> bringMyItinerary(String memberId, String tourName, Date tourDate) {
      Map<String, Object> params = new HashMap<String,Object>();
      params.put("memberId", memberId);
      params.put("tourName", tourName);
      params.put("tourDate", tourDate);
      return itineraryDao.selectMyItineraryinDate(params);
   }
   //1.4. showMyItinerary(String memberId, String tourName) : myInfo에서 조회하는 내 여행 
   @Override
   public List<Itinerary> showMyItinerary(String memberId, String tourName) {
      // TODO Auto-generated method stub
      Map<String, Object> params = new HashMap<String,Object>();
      params.put("memberId", memberId);
      params.put("tourName", tourName);
      return itineraryDao.selectMyItineraryforMyInfo(params);
   }
   

//2. 편집
   @Override
   public int addBase(Itinerary itinerary) {
      
      Map<String, Object> params = new HashMap<String,Object>();
      params.put("memberId", itinerary.getMemberId());
       params.put("tourName", itinerary.getTourName());
       params.put("departureDate", itinerary.getDepartureDate());
       params.put("endDate", itinerary.getEndDate());
       params.put("tourDate", itinerary.getTourDate());
       params.put("itineraryType", "BASE");
       System.out.println(params);
      return itineraryDao.insertBase(params);
   }
   //2.1. TOUR 일정
   //2.1.1. addTour() : TOUR 일정 추가
   @Override
   public int addTour(String memberId,String tourName,Date departureDate,Date endDate, Date tourDate, String tourSpot, String spotLink,String tourMemo, String itineraryType) {
      Map<String, Object> params = new HashMap<String,Object>();

      params.put("memberId", memberId);
      params.put("tourName", tourName);
      params.put("departureDate", departureDate);
      params.put("endDate", endDate);
      params.put("tourDate", tourDate);
      params.put("tourSpot", tourSpot);
      params.put("spotLink", spotLink);
      params.put("tourMemo", tourMemo);
      params.put("itineraryType", itineraryType);

      int itinerarySeq=itineraryDao.insertTour(params);
      
      return itinerarySeq;
   }

   //2.1.2. modifyTour() : TOUR 일정 수정
   @Override
   public boolean modifyTour(int itinerarySeq, String memberId, String tourSpot, String spotLink, String tourMemo) {
      Map<String, Object> params = new HashMap<String,Object>();
      
      params.put("itinerarySeq", itinerarySeq);
      params.put("tourSpot", tourSpot);
      params.put("spotLink", spotLink);
      params.put("tourMemo", tourMemo);

      if(itineraryDao.updateTour(params)>0) {
         return true;
      }
      return false;
   }
   
   //2.1.3. deleteTour() : TOUR 일정 삭제
   @Override
   public boolean deleteTour(int itinerarySeq) {
      if(itineraryDao.deleteItinerary(itinerarySeq)>0) {
         return true;
      }
      return false;
   }
   
   //2.2. TRANSPORT 일정
   //2.2.1. addTransport() : TRANSPORT 일정 추가
   public int addTransport(Itinerary itinerary) throws Exception {
      
      Map<String, Object> params = new HashMap<String,Object>();
      
      int itinerarySeq;
      
      if(itinerary.getDuration()!=null) {   //교통 수단 이용
         params.put("memberId", itinerary.getMemberId());
         params.put("tourName", itinerary.getTourName());
         params.put("departureDate", itinerary.getDepartureDate());
         params.put("endDate", itinerary.getEndDate());
         params.put("tourDate", itinerary.getTourDate());
         params.put("distance", itinerary.getDistance());
         params.put("duration", itinerary.getDuration());
         params.put("departure", itinerary.getDeparture());
         params.put("destination", itinerary.getDestination());
         params.put("transportation", "TRANSIT");
         params.put("itineraryType", "TRANSPORT");
         
         System.out.println("service :  "+params);
         itinerarySeq = itineraryDao.insertTransit(params);
      }else { //도보 또는 차 이용
         params.put("memberId", itinerary.getMemberId());
         params.put("tourName", itinerary.getTourName());
         params.put("departureDate", itinerary.getDepartureDate());
         params.put("endDate", itinerary.getEndDate());
         params.put("tourDate", itinerary.getTourDate());
         params.put("departure", itinerary.getDeparture());
         params.put("destination", itinerary.getDestination());
         params.put("transportation", itinerary.getTransportation());
         params.put("itineraryType", "TRANSPORT");
         
         System.out.println("service :  "+params);
         itinerarySeq = itineraryDao.insertWalkOrDrive(params);
      }
      
      return itinerarySeq;
      
   }
   
   //2.2.2. modifyTransport() : TRANSPORT 일정 수정
   @Override
   public boolean modifyTransport(Itinerary itinerary) {
      
      Map<String, Object> params = new HashMap<String,Object>();
      

      if(itinerary.getDuration()!=null) {   //교통 수단 이용
         params.put("itinerarySeq", itinerary.getItinerarySeq());
         params.put("distance", itinerary.getDistance());
         params.put("duration", itinerary.getDuration());
         params.put("departure", itinerary.getDeparture());
         params.put("destination", itinerary.getDestination());
         params.put("transportation", "TRANSIT");
         params.put("itineraryType", "TRANSPORT");
         
         System.out.println("service :  "+params);
         
         if(itineraryDao.updateTransit(params)>0) {
            return true;
         }
      }else { //도보 또는 차 이용
         params.put("itinerarySeq", itinerary.getItinerarySeq());
         params.put("departure", itinerary.getDeparture());
         params.put("destination", itinerary.getDestination());
         params.put("transportation", itinerary.getTransportation());
         params.put("itineraryType", "TRANSPORT");
         
         System.out.println("service :  "+params);
         if(itineraryDao.updateWalkOrDrive(params)>0) {
            return true;
         }
      }
      
      return false;
   }
   
   
   //2.2.3. deleteTransport() : TRANSPORT 일정 삭제 - 내용만 삭제한다.(transportation,departure,destination, distance,duration 만)
   @Override
   public boolean deleteTransport(int itinerarySeq) {
      
      if(itineraryDao.selectOneItinerary(itinerarySeq).getTransportation()=="TRANSIT") {
         if(itineraryDao.deleteTransit(itinerarySeq)>0) {
            return true;
         }
      }else {
         if(itineraryDao.deleteWalkOrDrive(itinerarySeq)>0) {
            return true;
         }
      }
      return false;
   }
   
   //2.2.4. dropTransport() : TRANSPORT 일정 아예 삭제
   @Override
   public boolean dropTransport(int itinerarySeq) {
      if(itineraryDao.deleteItinerary(itinerarySeq)>0) {
            return true;
      }
      return false;
   }
   
   
   
   //3. 여행 전체 편집
   //3.1. 여행 전체 삭제
   @Override
   public boolean deleteMyPlan(String memberId, String tourName) {
      Map<String, Object> params = new HashMap<String,Object>();
      params.put("memberId",memberId);
      params.put("tourName", tourName);
      if(itineraryDao.deleteMyPlan(params)>0) {
            return true;
         }
         return false;
   }
   
   
   
   //4. 길찾기
   //getDirections() : 길찾기 결과 요청
   @Override
   public List<Map<String,Object>> getDirections(String start,String fin) throws Exception {
      
      //길찾기 결과 정보 LIST
      List<Map<String,Object>> directions = new ArrayList<Map<String,Object>>();
      //1. 전체 길찾기 정보
      Map<String,Object> total_directions;
      //2. WALK STEP 정보
      Map<String,Object> walk_step;
      //3. BUS or SUBWAY 정보
      Map<String,Object> bus_subway_step;
      //4. TRAIN 정보
      Map<String,Object> train_step;
      
      
      //요청 URL에다가 파라미터 넣어서 요청
      Timestamp ts = new Timestamp(new Date().getTime());
      String origin = URLEncoder.encode(start,"UTF-8"); 
      String destination = URLEncoder.encode(fin,"UTF-8"); 
      String apiURL ="https://maps.googleapis.com/maps/api/directions/json?origin="+origin+"&destination="+destination+"&mode=transit&key=AIzaSyCDaCyJ-nputHM4cp2ogGZjCC_3ASAg-uE";
      
      URL url = new URL(apiURL);
      
      HttpURLConnection connection = (HttpURLConnection)url.openConnection();
      //connection에 클라이언트 id랑, 시크릿을 속성으로 넣어줘야 함
      connection.setRequestMethod("GET");
      
      int responseCode =  connection.getResponseCode();
      
      //responceCode >> HttpStatus 코드 : 200 이면 정상 호출   
      
      BufferedReader br = null;
      
      if(responseCode == 200) {
         //정상 호출
         //응답을 받아와서 데이터 가공 >>스트림으로 들어옴
         br = new BufferedReader(
               new InputStreamReader(connection.getInputStream()));
      } else {
         //예외 발생
         br = new BufferedReader(
               new InputStreamReader(connection.getErrorStream()));
      }
      //스트림에서 읽어온 데이터 조각을 합치기 위해서..
      String inputLine; //버퍼에서 문자열을 읽어오기 위한 변수
      StringBuffer response = new StringBuffer(); //응답을 위한 문자열을 만들어주는 객체
      while( (inputLine=br.readLine()) != null) {
         response.append(inputLine);
      }
      br.close();
      //읽어온 문자열을 우리가 원하는 데이터로 추출 >> 
      
      //System.out.println(response.toString());
      
      //문자열을 JSON 객체 형태로 읽어오기
      //JSON 객체 사용하기 위해서 라이브러리 추가
      JSONObject jsonData = new JSONObject(response.toString());
      System.out.println(jsonData);
      //jsonobject에서 jsonarray 얻어오기

      
      
      JSONObject jsonObject = jsonData.getJSONArray("routes").getJSONObject(0);
      

//1. 전체 길찾기 정보 total_directions LIST에 담기
      //전체 이동 거리
      String distance  = jsonObject.getJSONArray("legs").getJSONObject(0).getJSONObject("distance").getString("text");
      //전체 소요 시간
      String duration  = jsonObject.getJSONArray("legs").getJSONObject(0).getJSONObject("duration").getString("text");
      //출발지
      String start_address  = jsonObject.getJSONArray("legs").getJSONObject(0).getString("start_address");
      //도착지
      String end_address  = jsonObject.getJSONArray("legs").getJSONObject(0).getString("end_address");
   
      total_directions=new HashMap<String,Object>();
      total_directions.put("type", "total");
      total_directions.put("distance",distance);
      total_directions.put("duration",duration);
      total_directions.put("departure",start_address);
      total_directions.put("destination",end_address);
      directions.add(total_directions);   //전체 이동 정보 list에 담기


//2. STEP 길찾기 정보 각각 walk_step, bus_subway_step, train_step LIST에 담기
      JSONArray steps = jsonObject.getJSONArray("legs").getJSONObject(0).getJSONArray("steps");
      String step_distance;
      String step_duration;
      String step_mode;
      String step_information;
      for(int i=0;i<steps.length();i++) {
         //i번째 루트 이동 거리
         step_distance = steps.getJSONObject(i).getJSONObject("distance").getString("text");
         //i번째 루트 소요 시간
         step_duration = steps.getJSONObject(i).getJSONObject("duration").getString("text");
         //i번째 루트 이동 수단
         step_mode = steps.getJSONObject(i).getString("travel_mode");
         //i번째 루트 상세 설명
         step_information = steps.getJSONObject(i).getString("html_instructions");
         
         //교통 수단을 이용할 때 
         if(step_mode.equals("TRANSIT")) {
            //MODE == "TRANSIT"
            //승차 정류장
            String departureStop = steps.getJSONObject(i).getJSONObject("transit_details").getJSONObject("departure_stop").getString("name");
            //하차 정류장
            String arrivalStop = steps.getJSONObject(i).getJSONObject("transit_details").getJSONObject("arrival_stop").getString("name");
            //교통 수단 정보
            String vehicle = steps.getJSONObject(i).getJSONObject("transit_details").getJSONObject("line").getJSONObject("vehicle").getString("name");
            //교통 수단 상세 정보
            String vehicleName = steps.getJSONObject(i).getJSONObject("transit_details").getJSONObject("line").getString("name");
            //정류장 개수
            int stopNum =  steps.getJSONObject(i).getJSONObject("transit_details").getInt("num_stops");
         
            if(vehicle.equals("Train")) {
               //TRANSPORT == "TRAIN"
               //train_step에 길찾기 정보 담기
               train_step = new HashMap<String,Object>();
               train_step.put("type", "train_step");
               train_step.put("distnace", step_distance);
               train_step.put("duration", step_duration);
               train_step.put("mode", step_mode);
               train_step.put("information", step_information);
               train_step.put("departureStop", departureStop);
               train_step.put("arrivalStop", arrivalStop);
               train_step.put("vehicle", vehicle);
               train_step.put("vehicleName", vehicleName);
               train_step.put("stopNum", stopNum);
               directions.add(train_step);
            }else {
               //TRANSPORT == "BUS" OR "SUBWAY"
               //bus_subway_step에 길찾기 정보 담기
               String transit_route = steps.getJSONObject(i).getJSONObject("transit_details").getJSONObject("line").getString("short_name");
               bus_subway_step = new HashMap<String,Object>();
               bus_subway_step.put("type", "bus_subway_step");
               bus_subway_step.put("distance", step_distance);
               bus_subway_step.put("duration", step_duration);
               bus_subway_step.put("mode", step_mode);
               bus_subway_step.put("information", step_information);
               bus_subway_step.put("departureStop", departureStop);   
               bus_subway_step.put("arrivalStop", arrivalStop);
               bus_subway_step.put("vehicle", vehicle);
               bus_subway_step.put("vehicleName", vehicleName);
               bus_subway_step.put("stopNum", stopNum);
               bus_subway_step.put("transit_route", transit_route);
               directions.add(bus_subway_step);
            }
         }else {
            //MODE == "WALK"
            //walk_step에 길찾기 정보 담기
            walk_step = new HashMap<String,Object>();
            walk_step.put("type", "walk_step");
            walk_step.put("distance", step_distance);
            walk_step.put("duration", step_duration);
            walk_step.put("mode", step_mode);
            walk_step.put("information", step_information);
            directions.add(walk_step);
         }
         
      }
      return directions;
   }










   


}