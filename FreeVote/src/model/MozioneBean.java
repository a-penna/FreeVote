package model;

public class MozioneBean {
	private String testo;
	private int id;

	public MozioneBean() {
		testo = "";
		id = -1;
	}
	
    public String getTesto() {
        return testo;
    }

    public int getID() {
    	return id;
    }

    public void setTesto(String testo) {
        this.testo=testo;
    }

    public void setID(int id) {
        this.id=id;
    }

    public String toString() {
    	return getClass().getName() + "[testo=" + testo + ", id=" + id + "]";
    } 
}
