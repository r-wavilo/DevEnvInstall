# Debian / WSL Agent Tools

Run this once before installing system packages:

```bash
sudo apt update
```

## System Packages

Install the non-Python system utilities with one apt transaction:

```bash
sudo apt install -y \
  bubblewrap \
  curl \
  dos2unix \
  fd-find \
  file \
  imagemagick \
  jq \
  ripgrep \
  rsync \
  tesseract-ocr \
  tmux \
  unzip \
  vim \
  xxd
```

### `bubblewrap`

Lightweight command sandboxing through `bwrap`.

### `fd-find`

Fast recursive file search. The Debian executable is `fdfind`.

### `file`

File type detection through content and magic-number inspection.

### `jq`

JSON inspection and transformation for shell pipelines.

### `imagemagick`

Command-line image conversion, resizing, cropping, and metadata inspection.

Use `magick` as the main command in new scripts.

### `curl`

HTTP download utility used by installers such as nvm.

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

### `tmux`

Terminal multiplexer for persistent shell sessions.

### `ripgrep`

Fast recursive text search through the `rg` command.

### `rsync`

Efficient file and directory synchronization for release upgrades and preserving runtime data.

### `dos2unix`

Line-ending conversion between Windows and Unix text files.

### `unzip`

Extraction for `.zip` archives.

### `vim`

Terminal editor for direct file inspection and fallback editing.

### `xxd`

Hex dumps and byte-level file inspection.

## Node.js and npm

Use nvm for user-scoped Node.js and npm. Do not install Debian's `npm` package for agent tooling, and do not use `sudo npm install -g`.

Install nvm and the default Node.js line:

```bash
export NVM_DIR="$HOME/.nvm"
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
fi
. "$NVM_DIR/nvm.sh"
nvm install 24
nvm alias default 24
nvm use 24
node --version
npm --version
npx --version
```

For non-interactive scripts, load nvm before calling `node`, `npm`, or `npx`:

```bash
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
nvm use --silent default
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
