package model;

import java.sql.Date;

public class VotazionePoliticaBean {
	
	private Date data;
	private String partito;
	private String elettore;
	private int codice;
	
	public VotazionePoliticaBean() {
		this.data = null;
		this.partito = "";
		this.elettore = "";
		this.codice = -1;
	}
	
	public int getCodice() {
		return codice;
	}
	
	public Date getData() {
		return (Date)data.clone();
	}
	
	public String getElettore() {
		return elettore;
	}
	
	public String getPartito() {
		return partito;
	}
	
	public void setCodice(int codice) {
		this.codice = codice;
	}
	
	public void setData(Date data) {
		this.data = (Date)data.clone();
	}

	public void setPartito(String partito) {
		this.partito = partito;
	}
	
	
	public void setElettore(String elettore) {
		this.elettore = elettore;
	}
	
}

