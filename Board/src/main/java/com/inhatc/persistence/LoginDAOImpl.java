package com.inhatc.persistence;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;


@Repository
public class LoginDAOImpl implements LoginDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.js.mapper.LoginMapper";

	@Override
	public boolean login_check(String id, String pw) {
		// TODO Auto-generated method stub
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("pw", pw);
		System.out.println("id : "+paramMap.get("id"));
		System.out.println("pw : "+paramMap.get("pw"));
		int result = session.selectOne(namespace+".login_check",paramMap);
		
		if(result == 1)
			return true;
		else
			return false;
	}
	@Override
	public String check(String name, String email) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("name", name);
		paramMap.put("email", email);
		System.out.println("name : "+paramMap.get("name"));
		System.out.println("email : "+paramMap.get("email"));		
		String result = session.selectOne(namespace+".check",paramMap);
		
		return result;
	}
	@Override
	public String check2(String id,String name, String email) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("name", name);
		paramMap.put("email", email);
		System.out.println("id : "+paramMap.get("id"));
		System.out.println("name : "+paramMap.get("name"));
		System.out.println("email : "+paramMap.get("email"));	
		String result = session.selectOne(namespace+".check2",paramMap);
		
		return result;	
	}
}