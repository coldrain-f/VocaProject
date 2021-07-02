package edu.coldrain.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int page;
	private int amount;
	
	public Criteria() {
		this.page = 1;
		this.amount = 10;
	}
	
	public Criteria(int page, int amount) {
		this.page = page;
		this.amount = amount;
	}
	
}
