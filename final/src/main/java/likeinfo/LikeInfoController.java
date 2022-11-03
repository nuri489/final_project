package likeinfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import member.MemberService;

@Controller
public class LikeInfoController {

	
	@Autowired
	@Qualifier("memberservice")
	MemberService member_service;
	
	@Autowired
	@Qualifier("likeinfoservice")
	LikeInfoService likeinfoservice;
	
	/**
	 * 찜목록
	 * TODO: 현재 likeinfo-mapping.xml 에러남 확인 후 뿌려줘야함
	 * @param user_num 유저 식별자
	 */

	@GetMapping("/wish/{user_num}")
	public String getMemberWishList(@PathVariable int user_num, Model model) {
		List<LikeInfoDTO> dtos = likeinfoservice.getWishList(user_num);
		System.out.println(dtos);
		model.addAttribute("dtos", dtos);
		return "likeinfo/wishlist";
	
	}
	// 찜 목록 수량 수정
	//@PostMapping("/wish/update")
	
	
	@GetMapping("/wish2")
	public ModelAndView ggg(int user_num) {
		List<LikeInfoDTO> dto = likeinfoservice.getWishList(user_num);
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("dto",dto);
		mv.setViewName("likeinfo/wishlist2");
		return mv;
	}

	
}
