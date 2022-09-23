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
}
