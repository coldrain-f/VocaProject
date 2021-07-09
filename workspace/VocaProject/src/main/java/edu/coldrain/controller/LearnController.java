package edu.coldrain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LearnController {

	
	@GetMapping("/home/learn")
	public String learn() {
		log.info("LearnController.learnTest()");
		
		//나중에 이름 learn으로 변경해야 됨
		return "/home/learn2";
	}
	
	@GetMapping("/home/learnOld")
	public String learnOld() {
		
		return "/home/learn";
	}
}
