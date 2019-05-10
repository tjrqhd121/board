package com.inhatc.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.inhatc.domain.BoardVO;
import com.inhatc.domain.Criteria;
import com.inhatc.domain.Search;
import com.inhatc.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO dao;
	@Override
	public List<BoardVO> listAll() throws Exception {
		// TODO Auto-generated method stub
		return dao.listAll();
	}
	
	@Override
	public BoardVO read(int bno) throws Exception {
		return dao.read(bno);
	}
	
	@Override
	public int add_hits(int bno) throws Exception {
		return dao.add_hits(bno);
	}
	
	@Override
	public int add_likenum(int bno) throws Exception {
		return dao.add_likenum(bno);
	}
	  @Transactional
	@Override
	public void update_post(BoardVO vo) throws Exception {
	    dao.update_post(vo);
	    Integer bno = vo.getBno();
	    dao.deleteAttach(bno);
	    String[] files = vo.getFiles();
	    if(files == null) { return; } 
	    for (String fileName : files) {
	      dao.replaceAttach(fileName, bno);
	    }
	}
	
	@Override
	public void delete_post(int bno) throws Exception {
		System.out.println(dao.delete_post(bno));
	    dao.deleteAttach(bno);
	    dao.delete_post(bno);
	}
 @Transactional
	@Override
	public void write_post(BoardVO vo) throws Exception {
	 	dao.write_post(vo);    
	    String[] files = vo.getFiles();
	    if(files == null) { return; } 
	    for (String fileName : files) {
	      dao.addAttach(fileName);
	    }
	}
	
	@Override
	public int getCount() throws Exception {
		return dao.getCount();
	}
	
	@Override
	public List<BoardVO> selectPage(Criteria cri) throws Exception {
		return dao.selectPage(cri);
	}
	
	@Override
	public List<BoardVO> search(Search sch, Criteria cri) throws Exception {
		return dao.search(sch, cri);
	}
	
	@Override
	public int searchBoardCount(Search sch) throws Exception {
		return dao.searchBoardCount(sch);
	}
	  @Override
	  public List<String> getAttach(Integer bno) throws Exception {
	    return dao.getAttach(bno);
	  }
}