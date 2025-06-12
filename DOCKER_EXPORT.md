# Exporting `alp-litecoin` Docker Image Without Docker Hub

This guide will help you build and export the `alp-litecoin` image as a `.tar` file without needing Docker Hub or terminal login.

---

## ✅ Step-by-Step Instructions

### 1. Unzip the source archive

If you have `alp-litecoin-node-final.zip`, unzip it and go into the folder:

```bash
unzip alp-litecoin-node-final.zip
cd alp-litecoin-node-final
```

### 2. Build the Docker image locally

```bash
docker build -t alp-litecoin .
```

This will build the image directly from the included `Dockerfile`.

### 3. Export the image as a .tar file

```bash
docker save -o alp-litecoin.tar alp-litecoin
```

This will create a file named `alp-litecoin.tar`.

### 4. Share or move the .tar file

You can send this file to another system or upload it anywhere. Others can import it with:

```bash
docker load -i alp-litecoin.tar
```

---

## 🔁 Once loaded, run it:

```bash
docker run -it --rm alp-litecoin
```

This starts the `litecoind` node inside Docker with no RPC, no GUI — just pure background node.

---
