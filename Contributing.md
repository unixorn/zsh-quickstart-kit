# Contributing to the ZSH Quickstart Kit

The **ZSH Quickstart Kit** is a batteries-included starter kit for using `zsh`.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents

- [Contribution Guidelines](#contribution-guidelines)
- [New Features](#new-features)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Contribution Guidelines

Please only add scripts that have a license attached. I'd prefer to avoid the gray area of unlicensed code.

## New Features

Please open an issue before starting to code so we can discuss the new feature, especially if it adds new dependency requirements for the kit.

When adding a new feature, please also add `zqs-enable-featurename` and `zqs-disable-featurename` functions to `.zshrc`, and also update the `zqs-help` function. New features should use the `_zqs-get-setting` and `_zqs-set-setting` functions to load any settings they need instead of directly creating cookie files.

Please update the README to include instructions for your new feature.
