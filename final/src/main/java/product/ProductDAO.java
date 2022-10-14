package product;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository("productdao")
public interface ProductDAO {

	List<ProductDetailDTO> getpdtDetailTags(String keyword);
	int insertSales(ProductDTO dto);
	int getLastInsertNum();
	List<String> getforSale(HashMap<String, String> map);
	List<ProductDTO> getProducts(ProductDTO dto);
	int likeProduct(ProductDTO dto);
	int unlikeProduct(ProductDTO dto);
	List<Integer> getLikeProduct(int user_num);
	
	List<ProductDTO> getBuying_list(int buyer_num);
	// 구매목록과 구매목록에 표시될 리스트의 count

	List<ProductDTO> getAllProducts();
	List<ProductDTO> getProductsIdol(int idol_num);

}
