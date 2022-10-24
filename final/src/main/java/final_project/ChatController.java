package final_project;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatController {
	
	@GetMapping("/chat")
	public ModelAndView chatt() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("Chat");
		return mv;
	}
    
    
}
