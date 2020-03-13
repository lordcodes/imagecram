<p align="center">
    <img src="Art/logo.png" width="500" max-width="90%" alt="Imagecram" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/swiftpm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
     <img src="https://img.shields.io/badge/platforms-mac+linux-brightgreen.svg?style=flat" alt="Mac + Linux" />
     <a href="https://github.com/lordcodes/imagecram/releases/latest">
         <img src="https://img.shields.io/github/release/lordcodes/imagecram.svg?style=flat" alt="Latest release" />
     </a>
    <a href="https://twitter.com/lordcodes">
        <img src="https://img.shields.io/badge/twitter-@lordcodes-blue.svg?style=flat" alt="Twitter: @lordcodes" />
    </a>
</p>

---

This is **Imagecram** - a tool to quickly and easily compress images straight from your command line.

Compression is currently handled using the really powerful [TinyPNG service](https://tinypng.com).

&nbsp;

<p align="center">
    <a href="#features">Features</a> • <a href="#install">Install</a> • <a href="#usage">Usage</a> • <a href="#contributing-or-help">Contributing</a>
</p>

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

## Future

The plan is to implement image compression within the tool itself to remove the restriction of providing a TinyPNG API key and being limited on how many images they will compress for free each month. There is currently no time-frame on this and it will depend on simplicity and how effectively it compresses the images.

## Contributing or Help

If you notice any bugs or have a new feature to suggest, please check out the [contributing guide](https://github.com/lordcodes/imagecram/blob/master/CONTRIBUTING.md). If you want to make changes, please make sure to discuss anything big before putting in the effort of creating the PR.

To reach out, please contact [@lordcodes on Twitter](https://twitter.com/lordcodes).
