package final_project;

public class temp_ProductDTO {

	// 경매 요청 및 확인을 위한 임시 DTO
	
	int product_num , user_num , detail_num , product_price;
	String product_title , product_time;

	public String getProduct_title() {
		return product_title;
	}

	public void setProduct_title(String product_title) {
		this.product_title = product_title;
	}

	public String getProduct_time() {
		return product_time;
	}

	public void setProduct_time(String product_time) {
		this.product_time = product_time;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public int getUser_num() {
		return user_num;
	}

	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}

	public int getDetail_num() {
		return detail_num;
	}

	public void setDetail_num(int detail_num) {
		this.detail_num = detail_num;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	
	
}
