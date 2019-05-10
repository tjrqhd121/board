package com.inhatc.persistence;

public interface LoginDAO {
	//public boolean login_check(String id, String pw);
	public boolean login_check(String id, String pw);
	public String check(String name, String email);
	public String check2(String id, String name, String email);
}