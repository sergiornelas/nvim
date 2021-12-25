# Sergiornelas Neovim

<div align="center">
  
[![Lua](https://img.shields.io/badge/Made%20With-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)]()
[![Repo_Size](https://img.shields.io/github/languages/code-size/shaunsingh/nyoom.nvim?color=orange&label=Repo%20Size&style=for-the-badge)]()
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.6+-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=white)](https://github.com/neovim/neovim)

</div>

## Showcase

<img width="1450" alt="image" src="https://user-images.githubusercontent.com/71196912/144915258-dc6652cf-64e4-458f-8f01-8f17dbb33756.png">

## Try out this config

Make sure to remove or move your current `nvim` directory

```
git clone git@github.com:sergiornelas/Neovim ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

each video will be associated with a branch so checkout the one you are interested in

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```
  sudo apt install xsel
  ```

- On Arch Linux

  ```
  sudo pacman -S xsel
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```
  pip install pynvim
  ```

- Neovim node support

  ```
  npm i -g neovim
  ```
