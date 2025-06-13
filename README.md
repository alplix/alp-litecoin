# alp-litecoin

`alp-litecoin` is a fully stripped-down custom Litecoin node built from source, with all non-essential components removed. This version is intended for minimal environments and automation, with focus on portability and simplicity.


<a href="https://www.buymeacoffee.com/alplix" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
---

## 🚀 Quick Start

### Option 1: Using `git` (recommended)

```bash
git clone https://github.com/alplix/alp-litecoin.git
cd alp-litecoin
sudo bash setup-unix.sh
```

### Option 2: Without `git` (manual download with `curl` or `wget`)

```bash
# If curl is available
curl -L -O https://github.com/alplix/alp-litecoin/archive/refs/heads/main.zip

# OR if curl is not available, use wget
wget https://github.com/alplix/alp-litecoin/archive/refs/heads/main.zip

unzip main.zip
cd alp-litecoin-main
sudo bash setup-unix.sh
```

This will:
- Install required dependencies for your OS (Debian, Fedora, Arch, macOS, BSD)
- Compile `litecoind` from source with minimal features
- Place the binary in `/usr/local/bin/litecoind`

---

## 🔧 Features

- ✅ Based on official Litecoin source (`v0.21.2.2`)
- ✅ Built completely from source code
- ✅ No GUI, no RPC, no wallet, no mining, no tests
- ✅ Custom branding as `alp-litecoin` in peers, version output, logs
- ✅ Compatible with all major UNIX systems
- ✅ Includes:
  - `setup-unix.sh` for universal installation
  - `Dockerfile` for lightweight container builds
  - Clean `litecoind` only output

---

## 🐳 Docker Build

```bash
docker build -t alp-litecoin .
docker run -it --rm alp-litecoin
```

No volumes, ports or RPC setup needed.

---

## ⚙️ Optional Configuration

A basic `litecoin.conf`:

```
txindex=1
server=0
daemon=0
```

RPC is disabled. No RPC credentials or port binding is required.

---

## 📁 Directory Structure

```
.
├── src/                   # Cleaned source code
├── Dockerfile             # Docker build support
├── setup-unix.sh          # UNIX install script
├── autogen.sh
├── configure.ac
└── Makefile.am
```

---

## 🧩 Customizations

- Version strings changed to `alp-litecoin`
- GUI, wallet, RPC, mining, and test modules completely removed
- Only `litecoind` is compiled and installed

---

## 🔗 Based on

- Original source: https://github.com/litecoin-project/litecoin
- Maintained by: https://github.com/alplix

---

## 📜 License

MIT License — same as original Litecoin
