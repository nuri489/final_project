package likeinfo;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

public class LikeInfoController {

	/**
	 * 찜목록
	 * TODO: 현재 likeinfo-mapping.xml 에러남 확인 후 뿌려줘야함
	 * @param user_num 유저 식별자
	 */
	@GetMapping("/wish/{user_num}")
	public String getMemberWishList(@PathVariable int user_num, Model model) {
		List<LikeInfoDTO> dtos = member_service.getWishList(user_num);
		return "member/wishlist";
	}
}
