/*
 * Ring Argon2 Extension
 *
 * Implementation of Argon2 password hashing functions for the Ring programming language.
 * This module provides secure password hashing and verification using the Argon2 algorithm,
 * the winner of the Password Hashing Competition (PHC).
 *
 * Features:
 * - Support for all Argon2 variants: Argon2d, Argon2i, and Argon2id
 * - Password hashing and verification functions
 * - Access to Argon2 constants and error handling
 *
 * Copyright (c) 2025 Youssef Saeed (ysdragon) <youssefelkholey@gmail.com>
 * License: MIT
 */

#include "argon2.h"
#include "ring.h"

/*
 *	Private Functions
 */

/**
 * Hashes a password with Argon2, producing an encoded hash
 * @param pPointer Pointer to the Ring API parameter list
 * @param type The type of Argon2 to use (i, d, or id)
 * @return NULL if an error occurred, otherwise the encoded hash as a string
 * @pre   The parameter list must contain 6 parameters: password, salt, t_cost, m_cost, parallelism, hash_len
 * @pre   The password and salt must be strings
 * @pre   The t_cost, m_cost, parallelism, and hash_len must be numbers
 */
static void ring_argon2_hash(void *pPointer, argon2_type type)
{
	if (RING_API_PARACOUNT != 6)
	{
		RING_API_ERROR(
			"argon2 hash function expects 6 parameters: password, salt, t_cost, m_cost, parallelism, hash_len");
		return;
	}

	if (!RING_API_ISSTRING(1) || !RING_API_ISSTRING(2) || !RING_API_ISNUMBER(3) || !RING_API_ISNUMBER(4) ||
		!RING_API_ISNUMBER(5) || !RING_API_ISNUMBER(6))
	{
		RING_API_ERROR(RING_API_BADPARATYPE);
		return;
	}

	const char *pwd = RING_API_GETSTRING(1);
	size_t pwdlen = RING_API_GETSTRINGSIZE(1);
	const char *salt = RING_API_GETSTRING(2);
	size_t saltlen = RING_API_GETSTRINGSIZE(2);
	uint32_t t_cost = (uint32_t)RING_API_GETNUMBER(3);
	uint32_t m_cost = (uint32_t)RING_API_GETNUMBER(4);
	uint32_t parallelism = (uint32_t)RING_API_GETNUMBER(5);
	size_t hashlen = (size_t)RING_API_GETNUMBER(6);

	size_t encodedlen = argon2_encodedlen(t_cost, m_cost, parallelism, (uint32_t)saltlen, (uint32_t)hashlen, type);

	char *encoded = (char *)RING_API_MALLOC(encodedlen);
	if (encoded == NULL)
	{
		RING_API_ERROR(RING_OOM);
		return;
	}

	int result = argon2_hash(t_cost, m_cost, parallelism, pwd, pwdlen, salt, saltlen, NULL, hashlen, encoded,
							 encodedlen, type, ARGON2_VERSION_NUMBER);

	if (result != ARGON2_OK)
	{
		RING_API_FREE(encoded);
		RING_API_ERROR(argon2_error_message(result));
		return;
	}

	RING_API_RETSTRING(encoded);
}

/**
 * Verifies a password against an encoded string
 * @param pPointer Pointer to RingState
 * @param type Type of Argon2 to use
 * @return Zero if successful, a non zero error code otherwise
 */
static void ring_argon2_verify(void *pPointer, argon2_type type)
{
	if (RING_API_PARACOUNT != 2)
	{
		RING_API_ERROR(RING_API_MISS2PARA);
		return;
	}
	if (!RING_API_ISSTRING(1) || !RING_API_ISSTRING(2))
	{
		RING_API_ERROR(RING_API_BADPARATYPE);
		return;
	}

	const char *encoded = RING_API_GETSTRING(1);
	const char *pwd = RING_API_GETSTRING(2);
	size_t pwdlen = RING_API_GETSTRINGSIZE(2);

	int result = argon2_verify(encoded, pwd, pwdlen, type);

	RING_API_RETNUMBER(result == ARGON2_OK);
}

/*
 *  Public API Functions
 */

RING_FUNC(ring_argon2i_hash)
{
	ring_argon2_hash(pPointer, Argon2_i);
}

RING_FUNC(ring_argon2d_hash)
{
	ring_argon2_hash(pPointer, Argon2_d);
}

RING_FUNC(ring_argon2id_hash)
{
	ring_argon2_hash(pPointer, Argon2_id);
}

RING_FUNC(ring_argon2i_verify)
{
	ring_argon2_verify(pPointer, Argon2_i);
}

RING_FUNC(ring_argon2d_verify)
{
	ring_argon2_verify(pPointer, Argon2_d);
}

RING_FUNC(ring_argon2id_verify)
{
	ring_argon2_verify(pPointer, Argon2_id);
}

RING_FUNC(ring_argon2_error_message)
{
	if (RING_API_PARACOUNT != 1)
	{
		RING_API_ERROR(RING_API_MISS1PARA);
		return;
	}
	if (!RING_API_ISNUMBER(1))
	{
		RING_API_ERROR(RING_API_BADPARATYPE);
		return;
	}
	int error_code = (int)RING_API_GETNUMBER(1);
	RING_API_RETSTRING(argon2_error_message(error_code));
}

/*
 *  Constant Getter Functions
 */

RING_FUNC(ring_get_argon2_d)
{
	RING_API_RETNUMBER(Argon2_d);
}

RING_FUNC(ring_get_argon2_i)
{
	RING_API_RETNUMBER(Argon2_i);
}

RING_FUNC(ring_get_argon2_id)
{
	RING_API_RETNUMBER(Argon2_id);
}

RING_FUNC(ring_get_argon2_version)
{
	RING_API_RETNUMBER(ARGON2_VERSION_NUMBER);
}

RING_FUNC(ring_get_argon2_default_t_cost)
{
	RING_API_RETNUMBER(3);
}

RING_FUNC(ring_get_argon2_default_m_cost)
{
	RING_API_RETNUMBER(19456);
}

RING_FUNC(ring_get_argon2_default_parallelism)
{
	RING_API_RETNUMBER(1);
}

RING_FUNC(ring_get_argon2_default_hash_len)
{
	RING_API_RETNUMBER(32);
}

RING_FUNC(ring_get_argon2_default_salt_len)
{
	RING_API_RETNUMBER(16);
}

/*
 *  Library Init
 */

RING_LIBINIT
{
	RING_API_REGISTER("argon2i_hash", ring_argon2i_hash);
	RING_API_REGISTER("argon2d_hash", ring_argon2d_hash);
	RING_API_REGISTER("argon2id_hash", ring_argon2id_hash);
	RING_API_REGISTER("argon2i_verify", ring_argon2i_verify);
	RING_API_REGISTER("argon2d_verify", ring_argon2d_verify);
	RING_API_REGISTER("argon2id_verify", ring_argon2id_verify);
	RING_API_REGISTER("argon2_error_message", ring_argon2_error_message);

	RING_API_REGISTER("get_argon2_d", ring_get_argon2_d);
	RING_API_REGISTER("get_argon2_i", ring_get_argon2_i);
	RING_API_REGISTER("get_argon2_id", ring_get_argon2_id);
	RING_API_REGISTER("get_argon2_version", ring_get_argon2_version);
	RING_API_REGISTER("get_argon2_default_t_cost", ring_get_argon2_default_t_cost);
	RING_API_REGISTER("get_argon2_default_m_cost", ring_get_argon2_default_m_cost);
	RING_API_REGISTER("get_argon2_default_parallelism", ring_get_argon2_default_parallelism);
	RING_API_REGISTER("get_argon2_default_hash_len", ring_get_argon2_default_hash_len);
	RING_API_REGISTER("get_argon2_default_salt_len", ring_get_argon2_default_salt_len);
}