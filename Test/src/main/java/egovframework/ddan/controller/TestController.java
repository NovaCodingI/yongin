package egovframework.ddan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.ddan.service.MemberService;
import egovframework.ddan.service.MemberVo;

@Controller
public class TestController {

		@Autowired
		MemberService service;
	
		@GetMapping("/test")
		public String test(Model model) {
			
				
			try {
			
				List<MemberVo> list = service.getList();
				model.addAttribute("list", list);
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			return "test";
		}
		
		
		 
		
		
		
		
		
}
