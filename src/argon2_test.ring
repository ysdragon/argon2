arch = getarch()
if isWindows()
	if arch = "x64"
		loadlib("../lib/windows/amd64/ring_argon2.dll")
	but arch = "arm64"
		loadlib("../lib/windows/arm64/ring_argon2.dll")
	but arch = "x86"
		loadlib("../lib/windows/i386/ring_argon2.dll")
	ok
but isLinux()
	if arch = "x64"
		loadlib("../lib/linux/amd64/libring_argon2.so")
	but arch = "arm64"
		loadlib("lib/linux/arm64/libring_argon2.so")
	ok
but isFreeBSD()
	if arch = "x64"
		loadlib("../lib/freebsd/amd64/libring_argon2.so")
	but arch = "arm64"
		loadlib("../lib/freebsd/arm64/libring_argon2.so")
	ok
but isMacOSX()
	if arch = "x64"
		loadlib("../lib/macos/amd64/libring_argon2.dylib")
	but arch = "arm64"
		loadlib("../lib/macos/arm64/libring_argon2.dylib")
	ok
else
	raise("Unsupported OS! You need to build the library for your OS.")
ok

load "ring_argon2.rh"
load "utils/color.ring"

func main
	? colorText([:text = "--- Testing Argon2 ---", :color = :BRIGHT_YELLOW, :style = :BOLD])

	# Test Vector 1: Argon2d with default parameters
	password1 = "password123"
	salt1 = "somesalt1234"
	
	? colorText([:text = "Test Case 1: Argon2d with default parameters", :color = :BRIGHT_CYAN])
	? colorText([:text = "Password: ", :color = :MAGENTA]) + "'" + password1 + "'"
	? colorText([:text = "Salt: ", :color = :MAGENTA]) + "'" + salt1 + "'"

	encoded_hash1 = argon2d_hash(
		password1,
		salt1,
		ARGON2_DEFAULT_T_COST,
		ARGON2_DEFAULT_M_COST,
		ARGON2_DEFAULT_PARALLELISM,
		ARGON2_DEFAULT_HASH_LEN
	)
	? colorText([:text = "Encoded Hash: ", :color = :GREEN]) + encoded_hash1
	
	if argon2d_verify(encoded_hash1, password1)
		? colorText([:text = "Verification (correct password): OK", :color = :BRIGHT_GREEN])
	else
		? colorText([:text = "Verification (correct password): FAILED", :color = :BRIGHT_RED])
	ok
	
	if not argon2d_verify(encoded_hash1, "wrong_password")
		? colorText([:text = "Verification (wrong password): OK", :color = :BRIGHT_GREEN])
	else
		? colorText([:text = "Verification (wrong password): FAILED", :color = :BRIGHT_RED])
	ok
	? colorText([:text = copy("-", 50), :color = :BRIGHT_BLACK])

	# Test Vector 2: Argon2i with default parameters
	password2 = "another_password"
	salt2 = "anothersalt5678"
	
	? colorText([:text = "Test Case 2: Argon2i with default parameters", :color = :BRIGHT_CYAN])
	? colorText([:text = "Password: ", :color = :MAGENTA]) + "'" + password2 + "'"
	? colorText([:text = "Salt: ", :color = :MAGENTA]) + "'" + salt2 + "'"

	encoded_hash2 = argon2i_hash(
		password2,
		salt2,
		ARGON2_DEFAULT_T_COST,
		ARGON2_DEFAULT_M_COST,
		ARGON2_DEFAULT_PARALLELISM,
		ARGON2_DEFAULT_HASH_LEN
	)
	? colorText([:text = "Encoded Hash: ", :color = :GREEN]) + encoded_hash2
	
	if argon2i_verify(encoded_hash2, password2)
		? colorText([:text = "Verification (correct password): OK", :color = :BRIGHT_GREEN])
	else
		? colorText([:text = "Verification (correct password): FAILED", :color = :BRIGHT_RED])
	ok
	
	if not argon2i_verify(encoded_hash2, "wrong_password")
		? colorText([:text = "Verification (wrong password): OK", :color = :BRIGHT_GREEN])
	else
		? colorText([:text = "Verification (wrong password): FAILED", :color = :BRIGHT_RED])
	ok
	? colorText([:text = copy("-", 50), :color = :BRIGHT_BLACK])

	# Test Vector 3: Argon2id with default parameters
	password3 = "yet_another_password"
	salt3 = "yetanothersalt9012"
	
	? colorText([:text = "Test Case 3: Argon2id with default parameters", :color = :BRIGHT_CYAN])
	? colorText([:text = "Password: ", :color = :MAGENTA]) + "'" + password3 + "'"
	? colorText([:text = "Salt: ", :color = :MAGENTA]) + "'" + salt3 + "'"

	encoded_hash3 = argon2id_hash(
		password3,
		salt3,
		ARGON2_DEFAULT_T_COST,
		ARGON2_DEFAULT_M_COST,
		ARGON2_DEFAULT_PARALLELISM,
		ARGON2_DEFAULT_HASH_LEN
	)
	? colorText([:text = "Encoded Hash: ", :color = :GREEN]) + encoded_hash3
	
	if argon2id_verify(encoded_hash3, password3)
		? colorText([:text = "Verification (correct password): OK", :color = :BRIGHT_GREEN])
	else
		? colorText([:text = "Verification (correct password): FAILED", :color = :BRIGHT_RED])
	ok
	
	if not argon2id_verify(encoded_hash3, "wrong_password")
		? colorText([:text = "Verification (wrong password): OK", :color = :BRIGHT_GREEN])
	else
		? colorText([:text = "Verification (wrong password): FAILED", :color = :BRIGHT_RED])
	ok
	? colorText([:text = copy("-", 50), :color = :BRIGHT_BLACK])

	# Test Vector 4: Verify malformed hash fails
	? colorText([:text = "Test Case 4: Malformed hash verification", :color = :BRIGHT_CYAN])
	
	if not argon2d_verify("invalid_hash_string", password1)
		? colorText([:text = "Argon2d verification (malformed hash): OK", :color = :BRIGHT_GREEN])
	else
		? colorText([:text = "Argon2d verification (malformed hash): FAILED", :color = :BRIGHT_RED])
	ok
	
	if not argon2i_verify("invalid_hash_string", password2)
		? colorText([:text = "Argon2i verification (malformed hash): OK", :color = :BRIGHT_GREEN])
	else
		? colorText([:text = "Argon2i verification (malformed hash): FAILED", :color = :BRIGHT_RED])
	ok
	
	if not argon2id_verify("invalid_hash_string", password3)
		? colorText([:text = "Argon2id verification (malformed hash): OK", :color = :BRIGHT_GREEN])
	else
		? colorText([:text = "Argon2id verification (malformed hash): FAILED", :color = :BRIGHT_RED])
	ok
	? colorText([:text = copy("-", 50), :color = :BRIGHT_BLACK])

	? colorText([:text = "All Argon2 tests completed!", :color = :BRIGHT_GREEN, :style = :BOLD])