package model;

import java.util.Date;

public class Itinerary {
private int itinerarySeq; //ITINERARY_SEQ
private String memberId; //회원 아이디
private String tourName; //여행 이름
private Date departureDate; //여행 출발 날짜
private Date endDate; //여행 종료 날짜
private Date tourDate; //여행 날짜
private String tourSpot; //여행 장소 TOUR
private String spotLink; //여행 장소 링크 TOUR
private String tourMemo; //여행 상세 메모 TOUR
private String transportation; //교통 수단 TRANSPORT (:WALKING,DRIVING,TRANSIT)
private String departure; //출발지 TRANSPORT
private String destination; //도착지 TRANSPORT
private String duration; //전체 이동 소요 시간 TRANSPORT
private String distance; //전체 이동 거리 TRANSPORT
private String itineraryType; //계획 타입 : TOUR/TRANSPORT

public int getItinerarySeq() {
    return itinerarySeq;
}

public void setItinerarySeq(int itinerarySeq) {
    this.itinerarySeq = itinerarySeq;
}

public String getMemberId() {
    return memberId;
}

public void setMemberId(String memberId) {
    this.memberId = memberId;
}
public String getTourName() {
    return tourName;
}

public void setTourName(String tourName) {
    this.tourName = tourName;
}


public Date getDepartureDate() {
    return departureDate;
}

public void setDepartureDate(Date departureDate) {
    this.departureDate = departureDate;
}

public Date getEndDate() {
    return endDate;
}

public void setEndDate(Date endDate) {
    this.endDate = endDate;
}

public Date getTourDate() {
    return tourDate;
}

public void setTourDate(Date tourDate) {
    this.tourDate = tourDate;
}

public String getTourSpot() {
    return tourSpot;
}

public void setTourSpot(String tourSpot) {
    this.tourSpot = tourSpot;
}


public String getSpotLink() {
    return spotLink;
}

public void setSpotLink(String spotLink) {
    this.spotLink = spotLink;
}

public String getTourMemo() {
    return tourMemo;
}

public void setTourMemo(String tourMemo) {
    this.tourMemo = tourMemo;
}



public String getTransportation() {
    return transportation;
}

public void setTransportation(String transportation) {
    this.transportation = transportation;
}


public String getDeparture() {
    return departure;
}

public void setDeparture(String departrue) {
    this.departure = departrue;
}

public String getDestination() {
    return destination;
}

public void setDestination(String destination) {
    this.destination = destination;
}

public String getDuration() {
    return duration;
}

public void setDuration(String duration) {
    this.duration = duration;
}

public String getDistance() {
    return distance;
}

public void setDistance(String distance) {
    this.distance = distance;
}

public String getItineraryType() {
    return itineraryType;
}

public void setItineraryType(String itineraryType) {
    this.itineraryType = itineraryType;
}

@Override
public String toString() {
    return "Itinerary [itinerarySeq=" + itinerarySeq + ", memberId=" + memberId + ", tourName=" + tourName
            + ", departureDate=" + departureDate + ", endDate=" + endDate + ", tourDate=" + tourDate + ", tourSpot="
            + tourSpot + ", spotLink=" + spotLink + ", tourMemo=" + tourMemo + ", transportation=" + transportation
            + ", departure=" + departure + ", destination=" + destination + ", duration=" + duration + ", distance="
            + distance + ", itineraryType=" + itineraryType + "]";
}
}