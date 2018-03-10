package model;

import java.util.Date;

public class TMember {
	private String memberId;	//회원 아이디
	private String memberPass;	//회원 비밀번호
	private String memberName;	//회원 이름
	private String memberPhoneNum;	//회원 연락처x
	private String memberEmail;	//회원 연락처x
	private String memberGender;	//회원 성별
	private Date memberBirth;	//회원 출생일x
	private String memberProfile;	//회원 프로필 사진 경로
	private String memberIntro;	//회원 소개글
	private String memberSecret;	//회원 프로필 공개여부  : 공개/비공개
	//공개 : id, gender, birth, profile, introduction
	//비공개 : id, profile, introduction

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPass() {
		return memberPass;
	}

	public void setMemberPass(String memberPass) {
		this.memberPass = memberPass;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}



	public String getMemberPhoneNum() {
		return memberPhoneNum;
	}

	public void setMemberPhoneNum(String memberPhoneNum) {
		this.memberPhoneNum = memberPhoneNum;
	}

	@Override
	public String toString() {
		return "TMember [memberId=" + memberId + ", memberPass=" + memberPass + ", memberName=" + memberName
				+ ", memberPhoneNum=" + memberPhoneNum + ", memberEmail=" + memberEmail + ", memberGender="
				+ memberGender + ", memberBirth=" + memberBirth + ", memberProfile=" + memberProfile + ", memberIntro="
				+ memberIntro + ", memberSecret=" + memberSecret + "]";
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberGender() {
		return memberGender;
	}

	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}

	public Date getMemberBirth() {
		return memberBirth;
	}

	public void setMemberBirth(Date memberBirth) {
		this.memberBirth = memberBirth;
	}

	public String getMemberProfile() {
		return memberProfile;
	}

	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}

	public String getMemberIntro() {
		return memberIntro;
	}

	public void setMemberIntro(String memberIntro) {
		this.memberIntro = memberIntro;
	}

	public String getMemberSecret() {
		return memberSecret;
	}

	public void setMemberSecret(String memberSecret) {
		this.memberSecret = memberSecret;
	}


}
