package model;

public class SchedaVoto {
    VotazionePoliticaBean votoP;
    VotazioneReferendumBean votoR;

	public SchedaVoto() {
        
    }

	public void addVP(VotazionePoliticaBean voto) { 
		votoP = voto;
	}

    public void addVR(VotazioneReferendumBean voto) {
		votoR = voto;
	}

	public void deleteVP() {
		votoP=null;
	}

    public void deleteVR() {
		votoR=null;
	}

	public VotazionePoliticaBean getVP() {
		return votoP;
	}
    
	public VotazioneReferendumBean getVR() {
		return votoR;
	}

}
