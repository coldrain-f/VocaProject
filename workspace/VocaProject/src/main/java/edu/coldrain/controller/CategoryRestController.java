package edu.coldrain.controller;

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

import edu.coldrain.domain.CategoryVO;
import edu.coldrain.service.CategoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequiredArgsConstructor
public class CategoryRestController {

	private final CategoryService service;
	
	/*    ------ RestFul API 설계
	 * 	  /categories GET 모든 카테고리 목록 조회하기 -------- 당장 구현X
	 *    /books/{bookId}/categories GET 1번 책에 소속된 카테고리 목록 조회하기
	 *    /books/{bookId}/categories/new POST 1번 책에 카테고리 추가하기
	 *    /categories/{categoryId} GET 1번 카테고리 조회하기
	 *    /categories/{categoryId} PUT/PATCH 1번 카테고리 수정하기
	 *    /categories/{categoryId} DELETE 1번 카테고리 삭제하기
	 */
	
	//특정 책의 모든 카테고리 목록 조회하기 (내림차순)
	@GetMapping(value = "/books/{bookId}/categories",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CategoryVO>> getList(@PathVariable("bookId") Long bookId) {
		log.info("CategoryController.getList()");
		
		List<CategoryVO> list = service.getListByBookId(bookId);
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//특정 책에 카테고리 추가하기
	@PostMapping(value = "/books/{bookId}/categories/new",
				 consumes = MediaType.APPLICATION_JSON_VALUE,
				 produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody CategoryVO categoryVO, @PathVariable("bookId") Long bookId) {
		log.info("CategoryController.register()");
		
		// {"bookId": 5, "categoryName": "Unit 01 - 요리"}
		boolean success = service.register(categoryVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(bookId + "번 책의 카테고리 추가에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(bookId + "번 책의 카테고리 추가에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 카테고리 조회하기
	@GetMapping(value = "/categories/{categoryId}",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CategoryVO> get(@PathVariable("categoryId") Long categoryId) {
		log.info("CategoryController.get()");
		
		CategoryVO categoryVO = service.get(categoryId);
		
		ResponseEntity<CategoryVO> responseEntity = null;
		
		if (categoryVO != null) {
			log.info(categoryId + "번 카테고리 조회에 성공했습니다.");
			responseEntity = new ResponseEntity<>(categoryVO, HttpStatus.OK);
		} else {
			log.info(categoryId + "번 카테고리 조회에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 카테고리 수정하기
	@PatchMapping(value = "/categories/{categoryId}",
				  consumes = MediaType.APPLICATION_JSON_VALUE,
				  produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody CategoryVO categoryVO, @PathVariable("categoryId") Long categoryId) {
		log.info("CategoryController.modify()");
	
		ResponseEntity<String> responseEntity = null;
	
		//클라이언트 요청: {"categoryId": "1", "categoryName": "Unit 01 - 요리"}
		boolean success = service.modify(categoryVO);
		
		if (success) {
			log.info(categoryId + "번 카테고리 수정에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(categoryId + "번 카테고리 수정에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 카테고리 삭제하기
	@DeleteMapping(value = "/categories/{categoryId}",
				   produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("categoryId") Long categoryId) {
		log.info("CategoryController.remove()");
		
		boolean success = service.remove(categoryId);

		ResponseEntity<String> responseEntity = null;

		if (success) {
			log.info(categoryId + "번 카테고리 삭제에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(categoryId + "번 카테고리 삭제에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
}
