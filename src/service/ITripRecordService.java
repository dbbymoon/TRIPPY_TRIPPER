package service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import model.AttachFile;
import model.TripRecord;

public interface ITripRecordService {

	// 다이어리 글 작성
	public boolean myDiaryWrite(TripRecord tripRecord, List<MultipartFile> files);

	// 내가 작성한 게시글 파일 이름 전부 받아오기
	public List<AttachFile> selectAllMyAttachFileName(String memberId);

	// 내가 작성한 게시글 번호로 가져오기
	public TripRecord selectOneMyRecord(int recordSeq);

	// 내가 작성한 게시글의 사진 가져오기
	public List<AttachFile> selectAllAttachfileByRecordSeq(int recordSeq);

	// 내가 작성한 게시글 전부 가져오기
	public List<TripRecord> selectAllMyRecordList(String memberId);

	// 업로드 할 이미지 사이즈 가공하기
	public void imageResizing(String filePath, String fullName, String fileExt, Map<String, Object> params);

	// 다이어리 삭제
	public boolean myDiaryDelete(int recordSeq);

	// 다이어리 수정
	public boolean myDiaryModify(TripRecord tripRecord);

	// 내가 작성한 게시글 대표사진 가져오기
	public List<AttachFile> selectAllThumnailImg(String memberId);

	// 게시글 중 Secret이 공개인 사진만 대표사진 가져오기
	public List<AttachFile> selectAllmemberImgByPublic(String memberId);

	//모든 게시글 가져오기
	public List<Map<String, Object>> selectAllTripRecord();
}
