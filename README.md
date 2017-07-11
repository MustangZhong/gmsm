About gmsm
=========================

This is a PHP extension for SM Crypto Algorithm  that supports SM2 / SM3 / SM4.

Environment
------------

`php5.4`

SM Crypto Algorithm
------------

The secret algorithm is the abbreviation of the national commercial cryptographic algorithm. Since 2012, the National Password Authority to the "People's Republic of China password industry standard" approach, have announced the SM2 / SM3 / SM4 and other cryptographic algorithm standards and application specifications. Which "SM" on behalf of "business secret", that is used for commercial, not involving state secrets of the password technology. SM2 is a public key cryptography algorithm based on elliptic curve cryptography, including digital signature, key exchange and public key encryption. It is used to replace international algorithms such as RSA / Diffie-Hellman / ECDSA / ECDH. SM3 is password hash algorithm, SM4 is a block cipher used to replace DES / AES and other international algorithms. SM9 is an identity-based cryptographic algorithm that can replace PKI / CA based on digital certificate. By deploying the secret algorithm, you can reduce the security risks caused by weak passwords and bug implementations and the overhead of deploying PKI / CA.

Install
------------

 1. exec `phpize` in `gmsm` dir;
 2. `./configure` `make` `make install`;
 3.  modify php.ini to add `extension=gmsm.so`;
 4.  Then you can call origin function in PHP project;


Function List (For PHP)
------------

 * sm2_encrypt(string $data, string $pub_key_x, string pub_key_y)
 * sm2_decrypt(string $private_key, string $cipher)
 * sm3_hash(string $data)
 * sm4_encrypt(string $data, string $key)
 * sm4_decrypt(string $cipher, string $key)

Reference
------------

[Source of SM Crypto Algorithm](http://www.scctc.org.cn/templates/Download/index.aspx?nodeid=71)

Notice
------------

SM2 also has some problem to be solved.
