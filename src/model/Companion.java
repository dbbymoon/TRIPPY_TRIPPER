package model;

import java.util.Date;

public class Companion {
	private int companionSeq;	//COMPANION_SEQ
	private String memberId;	//동행글을 올린 회원 닉네임
	private String departure;	//출발지 : 장소 자동 완성 API, 꼭 입력 안해도됨
	private String destination;	//목적지 : 장소 자동 완성 API
	private String detailSpot;	//목적지 - 상세 지역 : 직접 입력 받음
	private String vehicles;	//교통 수단
	private String companionMemo;	//동행 게시글
	private Date tourDate;	//동행 날짜
	private int companionNum;	//동행 인원
	private int companionDeterminNum;	//확정된 동행인의 수 default=1
	private String memberProfile;//프로필 
	private String companionGender;	//동행인 성별 : 남자/여자/구분없음

	public int getCompanionDeterminNum() {
		return companionDeterminNum;
	}

	public void setCompanionDeterminNum(int companionDeterminNum) {
		this.companionDeterminNum = companionDeterminNum;
	}

	public String getMemberProfile() {
		return memberProfile;
	}

	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}
	
	public int getCompanionSeq() {
		return companionSeq;
	}

	public void setCompanionSeq(int companionSeq) {
		this.companionSeq = companionSeq;
	}

	public String getDeparture() {
		return departure;
	}

	public void setDeparture(String departure) {
		this.departure = departure;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getDetailSpot() {
		return detailSpot;
	}

	public void setDetailSpot(String detailSpot) {
		this.detailSpot = detailSpot;
	}

	public String getVehicles() {
		return vehicles;
	}

	public void setVehicles(String vehicles) {
		this.vehicles = vehicles;
	}

	public String getCompanionMemo() {
		return companionMemo;
	}

	public void setCompanionMemo(String companionMemo) {
		this.companionMemo = companionMemo;
	}

	public Date getTourDate() {
		return tourDate;
	}

	public void setTourDate(Date tourDate) {
		this.tourDate = tourDate;
	}

	public int getCompanionNum() {
		return companionNum;
	}

	public void setCompanionNum(int companionNum) {
		this.companionNum = companionNum;
	}

	public String getCompanionGender() {
		return companionGender;
	}

	public void setCompanionGender(String companionGender) {
		this.companionGender = companionGender;
	}



	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public String toString() {
		return "Companion [companionSeq=" + companionSeq + ", memberId=" + memberId + ", departure=" + departure
				+ ", destination=" + destination + ", detailSpot=" + detailSpot + ", vehicles=" + vehicles
				+ ", companionMemo=" + companionMemo + ", tourDate=" + tourDate + ", companionNum=" + companionNum
				+ ", companionDeterminNum=" + companionDeterminNum + ", memberProfile=" + memberProfile
				+ ", companionGender=" + companionGender + "]";
	}

}