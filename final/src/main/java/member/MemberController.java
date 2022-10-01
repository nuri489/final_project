package member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import final_project.AuctionService;

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


}
