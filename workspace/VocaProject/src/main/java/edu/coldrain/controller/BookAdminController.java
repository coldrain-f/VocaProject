package edu.coldrain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/book/*")
@RequiredArgsConstructor
public class BookAdminController {

	@GetMapping("/list")
	public String list(Model model) {
		log.info("BookAdminController.list()");
		
		return "admin/book_list";
	}
}
