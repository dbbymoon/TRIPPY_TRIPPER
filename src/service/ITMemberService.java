package service;

import org.springframework.web.multipart.MultipartFile;

import model.TMember;

public interface ITMemberService {
	public String selectOneById(String memberId, String memberPass);
	//아이디 찾기
	public String findId(String memberName, String memberEmail);
	//비밀번호 찾기
	public String findPw(String memberId, String memberName, String memberEmail);
	//회원 한명 조회하기
	public TMember selectMember(String memberId);
	//아이디 중복 체크
	public boolean checkId(String memberId);
	//이메일 중복체크
	public boolean checkEmail(String memberEmail);
	//회원가입 (step1)
	public boolean joinMember(TMember tMember);
	//회원가입 (step2)
	public boolean joinDetailMember(TMember tMember, MultipartFile file);
	//회원가입 (step2 - 프로필 사진 변경)
	public String joinProfile(String id, MultipartFile file);
	//회원 탈퇴
	public boolean deleteMember(String memberId);
	//회원 정보 수정
	public boolean modifyMember(TMember tMember);
	//아이디 하나로 검색하기 - 내 정보 불러오기
	public TMember selectOneById(String memberId);
}
