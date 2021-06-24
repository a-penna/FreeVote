package utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class Utility {

	public static String readLine(String label, String placeholder, boolean mandatory) {
		InputStreamReader keyIS = new InputStreamReader(System.in);
		BufferedReader keyBR = new BufferedReader(keyIS);
		String scelta = null;
		try {
			StringBuffer format = new StringBuffer(label);
			if (placeholder != null)
				format.append(" (" + placeholder + ")");
			format.append(": ");			
			do {
				System.out.print(format.toString());
				scelta = keyBR.readLine();
			} while ((scelta.trim().equals("") || scelta.equals("\n")) && mandatory);

		} catch (IOException e) {
		}

		return scelta;
	}	
	
	public static Date formatStringToDate(String data) {
		 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd"); 
		 try {
			 return sdf.parse(data);  
		 } catch(ParseException e) {}
		 return null;
	}
	
	public static java.sql.Date toSqlDate(Date data) {
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(data);
		calendar.set(Calendar.HOUR, 1); 
		calendar.set(Calendar.MINUTE, 0); 
		calendar.set(Calendar.SECOND, 0); 
		calendar.set(Calendar.MILLISECOND, 0); 

		return new java.sql.Date(calendar.getTimeInMillis());
	}
	
	public static void printSQLException(SQLException ex) {
		//System.out.println("Info sulla SQLException:\n");
		while (ex != null) {
			System.out.println("Message: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("ErrorCode: " + ex.getErrorCode());
			ex.printStackTrace();
			ex = ex.getNextException();
			
		}
	}
	
	public static String encryptMD5(String message) {
	    try{
	        MessageDigest m = MessageDigest.getInstance("MD5");
	        m.update(message.getBytes());
	        return String.format("%032x",new BigInteger(1,m.digest()));
	    }
	    catch(Exception e){
	        return null;
	    }
	}

	public static String filter(String input) {
		StringBuffer filtered = new StringBuffer(input.length());
		char c;
				
		for (int i = 0; i < input.length(); i++) {
			c = input.charAt(i);
			if (c == '<') {
				filtered.append("&lt;");
			}
			else if (c == '>') {
				filtered.append("&gt;");
			}
			else if (c == '.') {
				filtered.append("&period;");
			}
			else if (c == ',') {
				filtered.append("&comma;");
			}
			else if (c == ':') {
				filtered.append("&colon;");
			}
			else if (c == '$') {
				filtered.append("&dollar;");
			}
			else if (c == '%') {
				filtered.append("&percnt;");
			}
			else if (c == '&') {
				filtered.append("&amp;");
			} else if (c == '"') {
				filtered.append("&quot;");
			}
			else if (c == '@') {
				filtered.append("&commat;");
			} /*
			else if (c == 'à') {
				filtered.append("&agrave;");
			}
			else if (c == 'è') {
				filtered.append("&egrave;");
			}
			else if (c == 'ì') {
				filtered.append("&igrave;");
			}
			else if (c == 'ò') {
				filtered.append("&ograve;");
			}
			else if (c == 'ù') {
				filtered.append("&ugrave;");
			}
			else if (c == '[') {
				filtered.append("&lsqb;");
			}
			else if (c == ']') {
				filtered.append("&rsqb;");
			}
			else if (c == ';') {
				filtered.append("&semi;");
			}
			else if (c == 'é') {
				filtered.append("&eacute;");
			}
			else if (c == 'É') {
				filtered.append("&Eacute;");
			} 
			else if (c == '/') {
				filtered.append("&sol;");
			}
			else if (c == '\\') {
				filtered.append("&bsol;&bsol;");
			} */
			else {
				filtered.append(c);
			}
		} 	
		return filtered.toString();
	}
	
}
