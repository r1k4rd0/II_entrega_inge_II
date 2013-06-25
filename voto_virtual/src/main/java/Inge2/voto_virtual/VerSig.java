package Inge2.voto_virtual;

import java.io.*;
import java.security.*;
import java.security.spec.*;

class VerSig {

	private FileInputStream publicKey;
	private FileInputStream signature;
	private FileInputStream data;
	private final String ruta = "C:\\temp\\";
	private Conexion cbd;

	public String iD_Usuario;

	public VerSig(String elID) {
		iD_Usuario = elID;
	}

	public boolean verify(String[] args) {

		/*
		 * 
		 * Creando Datos
		 */

		try {
						
			
			//Signature dsa = Signature.getInstance("SHA1withDSA", "SUN");
		

			/* Update and sign the data */
/*
			FileOutputStream data = new FileOutputStream(ruta + "data");
			data.write(new String("holaMundo").getBytes());
			data.close();

			FileInputStream fis = new FileInputStream(ruta + "data");
			BufferedInputStream bufin = new BufferedInputStream(fis);
			byte[] buffer = new byte[1024];
			int len;
			while (bufin.available() != 0) {
				len = bufin.read(buffer);
				dsa.update(buffer, 0, len);
			}
			;
			bufin.close();
*/
			/*
			 * Now that all the data to be signed has been read in, generate a
			 * signature for it
			 */

//			byte[] realSig = dsa.sign();

			/* Save the signature in a file */
	/*		FileOutputStream sigfos = new FileOutputStream("sig");
			sigfos.write(realSig);
			sigfos.close();
*/
			/**************************************************************************************/

			/*
			 * 
			 * Verificando firma
			 */
	/*		FileInputStream keyfis = new FileInputStream(args[0]);
			byte[] encKey = new byte[keyfis.available()];
			keyfis.read(encKey);

			keyfis.close();

			X509EncodedKeySpec pubKeySpec = new X509EncodedKeySpec(encKey);

			KeyFactory keyFactory = KeyFactory.getInstance("DSA", "SUN");
			PublicKey pubKey = keyFactory.generatePublic(pubKeySpec);
*/
			/* input the signature bytes */
	/*		FileInputStream sigfis = new FileInputStream(args[1]);
			byte[] sigToVerify = new byte[sigfis.available()];
			sigfis.read(sigToVerify);

			sigfis.close();
*/
			/*
			 * create a Signature object and initialize it with the public key
			 */
	//		Signature sig = Signature.getInstance("SHA1withDSA", "SUN");
		//	sig.initVerify(pubKey);

			/* Update and verify the data */

			//FileInputStream datafis = new FileInputStream(args[2]);
			//BufferedInputStream bufin = new BufferedInputStream(datafis);
/*
			byte[] buffer = new byte[1024];
			int len;
			while (bufin.available() != 0) {
				len = bufin.read(buffer);
				sig.update(buffer, 0, len);
			}
			;

			bufin.close();
*/
			//boolean verifies = sig.verify(sigToVerify);

			//System.out.println("signature verifies: " + verifies);

		} catch (Exception e) {
			//System.err.println("Caught exception " + e.toString());
		}
		return true;
	}

}