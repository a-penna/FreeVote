package model;

public class PartitoBean {
	
	private String leader;
	private String nome;
    private String descrizione;
    private int n_votazioni_ricevute;
    private byte[] logo;
    
    public PartitoBean() {
		leader = "";
		nome = "";
		descrizione = "";
		n_votazioni_ricevute = -1;
		logo = null;
	}
    
    public String getLeader(){
        return leader;
    }

    public String getNome(){
        return nome;
    }
    
    public String getDescrizione(){
        return descrizione;
    }

    public int getn_votazioni_ricevute() {
        return n_votazioni_ricevute;
    }

    public byte[] getLogo(){
        return logo;
    }

    public void setLeader(String leader) {
        this.leader=leader;
    }
    
    public void setNome(String nome) {
        this.nome=nome;
    }
    
    public void setDescrizione(String descrizione){
        this.descrizione = descrizione;
    }

    public void setn_votazioni_ricevute(int n_votazioni_ricevute) {
        this.n_votazioni_ricevute=n_votazioni_ricevute;
    }

    public void setLogo(byte[] logo) {
        this.logo = logo;
    }
    
    public boolean isEmpty() {
    	return n_votazioni_ricevute == -1;
    }

    public String toString() {
    	return getClass().getName() + "[leader=" + leader + ", nome=" + nome + ", descrizione=" + descrizione + ", n_votazioni_ricevute=" + n_votazioni_ricevute +"]";
    } 

}