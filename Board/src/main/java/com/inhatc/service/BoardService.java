package com.inhatc.service;

import java.util.List;

import com.inhatc.domain.BoardVO;
import com.inhatc.domain.Criteria;
import com.inhatc.domain.Search;

public interface BoardService {
	public List<BoardVO> listAll() throws Exception;
	
	public BoardVO read(int bno) throws Exception;
	
	public int add_hits(int bno) throws Exception;
	
	public int add_likenum(int bno) throws Exception;	
	
	public void update_post(BoardVO vo) throws Exception;
	
	public void delete_post(int bno) throws Exception;
	
	public void write_post(BoardVO vo) throws Exception;
	
	public int getCount() throws Exception;
	
	public List<BoardVO> selectPage(Criteria cri) throws Exception;
	
	public List<BoardVO> search(Search sch, Criteria cri) throws Exception;
	
	public int searchBoardCount(Search sch) throws Exception;
	  
	public List<String> getAttach(Integer bno)throws Exception;
}