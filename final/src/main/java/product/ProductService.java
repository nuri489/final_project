package product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ProductService {
	
	List<ProductDetailDTO> getpdtDetailTags(String keyword);
	int insertSales(ProductDTO dto);
	int getLastInsertNum();
	List<String> getforSale(HashMap<String, String> map);
	List<ProductDTO> getProducts(ProductDTO dto);
	int likeProduct(ProductDTO dto);
	int unlikeProduct(ProductDTO dto);
	List<Integer> getLikeProduct(int user_num);
}
