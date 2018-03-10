package controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import model.Itinerary;

import service.ItineraryService;

@Controller
@RequestMapping("/itinerary")
public class ItineraryController {

   @Autowired
   private ItineraryService itineraryService;

   
   //1. start : 여행 선택 및 새로운 여행 추가를 위한 화면 요청
   @RequestMapping(value = "/start", method = RequestMethod.GET)
   public String compainonList(HttpSession session,Model model) {
      String memberId = (String) session.getAttribute("memberId");
      //회원이 가지고 있는 여행 목록을 가져와, 내 select box에 띄운다.
      List<Itinerary> itineraryList = itineraryService.bringMyItinerary(memberId);
      model.addAttribute("itineraryList",itineraryList);
      
      System.out.println(itineraryList);
      
      return "itineraryMod";
   }
   
   
   //2. plan : 여행 선택 또는 새로운 여행을 추가하고 일정을 관리하기 위한 화면 요청
   // 1) 기존 여행을 선택 했으면 기존 데이터를 모두 가져오고, 2) 새로운 여행을 추가했으면 그 여행의 입력받은 이름,출발일,도착일을 가져온다
   @RequestMapping(value="/plan")
   public String showMyItinerary(HttpSession session, Itinerary itinerary,Model model){
      
//      SimpleDateFormat transFormat = new SimpleDateFormat("yyyy/MM/dd");
      
      String memberId = (String) session.getAttribute("memberId");
      itinerary.setMemberId(memberId);
      itinerary.setTourDate(itinerary.getDepartureDate());
      
      String tourName = itinerary.getTourName();
      Date departureDate = itinerary.getDepartureDate();

      List<Itinerary> itineraryList = null;
      
      boolean checkTypeBase = false;
      
//      if(date==null) {
         if(departureDate==null) {
            //내 여행 목록 중에 선택
            itineraryList = itineraryService.bringMyItinerary(memberId,tourName);
         }else {
            List<Itinerary> checkforTypeBase = itineraryService.bringMyItinerary(memberId, tourName);
            for(int i=0;i<checkforTypeBase.size();i++) {
               if(checkforTypeBase.get(i).getItineraryType().equals("BASE")) {
                     //화면 리로드 시 BASE 추가하지 않기
                  checkTypeBase = true;   //BASE 있음
                  break;
               }
            }
            if(checkTypeBase) {
               //새 여행 추가 후 화면 리로드 시 base 추가 하지 않기
               itineraryList = itineraryService.bringMyItinerary(memberId,tourName);
            }else {
               //새 여행 추가
               if(itineraryService.addBase(itinerary)>0) {
                   itineraryList = itineraryService.bringMyItinerary(memberId,tourName);
                }
            }
            
         }

//      }else {
//         try {
//            Date to = transFormat.parse(date);
//            itinerary.setTourDate(to);
//         } catch (ParseException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//         }
//         Date tourDate = itinerary.getTourDate();
//
//         //전날 및 다음 날
//         itineraryList = itineraryService.bringMyItinerary(memberId,tourName,tourDate);
//         System.out.println(itineraryList);
//      }
      
      model.addAttribute("itineraryList", itineraryList);
      
      return "itinerary";

}   
   
   //3. 일정 편집
   //3.1. 일정 추가
   //3.1.1. addTour : TOUR 일정 추가
   @RequestMapping(value="/addTour" ,method=RequestMethod.POST)
   public ResponseEntity<Integer> addTour(Itinerary itinerary) {
         
      ResponseEntity<Integer> entity = null;   
      String itineraryType = "TOUR";
      int itinerarySeq = itineraryService.addTour(itinerary.getMemberId(), itinerary.getTourName(),itinerary.getDepartureDate(),itinerary.getEndDate(),itinerary.getTourDate(), itinerary.getTourSpot(),itinerary.getSpotLink(), itinerary.getTourMemo(), itineraryType);
      try {            
         if(itinerarySeq>0) {
            entity = new ResponseEntity<Integer>(itinerarySeq,HttpStatus.OK);
         }else {
            entity = new ResponseEntity<Integer>(HttpStatus.OK);
         }
      }catch (Exception e) {
         e.printStackTrace();
      }
      return entity;
   }
   //3.1.2. addTransport : TRANSPORT 일정 추가
   @RequestMapping(value="/addTransport" ,method=RequestMethod.POST)
   public ResponseEntity<Integer> addTransport(Itinerary itinerary) {
      ResponseEntity<Integer> entity = null;
      int itinerarySeq;
            
      try {
         itinerarySeq=itineraryService.addTransport(itinerary);
         if(itinerarySeq>0) {
            entity = new ResponseEntity<Integer>(itinerarySeq,HttpStatus.OK);
               
         }else {
            entity = new ResponseEntity<Integer>(HttpStatus.OK);
         }
      } catch (Exception e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      
      
      return entity;
   }

   //3.2. 일정 수정
   //3.2.1. modifyTour : TOUR 일정 수정
   @RequestMapping(value="/modifyTour" ,method=RequestMethod.POST)
   public ResponseEntity<String> modifyTour(String memberId,String itinerarySeq,String tourSpot,String spotLink, String tourMemo) {
      ResponseEntity<String> entity = null;
      int itinerarySeq_int = Integer.parseInt(itinerarySeq);
      
      try {            
         if(itineraryService.modifyTour(itinerarySeq_int, memberId,tourSpot,spotLink, tourMemo)) {
            entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
         }else {
            entity = new ResponseEntity<String>("FAIL",HttpStatus.OK);
         }
      }catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
      }
      
      return entity;
   }
   //3.2. 일정 수정
   //3.2.2. modifyTransport : TRANSPORT 일정 수정
   @RequestMapping(value="/modifyTransport" ,method=RequestMethod.POST)
   public ResponseEntity<String> modifyTransport(Itinerary itinerary) {
      ResponseEntity<String> entity = null;
      try {            
         if(itineraryService.modifyTransport(itinerary)) {
            entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
         }else {
            entity = new ResponseEntity<String>("FAIL",HttpStatus.OK);
         }
      }catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
      }
      
      return entity;
   }
   
   
   
   //3.3. 일정 삭제
   //3.3.1. deleteTour : TOUR 일정 삭제 
   @RequestMapping(value="/deleteTour" ,method=RequestMethod.POST)
   public ResponseEntity<String> deleteTour(String itinerarySeq) {
      ResponseEntity<String> entity = null;
      int itinerarySeq_int = Integer.parseInt(itinerarySeq);
      try {            
         if(itineraryService.deleteTour(itinerarySeq_int)){
            entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
         }else {
            entity = new ResponseEntity<String>("FAIL",HttpStatus.OK);
         }
      }catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
      }
      
      return entity;
   }
   //3.3.2. deleteTransport : TRANSPORT 일정 삭제 - 내용만 삭제한다. (transportation,departure,destination, distance,duration 만)
   @RequestMapping(value="/deleteTransport" ,method=RequestMethod.POST)
   public ResponseEntity<String> deleteTransport(String itinerarySeq) {
      ResponseEntity<String> entity = null;
      int itinerarySeq_int = Integer.parseInt(itinerarySeq);
      try {            
         if(itineraryService.deleteTransport(itinerarySeq_int)){
            entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
         }else {
            entity = new ResponseEntity<String>("FAIL",HttpStatus.OK);
         }
      }catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
      }

      return entity;
   }
   //3.3.3. dropTransport
   @RequestMapping(value="/dropTransport" ,method=RequestMethod.POST)
   public ResponseEntity<String> dropTransport(String itinerarySeq) {
      ResponseEntity<String> entity = null;
      int itinerarySeq_int = Integer.parseInt(itinerarySeq);
      try {            
         if(itineraryService.dropTransport(itinerarySeq_int)){
            entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
         }else {
            entity = new ResponseEntity<String>("FAIL",HttpStatus.OK);
         }
      }catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
      }

      return entity;
   }

   
   //4. directions : 길찾기 결과 정보 요청 
   @RequestMapping(value="/directions" ,method=RequestMethod.GET)
   public ResponseEntity<List<Map<String,Object>>> directions(String start,String fin) {
      ResponseEntity<List<Map<String,Object>>> entity = null;
      try {         
         System.out.println(itineraryService.getDirections(start, fin));
         List<Map<String,Object>> directions = itineraryService.getDirections(start, fin);
         entity = new ResponseEntity<List<Map<String,Object>>>(directions,HttpStatus.OK); 
      }catch (Exception e) {
         entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
      }
   return entity;
   }
   
   
   //5. 날짜 이동
   //5.1. 이전 버튼
   @RequestMapping(value="/previous" ,method=RequestMethod.GET)
   public ResponseEntity<List<Itinerary>> previousMyItinerary(HttpSession session,Date tourDate, String tourName){
      ResponseEntity<List<Itinerary>> entity = null;
      String memberId = (String) session.getAttribute("memberId");
      try {
         List<Itinerary> itineraryList = itineraryService.bringMyItinerary(memberId, tourName, tourDate);
         System.out.println(itineraryList);
         entity = new ResponseEntity<List<Itinerary>>(itineraryList,HttpStatus.OK); 
      }catch(Exception e){
         entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
      }
      return entity;
   }
   //5.2. 다음 버튼
   @RequestMapping(value="/next" ,method=RequestMethod.GET)
   public ResponseEntity<List<Itinerary>> nextMyItinerary(HttpSession session,Date tourDate, String tourName){
      ResponseEntity<List<Itinerary>> entity = null;
      String memberId = (String) session.getAttribute("memberId");
      System.out.println(tourDate);
      try {
         List<Itinerary> itineraryList = itineraryService.bringMyItinerary(memberId, tourName, tourDate);
         System.out.println(itineraryList);
         entity = new ResponseEntity<List<Itinerary>>(itineraryList,HttpStatus.OK); 
      }catch(Exception e){
         entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
      }
      return entity;
   }
   

}