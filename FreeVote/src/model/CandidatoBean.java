package model;
import java.sql.Blob;

public class CandidatoBean {
	private String cf;
	private String nome;
	private String cognome;
	private String partito;
    private Blob foto;
    private String curriculum;

	public CandidatoBean() { ;}
	
    public String getCf() {
        return cf;
    }
    
    public String getNome() {
        return nome;
    }
    
    public String getCognome() {
        return cognome;
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
    
    public String getPartito() {
		return partito;
	}

	public void setPartito(String partito) {
		this.partito = partito;
	}

    public String getCurriculum() {
		return curriculum;
	}

	public void setCurriculum(String curriculum) {
		this.curriculum = curriculum;
	}

    public Blob getFoto() {
		return foto;
	}

	public void setFoto(Blob foto) {
		this.foto = foto;
	}
}

