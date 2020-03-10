# Imagecram 🗜

[![SPM](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org/package-manager)
![Platforms](https://img.shields.io/badge/Platforms-macOS-blue.svg)
[![Git Version](https://img.shields.io/github/release/lordcodes/imagecram.svg)](https://github.com/lordcodes/imagecram/releases)
[![license](https://img.shields.io/github/license/lordcodes/imagecram.svg)](https://github.com/lordcodes/imagecram/blob/master/LICENSE)

A command line tool to compress and optimise images using the [TinyPNG service](https://tinypng.com).

## Features

#### ☑️ Compress one or more images

Provide a single image file or multiple image files to be compressed.

#### ☑️ Select images with a regex

Instead of file paths, specify using a regex. E.g. `*.png` to compress all PNGs in the current folder.

#### ☑️ Specify the output location

Provide the output file or folder to write the compressed file(s) to.

## Install

#### ▶︎ Swift Package Manager

Imagecram can be easily installed using Swift Package Manager.

```terminal
 git clone https://github.com/lordcodes/imagecram
 cd imagecram
 swift run task install
```

It can be uninstalled later using: `swift run task uninstall`.

#### ▶︎ Mint

Imagecram can be installed using Mint.

```terminal
mint install lordcodes/imagecram
```

#### ▶︎ Homebrew

Support for Homebrew is planned.

## Usage

```terminal
USAGE: imagecram [<inputs> ...] [--output <output>] [--version] [--quiet]

ARGUMENTS:
  <inputs>                One or more input image files 

OPTIONS:
  -o, --output <output>   Output image file or directory 
  -v, --version           Output the version number 
  -q, --quiet             Silence any output except errors 
  -h, --help              Show help information.
```

### TinyPNG API key

On first run, you will be asked for your TinyPNG API key, which will be stored on your system for future runs.

If you already have a TinyPNG account you can get the API key from your [account dashboard](https://tinypng.com/dashboard/api).

If you don't have an account yet it only takes a few seconds to [get one from the TinyPNG website](https://tinypng.com/developers).

### Examples

#### ▶︎ Compress and overwrite a single image

```
imagecram article-header.png
```

#### ▶︎ Compress and overwrite a list of images

```
imagecram one.jpg two.png three.png
```

#### ▶︎ Compress and overwrite multiple images

```
imagecram ~/Downloads/*.png
```

#### ▶︎ Compress and save as a new image

```
imagecram old.png -o new.png
```

#### ▶︎ Compress multiple images and save to a folder

```
imagecram *.png -o compressed
```

## Contributing or Help

If you notice any bugs or have a new feature to suggest, please check out the [contributing guide](https://github.com/lordcodes/imagecram/blob/master/CONTRIBUTING.md). If you want to make changes, please make sure to discuss anything big before putting in the effort of creating the PR.

To reach out please contact [@lordcodes on Twitter](https://twitter.com/lordcodes).
