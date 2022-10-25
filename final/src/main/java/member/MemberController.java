package member;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import final_project.AuctionService;
import likeinfo.LikeInfoDTO;
import product.ProductDTO;

@Controller
public class MemberController {
	
	@Autowired
	@Qualifier("auctionservice")
	AuctionService auction_service;
	
	@Autowired
	@Qualifier("memberservice")
	MemberService member_service;
	
	
	@GetMapping("/loginform")
	public String login() {
		return "member/loginform";
	}
	
	@ResponseBody
	@PostMapping("/login")
	public int loginprocess(String id, String password , HttpServletRequest request) {

		int check = member_service.login(id, password);
		
		if(check == 1) {
			HttpSession session = request.getSession();
			int user_num = member_service.user_num(id);
			session.setAttribute("sessionUser_num", user_num);
			return 1;
		}
		// 해당 아이디와 비밀번호가 맞는 계정이 있다면 로그인 성공
		
		else {
			return 0;
		}
	}
	// 로그인
	
	@ResponseBody
	@PostMapping("/logout")
	public int logout(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("sessionUser_num") != null) {
			session.removeAttribute("sessionUser_num");
		}
		else {
			session.setAttribute("sessionUser_num", null);
		}
		return 1;
	}
	// 로그아웃

	//회원가입
	@GetMapping("/memberjoin")
	public String writingform() {
		return "member/joinform";
	}
	
	@RequestMapping("/memberjoin" )
	public ModelAndView memberjoin(MemberDTO dto) {
		int insertcount = member_service.registerMember(dto);
		ModelAndView mv = new ModelAndView();
		mv.addObject("insertcount", insertcount);
		mv.setViewName("member/joinprocess");
		return mv;
	}
	
	//[승희] 본인 판매글 모아보기
		@RequestMapping("/sellproductlist")
		@ResponseBody
		public ModelAndView sellproductlist(HttpServletRequest request){
			ModelAndView mv = new ModelAndView();
			ProductDTO dto = new ProductDTO();
			
			HttpSession session = request.getSession();
			int user_num = Integer.parseInt(String.valueOf(session.getAttribute("sessionUser_num")));
			String user_id = String.valueOf(session.getAttribute("sessionUser_id"));
			
			List<ProductDTO> productlist = member_service.getProductList(user_num);
			
			if(user_id != null) {
				mv.addObject("sellproductlist", productlist);
				mv.setViewName("member/sellproductlist");
			}
			else {
				mv.setViewName("temp_mainpage");
			}
			return mv;
		}
		/**
		 * 마이페이지 
		 * @param user_num 유저식별자
		 */
		@GetMapping("/my/{user_num}")
		public String getMemberMyPage(@PathVariable int user_num, Model model) {
			MemberDTO dto = member_service.getUser(user_num);
			model.addAttribute("user", dto);
			return "member/mypage";
		}

		@GetMapping("/wish/{user_num}")
		public String getMemberWishList(@PathVariable int user_num, Model model) {
			List<LikeInfoDTO> dtos = member_service.getWishList(user_num);
			return "member/wishlist";
		}	
		
		/* 회원정보 수정
		@ResponseBody
		@PutMapping("/update")
		public int userupdate() {
			
		} */

	
}
