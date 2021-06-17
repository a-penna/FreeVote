package model;

import java.sql.Date;

public class VotazioneReferendumBean {
	private int codice;
	private String preferenza;
	private Date data;
	private String elettore;

	public VotazioneReferendumBean() {	}
	
	public int getCodice() {
		return codice;
	}
	
	public void setCodice(int codice) {
		this.codice = codice;
	}
	
	public String getPreferenza() {
		return preferenza;
	}
	
	public void setPreferenza(String preferenza) {
		this.preferenza = preferenza;
	}
	
	public Date getData() {
		return (Date)data.clone();
	}
	
	public void setData(Date data) {
		this.data = (Date)data.clone();
	}
	
	public String getElettore() {
		return elettore;
	}
	
	public void setElettore(String elettore) {
		this.elettore = elettore;
	}
	
}
