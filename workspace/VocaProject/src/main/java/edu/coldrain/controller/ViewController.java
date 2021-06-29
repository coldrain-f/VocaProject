package edu.coldrain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequiredArgsConstructor
public class ViewController {

	@GetMapping("/admin/book/list")
	public String bookList() {
		log.info("ViewController.bookList()");
		
		return "admin/book_list";
	}
	
	@GetMapping("/admin/category/list")
	public String categoryList() {
		log.info("ViewController.categoryList()");
		
		return "admin/category_list";
	}
}
