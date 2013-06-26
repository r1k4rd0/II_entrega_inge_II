package Inge2.voto_virtual;

import java.awt.BufferCapabilities.FlipContents;
import java.io.*;
import java.security.*;
import java.security.spec.*;
import java.sql.ResultSet;
import java.sql.SQLException;


import java.io.*;
import java.security.*;
import java.security.spec.*;

class VerSig {

	private FileInputStream publicKey;
	private FileInputStream signature;
	private FileInputStream data;
	//private final String ruta = "C:\\temp\\";
	private Conexion cbd;
	private PrivateKey priv;
	private PublicKey pub;
	private String ruta = "C:\\temp\\";
	public String iD_Usuario;
	boolean verifies;
	public VerSig(String elID) {
		iD_Usuario = elID;//cedula
		cbd = new Conexion("eduardo", "steiner.garro");
	}

	public boolean verify(File file) {

		try {
			String path = "C:\\temp";
			KeyPairGenerator keyGen = KeyPairGenerator.getInstance("DSA", "SUN");
			SecureRandom random = SecureRandom.getInstance("SHA1PRNG",
					"SUN"); 
			keyGen.initialize(1024, random);
			
			KeyPair generatedKeyPair = keyGen.genKeyPair();

			System.out.println("Generated Key Pair");
			this.dumpKeyPair(generatedKeyPair);
			this.SaveKeyPair(path, generatedKeyPair);
			
			this.firmar();

			KeyPair loadedKeyPair = this.LoadKeyPair(path, "DSA");
			System.out.println("Loaded Key Pair");
			this.dumpKeyPair(loadedKeyPair);
								
		} catch (Exception e) {
			e.printStackTrace();
			//return;
		}
		return verifies;
	}
	
	
	private void firmar() {
		try {
			Signature dsa = Signature.getInstance("SHA1withDSA", "SUN");
			dsa.initSign(priv);

			FileOutputStream data = new FileOutputStream("C:\\temp\\data");
			data.write(new String("holaMundo").getBytes());
			data.close();

			FileInputStream fis = new FileInputStream("C:\\temp\\data");
			BufferedInputStream bufin = new BufferedInputStream(fis);
			byte[] buffer = new byte[1024];
			int len;
			while (bufin.available() != 0) {
				len = bufin.read(buffer);
				dsa.update(buffer, 0, len);
			}
			;
			bufin.close();
			
			
			byte[] realSig = dsa.sign(); // Se firma

			/* Save the signature in a file */
			FileOutputStream sigfos = new FileOutputStream("c:\\temp\\sig");
			sigfos.write(realSig);

			sigfos.close();
			
			//System.out.println("FIRMADO");
		} catch (Exception e) {
			e.printStackTrace();
			return;

		}
	}

	private void dumpKeyPair(KeyPair keyPair) {
		pub = keyPair.getPublic();
		//System.out.println("Old public: 308201b83082012c06072a8648ce3804013082011f02818100fd7f53811d75122952df4a9c2eece4e7f611b7523cef4400c31e3f80b6512669455d402251fb593d8d58fabfc5f5ba30f6cb9b556cd7813b801d346ff26660b76b9950a5a49f9fe8047b1022c24fbba9d7feb7c61bf83b57e7c6a8a6150f04fb83f6d3c51ec3023554135a169132f675f3ae2b61d72aeff22203199dd14801c70215009760508f15230bccb292b982a2eb840bf0581cf502818100f7e1a085d69b3ddecbbcab5c36b857b97994afbbfa3aea82f9574c0b3d0782675159578ebad4594fe67107108180b449167123e84c281613b7cf09328cc8a6e13c167a8b547c8d28e0a3ae1e2bb3a675916ea37f0bfa213562f1fb627a01243bcca4f1bea8519089a883dfe15ae59f06928b665e807b552564014c3bfecf492a0381850002818100c0d1f3d7d1c3c8b983651f3b0d7faeed03694a1834a735d1dfd86c3d0257847859e31038e0099581a78070d3a9e4b580880e76ac8d3f66d79b960b9fdca2bbbd48a43293ea0b89485d4ff618d2c1eacf6f910cadae763c82ffa9b67fd779c86e9c4a295da69bc395c6eabdab11975a7fccb78736b41b4edc1d26c7c375ab7e5f");
		System.out.println("Public Key: " + getHexString(pub.getEncoded()));

		priv = keyPair.getPrivate();
		//System.out.println("Old Private: 3082014b0201003082012c06072a8648ce3804013082011f02818100fd7f53811d75122952df4a9c2eece4e7f611b7523cef4400c31e3f80b6512669455d402251fb593d8d58fabfc5f5ba30f6cb9b556cd7813b801d346ff26660b76b9950a5a49f9fe8047b1022c24fbba9d7feb7c61bf83b57e7c6a8a6150f04fb83f6d3c51ec3023554135a169132f675f3ae2b61d72aeff22203199dd14801c70215009760508f15230bccb292b982a2eb840bf0581cf502818100f7e1a085d69b3ddecbbcab5c36b857b97994afbbfa3aea82f9574c0b3d0782675159578ebad4594fe67107108180b449167123e84c281613b7cf09328cc8a6e13c167a8b547c8d28e0a3ae1e2bb3a675916ea37f0bfa213562f1fb627a01243bcca4f1bea8519089a883dfe15ae59f06928b665e807b552564014c3bfecf492a04160214364e2cdcc729e68372704a7faee65a8c9c9e938c");
		//System.out.println("Private Key: " + getHexString(priv.getEncoded()));
	}

	private String getHexString(byte[] b) {
		String result = "";
		for (int i = 0; i < b.length; i++) {
			result += Integer.toString((b[i] & 0xff) + 0x100, 16).substring(1);
		}
		return result;
	}

	public void SaveKeyPair(String path, KeyPair keyPair) throws IOException {
		PrivateKey privateKey = keyPair.getPrivate();
		PublicKey publicKey = keyPair.getPublic();

		// Store Public Key.
		X509EncodedKeySpec x509EncodedKeySpec = new X509EncodedKeySpec(
				publicKey.getEncoded());
		FileOutputStream fos = new FileOutputStream(path + "/public.key");
		fos.write(x509EncodedKeySpec.getEncoded());		
		//cbd.ejecutarSeguro("update persona set llave_publica = ? where cedula = 112345678", x509EncodedKeySpec.getEncoded());
		/*
		if(cbd.ejecutar("update persona set llave_publica = '"+x509EncodedKeySpec.getEncoded()+"' where cedula = 113530880")){
			System.out.println("\n\n exito \n\n");
			
		}else{
			System.out.println("\n\n fallo\n\n");			
		}*/
		fos.close();

		// Store Private Key.
		PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(
				privateKey.getEncoded());
		fos = new FileOutputStream(path + "/private.key");
		fos.write(pkcs8EncodedKeySpec.getEncoded());
		fos.close();
	}

	public KeyPair LoadKeyPair(String path, String algorithm)
			throws IOException, NoSuchAlgorithmException,
			InvalidKeySpecException, SQLException {
		// Read Public Key.
		File filePublicKey = new File(path + "/public.key");
		FileInputStream fis = new FileInputStream(path + "/public.key");
		//byte[] bts = null;
		//ResultSet result = cbd.consultar("Select llave_publica from persona where cedula = 112345678");
		//bts = result.getBytes(1);
		String filePublicKey_s = cbd.consultarArray("Select llave_publica from persona where cedula = 112345678").get(0).get(0);
		byte[] encodedPublicKey = new byte[(int) filePublicKey.length()];
		//byte[] bytes =  
		encodedPublicKey = (filePublicKey_s).getBytes();
		System.out.println("Public Key; "+filePublicKey_s);
		System.out.println("rescato de la base; "+(filePublicKey_s).getBytes());// LA que rescato de la base
		fis.read(encodedPublicKey);
		System.out.println("Public Key; "+encodedPublicKey);
		fis.close();

		// Read Private Key.
		File filePrivateKey = new File(path + "/private.key");
		fis = new FileInputStream(path + "/private.key");
		byte[] encodedPrivateKey = new byte[(int) filePrivateKey.length()];
		fis.read(encodedPrivateKey);
		fis.close();

		// Generate KeyPair.
		KeyFactory keyFactory = KeyFactory.getInstance(algorithm);
		X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(
				encodedPublicKey);
		PublicKey publicKey = keyFactory.generatePublic(publicKeySpec);

		PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(
				encodedPrivateKey);
		PrivateKey privateKey = keyFactory.generatePrivate(privateKeySpec);

		
		/*VErificando firma */
		/* input the signature bytes */
		FileInputStream sigfis = new FileInputStream("c:\\temp\\sig");
		byte[] sigToVerify = new byte[sigfis.available()];
		sigfis.read(sigToVerify);

		sigfis.close();

		
		/*
		 * create a Signature object and initialize it with the public
		 * key
		 */
		try{
		Signature sig = Signature.getInstance("SHA1withDSA", "SUN");
		sig.initVerify(publicKey);
		//sig.initVerify((PublicKey) privKey);

		/* Update and verify the data */

		FileInputStream datafis = new FileInputStream("c:\\temp\\data");
		BufferedInputStream bufin = new BufferedInputStream(datafis);

		byte[] buffer = new byte[1024];
		int len;
		while (bufin.available() != 0) {
			len = bufin.read(buffer);
			sig.update(buffer, 0, len);
		}
		;

		bufin.close();

		verifies = sig.verify(sigToVerify);

		System.out.println("signature verifies: " + verifies);
		
		}catch(Exception e){
			System.err.println("Caught exception " + e.toString());			
		}
		return new KeyPair(publicKey, privateKey);
	}
/*
	public KeyPair LoadKeyPair(String path, String algorithm)
			throws IOException, NoSuchAlgorithmException,
			InvalidKeySpecException {
		// Read Public Key.
		File filePublicKey = new File(path + "/public.key");
		FileInputStream fis = new FileInputStream(path + "/public.key");
		byte[] encodedPublicKey = new byte[(int) filePublicKey.length()];
		fis.read(encodedPublicKey);
		fis.close();

		// Read Private Key.
		File filePrivateKey = new File(path + "/private.key");
		fis = new FileInputStream(path + "/private.key");
		byte[] encodedPrivateKey = new byte[(int) filePrivateKey.length()];
		fis.read(encodedPrivateKey);
		fis.close();

		// Generate KeyPair.
		KeyFactory keyFactory = KeyFactory.getInstance(algorithm);
		X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(
				encodedPublicKey);
		PublicKey publicKey = keyFactory.generatePublic(publicKeySpec);

		PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(
				encodedPrivateKey);
		PrivateKey privateKey = keyFactory.generatePrivate(privateKeySpec);

		return new KeyPair(publicKey, privateKey);
	}
*/
	/*
	private boolean ver() {
		/* VErificando firma */
		/* input the signature bytes */
	/*	FileInputStream sigfis = new FileInputStream("c:\\temp\\sig");
		byte[] sigToVerify = new byte[sigfis.available()];
		sigfis.read(sigToVerify);

		sigfis.close();
*/
		/*
		 * create a Signature object and initialize it with the public key
		 */
	/*	try {
		//	Signature sig = Signature.getInstance("SHA1withDSA", "SUN");
			//sig.initVerify(publicKey);
			// sig.initVerify((PublicKey) privKey);

			/* Update and verify the data */
/*
			FileInputStream datafis = new FileInputStream("c:\\temp\\data");
			BufferedInputStream bufin = new BufferedInputStream(datafis);

			byte[] buffer = new byte[1024];
			int len;
			while (bufin.available() != 0) {
				len = bufin.read(buffer);
				//sig.update(buffer, 0, len);
			}
			;

			bufin.close();

			//boolean verifies = sig.verify(sigToVerify);

			//System.out.println("signature verifies: " + verifies);

		} catch (Exception e) {
			System.err.println("Caught exception " + e.toString());
		}

	}*/

}