package edu.coldrain.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.coldrain.domain.BookVO;
import edu.coldrain.domain.Criteria;
import edu.coldrain.domain.PageDTO;
import edu.coldrain.service.BookService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/book/*")
@RequiredArgsConstructor
public class BookController {
	
	private final BookService bookService;
	
	@GetMapping("/list")
	public String list(Criteria criteria, Model model) {
		log.info("BookController.list()");
		
		log.info("criteria = " + criteria);
		List<BookVO> books = bookService.getListWithPaging(criteria);
		model.addAttribute("books", books);
		model.addAttribute("pageDTO", new PageDTO(criteria, bookService.getTotalCount()));
		
		return "admin/book_list";
	}
	
	@PostMapping("/register")
	public String register(BookVO bookVO, Criteria criteria, RedirectAttributes rttr) {
		log.info("BookController.register()");
		
		log.info("bookVO = " + bookVO);
		
		//추가하면 무조건 1페이지로 이동한다.
		int page = 1;
		int amount = criteria.getAmount();
		
		boolean success = bookService.register(bookVO);
		if (success) {
			rttr.addFlashAttribute("result", "REGISTER SUCCESS");
		}
		
		return "redirect:/admin/book/list?page=" + page + "&amount=" + amount;
	}
	
	@PostMapping("/modify")
	public String modify(BookVO bookVO, Criteria criteria, RedirectAttributes rttr) {
		log.info("BookController.modify()");
		
		log.info("bookVO = " + bookVO);
		
		int page = criteria.getPage();
		int amount = criteria.getAmount();
		
		boolean success = bookService.modify(bookVO);
		if (success) {
			rttr.addFlashAttribute("result", "MODIFY SUCCESS");
		}
		
		return "redirect:/admin/book/list?page=" + page + "&amount=" + amount;
	}
	
	@PostMapping("/remove")
	public String remove(BookVO bookVO, Criteria criteria, RedirectAttributes rttr) {
		log.info("BookController.remove()");
		
		log.info("bookVO = " + bookVO);
		
		int page = criteria.getPage();
		int amount = criteria.getAmount();
		
		boolean success = bookService.remove(bookVO.getBookId());
		if (success) {
			rttr.addFlashAttribute("result", "REMOVE SUCCESS");
		}
		
		return "redirect:/admin/book/list?page=" + page + "&amount=" + amount;
	}
}
