package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.TReplyDao;
import model.TReply;

@Service
public class TReplyService implements ITReplyService {

	@Autowired
	private TReplyDao tReplyDao;

	@Override
	// 댓글 추가(대댓글X)
	public int insertReply(TReply tReply) {
		int result = 0;
		//tReply에 @+memberId가 있으면 대댓글
		//없으면 그냥 댓글임
		
		if(tReply.getReplyContent().contains("@")) {
			// 대댓글이 달릴 댓글의 대댓글 수 가져오기
			int depth = tReplyDao.getReplyCount(tReply.getReplyNum());
			tReply.setDepth(depth);
			
			if (tReplyDao.insertReplyOfReply(tReply) > 0) {
				result = 1;
			}
		}else {
			// 그냥 댓글일 경우
			tReply.setDepth(0);
			System.out.println(tReply);

			if (tReplyDao.insertReply(tReply) > 0) {
				result = 1;
			}
		}
		return result;
	}

	@Override
	// 특정 게시글의 모든 댓글 조회
	public List<TReply> selectAllReply(int recordSeq) {
		return tReplyDao.selectAllReply(recordSeq);
	}

	@Override
	// 댓글 삭제
	public int deleteReply(int tReplySeq) {
		//만약 삭제하려는 댓글의 depth가 0이면 같은 replyNum을 가진 댓글 전부 삭제
		TReply treply = tReplyDao.selectOneReply(tReplySeq);

		if(treply.getDepth() == 0) {
			return tReplyDao.deleteAllReplyforReplyNum(treply.getReplyNum());
		}else {
			//만약 삭제하려는 댓글의 depth가 0이 아니면 선택한 댓글 하나만 삭제
			return tReplyDao.deleteReply(tReplySeq);
		}
	}
}
