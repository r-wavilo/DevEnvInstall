# Debian / WSL Agent Tools

Run this once before installing system packages:

```bash
sudo apt update
```

## System Packages

### `bubblewrap`

Lightweight command sandboxing through `bwrap`.

```bash
sudo apt install -y bubblewrap
```

### `fd-find`

Fast recursive file search. The Debian executable is `fdfind`.

```bash
sudo apt install -y fd-find
```

### `file`

File type detection through content and magic-number inspection.

```bash
sudo apt install -y file
```

### `jq`

JSON inspection and transformation for shell pipelines.

```bash
sudo apt install -y jq
```

### `imagemagick`

Command-line image conversion, resizing, cropping, and metadata inspection.

```bash
sudo apt install -y imagemagick
```

Use `magick` as the main command in new scripts.

### `npm`

Node.js package manager for JavaScript and TypeScript tooling.

```bash
sudo apt install -y npm
```

### `python3` and `python3-venv`

Python interpreter and virtual environment support.

```bash
sudo apt install -y python3 python3-venv
```

Create a venv for Python packages:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
```

### `tesseract-ocr`

System OCR engine required by the Python `pytesseract` wrapper.

```bash
sudo apt install -y tesseract-ocr
```

### `ripgrep`

Fast recursive text search through the `rg` command.

```bash
sudo apt install -y ripgrep
```

### `dos2unix`

Line-ending conversion between Windows and Unix text files.

```bash
sudo apt install -y dos2unix
```

### `unzip`

Extraction for `.zip` archives.

```bash
sudo apt install -y unzip
```

### `vim`

Terminal editor for direct file inspection and fallback editing.

```bash
sudo apt install -y vim
```

### `xxd`

Hex dumps and byte-level file inspection.

```bash
sudo apt install -y xxd
```

## Python Packages

Install these inside an activated virtual environment:

```bash
python -m pip install \
  mypy \
  numpy \
  opencv-python \
  p4python \
  pillow \
  pydantic \
  pytest \
  pytesseract \
  rich \
  ruff \
  typer
```

Package notes:

- `pillow` imports as `PIL`.
- `opencv-python` imports as `cv2`.
- `p4python` imports as `P4`.
- `pytesseract` requires the system `tesseract-ocr` package.
