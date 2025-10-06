load "argon2.ring"
load "openssllib.ring"

cPassword = "123123"

see "Generating secure random salt using OpenSSL..." + nl
cSalt = randbytes(ARGON2_DEFAULT_SALT_LEN)
see "Generated Salt: " + cSalt + nl

see "Hashing password using Argon2i with OpenSSL-generated salt..." + nl

cEncodedHash = argon2i_hash(
    cPassword,
    cSalt,
    ARGON2_DEFAULT_T_COST,
    ARGON2_DEFAULT_M_COST,
    ARGON2_DEFAULT_PARALLELISM,
    ARGON2_DEFAULT_HASH_LEN
)

see "Password: " + cPassword + nl
see "Salt: " + cSalt + nl
see "Encoded Hash: " + cEncodedHash + nl
see "---------------------------------" + nl

see "Verifying correct password..." + nl
if argon2i_verify(cEncodedHash, cPassword)
    see "Verification successful! (Correct)" + nl
else
    see "Verification FAILED! (This should not happen)" + nl
ok

see "Verifying incorrect password..." + nl
if argon2i_verify(cEncodedHash, "wrong_password")
    see "Verification successful! (This is a security flaw!)" + nl
else
    see "Verification FAILED! (Correct)" + nl
ok

see "Verifying with a malformed hash (should fail)..." + nl
if argon2i_verify("invalid_hash_string", cPassword)
    see "Verification successful! (This is a security flaw!)" + nl
else
    see "Verification FAILED! (Correct)" + nl
ok

? nl + "Done!"