package com.inhatc.board;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inhatc.domain.BoardVO;
import com.inhatc.domain.Criteria;
import com.inhatc.domain.Search;
import com.inhatc.service.BoardService;
import com.inhatc.service.CommentService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	BoardService service;
	
	@Inject
	CommentService com_service;
	
	@RequestMapping(value="/")
	public String start() {
		return "/login/login";
	}
	
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String boardSearch(Model model, Criteria cri, Search sch, HttpSession session) throws Exception {
		cri.setSizeOfPage(10);
		cri.setNumberOfRecords(service.searchBoardCount(sch));
		cri.makePaging();
		if(session.getAttribute("id") != null) {
			model.addAttribute("session", "yes");
			model.addAttribute("id", session.getAttribute("id"));
		}
		model.addAttribute("page", service.search(sch, cri));
		model.addAttribute("pager", cri); 
		model.addAttribute("search", sch);
		return "/board/board";
	}	
	
	@RequestMapping(value = "/board/read", method = RequestMethod.GET)
	public void read(Model model, @RequestParam("bno") int bno, Criteria cri, Search sch, HttpSession session) throws Exception {
		logger.info("뷰페이지");
		service.add_hits(bno);
		model.addAttribute("post", service.read(bno));
		model.addAttribute("comment", com_service.commentSearch(bno));
		model.addAttribute("cri", cri);
		model.addAttribute("search", sch);
		if(session.getAttribute("id") != null) {
			model.addAttribute("session", "yes");
			model.addAttribute("id", session.getAttribute("id"));
		}
	}
	
	@RequestMapping(value = "/board/modify", method = RequestMethod.GET)
	public void modify(Model model, @RequestParam("bno") int bno, Criteria cri, Search sch, HttpSession session) throws Exception {
		logger.info("수정페이지");
		model.addAttribute("post", service.read(bno));
		model.addAttribute("cri", cri);
		model.addAttribute("search", sch);
		if(session.getAttribute("id") != null) {
			model.addAttribute("session", "yes");
			model.addAttribute("id", session.getAttribute("id"));
		}
	}
	
	@RequestMapping(value = "/board/modify", method = RequestMethod.POST)
	public String modify_post(Model model, BoardVO vo, HttpSession session) throws Exception {
		logger.info("수정완료");
		System.out.println(vo.getTitle());
		vo.setId(session.getAttribute("id").toString());
		service.update_post(vo);
	      if(session.getAttribute("id") != null){
	          model.addAttribute("session", "yes");
	          model.addAttribute("id", session.getAttribute("id"));
	       }
		return "redirect:/board/read?bno="+vo.getBno();
	}
	
	@RequestMapping(value = "/board/delete", method = RequestMethod.POST)
	public String delete(Model model, BoardVO vo, HttpSession session) throws Exception {
		logger.info("삭제완료");
		service.delete_post(vo.getBno());
	      if(session.getAttribute("id") != null){
	          model.addAttribute("session", "yes");
	          model.addAttribute("id", session.getAttribute("id"));
	       }
		return "redirect:/board";	
	}
	
	@RequestMapping(value = "/board/write", method = RequestMethod.GET)
	public void write(Model model, Criteria cri, BoardVO vo, Search sch, HttpSession session) throws Exception {
		logger.info("글쓰기 페이지");
		model.addAttribute("cri", cri);
		model.addAttribute("search", sch);
		if(session.getAttribute("id") != null) {
			model.addAttribute("session", "yes");
			model.addAttribute("id", session.getAttribute("id"));
		}
	}
	
	@RequestMapping(value = "/board/write", method = RequestMethod.POST)
	public String write_post(Model model, BoardVO vo, HttpSession session) throws Exception {
		logger.info("쓰기완료");
		vo.setId(session.getAttribute("id").toString());	
		
		service.write_post(vo);
	      if(session.getAttribute("id") != null){
	          model.addAttribute("session", "yes");
	          model.addAttribute("id", session.getAttribute("id"));
	       }
		return "redirect:/board";		
	}
	@RequestMapping(value = "/board/likenum", method = RequestMethod.POST)
	public @ResponseBody int add_likenum(Model model, BoardVO vo) throws Exception {
			int result = service.add_likenum(vo.getBno());
			System.out.println(result);
		    return result;
		  }	
	  @RequestMapping(value = "/getAttach/{bno}")
	  @ResponseBody
	  public List<String> getAttach(@PathVariable("bno")Integer bno)throws Exception{
	    return service.getAttach(bno);
	  }  	
}