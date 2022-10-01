package final_project;

import product.ProductDTO;

public interface AuctionService {

	public int auction_request(int product_num , int user_num);
	public int request_num(int product_num);
	public int request_num2(int product_num, int user_num);
	
	public int requestAccept(AuctionDTO dto);
	public int auctionCheck(int product_num);
	
	public int auctionChecking(int product_num);
	
	public AuctionDTO auction_info(int product_num);
	public ProductDTO product_info(int product_num);
	
	public int user_num(String user_id);
	// 임시 유저 고유 번호 호출
	public String user_id(int user_num);
	// 임시 유저 아이디 호출
	
	public String detail_name(int detail_num);
	// detail_name 호출
	
	public int bid_request(int auction_num , int user_num , int bid_price);
	// 입찰
	
	public int checkbid(int auction_num , int user_num);
	// 비공개 입찰에서 입찰여부 조회
	public int lastbid(int auction_num);
	// 최신 입찰자 user_num 호출
	public int firstbid(int auction_num);
	// 판매자의 user_num 호출
	
	public int updateprice(int bid_price , int auction_num);
	// auction_info의 fianl_price 값 update
	
	public int mybid(int auction_num , int user_num);
	// 어떤 경매에 대한 내 제시가
	public int usermoney(int user_num);
	// 유저 보유 머니 호출
	public int updatemoney(int final_price , int user_num);
	// 입찰자의 보유 머니 차감
	public int refundmoney(int final_price , int user_num);
	// 입찰자의 보유 머니 환불
	
}
