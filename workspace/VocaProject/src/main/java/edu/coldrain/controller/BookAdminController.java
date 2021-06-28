package edu.coldrain.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.coldrain.domain.BookVO;
import edu.coldrain.service.BookService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/book/*")
@RequiredArgsConstructor
public class BookAdminController {
	
	private final BookService bookService;

	@GetMapping("/list")
	public String list(Model model) {
		log.info("BookAdminController.list()");
		
		List<BookVO> books = bookService.getList();
		model.addAttribute("books", books);
		
		return "admin/book_list";
	}
}
