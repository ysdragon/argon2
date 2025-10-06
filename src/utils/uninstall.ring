load "stdlibcore.ring"

cPathSep = "/"

if isWindows()
	cPathSep = "\\"
ok

# Remove the argon2.ring file from the load directory
remove(exefolder() + "load" + cPathSep + "argon2.ring")

# Remove the argon2.ring file from the Ring2EXE libs directory
remove(exefolder() + ".." + cPathSep + "tools" + cPathSep + "ring2exe" + cPathSep + "libs" + cPathSep + "argon2.ring")

# Change current directory to the samples directory
chdir(exefolder() + ".." + cPathSep + "samples")

# Remove the UsingArgon2 directory if it exists
if direxists("UsingArgon2")
	OSDeleteFolder("UsingArgon2")
ok