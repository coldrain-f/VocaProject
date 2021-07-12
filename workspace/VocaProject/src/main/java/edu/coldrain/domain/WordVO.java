package edu.coldrain.domain;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class WordVO {

	// 단어 아이디 AUTO SEQUENCE
	private Long wordId;
	
	// 단어 이름 UNIQUE
	private String wordName;
	  
	// 단어 뜻 UNIQUE
	private String wordMeaning;
	
	// 카테고리 아이디 UNIQUE
	private Long categoryId;
	
	// 등록일 DEFAULT SYSDATE
	private Date regdate;
	
	// 수정일 DEFAULT SYSDATE
	private Date updatedate;
	
	// 후리가나
	private String hurigana;
	
	public WordVO(String wordName, String wordMeaning, Long categoryId) {
		this.wordName = wordName;
		this.wordMeaning = wordMeaning;
		this.categoryId = categoryId;
	}
	
}
