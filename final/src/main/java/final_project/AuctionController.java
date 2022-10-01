package final_project;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.MemberService;
import product.ProductDTO;

@Controller
public class AuctionController {
	
	@Autowired
	@Qualifier("auctionservice")
	AuctionService auction_service;
	
	@Autowired
	@Qualifier("memberservice")
	MemberService member_service;
	
	
	@GetMapping("/temp_main")
	public String Main() {
		return "temp_mainpage";
	}
	// 임시 메인
	
	@GetMapping("/temp_product")
	public ModelAndView temp_product(int product_num) {
		
		ModelAndView mv = new ModelAndView();
		ProductDTO dto = auction_service.product_info(product_num);
		// product_info 테이블에서 제품 정보 가져옴
		int request_num = auction_service.request_num(product_num);
		// auction_gauge 테이블에서 경매 요청 정보 가져옴
		
		mv.addObject("temp_dto",dto);
		mv.addObject("request_num",request_num);
		
		mv.setViewName("AuctionPage2");
		return mv;
	}
	// 임시 제품 상세 페이지. 제품에 대한 정보와 경매 요청 횟수를 모델로 넘김
	
	@ResponseBody
	@PostMapping("/auction_request")
	public int auctionRequest(int product_num , int user_num) {
		

		int request2 = auction_service.request_num2(product_num , user_num);
		// 로그인한 유저의 경매 요청에 대한 유무 확인. 0 또는 1
		
		if(request2 == 0) { // 요청한 적 없음
			auction_service.auction_request(product_num, user_num);
		}
		// auction_gauge에 insert
		// 해당 유저가 해당 글에 대한 요청이 이미 있으면 요청되지 않음

		int request = auction_service.request_num(product_num);
		// auction_gauge에서 select문으로 where product_num의 count 값 리턴
		
		return request;
	}
	// 경매 요청 및 횟수 조회
	
	
	@GetMapping("/request_accepting")
	public ModelAndView auctionAccepting(int product_num) {
		
		ModelAndView mv = new ModelAndView();
		ProductDTO dto = auction_service.product_info(product_num); 
		// 제품에 대한 정보 dto에 저장
		String user_id = member_service.user_id(auction_service.product_info(product_num).getUser_num());
		// 판매자 아이디
		String detail_name = auction_service.detail_name(auction_service.product_info(product_num).getDetail_num());
		// 상품 상세 이름
		
		mv.addObject("dto",dto);
		mv.addObject("user_id", user_id);
		mv.addObject("detail_name",detail_name);
		mv.setViewName("temp_AuctionPage");

		return mv;
	}
	// 경매로 전환 과정
	
	@GetMapping("/request_accepted")
	public String auctionAccepted(AuctionDTO dto) {
		
		int check = auction_service.auctionChecking(dto.product_num); // 경매 유무 확인

		if(check == 0) {
			auction_service.auctionCheck(dto.product_num); // auction_check 값 1로 바꿈
			auction_service.requestAccept(dto); // auction_info 테이블에 insert
			
			AuctionDTO dto1 = auction_service.auction_info(dto.product_num);
			int auction_num = dto1.auction_num;
			int user_num = dto.user_num;
			int bid_price = dto1.final_price;
			auction_service.bid_request(auction_num , user_num , bid_price);
			// auction_bid 테이블에 판매자의 user_num으로 첫번째 입찰 insert
		}
		// auction_info 테이블에 해당 제품에 대한 정보가 없을 시, insert 함
		// 최초 경매로 바꿀 때, 판매자의 정보로 해당 경매에 대한 입찰 정보 입력.
		// 즉, 최초 입찰자는 판매자 본인이며 입찰가는 원래 판매가와 동일함
		
		return "temp_mainpage";
	}
	// 경매로 전환
	
	@GetMapping("/auctionpage")
	public ModelAndView auctionpage(int product_num) {
		
		ModelAndView mv = new ModelAndView();

		
		auction_service.auctionCheck(product_num); // auction_check 값 1로 바꿈
		int check = auction_service.auctionChecking(product_num); // 경매 유무 확인
		
		ProductDTO dto2 = auction_service.product_info(product_num); 
		// 제품에 대한 상세 정보를 dto2에 저장
		String user_id = member_service.user_id(auction_service.product_info(product_num).getUser_num());
		// 상품 등록자 ID
		String detail_name = auction_service.detail_name(auction_service.product_info(product_num).getDetail_num());
		// 상품 상세 이름
		AuctionDTO dto1 = auction_service.auction_info(product_num);
		// 경매 정보 dto1에 저장
		
		if(check == 1) {
			mv.addObject("dto1",dto1);
			mv.addObject("dto2",dto2);
			mv.addObject("user_id", user_id);
			mv.addObject("detail_name",detail_name);
			
			mv.setViewName("AuctionPage");
		}
		else {
			mv.setViewName("temp_mainpage");
		}
		// product_info의 경매유무 값에 따라 경매글인지 아닌지 구분하여 연결

		return mv;
	}
	// 경매 판매글
	
	@ResponseBody
	@PostMapping("/open_bid")
	public int open_bid(int auction_num , int user_num , int bid_price , int product_num){
		
		int money = auction_service.usermoney(user_num);
		// 유저 보유 머니

		AuctionDTO dto = auction_service.auction_info(product_num);
		
		int last = auction_service.lastbid(auction_num);
		// 해당 상품의 최신 입찰자의 user_num 호출. 현재 입찰하려는 사람과 별개임
		int first = auction_service.firstbid(auction_num);
		// 첫번째 입찰자 = 판매자의 user_num 호출
		
		if(last == user_num) {
			return 1;
		}
		
		if(money >= bid_price) {
			
			if(last == user_num) {
				return 1;
			}
			// 최신 입찰자와 현재 입찰하려는 사람의 user_num이 같다면 입찰 불가
			
			else {
				
				auction_service.bid_request(auction_num , user_num , bid_price);
				// auction_bid에 입찰 정보 insert
				
				auction_service.updateprice(bid_price, auction_num);
				// auction_info의 final_price 업데이트
				
				auction_service.updatemoney(bid_price , user_num);
				// 입찰자의 보유머니 차감

				if(last != first) {
					auction_service.refundmoney(dto.final_price, last);
				}
				// last == fist는 판매자와 최신 입찰자가 같은 상황
				// 즉, 판매자가 경매로 바꾸고 아직 아무도 입찰을 하지 않은 상황
				// 새로운 사람이 입찰을 한다면 환불을 해줘야 하는 사람이 아무도 없으므로
				// last != first 일때만 last에게 환불해줌
				
				return 2;
			}
		}
		
		else {
			return 0;
		}
	}
	// 공개 경매의 입찰과정

	@ResponseBody
	@PostMapping("/private_bid")
	public int private_bid(int auction_num , int user_num , int bid_price , int product_num) {

		int check = auction_service.checkbid(auction_num, user_num);
		// 해당 제품에 대한 입찰여부. count(*)로 입찰횟수 리턴함
		int mybid = 0;
		
		if(check != 0) {
			mybid = auction_service.mybid(auction_num, user_num);
		}
		// 입찰을 한 기록이 있으면 예전 입찰가 호출
		
		if(check >= 1) {
			if(bid_price > mybid) {				
				auction_service.refundmoney(mybid, user_num);
			}
			else if(bid_price <= mybid) {
				return 3;
			}
		}
		// 이전 제시에 대한 환불
		
		int money = auction_service.usermoney(user_num);
		// 유저 보유 머니
		
		if(money >= bid_price) {
			
			if(check >= 1) {
				
				if(bid_price > mybid) {
					
					auction_service.bid_request(auction_num , user_num , bid_price);
					// auction_bid에 입찰 정보 insert
					
					auction_service.updatemoney(bid_price , user_num);
					// 입찰자의 보유머니 차감
					
					return 1;
				}
			}
			// 이미 해당 제품에 대하여 입찰을 한 상태
			
			else {
				
				auction_service.bid_request(auction_num , user_num , bid_price);
				// auction_bid에 입찰 정보 insert
				
				auction_service.updatemoney(bid_price , user_num);
				// 입찰자의 보유머니 차감
				
				return 2;
			}
		}

		return 0;
	}
	// 비공개 경매의 입찰과정
	
	@ResponseBody
	@PostMapping("/my_bid")
	public int mybid(int auction_num , int user_num) {
		
		int check = auction_service.checkbid(auction_num, user_num);
		// 해당 제품에 대한 입찰여부. count(*)로 입찰횟수 리턴함
		int mybid = 0;
		
		if(check != 0) {
			mybid = auction_service.mybid(auction_num, user_num);
		}
		// 예전에 입찰을 한 기록이 있다면 예전 입찰가 가져옴
		
		return mybid;
	}
	// 내 제시가 호출

}