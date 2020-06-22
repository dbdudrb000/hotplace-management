package collabo.wato.springboot.web.member.vo;

import collabo.wato.springboot.web.common.vo.CommonVO;

public class MemberVO extends CommonVO{
	
	private String email;
	private String nickname;
	private String address;
	private String available;
	private String password;
	private String username;
	private String phone;
	private String remark;
	private String loginyn;
	private String type;
	private String lat;
	private String lng;
	private String cs_like;
	
	public String getCs_like() {
		return cs_like;
	}
	public void setCs_like(String cs_like) {
		this.cs_like = cs_like;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAvailable() {
		return available;
	}
	public void setAvailable(String available) {
		this.available = available;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getLoginyn() {
		return loginyn;
	}
	public void setLoginyn(String loginyn) {
		this.loginyn = loginyn;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	
}