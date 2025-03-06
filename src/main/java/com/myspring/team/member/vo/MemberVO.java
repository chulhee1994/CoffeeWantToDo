package com.myspring.team.member.vo;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.stereotype.Component;

@Component("memberVO")
public class MemberVO {
	
	private String mem_id;
	private String mem_pwd;
	private String mem_pwd_hint;
	private String mem_name;
	
	private String mem_tel1;
	private String mem_tel2;
	private String mem_tel3;
	private String mem_telsts_yn;
	
	private int mem_gender;
	private String mem_email1;
	private String mem_email2;
	private String mem_emailsts_yn;
	
	private String mem_birth;
	private String mem_birth_y;
	private String mem_birth_m;
	private String mem_birth_d;
	
	private String mem_zipcode;
	private String mem_add1;
	private String mem_add2;
	private String mem_add3;
	private int mem_point;
	private String mem_del_yn;
	private String mem_grade;
	private Date mem_joindate;
	private String mem_seller_num;
	private String mem_cmp_name;
	private String mem_agree1;
	private String mem_agree2;
	private Timestamp mem_del_yn_date;
	
	public Timestamp getMem_del_yn_date() {
		return mem_del_yn_date;
	}
	public void setMem_del_yn_date(Timestamp mem_del_yn_date) {
		this.mem_del_yn_date = mem_del_yn_date;
	}
	//카카오 관련VO
	private String email;
    private String loginType;
    private String kakaoEmail;
    private String sendCode;
    
    //네이버 관련VO
    private String naverEmail;
    
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getLoginType() {
		return loginType;
	}
	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}
	public String getKakaoEmail() {
		return kakaoEmail;
	}
	public void setKakaoEmail(String kakaoEmail) {
		this.kakaoEmail = kakaoEmail;
	}
	public String getSendCode() {
		return sendCode;
	}
	public void setSendCode(String sendCode) {
		this.sendCode = sendCode;
	}
	public String getNaverEmail() {
		return naverEmail;
	}
	public void setNaverEmail(String naverEmail) {
		this.naverEmail = naverEmail;
	}
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pwd() {
		return mem_pwd;
	}
	public void setMem_pwd(String mem_pwd) {
		this.mem_pwd = mem_pwd;
	}
	public String getMem_pwd_hint() {
		return mem_pwd_hint;
	}
	public void setMem_pwd_hint(String mem_pwd_hint) {
		this.mem_pwd_hint = mem_pwd_hint;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_tel1() {
		return mem_tel1;
	}
	public void setMem_tel1(String mem_tel1) {
		this.mem_tel1 = mem_tel1;
	}
	public String getMem_tel2() {
		return mem_tel2;
	}
	public void setMem_tel2(String mem_tel2) {
		this.mem_tel2 = mem_tel2;
	}
	public String getMem_tel3() {
		return mem_tel3;
	}
	public void setMem_tel3(String mem_tel3) {
		this.mem_tel3 = mem_tel3;
	}
	public String getMem_telsts_yn() {
		return mem_telsts_yn;
	}
	public void setMem_telsts_yn(String mem_telsts_yn) {
		this.mem_telsts_yn = mem_telsts_yn;
	}
	public int getMem_gender() {
		return mem_gender;
	}
	public void setMem_gender(int mem_gender) {
		this.mem_gender = mem_gender;
	}
	public String getMem_email1() {
		return mem_email1;
	}
	public void setMem_email1(String mem_email1) {
		this.mem_email1 = mem_email1;
	}
	public String getMem_email2() {
		return mem_email2;
	}
	public void setMem_email2(String mem_email2) {
		this.mem_email2 = mem_email2;
	}
	public String getMem_emailsts_yn() {
		return mem_emailsts_yn;
	}
	public void setMem_emailsts_yn(String mem_emailsts_yn) {
		this.mem_emailsts_yn = mem_emailsts_yn;
	}
	public String getMem_birth() {
		return mem_birth;
	}
	public void setMem_birth(String mem_birth) {
		this.mem_birth = mem_birth;
	}
	public String getMem_birth_y() {
		return mem_birth_y;
	}
	public void setMem_birth_y(String mem_birth_y) {
		this.mem_birth_y = mem_birth_y;
	}
	public String getMem_birth_m() {
		return mem_birth_m;
	}
	public void setMem_birth_m(String mem_birth_m) {
		this.mem_birth_m = mem_birth_m;
	}
	public String getMem_birth_d() {
		return mem_birth_d;
	}
	public void setMem_birth_d(String mem_birth_d) {
		this.mem_birth_d = mem_birth_d;
	}
	public String getMem_zipcode() {
		return mem_zipcode;
	}
	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}
	public String getMem_add1() {
		return mem_add1;
	}
	public void setMem_add1(String mem_add1) {
		this.mem_add1 = mem_add1;
	}
	public String getMem_add2() {
		return mem_add2;
	}
	public void setMem_add2(String mem_add2) {
		this.mem_add2 = mem_add2;
	}
	public String getMem_add3() {
		return mem_add3;
	}
	public void setMem_add3(String mem_add3) {
		this.mem_add3 = mem_add3;
	}
	public int getMem_point() {
		return mem_point;
	}
	public void setMem_point(int mem_point) {
		this.mem_point = mem_point;
	}
	public String getMem_del_yn() {
		return mem_del_yn;
	}
	public void setMem_del_yn(String mem_del_yn) {
		this.mem_del_yn = mem_del_yn;
	}
	public String getMem_grade() {
		return mem_grade;
	}
	public void setMem_grade(String mem_grade) {
		this.mem_grade = mem_grade;
	}
	public Date getMem_joindate() {
		return mem_joindate;
	}
	public void setMem_joindate(Date mem_joindate) {
		this.mem_joindate = mem_joindate;
	}
	public String getMem_seller_num() {
		return mem_seller_num;
	}
	public void setMem_seller_num(String mem_seller_num) {
		this.mem_seller_num = mem_seller_num;
	}
	public String getMem_cmp_name() {
		return mem_cmp_name;
	}
	public void setMem_cmp_name(String mem_cmp_name) {
		this.mem_cmp_name = mem_cmp_name;
	}
	public String getMem_agree1() {
		return mem_agree1;
	}
	public void setMem_agree1(String mem_agree1) {
		this.mem_agree1 = mem_agree1;
	}
	public String getMem_agree2() {
		return mem_agree2;
	}
	public void setMem_agree2(String mem_agree2) {
		this.mem_agree2 = mem_agree2;
	}



}

