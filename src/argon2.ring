# This file is part of the Ring Argon2 library.

# Load the Ring Argon2 library based on the operating system.
if isWindows()
	loadlib("ring_argon2.dll")
but isLinux() or isFreeBSD()
	loadlib("libring_argon2.so")
but isMacOSX()
	loadlib("libring_argon2.dylib")
else
	raise("Unsupported OS! You need to build the library for your OS.")
ok

# Load Ring Argon2 Constants.
load "ring_argon2.rh"