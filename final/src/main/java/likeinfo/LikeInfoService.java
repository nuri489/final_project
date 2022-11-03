package likeinfo;

import java.util.List;

public interface LikeInfoService {
	//찜 목록
	public List<LikeInfoDTO> getWishList(int user_num);
	// 찜 목록 리스트
	//public List<LikeInfoDTO> getWishList(String memberId);
	// 찜 수량 수정
	//public int modifyCount(LikeInfoDTO likeinfo);
	// 찜 삭제
	//public int deleteLikeInfo(int likeinfoId);
}
