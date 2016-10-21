package model1;
//순수하게 리스트 페이징처리에만 관련있음.

import java.util.ArrayList;

public class PagingDto {
	private int cpage;
	private int recordPerpage;
	private int blockPerpage;
	private int totalPage;
	private int startBlock;
	private int endBlock;
	private ArrayList<Stu_board_Dto> boardList;

public PagingDto() {
		this.cpage =1;
		this.recordPerpage =10;
		this.blockPerpage =5;
		this.totalPage =1;
	
	}

public int getCpage() {
	return cpage;
}

public void setCpage(int cpage) {
	this.cpage = cpage;
}

public int getRecordPerpage() {
	return recordPerpage;
}

public void setRecordPerpage(int recordPerpage) {
	this.recordPerpage = recordPerpage;
}

public int getBlockPerpage() {
	return blockPerpage;
}

public void setBlockPerpage(int blockPerpage) {
	this.blockPerpage = blockPerpage;
}

public int getTotalPage() {
	return totalPage;
}

public void setTotalPage(int totalPage) {
	this.totalPage = totalPage;
}

public int getStartBlock() {
	return startBlock;
}

public void setStartBlock(int startBlock) {
	this.startBlock = startBlock;
}

public int getEndBlock() {
	return endBlock;
}

public void setEndBlock(int endBlock) {
	this.endBlock = endBlock;
}

public ArrayList<Stu_board_Dto> getBoardList() {
	return boardList;
}

public void setBoardList(ArrayList<Stu_board_Dto> boardList) {
	this.boardList = boardList;
}
	
	
}
