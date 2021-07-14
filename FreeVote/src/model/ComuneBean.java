package model;

public class ComuneBean {
    private String nome;
    private String CAP;
    private int nAventiDiritto;
    private String listaCodiciPassword;
    private String regione;

    public ComuneBean() {
        nome = "";
        CAP = "";
        nAventiDiritto = -1;
        listaCodiciPassword = "";
        regione = "";
    }

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCAP() {
		return CAP;
	}

	public void setCAP(String CAP) {
		this.CAP = CAP;
	}

	public int getNAventiDiritto() {
		return nAventiDiritto;
	}

	public void setNAventiDiritto(int nAventiDiritto) {
		this.nAventiDiritto = nAventiDiritto;
	}

	public String getListaCodiciPassword() {
		return listaCodiciPassword;
	}

	public void setListaCodiciPassword(String listaCodiciPassword) {
		this.listaCodiciPassword = listaCodiciPassword;
	}

	public String getRegione() {
		return regione;
	}
    
	public void setRegione(String regione) {
		this.regione = regione;
	}
	
	public boolean isEmpty() {
		return this.nome.equals("");
	}


}
