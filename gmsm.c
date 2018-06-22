/*
  +----------------------------------------------------------------------+
  | PHP Version 5                                                        |
  +----------------------------------------------------------------------+
  | Copyright (c) 1997-2014 The PHP Group                                |
  +----------------------------------------------------------------------+
  | This source file is subject to version 3.01 of the PHP license,      |
  | that is bundled with this package in the file LICENSE, and is        |
  | available through the world-wide-web at the following url:           |
  | http://www.php.net/license/3_01.txt                                  |
  | If you did not receive a copy of the PHP license and are unable to   |
  | obtain it through the world-wide-web, please send a note to          |
  | license@php.net so we can mail you a copy immediately.               |
  +----------------------------------------------------------------------+
  | Author:                                                              |
  +----------------------------------------------------------------------+
*/

/* $Id$ */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "php.h"
#include "php_ini.h"
#include "ext/standard/info.h"
#include "php_gmsm.h"

/* If you declare any globals in php_gmsm.h uncomment this:
ZEND_DECLARE_MODULE_GLOBALS(gmsm)
*/

/* True global resources - no need for thread safety here */
static int le_gmsm;

/* {{{ gmsm_functions[]
 *
 * Every user visible function must have an entry in gmsm_functions[].
 */
const zend_function_entry gmsm_functions[] = {
	PHP_FE(sm2_encrypt,	NULL)
	PHP_FE(sm2_decrypt,	NULL)
	PHP_FE(sm3_hash,	NULL)
	PHP_FE(sm4_encrypt,	NULL)
	PHP_FE(sm4_decrypt,	NULL)
	PHP_FE_END	/* Must be the last line in gmsm_functions[] */
};
/* }}} */

/* {{{ gmsm_module_entry
 */
zend_module_entry gmsm_module_entry = {
#if ZEND_MODULE_API_NO >= 20010901
	STANDARD_MODULE_HEADER,
#endif
	"gmsm",
	gmsm_functions,
	PHP_MINIT(gmsm),
	PHP_MSHUTDOWN(gmsm),
	PHP_RINIT(gmsm),		/* Replace with NULL if there's nothing to do at request start */
	PHP_RSHUTDOWN(gmsm),	/* Replace with NULL if there's nothing to do at request end */
	PHP_MINFO(gmsm),
#if ZEND_MODULE_API_NO >= 20010901
	PHP_GMSM_VERSION,
#endif
	STANDARD_MODULE_PROPERTIES
};
/* }}} */

#ifdef COMPILE_DL_GMSM
ZEND_GET_MODULE(gmsm)
#endif

/* {{{ PHP_INI
 */
/* Remove comments and fill if you need to have entries in php.ini
PHP_INI_BEGIN()
    STD_PHP_INI_ENTRY("gmsm.global_value",      "42", PHP_INI_ALL, OnUpdateLong, global_value, zend_gmsm_globals, gmsm_globals)
    STD_PHP_INI_ENTRY("gmsm.global_string", "foobar", PHP_INI_ALL, OnUpdateString, global_string, zend_gmsm_globals, gmsm_globals)
PHP_INI_END()
*/
/* }}} */

/* {{{ php_gmsm_init_globals
 */
/* Uncomment this function if you have INI entries
static void php_gmsm_init_globals(zend_gmsm_globals *gmsm_globals)
{
	gmsm_globals->global_value = 0;
	gmsm_globals->global_string = NULL;
}
*/
/* }}} */

/* {{{ PHP_MINIT_FUNCTION
 */
PHP_MINIT_FUNCTION(gmsm)
{
	/* If you have INI entries, uncomment these lines 
	REGISTER_INI_ENTRIES();
	*/
	return SUCCESS;
}
/* }}} */

/* {{{ PHP_MSHUTDOWN_FUNCTION
 */
PHP_MSHUTDOWN_FUNCTION(gmsm)
{
	/* uncomment this line if you have INI entries
	UNREGISTER_INI_ENTRIES();
	*/
	return SUCCESS;
}
/* }}} */

/* Remove if there's nothing to do at request start */
/* {{{ PHP_RINIT_FUNCTION
 */
PHP_RINIT_FUNCTION(gmsm)
{
	return SUCCESS;
}
/* }}} */

/* Remove if there's nothing to do at request end */
/* {{{ PHP_RSHUTDOWN_FUNCTION
 */
PHP_RSHUTDOWN_FUNCTION(gmsm)
{
	return SUCCESS;
}
/* }}} */

/* {{{ PHP_MINFO_FUNCTION
 */
PHP_MINFO_FUNCTION(gmsm)
{
	php_info_print_table_start();
	php_info_print_table_header(2, "gmsm support", "enabled");
	php_info_print_table_end();

	/* Remove comments if you have entries in php.ini
	DISPLAY_INI_ENTRIES();
	*/
}
/* }}} */


/* Remove the following function when you have successfully modified config.m4
   so that your module can be compiled into PHP, it exists only for testing
   purposes. */

/* Every user-visible function in PHP should document itself in the source */
/* {{{ proto string confirm_gmsm_compiled(string arg)
   Return a string to confirm that the module is compiled in */
/**
 * sm2_encrypt
 */
PHP_FUNCTION(sm2_encrypt)
{
	unsigned char *data, *private_key, *cipher, *hex_cipher = NULL;
	int data_len, private_key_len, cipher_len, hex_cipher_len = 0;
	unsigned char *pub_key_x, *pub_key_y = NULL;
	int pub_key_x_len, pub_key_y_len = 0;

	if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "sss", &data, &data_len, &pub_key_x, &pub_key_x_len, &pub_key_y, &pub_key_y_len) == FAILURE) {
		return;
	}

	cipher_len = data_len + 32*3;
	cipher = emalloc(cipher_len);
	memset(cipher, 0, cipher_len);
	SM2_Encrypt_New(data, data_len, pub_key_x, pub_key_y, cipher);

	hex_cipher_len = cipher_len*2;
	hex_cipher = emalloc(hex_cipher_len);
	memset(hex_cipher, 0, hex_cipher_len);
	BCD2HexString(cipher, cipher_len, hex_cipher, hex_cipher_len);

#if defined(ZEND_ENGINE_3)
    RETVAL_STR(contents);
#else
    RETVAL_STRINGL(contents, hex_cipher_len, 1);
#endif

	efree(cipher);
	efree(hex_cipher);
}

/**
 * sm2_decrypt
 */
PHP_FUNCTION(sm2_decrypt)
{
	unsigned char *cipher, *key, *data = NULL;
	int cipher_len, key_len, data_len = 0;
	int i = 0;

	if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "ss", &key, &key_len, &cipher, &cipher_len) == FAILURE) {
		return;
	}

	data_len = cipher_len - 32*3;
	data = emalloc(data_len);
	memset(data, 0, data_len);
	SM2_Decrypt_New(cipher, cipher_len, key, data);

#if defined(ZEND_ENGINE_3)
    RETVAL_STR(contents);
#else
    RETVAL_STRINGL(contents, data_len, 1);
#endif

	efree(data);
}

/**
 * sm3_hash
 */
PHP_FUNCTION(sm3_hash)
{
    unsigned char *str, *hash_str = NULL;
    int str_len = 0;

    if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "s", &str, &str_len) == FAILURE) {
        return;
    }

    hash_str = emalloc(32);
    memset(hash_str, 0, 32);
    SM3_256(str, str_len, hash_str);

#if defined(ZEND_ENGINE_3)
    RETVAL_STR(contents);
#else
    RETVAL_STRINGL(hash_str, strlen(hash_str), 1);
#endif

    efree(hash_str);
}

/**
 * sm4_encrypt
 */
PHP_FUNCTION(sm4_encrypt)
{
    unsigned char *data, *key, *cipher = NULL;
    int data_len, key_len = 0;
    int i = 0;

    if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "ss", &data, &data_len, &key, &key_len) == FAILURE) {
        return;
    }

    // encrypt
    cipher = emalloc(16);
    memset(cipher, 0, 16);
    SM4_Encrypt(key, data, cipher);

#if defined(ZEND_ENGINE_3)
    RETVAL_STR(contents);
#else
    RETVAL_STRINGL(cipher, 16, 1);
#endif

    efree(cipher);
}

/**
 * sm4_decrypt
 */
PHP_FUNCTION(sm4_decrypt)
{
    unsigned char *cipher, *key, *data = NULL;
    int cipher_len, key_len = 0;
    int i = 0;

    if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "ss", &cipher, &cipher_len, &key, &key_len) == FAILURE) {
        return;
    }

    data = emalloc(16);
    memset(data, 0, 16);
    SM4_Decrypt(key, cipher, data);

#if defined(ZEND_ENGINE_3)
    RETVAL_STR(contents);
#else
    RETVAL_STRINGL(data, strlen(data), 1);
#endif

    efree(data);
}
/* }}} */
/* The previous line is meant for vim and emacs, so it can correctly fold and 
   unfold functions in source code. See the corresponding marks just before 
   function definition, where the functions purpose is also documented. Please 
   follow this convention for the convenience of others editing your code.
*/


/*
 * Local variables:
 * tab-width: 4
 * c-basic-offset: 4
 * End:
 * vim600: noet sw=4 ts=4 fdm=marker
 * vim<600: noet sw=4 ts=4
 */
