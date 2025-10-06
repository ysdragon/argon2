aPackageInfo = [
	:name = "Ring Argon2",
	:description = "A Ring language binding for the Argon2 password hashing algorithm, providing secure password hashing and verification capabilities.",
	:folder = "argon2",
	:developer = "ysdragon",
	:email = "youssefelkholey@gmail.com",
	:license = "MIT License",
	:version = "1.0.0",
	:ringversion = "1.24",
	:versions = 	[
		[
			:version = "1.0.0",
			:branch = "master"
		]
	],
	:libs = 	[
		[
			:name = "ringopenssl",
			:version = "1.0.9",
			:providerusername = "ringpackages"
		]
	],
	:files = 	[
		"lib.ring",
		"main.ring",
		".clang-format",
		"CMakeLists.txt",
		"LICENSE",
		"README.md",
		"examples/01-argon2d_basic_example.ring",
		"examples/02-argon2d_openssl_salt_example.ring",
		"examples/03-argon2i_basic_example.ring",
		"examples/04-argon2i_openssl_salt_example.ring",
		"examples/05-argon2id_basic_example.ring",
		"examples/06-argon2id_openssl_salt_example.ring",
		"src/argon2.ring",
		"src/argon2_test.ring",
		"src/ring_argon2.c",
		"src/ring_argon2.rh",
		"src/utils/install.ring",
		"src/utils/uninstall.ring",
		"src/utils/color.ring"
	],
	:ringfolderfiles = 	[

	],
	:windowsfiles = 	[
		"lib/windows/i386/ring_argon2.dll",
		"lib/windows/amd64/ring_argon2.dll",
		"lib/windows/arm64/ring_argon2.dll"
	],
	:linuxfiles = 	[
		"lib/linux/amd64/libring_argon2.so",
		"lib/linux/arm64/libring_argon2.so"
	],
	:ubuntufiles = 	[

	],
	:fedorafiles = 	[

	],
	:macosfiles = 	[
		"lib/macos/amd64/libring_argon2.dylib",
		"lib/macos/arm64/libring_argon2.dylib"
	],
	:freebsdfiles = 	[
		"lib/freebsd/amd64/libring_argon2.so",
		"lib/freebsd/arm64/libring_argon2.so"
	],
	:windowsringfolderfiles = 	[

	],
	:linuxringfolderfiles = 	[

	],
	:ubunturingfolderfiles = 	[

	],
	:fedoraringfolderfiles = 	[

	],
	:freebsdringfolderfiles = 	[

	],
	:macosringfolderfiles = 	[

	],
	:run = "ring main.ring",
	:windowsrun = "",
	:linuxrun = "",
	:macosrun = "",
	:ubunturun = "",
	:fedorarun = "",
	:setup = "ring src/utils/install.ring",
	:windowssetup = "",
	:linuxsetup = "",
	:macossetup = "",
	:ubuntusetup = "",
	:fedorasetup = "",
	:remove = "ring src/utils/uninstall.ring",
	:windowsremove = "",
	:linuxremove = "",
	:macosremove = "",
	:ubunturemove = "",
	:fedoraremove = ""
]