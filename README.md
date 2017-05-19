# Iconic CLI

This repository is proof of concept for CLI support in [Iconic](https://github.com/dzenbot/Iconic) iOS framework.

## Installation

```bash
$ make build // fetch dependencies & build Iconic
```

Once the installation is finished, Iconic is installed in `./.build/debug/Iconic`.
I choosed Swift PM as dependency manager so no frameworks has to be bundled ([ref](http://colemancda.github.io/2015/02/12/embedded-swift-frameworks-osx-command-line-tools)).
Now all code is managed with Swift PM, no code was copied to the repository directly.
Iconic is now completely written in swift (all bash scripts were rewritten).

## Run the demo

For now, CLI has the very same API as v1.3.
After successful build, you can run Iconic with:

```
$ ./.build/debug/Iconic ~/Downloads/FontAwesome.ttf --output src/Generated
```

Font may be given with both relative and absolute path.
Relative path is taken to the directory where you run `iconic` command.

The `src/Generated` must be a directory and must exist **before** you run Iconic.
Otherwise it will fail.

## Things to point out
Main difference from current version of Iconic is that `SwiftGen` dependency is completely removed.
Iconic is now standalone app, all dependencies are managed with Swift PM.

Since v1.3 release, SwiftGen templates were taken to it's own [repository](https://github.com/SwiftGen/templates).
As Iconic now have it's own CLI, only stencil filters from SwiftGen templates repository are used as dependency.

I changed the whole repository structure and the generated code structure.

## Targets

New Iconic has two targets: `Iconic` and `IconicKit`.
The first one takes care of the CLI interface and IO operations.
The second one actually works works with fonts.
This means that `IconicKit` may be used dependency with Carthage or CocoaPods.

## Changes

* Catalog is now one file generated stencil stencil (no command line hacks required)
* Quick build
* No dependecies copied into Iconic source
* Shell scripts are removed

Breaking changes
* JSON parser was removed, but may be easily added
* `--enumName` option was removed
* Dropped Apple watch support
* No tests are provided

All breaking changes are easy to fix but not supported yet.

## And the brew..

Brew is still not supported (wait what?).
Since I did the bottom-up rewrite, brew package is still not done.
However, thanks to rewrite it should be pretty easy now.
