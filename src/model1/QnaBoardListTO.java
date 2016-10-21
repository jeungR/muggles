package model1;

import java.util.ArrayList;

public class QnaBoardListTO {
	private int cpage;			//기본생성자가 있다. cpage~totalPage까지 
	private int recordPerPage;  
	private int blockPerPage;
	private int totalPage;
	private int startBlock;
	private int endBlock;
	private ArrayList<QnaBoardTO> boardList;
	
	public QnaBoardListTO(){
		this.cpage = 1;
		this.recordPerPage = 100;
		this.blockPerPage = 5;
		this.totalPage = 1;
	}
	
	
	public int getCpage() {
		return cpage;
	}
	public void setCpage(int cpage) {
		this.cpage = cpage;
	}
	public int getRecordPerPage() {
		return recordPerPage;
	}
	public void setRecordPerPage(int recordPerPage) {
		this.recordPerPage = recordPerPage;
	}
	public int getBlockPerPage() {
		return blockPerPage;
	}
	public void setBlockPerPage(int blockPerPage) {
		this.blockPerPage = blockPerPage;
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
	public ArrayList<QnaBoardTO> getBoardList() {
		return boardList;
	}
	public void setBoardList(ArrayList<QnaBoardTO> boardList) {
		this.boardList = boardList;
	}
	
	
	
	
}
