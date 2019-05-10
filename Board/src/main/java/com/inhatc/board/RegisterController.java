package com.inhatc.board;

import java.util.HashMap;
import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpSession;

import com.inhatc.domain.RegisterVO;
import com.inhatc.service.RegisterService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class RegisterController {
	
	@Inject
	RegisterService service;

	@RequestMapping(value = "/login/signup", method = RequestMethod.GET)
	public void login() {
	}	
	
	@RequestMapping(value = "/login/checkid", method = RequestMethod.POST)
	     @ResponseBody 
	      public Object idcheck(Model model, RegisterVO vo) throws Exception {
		  HashMap<String, Object> paramMap = new HashMap<String, Object>();
	      int result = service.idcheck(vo);
	      System.out.println(result);
	      paramMap.put("result", result);
	      return paramMap;
	   }
	@RequestMapping(value = "/login/checkemail", method = RequestMethod.POST)
    @ResponseBody 
     public Object emailcheck(Model model, RegisterVO vo) throws Exception {
	  HashMap<String, Object> paramMap = new HashMap<String, Object>();
     int result = service.emailcheck(vo);
     System.out.println(result);
     paramMap.put("result", result);
     return paramMap;
  }	
	@RequestMapping(value = "/login/signup", method = RequestMethod.POST)
	public String register(RegisterVO vo, Model model, RedirectAttributes rttr) throws Exception {
		System.out.println("test");
		int result=service.register(vo);
		if(result==1){
			System.out.println("회원가입성공");
			rttr.addFlashAttribute("success","success");
			 return "redirect:/";
		}else{
			System.out.println("회원가입실패");
			model.addAttribute("success","fail");
			return "/login/signup";	
		}
	}	
}