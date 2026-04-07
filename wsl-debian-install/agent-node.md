# Debian / WSL Agent Tools

## `bsdutils`
Name: `bsdutils`

This package provides small core system utilities that many scripts assume are present, such as `logger`, `renice`, and other low-level helper commands. Agents usually do not call it directly as one tool, but Debian systems commonly rely on the package being installed.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y bsdutils
```

## `bubblewrap`
Name: `bubblewrap`

`bubblewrap` installs the `bwrap` executable, which creates lightweight sandboxes for running commands with restricted filesystem and process access. It is useful when an agent or tool wants an isolated execution environment without a full container runtime.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y bubblewrap
```

## `findutils`
Name: `findutils`

This package provides standard file-search tools such as `find` and `xargs`, which are commonly used by agents to locate files, filter paths, and build batch command pipelines. It is part of the normal Unix command-line toolkit.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y findutils
```

## `fd-find`
Name: `fd-find`

`fd-find` provides a fast, user-friendly alternative to `find` for common recursive file searches. It is useful when an agent wants simpler syntax, smart defaults, and faster interactive search through large trees.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y fd-find
```

On Debian, the package name is `fd-find`, but the executable is `fdfind` rather than `fd` because of a filename clash.

Verify the tool is available:

```bash
fdfind --version
```

## `grep`
Name: `grep`

`grep` searches text using literal strings or regular expressions, making it useful for scanning logs, source files, and generated output. Agents often use it for quick filtering when a repo does not already have `ripgrep`.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y grep
```

## `jq`
Name: `jq`

`jq` is a lightweight command-line JSON processor used to inspect, filter, transform, and reformat structured JSON data in shell pipelines. Agents use it when APIs, manifests, logs, or config files need precise machine-readable extraction instead of plain-text grep.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y jq
```

Verify the tool is available:

```bash
jq --version
```

## `gzip`
Name: `gzip`

`gzip` provides compression and decompression tools for `.gz` files, including the `gzip` and `gunzip` commands. Agents use it when handling compressed logs, archives, or downloaded assets.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y gzip
```

## `imagemagick`
Name: `imagemagick`

`imagemagick` installs the ImageMagick command-line image processing tools used to convert formats, resize or crop images, inspect metadata, and script bitmap edits from the shell. On Debian / WSL, you get it directly from the normal Debian `apt` repositories; no separate vendor installer is needed for this setup doc.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y imagemagick
```

Verify the tools are available:

```bash
magick --version
```

Some older scripts may still use legacy commands such as `convert`, but `magick` is the main entrypoint to prefer in new usage.

## `npm`
Name: `npm`

`npm` is the Node.js package manager used to install JavaScript and TypeScript dependencies, run project scripts, and fetch CLI tools published on the npm registry. On Debian, installing `npm` typically brings in the matching Node.js runtime packages needed to execute those tools.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y npm
```

Check that both `npm` and `node` are available after install:

```bash
npm --version
node --version
```

## `python3`
Name: `python3`

`python3` installs the main Python interpreter used for automation, scripting, helper tools, and many build or content pipelines. Agents use it to run `.py` scripts directly and to drive package-based Python tooling.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y python3
```

Verify the interpreter:

```bash
python3 --version
```

## `PIL`
Name: `PIL` (`python3-pil` / Pillow)

`PIL` is the Python import namespace commonly used for image work, while the actively maintained library is Pillow. On Debian / WSL, you typically install it with the `python3-pil` package, then import it in Python code as `from PIL import Image`.


If you are working inside a virtual environment and want to install it with `pip` instead of `apt`, use the package name `pillow`:

```bash
python -m pip install pillow
python -c "from PIL import Image; print(Image.__version__)"
```

## `NumPy`
Name: `NumPy` (`python3-numpy` / `numpy`)

NumPy provides fast array and numerical computing primitives used by many scientific, image-processing, and machine-learning workflows. For isolated agent environments, install it inside the active virtual environment with `pip`; the Debian system package equivalent is `python3-numpy`.

Install inside an activated virtual environment:

```bash
python -m pip install numpy
```

If you need the Debian system package instead of a venv-local install:

```bash
sudo apt update
sudo apt install -y python3-numpy
```

Verify the Python-side setup from inside the venv:

```bash
python -c "import numpy; print(numpy.__version__)"
```

## `OpenCV`
Name: `OpenCV` (`python3-opencv` / `opencv-python`)

OpenCV provides image, video, and computer-vision APIs and is usually imported in Python as `cv2`. For venv-based agent setups, install `opencv-python` inside the active virtual environment; the Debian system package equivalent is `python3-opencv`.

Install inside an activated virtual environment:

```bash
python -m pip install opencv-python
```

If you need the Debian system package instead of a venv-local install:

```bash
sudo apt update
sudo apt install -y python3-opencv
```

Verify the Python-side setup from inside the venv:

```bash
python -c "import cv2; print(cv2.__version__)"
```

## `python3-venv`
Name: `python3-venv`

`python3-venv` is the Debian package that enables Python virtual environments through the built-in `venv` module. It is what lets an agent create isolated Python dependency environments with `python3 -m venv`, which is the standard way to install project-specific Python packages without polluting the system Python install.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y python3 python3-venv
```

Create and activate a virtual environment after install:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
```

After activation, install the packages the agent needs into that environment:

```bash
python -m pip install <package-name>
```

If you are given a `requirements.txt`, install from it with:

```bash
python -m pip install -r requirements.txt
```

## `tesseract-ocr`
Name: `tesseract-ocr` (`pytesseract` inside venv)

`tesseract-ocr` is the system OCR engine that extracts text from images, while `pytesseract` is the Python wrapper agents typically install inside a virtual environment to call that engine from Python code. You need both pieces: `pytesseract` does not include the OCR engine, and it depends on the system `tesseract` executable provided by the Debian `tesseract-ocr` package.

Install the OCR engine on Debian / WSL:

```bash
sudo apt update
sudo apt install -y tesseract-ocr
```

Verify the system binary:

```bash
tesseract --version
```

Inside an activated virtual environment, install the Python wrapper and image support. This only works after the system `tesseract-ocr` package is installed:

```bash
python -m pip install --upgrade pip
python -m pip install pytesseract pillow
```

Verify the Python-side setup from inside the venv:

```bash
python -c "import pytesseract; from PIL import Image; print(pytesseract.get_tesseract_version())"
```

Minimal usage example:

```python
from PIL import Image
import pytesseract

text = pytesseract.image_to_string(Image.open("input.png"))
print(text)
```

## `ripgrep`
Name: `ripgrep`

`ripgrep` installs the `rg` executable, which is a fast recursive search tool for source trees and text files. Agents prefer it over older tools for codebase search because it respects ignore files and is usually much faster on large repositories.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y ripgrep
```

## `dos2unix`
Name: `dos2unix`

`dos2unix` converts text files between Windows CRLF and Unix LF line endings, which is useful when scripts or source files were edited on Windows and then used inside WSL or Linux tooling. The same package also provides companion commands such as `unix2dos`, `mac2unix`, and `unix2mac`.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y dos2unix
```

Verify the tool is available:

```bash
dos2unix --version
```

## `unzip`
Name: `unzip`

`unzip` extracts `.zip` archives and is useful for unpacking downloaded tools, assets, fixtures, or release bundles. Agents often need it when a dependency or artifact is distributed as a zip file.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y unzip
```

## `vim`
Name: `vim`

`vim` is a terminal text editor that is widely available on Debian systems and useful for direct file inspection or emergency edits in shells without a graphical editor. Even if an agent does not use it interactively, it is a common fallback editor on headless environments.

Install on Debian / WSL:

```bash
sudo apt update
sudo apt install -y vim
```
