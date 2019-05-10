package com.inhatc.persistence;

import java.util.List;

import com.inhatc.domain.BoardVO;
import com.inhatc.domain.Criteria;
import com.inhatc.domain.Search;

public interface BoardDAO {
	public List<BoardVO> listAll() throws Exception;
	
	public BoardVO read(int bno) throws Exception;
	
	public int add_hits(int bno) throws Exception;
	
	public int add_likenum(int bno) throws Exception;	
	
	public int update_post(BoardVO vo) throws Exception;
	
	public int delete_post(int bno) throws Exception;
	
	public void write_post(BoardVO vo) throws Exception;
	
	public int getCount() throws Exception;
	
	public List<BoardVO> selectPage(Criteria cri) throws Exception;
	
	public List<BoardVO> search(Search sch, Criteria cri) throws Exception;
	
	public int searchBoardCount(Search sch) throws Exception;
	
    public void addAttach(String fullName)throws Exception;
    
    public List<String> getAttach(Integer bno)throws Exception; 
    
    public void deleteAttach(Integer bno)throws Exception;
    
    public void replaceAttach(String fullName, Integer bno)throws Exception;
}