My dotfiles and setup
---


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