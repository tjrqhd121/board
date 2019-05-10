package com.inhatc.service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;
import com.inhatc.domain.RegisterVO;
import com.inhatc.persistence.RegisterDAO;

@Service
public class RegisterServiceImpl implements RegisterService {

	@Inject
	private RegisterDAO dao;
	
	@Override
	public int register(RegisterVO vo){
		// TODO Auto-generated method stub
		System.out.println(vo+"Test");
		return dao.register(vo);
	}
/*	public int idcheck(RegisterVO vo){
		System.out.println(vo+"Test");
		return dao.idcheck(vo);
	}*/
	public int idcheck(RegisterVO vo){
	      return dao.idcheck(vo);
	   }
	public int emailcheck(RegisterVO vo){
	      return dao.emailcheck(vo);
	   }
}