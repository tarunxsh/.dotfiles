# My dotfiles

### Managing Dotfiles with GNU Stow

GNU Stow is a symlink farm manager that makes dotfile management clean and elegant. Here's how to use it correctly.

### The Core Concept

Stow works by creating symlinks from a **source directory** (your dotfiles repo) into a **target directory** (usually `$HOME`). The directory structure inside your stow package mirrors where the files should live relative to the target.

---

### 1. Set Up Your Dotfiles Directory

```bash
mkdir ~/dotfiles
cd ~/dotfiles
git init
```

---

### 2. Structure Your Packages

Each **subdirectory** in `~/dotfiles` is a "package". Inside it, replicate the directory structure relative to `$HOME`:

1. `.stow-local-ignore` - stow igore file
2. `brew.sh` - install script for Homebrew

```
~/dotfiles/
├── bash/
│   ├── .bashrc
│   └── .bash_profile
├── git/
│   └── .gitconfig
├── nvim/
│   └── .config/
│       └── nvim/
│           ├── init.lua
│           └── lua/
│               └── plugins.lua
├── tmux/
│   └── .tmux.conf
├── .stow-local-ignore 
├── brew.sh 
```

So `bash/.bashrc` → symlinks to `~/.bashrc`.
Similarly `nvim/.config/nvim/init.lua` → symlinks to `~/.config/nvim/init.lua`

---

### 3. Stow a Package

```bash
cd ~/dotfiles

# Stow a single package
stow bash

# Stow multiple packages at once
stow bash git nvim tmux

# Stow all packages (from the dotfiles root)
stow */
```

This creates symlinks in `$HOME` pointing back into `~/dotfiles`.

---

### 4. Key Flags to Know

| Flag | Purpose |
|---|---|
| `-n` / `--no` | **Dry run** — preview what would happen |
| `-v` | Verbose output |
| `-D` | **Delete** (remove symlinks for a package) |
| `-R` | **Restow** — delete then re-stow (useful after restructuring) |
| `--target=DIR` | Set a custom target directory |
| `--dotfiles` | Auto-expand `dot-` prefix to `.` in filenames |

```bash
stow -nv bash        # dry run first — always a good habit
stow -D bash         # unstow / remove symlinks
stow -R bash         # restow after changes
```

---

### 6. The `--dotfiles` Flag (Modern Convenience)

If you don't like hidden directories in your repo, you can use the `dot-` prefix convention:

```
~/dotfiles/bash/
├── dot-bashrc        →  ~/.bashrc
└── dot-bash_profile  →  ~/.bash_profile
```

Then stow with:

```bash
stow --dotfiles bash
```

---

### 7. Adopt an Existing Config

Use `--adopt` to pull an existing file from `$HOME` into your dotfiles repo and symlink it back

```bash
# 1. Create the package dir and a placeholder file
mkdir -p ~/dotfiles/mycli
touch ~/dotfiles/mycli/.myclirc

# 2. Adopt — stow moves the real ~/.myclirc into the package and symlinks it
cd ~/dotfiles
stow --adopt mycli
```

---

### 8. Typical Workflow

```bash
# 1. Move an existing config into your dotfiles repo
mv ~/.bashrc ~/dotfiles/bash/.bashrc

# 2. Dry run to verify
stow -nv bash

# 3. Stow it
stow bash

# 4. Commit
cd ~/dotfiles && git add . && git commit -m "add bash config"

# 5. On a new machine:
git clone https://github.com/you/dotfiles ~/dotfiles
cd ~/dotfiles
stow bash git nvim tmux
```

---

## Some useful packages

1. Install [intel-one-mono](https://github.com/intel/intel-one-mono) font    

    ```bash
    brew install --cask font-intel-one-mono
    ```

2. Install [ohmyzsh](https://ohmyz.sh/)

3. Install [z](https://github.com/rupa/z) plugin ( or [zoxide](https://github.com/ajeetdsouza/zoxide) alternatively)

    ```bash
    plugins+=(z)
    ```

4. Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) plugin

    ```bash
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    plugins+=(zsh-autosuggestions)
    ```

5. Install [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) or [fzf-tab](https://github.com/Aloxaf/fzf-tab)

    ```bash
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
    plugins+=(zsh-autocomplete)
    ```

6. Install [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) : fast and better  [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

    ```bash
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
    plugins+=(fast-syntax-highlighting)
    ```

7. Install [bat](https://github.com/sharkdp/bat) : cat with syntax highlighting and git integration

    ```bash
    brew install bat
    ```

8. Install [fd](https://github.com/sharkdp/fd): better alternative to `find`

    ```bash
    brew install fd
    ```

9. install [eza](https://eza.rocks/): better alternative to `ls` require [nerd-fonts](https://github.com/ryanoasis/nerd-fonts)

    ```bash
    brew install eza
    brew install font-hack-nerd-font
    echo "alias ls='eza -l'" >> ${ZDOTDIR:-$HOME}/.zshrc
    source ~/.zshrc
    ```

9. install [jq](https://jqlang.org/): command-line JSON processor

    ```bash
    brew install jq
    jq --version
    echo "json() { echo "$1" | jq . }" >> ${ZDOTDIR:-$HOME}/.zshrc
    source ~/.zshrc

    # usage to parse json string
    json '{"foo": "bar"}'

    # return value at given path
    json '{"foo": "bar"}' | jq .foo

    # list all keys
    json '{"foo": "bar"}' | jq keys
    ```

10. install fzf [here](https://jitesh117.github.io/blog/how-i-use-fzf-to-supercharge-my-workflow/)

    ```bash
    # bat as a previewer for fzf
    fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"
    ```

11. Setup aws cli with cmd completion
[here](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-completion.html)

12. Setup try directories [here](https://github.com/tobi/try)