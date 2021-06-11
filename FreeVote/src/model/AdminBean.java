package model;

public class AdminBean {

	private String password;
	private String nomeUtente;
	
	
	
	public AdminBean() { }
	
	public void setPassword(String password) {
		this.password=password;
	}
	
	public void setnomeUtente(String nome) {
		this.nomeUtente = nome;
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public String getnomeUtente() {
		return this.nomeUtente;
	}
}
