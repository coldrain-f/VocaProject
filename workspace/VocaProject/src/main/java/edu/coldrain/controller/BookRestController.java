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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import edu.coldrain.domain.BookVO;
import edu.coldrain.service.BookService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/books")
@RequiredArgsConstructor
public class BookRestController {
	
	private final BookService service;
	
	/*    ------ RestFul API 설계
	 * 	  /books GET 모든 책 조회
	 *    /books/new POST 책 추가하기
	 *    /books/1 GET 특정 책 조회하기
	 *    /books/1 PUT/PATCH 특정 책 수정하기
	 *    /books/1 DELETE 특정 책 삭제하기
	 */
	
	//모든 데이터를 조회한다.
	@GetMapping(produces =  MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BookVO>> getList() {
		log.info("BookController.getList()");
		
		List<BookVO> list = service.getList();
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//클라이언트에서 전송한 JSON 데이터를 받아서 데이터베이스에 추가하고 성공했다는 메시지를 응답해준다.
	@PostMapping(value = "/new", 
				 consumes = MediaType.APPLICATION_JSON_VALUE,
				 produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody BookVO bookVO) {
		log.info("BookController.register()");
		log.info("BookVO = " + bookVO);
		
		//책 등록
		boolean success = service.register(bookVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info("책 등록에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info("책 등록에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//클아이언트가 1번의 책 정보를 요청하면 데이터베이스에서 조회해서 JSON 데이터를 응답해준다.
	@GetMapping(value = "/{bookId}",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<BookVO> get(@PathVariable("bookId") Long bookId) {
		log.info("BookController.get()");
		log.info("bookId = " + bookId);
		
		BookVO bookVO = service.get(bookId);
		log.info("BookVO = " + bookVO);
		
		ResponseEntity<BookVO> responseEntity = null;
		
		if (bookVO != null) {
			log.info(bookId + "번 책 조회에 성공했습니다.");
			responseEntity = new ResponseEntity<>(bookVO, HttpStatus.OK);
		} else {
			log.info(bookId + "번 책 조회에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//클라이언트가 수정할 책 아이디와 수정할 책 정보를 전송하면 데이터베이스에서 수정하고 성공했다는 메시지를 응답해준다.
	@PatchMapping(value = "/{bookId}",
				  consumes = MediaType.APPLICATION_JSON_VALUE,
				  produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody BookVO bookVO, @PathVariable("bookId") Long bookId) {
		log.info("BookController.modify()");
		
		//{"bookId": 5, "bookName": "단어가 읽기다 기본편"}
		boolean success = service.modify(bookVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(bookId + "번 책 수정에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(bookId + "번 책 수정에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	
	//클라이언트가 책 아이디 1번을 요청하면 1번 책을 데이터베이스에서 삭제한다.
	@DeleteMapping(value = "/{bookId}", 
				   produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("bookId") Long bookId) {
		log.info("BookController.remove()");
		log.info("bookId = " + bookId);
		
		boolean success = service.remove(bookId);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(bookId + "번 책 삭제에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(bookId + "번 책 삭제에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		return responseEntity;
	}
	
}
