package product;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import upload.UploadDTO;
import upload.UploadService;

@Controller
public class ProductController {
	
	@Autowired
	@Qualifier("productservice")
	ProductService pdtService;
	
	@Autowired
	@Qualifier("uploadservice")
	UploadService uploadService;
	
	@RequestMapping("/getsalesform")
	public String getSalesForm() {
		
		return "product/salesform";
	}
	
	@RequestMapping("/insertsales")
	public String insertSales(ProductDTO dto) throws IOException {
		String savePath="/Users/choiyoonseo/Documents/final_images/"; //이거 수정하세용~!! C://final_images/
		
		int last_insert_pdt_num = 0;
		dto.setUser_num(1);
		UploadDTO uploaddto = new UploadDTO();
		int insert_result = pdtService.insertSales(dto);
		String [] imgexp = {"jpg","jfif","png","jpeg"}; //업로드 가능한 이미지 확장자들
		
		if(dto.getImages().length!=0) {   //---파일이 있을 경우만 저장 
			if(insert_result>0) { // 파일이 있고 게시물이 성공적으로 저장되었을 때 파일 저장
				last_insert_pdt_num = pdtService.getLastInsertNum();
				uploaddto.setProduct_num(last_insert_pdt_num); //마지막 저장된 테이블의 PK가져옴
				
				for(int i=0;i<dto.getImages().length;i++) {
					String filename = dto.getImages()[i].getOriginalFilename();   //--- 파일명을 얻어옴. a.txt
					String beforeext1 = filename.substring(0, filename.indexOf("."));  //a
					String ext1 = filename.substring(filename.indexOf("."));  //.txt
					ext1 = ext1.substring(1); //txt
					
					//확장자가 이미지일때만 난수 붙여 파일 저장후 DB에 기록
					for(int j=0;j<imgexp.length;j++) {
						if(imgexp[j].equals(ext1)) {
							String newname1 = beforeext1 +"(" +UUID.randomUUID().toString() +")"+ ext1;
							uploaddto.setImage_path(newname1);
							File servefile1 = new File(savePath+newname1);
							dto.getImages()[i].transferTo(servefile1); 
							uploadService.insertFile(uploaddto);
						} //if end
					} //inner end
				} //outer end
			}
		}
		
		return "product/salesform";
	}
	
	//상품판매글 등록시 디테일 태그 보여주기
	@RequestMapping(value="/getpdtdetailtags", produces= {"application/json;charset=utf-8"})
	@ResponseBody
	public List<ProductDetailDTO> getpdtDetailTags(String keyword) {
		keyword = "%"+keyword+"%";
		List<ProductDetailDTO> tag_result = pdtService.getpdtDetailTags(keyword);
		return tag_result;
	}

	
}
