package service;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import dao.CReplyDao;
import dao.CompanionDao;
import dao.MatchingDao;
import dao.TMemberDao;
import dao.TReplyDao;
import dao.TripRecordDao;
import model.CReply;
import model.Companion;
import model.TMember;
import model.TReply;
import model.TripRecord;

@Service
public class TMemberService implements ITMemberService {

	@Autowired
	private TMemberDao tMemberDao;
	@Autowired
	private CompanionDao companionDao;
	@Autowired
	private MatchingDao matchingDao;
	@Autowired
	private CReplyDao cReplyDao;
	@Autowired
	private TReplyDao tReplyDao;
	@Autowired
	private TripRecordDao tripRecordDao;

	// 파일 업로드 패스
	// private static final String UPLOAD_PATH =
	// C:\\Users\\hb2007\\user\\hb2007\\springFramwork\\TRIPPY_TRIPPER\\WebContent\\profileImg;
	private static final String UPLOAD_PATH = "C:\\Users\\hb2008\\apache-tomcat-8.5.23\\webapps\\TRIPPY_TRIPPER\\profileImg";
	// 아이디 중복 체크
	@Override
	public boolean checkId(String memberId) {
		TMember memberOriginId = tMemberDao.selectOneMember(memberId);

		if (memberOriginId == null) {
			// 아이디 없음 >>> 가능
			return true;
		}

		return false;
	}

	// 이메일 중복 체크
	@Override
	public boolean checkEmail(String memberEmail) {
		TMember memberOriEmail = tMemberDao.selectOneMemberByEmail(memberEmail);

		if (memberOriEmail == null) {
			// 이메일 없음 >>> 가능
			return true;
		}

		return false;
	}

	 // 회원 가입 (step 1)
	   @Override
	   public boolean joinMember(TMember tMember) {
	      tMember.setMemberId(tMember.getMemberId());
	      tMember.setMemberPass(tMember.getMemberPass());
	      tMember.setMemberName(tMember.getMemberName());
	      tMember.setMemberEmail(tMember.getMemberEmail());
	      System.out.println("tMember step 1 : " + tMember);

	      if (tMemberDao.insertMember(tMember) > 0) {
	         return true;
	      }

	      return false;
	   }

	   // 실제 파일을 받아와서 저장하는 메서드 작성 : uploadFile()
	   // 업로드 후 파일명 반환
	   private String uploadFile(String fileName, byte[] fileData) throws Exception {

	      // 읽어온 파일을 이용해서 파일을 하나 생성 : new File(저장경로, 파일이름);
	      // 파일 이름이 중복되면 안됨 : UUID 붙여서 저장
	      UUID uid = UUID.randomUUID();
	      String fullName = uid.toString() + "_" + fileName;
	      File target = new File(UPLOAD_PATH, fullName);

	      FileCopyUtils.copy(fileData, target);

	      return fullName;
	   }

	   // 가입 step 2 - 프로필 사진 변경
	   @Override
	   public String joinProfile(String id, MultipartFile file) {

	      try {
	         String fullName = uploadFile(file.getOriginalFilename(), file.getBytes());
	         
	         TMember member = new TMember();
	         member.setMemberId(id);
	         member.setMemberProfile(fullName);
	         tMemberDao.updateMemberForProfile(member);

	         /*동행 게시판의 프로필 사진도 함께 수정해야함*/
	         Companion companion = new Companion();
	         companion.setMemberId(id);
	         companion.setMemberProfile(fullName);
	         companionDao.updateCompanionForProfile(companion);
	         
	         
	         /*동행 게시판의 댓글 사진도 수정*/
	         CReply cReply = new CReply();
	         cReply.setMemberId(id);
	         cReply.setMemberProfile(fullName);
	         cReplyDao.updateReplyForProfile(cReply);
	              
	         /*다이어리 게시판의 댓글 사진도 수정*/
	         TReply tReply = new TReply();
	         tReply.setMemberId(id);
	         tReply.setMemberProfile(fullName);
	         tReplyDao.updateReplyForProfile(tReply);
	         
	         System.out.println(fullName);
	         return fullName;

	      } catch (Exception e) {
	         e.printStackTrace();
	         return "fail";
	      }

	   }
	   

	// 회원 가입 (step 2)
	   @Override
	   public boolean joinDetailMember(TMember tMember, MultipartFile file) {

	       try {
	           String id = tMember.getMemberId();
	           System.out.println("id : " +id);
	           tMember.setMemberGender(tMember.getMemberGender());
	           tMember.setMemberIntro(tMember.getMemberIntro());
	           tMember.setMemberSecret(tMember.getMemberSecret());
	           tMember.setMemberId(tMember.getMemberId());
	           System.out.println("tMember : " + tMember);
	           tMemberDao.updateMemberForJoin(tMember);

	           return true;

	       } catch (Exception e) {
	           return false;
	       }
	   }

	@Override
	// 아이디 찾기
	public String findId(String memberName, String memberEmail) {
		TMember member = tMemberDao.selectOneMemberByEmail(memberEmail);

		if (member == null) {
			// 이메일 없음
			return "회원 없음";
		} else {
			// 이메일 있음, 기존 이름과 입력받은 이름 비교
			if (member.getMemberName().equals(memberName)) {
				// 이름도 같음 : 아이디 찾기 성공 >> 아이디 반환
				return member.getMemberId();
			} else {
				// 이름 불일치
				return "불일치";
			}
		}

	}

	@Override
	// 비밀번호 찾기
	public String findPw(String memberId, String memberName, String memberEmail) {
		TMember member = tMemberDao.selectOneMember(memberId);

		if (member == null) {
			// 아이디 없음
			return "회원 없음";
		} else {
			// 아이디 있음, 이름과 이메일 비교
			if (member.getMemberName().equals(memberName) && member.getMemberEmail().equals(memberEmail)) {
				// 이름, 이메일 일치 : 비밀번호 찾기 성공 >> 비밀번호 반환
				return member.getMemberPass();
			} else {
				// 이름 또는 이메일 불일치
				return "불일치";
			}
		}
	}

	@Override
	// 아이디 하나로 검색하기 - 내 정보 불러오기
	public TMember selectOneById(String memberId) {

		TMember tmember = tMemberDao.selectOneMember(memberId);
		return tMemberDao.selectOneMember(memberId);
	}

	@Override
	// 회원 탈퇴
	public boolean deleteMember(String memberId) {
		boolean result = false;
		
		/*회원 탈퇴 전에 할일*/
		// 다이어리는 삭제되지 않지만 댓글은 삭제됨
		// -> 정확히는 삭제가 아니라 '이미 삭제된 댓글입니다'로 대체하기 (나중에 대댓글을 위해)
    	
		// 매칭 모두 삭제
		matchingDao.deleteMatchingById(memberId);
    	// 동행 구하는 글 모두 삭제
		companionDao.deleteCompanionById(memberId);
    	// 여행 계획 모두 삭제
		
		// 스크랩 삭제
		
		if (tMemberDao.deleteMember(memberId) > 0) {
			result = true;
		}
		return result;
	}

	@Override
	// 회원정보 수정
	public boolean modifyMember(TMember tMember) {

		if (tMemberDao.updateMember(tMember) > 0) {
			return true;
		}
		return false;
	}

	@Override
	public TMember selectMember(String memberId) {
		return tMemberDao.selectOneMember(memberId);
	}

	@Override
	//아이디 하나로 검색하기(로그인)
	public String selectOneById(String memberId, String memberPass) {

	    TMember tmember = tMemberDao.selectOneMember(memberId);

	    if(tmember != null) {
	        if(tmember.getMemberPass().equals(memberPass)) {
	            return "성공";
	        }else {
	            return "비밀번호";
	        }
	    }else {
	        return "아이디";
	    }
	}
}
