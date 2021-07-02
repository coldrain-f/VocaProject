package edu.coldrain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LearnController {

	@GetMapping("/home/learn")
	public void learn() {
		log.info("LearnController.learn()");
		
	}
}
