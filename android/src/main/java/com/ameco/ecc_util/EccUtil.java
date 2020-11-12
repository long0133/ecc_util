package com.ameco.ecc_util;

import android.util.Base64;

import org.spongycastle.jce.provider.BouncyCastleProvider;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Security;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

/**
 * @author liaoyu
 * @version 1.0.0
 * @ClassName EccUtil.java
 * @Description ecc 加解密
 * @createTime 2020年11月06日 11:17:00
 */
public class EccUtil {
    private static final String ALGRITHM = "EC";
    private static final String PROVIDER = "SC";
    private static final String CIPHER = "ECIES";
    private static final int KEY_SIZE = 256;
    private static final String publicKeyString = "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEZYyOwpSUofP97I1aO3N7wcCj/0KncuoxvPS3RkWrMZVfH+2Z/30ejLiCWl9u/Cqpp+Isiq8TrnwzURgjlBkQlg==";
    private static final String privateKeyString = "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgjBMlENAa3JnnPoPBG5xxO5d+4mcx46HU2c2nDqY/i12gCgYIKoZIzj0DAQehRANCAARljI7ClJSh8/3sjVo7c3vBwKP/Qqdy6jG89LdGRasxlV8f7Zn/fR6MuIJaX278Kqmn4iyKrxOufDNRGCOUGRCW";
    static {
        Security.insertProviderAt(new BouncyCastleProvider(), 1);
    }
    /**
     * 加密文本
     *
     * @param text  文本
     * @return 密文
     */
    public static String encrypt(String text) {
        try {
            byte[] data = text.getBytes("UTF-8");
            if (data == null) {
                return text;
            }
            // 获取公钥
            byte[] keyData = Base64.decode(publicKeyString, android.util.Base64.DEFAULT);
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyData);
            KeyFactory keyFactory = KeyFactory.getInstance(ALGRITHM, PROVIDER);
            PublicKey publicKey = keyFactory.generatePublic(keySpec);
            // 加密
            Cipher cipher = Cipher.getInstance(CIPHER, PROVIDER);
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            return Base64.encodeToString(cipher.doFinal(data),Base64.DEFAULT);
        } catch (InvalidKeySpecException | NoSuchAlgorithmException | BadPaddingException | InvalidKeyException | NoSuchProviderException | IllegalBlockSizeException | UnsupportedEncodingException | NoSuchPaddingException e) {
            e.printStackTrace();
        }
        return  "";
    }

    /**
     * 解密
     *
     * @param text  密文
     * @return 明文
     */
    public static String decrypt(String text) {
        try {
            byte[] data = Base64.decode(text,Base64.DEFAULT);
            // 获取私钥
            byte[] keyData = Base64.decode(privateKeyString,Base64.DEFAULT);
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyData);
            KeyFactory keyFactory = KeyFactory.getInstance(ALGRITHM, PROVIDER);
            PrivateKey privateKey = keyFactory.generatePrivate(keySpec);
            // 解密
            Cipher cipher = Cipher.getInstance(CIPHER, PROVIDER);
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            return new String(Base64.decode(new String(cipher.doFinal(data)),Base64.DEFAULT));
        } catch (InvalidKeySpecException | NoSuchAlgorithmException | BadPaddingException | InvalidKeyException | NoSuchPaddingException | NoSuchProviderException | IllegalBlockSizeException e) {
            e.printStackTrace();
        }
        return "";
    }
}
