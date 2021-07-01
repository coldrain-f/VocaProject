package edu.coldrain.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.coldrain.domain.BookVO;
import edu.coldrain.domain.CategoryVO;
import edu.coldrain.service.BookService;
import edu.coldrain.service.CategoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/category/*")
public class CategoryController {
	
	private final CategoryService categoryService;
	private final BookService bookService;

	@GetMapping("/list")
	public String list(Long bookId, Model model) {
		log.info("CategoryController.list()");
		
		//책 셀렉트 박스 초기화 설정
		List<BookVO> books = bookService.getList();
		Collections.reverse(books);
		model.addAttribute("books", books);
		
		log.info("bookId = " + bookId);
		
		//최초 리스트 페이지 요청시 bookId는 null이다.
		if (bookId != null) { //카테고리 조회 버튼을 클릭하면 이벤트 처리
			//책의 아이디로 소속된 모든 카테고리를 가지고 온다.
			List<CategoryVO> categories = categoryService.getListByBookId(bookId);
			model.addAttribute("categories", categories);
			
			//조회된 책이 selected가 되도록 bookId를 모델에 담는다.
			model.addAttribute("bookId", bookId);
		}
		
		return "admin/category_list";
	}
	
	@PostMapping("/register")
	public String register(CategoryVO categoryVO, RedirectAttributes rttr) {
		log.info("CategoryController.register()");
		
		log.info("categoryVO = " + categoryVO);
		Long bookId = categoryVO.getBookId();
		//최초 리스트 접근시 추가하기 버튼을 누르면 bookId가 없다. 나중에 처리해야 한다.
		boolean success = categoryService.register(categoryVO);
		
		if (success) {
			rttr.addFlashAttribute("result", "REGISTER SUCCESS");
		}
		
		return "redirect:/admin/category/list?bookId=" + bookId;
	}
	
	@PostMapping("/modify")
	public String modify(CategoryVO categoryVO, RedirectAttributes rttr) {
		log.info("CategoryController.modify()");
		
		log.info("categoryVO = " + categoryVO);
		
		boolean success = categoryService.modify(categoryVO);
		Long bookId = categoryVO.getBookId();
		
		if (success) {
			rttr.addFlashAttribute("result", "MODIFY SUCCESS");
		}
		
		return "redirect:/admin/category/list?bookId=" + bookId;
	}
	
	@PostMapping("/remove")
	public String remove(CategoryVO categoryVO, RedirectAttributes rttr) {
		log.info("CategoryController.remove()");
		
		log.info("categoryVO = " + categoryVO);
		boolean success = categoryService.remove(categoryVO.getCategoryId());
		Long bookId = categoryVO.getBookId();
		
		if (success) {
			rttr.addFlashAttribute("result", "REMOVE SUCCESS");
		}
		return "redirect:/admin/category/list?bookId=" + bookId;
	}
}
