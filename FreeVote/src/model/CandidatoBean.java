
package model;

public class CandidatoBean {
	private String cf;
	private String nome;
	private String cognome;
	private String partito;
    private byte[] foto;
    private String curriculum;

	public CandidatoBean() { 
		cf = "";
		nome = "";
		cognome = "";
		partito = "";
		foto = null;
		curriculum = "";
	}
	
    public String getCf() {
        return cf;
    }
    
    public String getNome() {
        return nome;
    }
    
    public String getCognome() {
        return cognome;
    }

    public String getCurriculum() {
    	return curriculum;
    }
    
    public byte[] getFoto() {
    	return foto;
    }

    public String getPartito() {
    	return partito;
    }

    public void setCf(String cf) {
        this.cf=cf;
    }

    public void setNome(String nome) {
        this.nome=nome;
    }
    
    public void setCognome(String cognome) {
        this.cognome=cognome;
    }    

	public void setPartito(String partito) {
		this.partito = partito;
	}

	public void setCurriculum(String curriculum) {
		this.curriculum = curriculum;
	}

	public void setFoto(byte[] foto) {
		this.foto = foto;
	}
	
	public String toString() {
		return getClass().getName() + "[cf=" + cf + ", nome=" + nome + ", cognome=" + cognome + ", partito=" + partito + ", curriculum=" + curriculum + "]";
	} 
}

