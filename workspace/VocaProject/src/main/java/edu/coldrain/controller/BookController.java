package edu.coldrain.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.coldrain.domain.BookVO;
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
	public String list(Model model) {
		log.info("BookController.list()");
		
		List<BookVO> books = bookService.getList();
		model.addAttribute("books", books);
		
		return "admin/book_list";
	}
	
	@PostMapping("/register")
	public String register(BookVO bookVO, RedirectAttributes rttr) {
		log.info("BookController.register()");
		
		log.info("bookVO = " + bookVO);
		boolean success = bookService.register(bookVO);
		if (success) {
			rttr.addFlashAttribute("result", "REGISTER SUCCESS");
		}
		
		return "redirect:/admin/book/list";
	}
	
	@PostMapping("/modify")
	public String modify(BookVO bookVO, RedirectAttributes rttr) {
		log.info("BookController.modify()");
		
		log.info("bookVO = " + bookVO);
		boolean success = bookService.modify(bookVO);
		if (success) {
			rttr.addFlashAttribute("result", "MODIFY SUCCESS");
		}
		
		return "redirect:/admin/book/list";
	}
	
	@PostMapping("/remove")
	public String remove(BookVO bookVO, RedirectAttributes rttr) {
		log.info("BookController.remove()");
		
		log.info("bookVO = " + bookVO);
		boolean success = bookService.remove(bookVO.getBookId());
		if (success) {
			rttr.addFlashAttribute("result", "REMOVE SUCCESS");
		}
		
		return "redirect:/admin/book/list";
	}
}
