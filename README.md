# alp-litecoin

`alp-litecoin` is a fully stripped-down custom Litecoin node built from source, with all non-essential components removed. This version is intended for minimal environments and automation, with focus on portability and simplicity.

---

## 🔧 Features

- ✅ Based on official Litecoin source (`v0.21.2.2`)
- ✅ Built completely from source code
- ✅ No GUI, no RPC, no wallet, no mining, no tests
- ✅ Custom branding as `alp-litecoin` in peers, version output, logs
- ✅ Compatible with all major UNIX systems (Debian, Fedora, Arch, macOS, FreeBSD)
- ✅ Includes:
  - `setup-unix.sh` for building manually
  - `Dockerfile` for Docker image build
  - Clean `litecoind` binary output

---

## 📦 Build and Install (All UNIX Systems)

```bash
sudo bash setup-unix.sh
```

This will:
- Install required packages depending on your system
- Run `autogen.sh`, `configure`, and `make`
- Copy `litecoind` into `/usr/local/bin/litecoind`

---

## 🐳 Docker Build

```bash
docker build -t alp-litecoin .
```

Then you can run it like:

```bash
docker run -it --rm alp-litecoin
```

No volumes or RPC required. Configuration file is optional.

---

## ⚙️ Configuration

A minimal `litecoin.conf` (optional):

```
txindex=1
server=0
daemon=0
```

RPC is disabled at build-time. You don’t need RPC credentials or ports.

---

## 📁 Directory Structure

```
.
├── src/                   # Cleaned source code
├── Dockerfile             # Docker build support
├── setup-unix.sh          # Universal UNIX install script
├── autogen.sh
├── configure.ac
└── Makefile.am
```

---

## 🧩 Customizations

- All version strings replaced with `alp-litecoin`
- GUI, wallet, RPC, mining, and testing modules fully removed
- Only `litecoind` is compiled and installed

---

## 🔗 Based on

- Original source: https://github.com/litecoin-project/litecoin
- Maintained by: https://github.com/alplix

---

## 📜 License

MIT License — same as original Litecoin

