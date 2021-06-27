package edu.coldrain.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import edu.coldrain.domain.CategoryVO;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CategoryServiceTests {

	@Autowired
	private CategoryService service;
	
	@Test
	public void testExist() {
		log.info(service);
	}
	
	@Test
	public void testRegister() {
		CategoryVO categoryVO = new CategoryVO("REGISTER TEST", 5L);
		boolean success = service.register(categoryVO);
		log.info("REGISTER SUCCESS = " + success);
	}
	
	@Test
	public void testGet() {
		CategoryVO categoryVO = service.get(29L);
		log.info(categoryVO);
	}
	
	@Test
	public void testModify() {
		CategoryVO categoryVO = service.get(29L);
		categoryVO.setCategoryName("MODIFY TEST");
		
		boolean success = service.modify(categoryVO);
		log.info("MODIFY SUCCESS = " + success);
	}
	
	@Test
	public void testRemove() {
		boolean success = service.remove(29L);
		log.info("DELETE SUCCESS = " + success);
	}
	
	@Test
	public void testGetList() {
		List<CategoryVO> list = service.getList();
		list.forEach(category -> log.info(category));
	}
	
	@Test
	public void testGetListByBookId() {
		List<CategoryVO> list = service.getListByBookId(5L);
		list.forEach(category -> log.info(category));
	}
}
