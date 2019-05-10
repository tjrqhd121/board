package com.inhatc.service;
import com.inhatc.domain.RegisterVO;
public interface RegisterService {
	public int register(RegisterVO vo);
	/*public int idcheck(RegisterVO vo);*/
	public int idcheck(RegisterVO vo);
	public int emailcheck(RegisterVO vo);
}