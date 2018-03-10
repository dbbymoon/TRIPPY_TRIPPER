package dao;

import java.util.List;
import java.util.Map;

import model.AttachFile;

public interface AttachFileDao {
	//기본 CRUD
	public int insertAttachFile(Map<String, Object> params);
	public int updateAttachFile(AttachFile attachFile);
	public int deleteAttachFile(int fileNum);
	public AttachFile selectOneAttachFile(int fileNum);
		
	//추가메서드 : 메서드 기능 주석 달아주세요
	//특정 게시물의 파일 리스트 가져오기
	public List<AttachFile> selectAllAttachFiles(int recordSeq);
	
	// 내가 업로드한 모든 파일 가져오기
	public List<AttachFile> selectAllMyAttachFiles(String memberId);
	
	// 파일 번호 받아오기
	public List<AttachFile> selectAttachfileNum(int recordSeq);
	
	// 내가 가진 id로 Seq 조회하기
	public List<AttachFile> selectAllRecordSeq(String memberId);
	
	
	
	
	
	
	
	
	// 전체 파일 가져오기 (모든 회원)
	public List<AttachFile> allAttachFiles();
}
