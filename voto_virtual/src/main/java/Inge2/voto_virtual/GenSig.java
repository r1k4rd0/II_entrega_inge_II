package Inge2.voto_virtual;

import java.io.*;
import java.security.*;

class GenSig {

	public static void main(String[] args) {

		/* Generate a DSA signature */

		if (args.length == 1) {
			System.out.println("Usage: GenSig nameOfFileToSign");
		} else
			try {

				/* Generate a key pair */

				KeyPairGenerator keyGen = KeyPairGenerator.getInstance("DSA",
						"SUN");
				SecureRandom random = SecureRandom.getInstance("SHA1PRNG",
						"SUN");

				keyGen.initialize(1024, random);

				KeyPair pair = keyGen.generateKeyPair();
				PrivateKey priv = pair.getPrivate();
				PublicKey pub = pair.getPublic();

				

				/* Save the public key in a file */
				byte[] key = pub.getEncoded();
				FileOutputStream keyfos = new FileOutputStream("suepk");
				keyfos.write(key);

				keyfos.close();
				
				/*Save the private key in a file*/
				key = priv.getEncoded();
				keyfos = new FileOutputStream("privateKey");
				keyfos.write(key);

				keyfos.close();
			} catch (Exception e) {
				System.err.println("Caught exception " + e.toString());
			}

	}

}