package com.inhatc.service;

public interface LoginService {
	public boolean login_check(String id, String pw);
	public String check(String name, String email);
	public String check2(String id, String name, String email);
}