package edu.coldrain.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.coldrain.domain.WordVO;
import edu.coldrain.service.WordService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/word/*")
public class WordController {

	private final WordService service;
	
	
	@GetMapping("/list")
	public String list(Long bookId, Long categoryId, Model model) {
		log.info("WordController.list()");

		if ( !isEmpty(bookId, categoryId) ) {
			List<WordVO> words = service.getListByCategoryId(categoryId);
			model.addAttribute("words", words);
			model.addAttribute("bookId", bookId);
			model.addAttribute("categoryId", categoryId);
		} else if (categoryId != null && categoryId == -1) {
			model.addAttribute("result", "NOT FOUND CATEGORY");
		}
		
		return "admin/word_list";
	}
	
	@PostMapping("/remove")
	public String remove(WordVO wordVO, Long bookId, Long categoryId, RedirectAttributes rttr) {
		log.info("WordController.remove()");
		
		log.info(wordVO);
		log.info("bookId = " + bookId);
		log.info("categoryId = " + categoryId);
		
		boolean success = service.remove(wordVO.getWordId());
		//삭제 성공 메시지를 전달해 준다.
		if (success) {
			rttr.addFlashAttribute("result", "REMOVE SUCCESS");
		}
		
		return "redirect:/admin/word/list?bookId=" + bookId + "&categoryId=" + categoryId;
	}
	
	@PostMapping("/modify")
	public String modify(WordVO wordVO, Long bookId, Long categoryId, RedirectAttributes rttr) {
		
		log.info("WordController.modify()");
		
		log.info(wordVO);
		log.info("bookId = " + bookId);
		log.info("categoryId = " + categoryId);
		
		boolean success = service.modify(wordVO);
		//수정 성공 메시지를 전달해 준다.
		if (success) {
			rttr.addFlashAttribute("result", "MODIFY SUCCESS");
		}
		
		return "redirect:/admin/word/list?bookId=" + bookId + "&categoryId=" + categoryId;
	}
	
	@PostMapping("/register")
	public String register(WordVO wordVO, Long bookId, Long categoryId, RedirectAttributes rttr) {
		log.info("WordController.register()");
		
		log.info(wordVO);
		log.info("bookId = " + bookId);
		log.info("categoryId = " + categoryId);
		
		boolean success = service.register(wordVO);
		//등록 성공 메시지를 전달해 준다.
		if (success) {
			rttr.addFlashAttribute("result", "REGISTER SUCCESS");
		}
		
		return "redirect:/admin/word/list?bookId=" + bookId + "&categoryId=" + categoryId;
	}
	
	//파라미터 검증
	private static boolean isEmpty(Long bookId, Long categoryId) {
		//나중에 bookId = -1도 체크해야 된다.
		if (bookId == null || categoryId == null || categoryId == -1) {
			return true;
		}
		return false;
	}
	
}
