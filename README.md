# Ring Argon2

[license]: https://img.shields.io/github/license/ysdragon/argon2?style=for-the-badge&logo=opensourcehardware&label=License&logoColor=C0CAF5&labelColor=414868&color=8c73cc
[![][license]](https://github.com/ysdragon/argon2/blob/master/LICENSE)

[ring]: https://img.shields.io/badge/Made_with_❤️_for-Ring-2D54CB?style=for-the-badge
[![][ring]](https://ring-lang.net/)

A Ring language binding for the [Argon2](https://github.com/P-H-C/phc-winner-argon2) password hashing algorithm, providing secure password hashing and verification capabilities with support for Argon2d, Argon2i, and Argon2id variants.

## 📖 Overview

Argon2 is the winner of the Password Hashing Competition (PHC) and is designed to be a memory-hard password hashing algorithm that is resistant to GPU cracking attacks and side-channel attacks.

## ✨ Features

- Support for all three Argon2 variants: Argon2d, Argon2i, and Argon2id
- Easy-to-use API for password hashing and verification

## 📦 Installation

This package can be installed using the Ring Package Manager (**RingPM**):

```
ringpm install argon2 from ysdragon
```

## 💡 Usage

First, load the library in your Ring script:

```ring
load "argon2.ring"
```

### Basic Password Hashing

To hash a password using Argon2d with default parameters:

```ring
cPassword = "my_secure_password"
cSalt = "somesalt1234"  # In production, use a securely generated random salt

cEncodedHash = argon2id_hash(
    cPassword,
    cSalt,
    ARGON2_DEFAULT_T_COST,      # Time cost
    ARGON2_DEFAULT_M_COST,      # Memory cost
    ARGON2_DEFAULT_PARALLELISM, # Parallelism
    ARGON2_DEFAULT_HASH_LEN     # Hash length
)
```

### Password Verification

To verify a password against a stored hash:

```ring
if argon2id_verify(cEncodedHash, cPassword)
    see "Verification successful!" + nl
else
    see "Verification failed!" + nl
ok
```

## ⚙️ Variants

- **Argon2i**: Resistant to side-channel attacks but potentially weaker against GPU cracking
- **Argon2d**: Provides better resistance against GPU attacks but is vulnerable to side-channel attacks in certain contexts
- **Argon2id**: A hybrid that provides both GPU attack resistance and side-channel protection

## 📚 API Reference

### Hashing Functions

- `argon2i_hash(password, salt, t_cost, m_cost, parallelism, hash_len)` - Hashes a password using Argon2i algorithm
- `argon2d_hash(password, salt, t_cost, m_cost, parallelism, hash_len)` - Hashes a password using Argon2d algorithm
- `argon2id_hash(password, salt, t_cost, m_cost, parallelism, hash_len)` - Hashes a password using Argon2id algorithm

All hashing functions take these parameters:
- `password` (string): The password to hash
- `salt` (string): The salt to use for hashing
- `t_cost` (number): Time cost parameter (iterations)
- `m_cost` (number): Memory cost parameter (in KB)
- `parallelism` (number): Parallelism parameter (number of threads)
- `hash_len` (number): Output hash length in bytes

### Verification Functions

- `argon2d_verify(encoded_hash, password)` - Verifies a password against an Argon2d encoded hash
- `argon2i_verify(encoded_hash, password)` - Verifies a password against an Argon2i encoded hash
- `argon2id_verify(encoded_hash, password)` - Verifies a password against an Argon2id encoded hash

All verification functions take these parameters:
- `encoded_hash` (string): The encoded hash to verify against
- `password` (string): The password to verify

### Constants

The following constants are available after loading the library:

- `ARGON2_D` - Argon2d type identifier
- `ARGON2_I` - Argon2i type identifier
- `ARGON2_ID` - Argon2id type identifier
- `ARGON2_VERSION` - Current Argon2 version
- `ARGON2_DEFAULT_T_COST` - Default time cost (3)
- `ARGON2_DEFAULT_M_COST` - Default memory cost (19456 KB)
- `ARGON2_DEFAULT_PARALLELISM` - Default parallelism (1)
- `ARGON2_DEFAULT_HASH_LEN` - Default hash length (32 bytes)
- `ARGON2_DEFAULT_SALT_LEN` - Default salt length (16 bytes)

### Error Handling

- `argon2_error_message(error_code)` - Returns a human-readable error message for an error code

## 🛠️ Development

If you wish to contribute to the development of Ring Argon2 or build it from the source, follow these steps.

### Prerequisites

-   **CMake**: Version 3.16 or higher.
-   **C Compiler**: A C compiler compatible with your platform (e.g., GCC, Clang, MSVC).
-   **[Ring](https://ring-lang.net/) Source Code**: You will need to have the Ring language source code available on your machine.

### Build Steps

1.  **Clone the Repository:**
    ```sh
    git clone https://github.com/ysdragon/argon2.git --recursive
    ```
    > **Note**: If you installed the library via RingPM, you can skip this step.

2.  **Set the `RING` Environment Variable:**
    This variable must point to the root directory of the Ring language source code.

    -   **Windows (Command Prompt):**
        ```cmd
        set RING=X:\path\to\ring
        ```
    -   **Windows (PowerShell):**
        ```powershell
        $env:RING = "X:\path\to\ring"
        ```
    -   **Unix-like Systems (Linux, macOS or FreeBSD):**
        ```bash
        export RING=/path/to/ring
        ```

3.  **Configure with CMake:**
    Create a build directory and run CMake from within it.
    ```sh
    mkdir build
    cd build
    cmake ..
    ```

4.  **Build the Project:**
    Compile the source code using the build toolchain configured by CMake.
    ```sh
    cmake --build .
    ```

    The compiled library will be available in the `lib/<os>/<arch>` directory.

## 🤝 Contributing

Contributions are always welcome! If you have suggestions for improvements or have identified a bug, please feel free to open an issue or submit a pull request.

## 📄 License

This project is licensed under the MIT License. See the [`LICENSE`](LICENSE) file for more details.