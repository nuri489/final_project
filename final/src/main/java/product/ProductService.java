package product;

import java.util.HashMap;
import java.util.List;

public interface ProductService {
	
	List<ProductDetailDTO> getpdtDetailTags(String keyword);
	int insertSales(ProductDTO dto);
	int getLastInsertNum();
	List<String> getforSale(HashMap<String, String> map);
	List<ProductDTO> getProducts(ProductDTO dto);
	int likeProduct(ProductDTO dto);
	int unlikeProduct(ProductDTO dto);
	List<Integer> getLikeProduct(int user_num);
	List<ProductDTO> getAllProducts();
	List<ProductDTO> getProductsIdol(int idol_num);
	List<ProductDTO> getQuote(int detail_num);
	List<ProductDTO> getQuoteFilter(ProductDTO dto);
	int getProductDetailNum(String detail_name);
	
	List<ProductDTO> getSaleslist(int user_num);
}
