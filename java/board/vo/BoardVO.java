package collabo.wato.springboot.web.board.vo;

import collabo.wato.springboot.web.common.vo.CommonVO;

public class BoardVO extends CommonVO{

	private String boardid = "";
	private String board_address = "";
	private String title = "";
	private String detail = "";
	private String feeling = "";
	private String delyn = "";
	private String lat = "";
	private String lng = "";
	private String create_user = "";
	private String filepath = "";
	private String search = "";
	private String sw = "";
	private String ne = "";
	private String swLatlngFrom = "";
	private String swLatlngTo = "";
	private String neLatlngFrom = "";
	private String neLatlngTo = "";
	
	private String[] sub_city = null;
	
	public String[] getSub_city() {
		return sub_city;
	}
	public void setSub_city(String[] sub_city) {
		this.sub_city = sub_city;
	}
	public String getSwLatlngFrom() {
		return swLatlngFrom;
	}
	public void setSwLatlngFrom(String swLatlngFrom) {
		this.swLatlngFrom = swLatlngFrom;
	}
	public String getSwLatlngTo() {
		return swLatlngTo;
	}
	public void setSwLatlngTo(String swLatlngTo) {
		this.swLatlngTo = swLatlngTo;
	}
	public String getNeLatlngFrom() {
		return neLatlngFrom;
	}
	public void setNeLatlngFrom(String neLatlngFrom) {
		this.neLatlngFrom = neLatlngFrom;
	}
	public String getNeLatlngTo() {
		return neLatlngTo;
	}
	public void setNeLatlngTo(String neLatlngTo) {
		this.neLatlngTo = neLatlngTo;
	}
	public String getSw() {
		return sw;
	}
	public void setSw(String sw) {
		this.sw = sw;
	}
	public String getNe() {
		return ne;
	}
	public void setNe(String ne) {
		this.ne = ne;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	private String address = "";

	public String getCreate_user() {
		return create_user;
	}
	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}
	public String getBoard_address() {
		return board_address;
	}
	public void setBoard_address(String board_address) {
		this.board_address = board_address;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	public String getBoardid() {
		return boardid;
	}
	public void setBoardid(String boardid) {
		this.boardid = boardid;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getFeeling() {
		return feeling;
	}
	public void setFeeling(String feeling) {
		this.feeling = feeling;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	
	
}
