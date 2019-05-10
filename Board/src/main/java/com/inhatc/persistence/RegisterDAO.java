package com.inhatc.persistence;

import com.inhatc.domain.RegisterVO;
public interface RegisterDAO {
	//public boolean login_check(String id, String pw);
	public int register(RegisterVO vo);
	/*public int idcheck(RegisterVO vo);*/
	public int idcheck(RegisterVO vo);
	public int emailcheck(RegisterVO vo);
}