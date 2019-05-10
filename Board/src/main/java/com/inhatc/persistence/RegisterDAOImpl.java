package com.inhatc.persistence;

import java.util.HashMap;

import javax.inject.Inject;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.inhatc.domain.RegisterVO;

@Repository
public class RegisterDAOImpl implements RegisterDAO {
	@Inject
	private SqlSession session;
	@Inject
	private static String namespace = "com.js.mapper.registerMapper";

	@Override
	public int register(RegisterVO vo){

		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("id", vo.getId());
		paramMap.put("pw", vo.getPw());
		paramMap.put("email", vo.getEmail());
		paramMap.put("name", vo.getName());
		System.out.println("id : "+vo.getId());
		System.out.println("pw : "+vo.getPw());
		System.out.println("email : "+vo.getEmail());
		System.out.println("name : "+vo.getName());
		int result = session.insert(namespace+".register",paramMap);
		return result;
//		return 0;
	}
/*	public int idcheck(RegisterVO vo) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", vo.getId());
			System.out.println(paramMap);
			int result = session.selectOne(namespace+".idcheck",paramMap);
			return result;
	}*/
	public int idcheck(RegisterVO vo) {
	      HashMap<String, Object> paramMap = new HashMap<String, Object>();
	      paramMap.put("id", vo.getId());
	      System.out.println("id : "+vo.getId());
	      int result=session.selectOne(namespace+".idcheck", vo);
	      System.out.println("DAOImpl결과 : "+result);
	      return result;
	   }
	public int emailcheck(RegisterVO vo) {
	      HashMap<String, Object> paramMap = new HashMap<String, Object>();
	      paramMap.put("email", vo.getEmail());
	      System.out.println("email : "+vo.getEmail());
	      int result=session.selectOne(namespace+".emailcheck", vo);
	      System.out.println("DAOImpl결과 : "+result);
	      return result;
	   }
}