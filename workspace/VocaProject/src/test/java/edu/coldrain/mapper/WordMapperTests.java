package edu.coldrain.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import edu.coldrain.domain.Criteria;
import edu.coldrain.domain.WordVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class WordMapperTests {

	@Autowired
	private WordMapper mapper;
	
	@Autowired
	private CategoryMapper categoryMapper;
	
	@Test
	public void testExist() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		WordVO wordVO = new WordVO("INSERT", "삽입하다", 23L);
		int count = mapper.insert(wordVO);
		
		log.info("INSERT COUNT = " + count);
	}
	
	@Test
	public void testRead() {
		WordVO wordVO = mapper.read(30L);
		log.info("WORD_VO = " + wordVO);
	}
	
	@Test
	public void testUpdate() {
		WordVO wordVO = mapper.read(30L);
		wordVO.setWordName("UPDATE");
		wordVO.setWordMeaning("갱신하다");
		
		int count = mapper.update(wordVO);
		log.info("UPDATE COUNT = " + count);		
	}
	
	@Test
	public void testDelete() {
		int count = mapper.delete(30L);
		log.info("DELETE COUNT = " + count);
	}
	
	@Test
	public void testReadList() {
		List<WordVO> list = mapper.readList();
		list.forEach(word -> log.info(word));
	}
	
	@Test
	public void testReadListByCategoryId() {
		List<WordVO> list = mapper.readListByCategoryId(23L);
		list.forEach(word -> log.info(word));
	}
	
	@Test
	public void testReadListWithPaging() {
		List<WordVO> words = mapper.readListWithPaging(64L, new Criteria());
		words.forEach(word -> log.info(words));
	}
	
	@Test
	public void testReadListWithPaging2() {
		List<WordVO> words = mapper.readListWithPaging(64L, new Criteria(2, 10));
		words.forEach(word -> log.info(words));
	}
	
	@Test
	public void testReadTotalCount() {
		int total = mapper.readTotalCount(64L);
		log.info(total);
	}
	
	@Test
	public void testReadRownumByCategoryId() {
		//카테고리로 bookId를 조회한다.
		Long bookId = categoryMapper.read(67L).getBookId();
		Long rownum = mapper.readRownumByCategoryId(67L, bookId);
		log.info(rownum);
	}
	
	@Test
	public void testReadListByRownum() {
		Long bookId = categoryMapper.read(67L).getBookId();
		Long rownum = mapper.readRownumByCategoryId(67L, bookId);
		List<WordVO> words = mapper.readListByRownum(rownum, bookId);
		words.forEach(word -> log.info(word));
	}
	
}
