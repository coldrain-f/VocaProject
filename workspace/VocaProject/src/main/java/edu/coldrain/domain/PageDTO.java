package edu.coldrain.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {

	private Criteria criteria;
	private int startPage;
	private int endPage;
	private int realEndPage;
	private boolean prev;
	private boolean next;
	
	public PageDTO(Criteria criteria, int total) {
		this.criteria = criteria;
		
		this.endPage = (int)Math.ceil((criteria.getPage() / 10.0)) * 10;
		this.startPage = endPage - 9;
		
		this.realEndPage = (int)Math.ceil(total / 10.0);
		if (realEndPage < endPage) {
			endPage = realEndPage;
		}
		
		if (startPage > 1) {
			prev = true;
		}
		
		if (endPage < realEndPage) {
			next = true;
		}
		
	}
}
