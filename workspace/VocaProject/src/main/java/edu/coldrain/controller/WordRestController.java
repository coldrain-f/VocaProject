package edu.coldrain.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import edu.coldrain.domain.WordVO;
import edu.coldrain.service.CategoryService;
import edu.coldrain.service.WordService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequiredArgsConstructor
public class WordRestController {

	private final WordService service;
	private final CategoryService categoryService;
	
	/*    ------ RestFul API 설계
	 * 	  /words GET 모든 단어 목록 조회하기 -------- 당장 구현X
	 *    /categories/{categoryId}/words GET 1번 카테고리에 소속된 단어 목록 조회하기
	 *    /categories/{categoryId}/words/new POST 1번 카테고리에 단어 추가하기
	 *    /words/{wordId} GET 1번 단어 조회하기
	 *    /words/{wordId} PUT/PATCH 1번 단어 수정하기
	 *    /words/{wordId} DELETE 1번 단어 삭제하기
	 */
	
	//특정 카테고리에 소속된 단어 목록 조회하기
	@GetMapping(value = "/categories/{categoryId}/words",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<WordVO>> getList(@PathVariable("categoryId") Long categoryId) {
		log.info("WordController.getList()");
		
		List<WordVO> list = service.getListByCategoryId(categoryId);
		list.forEach(word -> log.info(word));
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//특정 카테고리에 소속된 단어 목록 조회하기 ( 랜덤 1/4/7/14 학습법 적용 )
	@GetMapping(value = "/categories/{categoryId}/words/shuffle",
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<WordVO>> getShuffleList(@PathVariable("categoryId") Long categoryId) {
		log.info("WordController.getShuffleList()");
		
		//카테고리 번호로 bookId를 조회한다.
		Long bookId = categoryService.get(categoryId).getBookId();
		
		//카테고리 번호로 해당하는 ROWNUM을 조회한다.
		Long rownum = service.getRownumByCategoryId(categoryId, bookId);
		
		//조회된 rownum으로 단어 목록을 조회한다.
		List<WordVO> list = service.getListByRownum(rownum, bookId);
		//Collections.shuffle(list);
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//특정 카테고리에 단어 추가하기
	@PostMapping(value = "/categories/{categoryId}/words/new",
				 consumes = MediaType.APPLICATION_JSON_VALUE,
				 produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody WordVO wordVO, @PathVariable("categoryId") Long categoryId) {
		log.info("WordController.register()");
		
		//{"categoryId" :1, "wordName": "spice", "wordMeaning": "양념"}
		boolean success = service.register(wordVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(categoryId + "번 카테고리의 단어 추가에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(categoryId + "번 카테고리의 단어 추가에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 단어 조회하기
	@GetMapping(value = "/words/{wordId}",
			    produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<WordVO> get(@PathVariable("wordId") Long wordId) {
		log.info("WordController.get()");
		
		WordVO wordVO = service.get(wordId);
		
		ResponseEntity<WordVO> responseEntity = null;
		
		if (wordVO != null) {
			log.info(wordId + "번 단어 조회에 성공했습니다.");
			responseEntity = new ResponseEntity<>(wordVO, HttpStatus.OK);
			
		} else {
			log.info(wordId + "번 단어 조회에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 단어 수정하기
	@PatchMapping(value = "/words/{wordId}",
				  consumes = MediaType.APPLICATION_JSON_VALUE,
				  produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody WordVO wordVO, @PathVariable("wordId") Long wordId) {
		log.info("WordController.modify()");
		
		//{"wordId": 41, "wordName": "remove", "wordMeaning": "제거하다"}
		boolean success = service.modify(wordVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(wordId +"번 단어 수정에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(wordId +"번 단어 수정에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	
	//특정 단어 삭제하기
	@DeleteMapping(value = "/words/{wordId}",
				   produces = MediaType.TEXT_XML_VALUE)
	public ResponseEntity<String> remove(@PathVariable("wordId") Long wordId) {
		log.info("WordController.remove()");
		
		boolean success = service.remove(wordId);
		
		ResponseEntity<String> responseEntity = null;

		if (success) {
			log.info(wordId + "번 단어 삭제에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(wordId + "번 단어 삭제에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
}
