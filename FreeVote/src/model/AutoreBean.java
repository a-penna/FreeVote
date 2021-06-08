package model;

public class AutoreBean {
	private String nomeCompleto;
	private int id;
	
	public AutoreBean() { 
		nomeCompleto = "";
		id = -1;
	}
	
	public String getNomeCompleto() {
		return nomeCompleto;
	}

	public int getID() {
		return id;
	}
	
	public void setNomeCompleto(String nomeCompleto) {
		this.nomeCompleto = nomeCompleto;
	}
	
	public void setID(int id) {
		this.id = id;
	}

}
