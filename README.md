# 🛠️ kyroceus/dotfiles

My personal dotfiles for setting up a consistent development environment across systems. Powered by [`stow`](https://www.gnu.org/software/stow/), systemd user services, and a touch of automation.

## 📦 Structure

This repo is structured with [GNU Stow](https://www.gnu.org/software/stow/) in mind. Each directory (like `zsh`, `nvim`, etc.) corresponds to a self-contained configuration that can be symlinked into the appropriate location in your home directory.

```bash
dotfiles/
├── zsh/
│   └── .zshrc
├── nvim/
│   └── .config/nvim/...
├── git/
│   └── .gitconfig
└── ...
```

## 🚀 Quick Start

### 1. Clone the repo

```bash
git clone https://github.com/kyroceus/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install dependencies

Make sure `stow` is installed:

```bash
# Ubuntu/Debian
sudo apt install stow

# Fedora
sudo dnf install stow

# macOS (Homebrew)
brew install stow

# Arch
sudo pacman -S stow
```

### 3. Stow your configs

Pick and choose which configs to use:

```bash
stow zsh
stow nvim
stow git
stow tmux
```

This will symlink the contents into your `$HOME` directory.

To unstow (remove symlinks):

```bash
stow -D zsh
```

## 🧠 systemd User Services (Optional)

The dotfiles have user-level systemd service for notifying battery status.

### Enable lingering for your user (if you want battery notify service to run before login):

```bash
sudo loginctl enable-linger $USER
```

### Symlink user services

```bash
stow systemd
```

Then reload and enable your service:

```bash
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable --now battery-check.timer
```

## 🔁 Updating your dotfiles

Since everything is symlinked, just edit the files in `~/dotfiles` and commit your changes. Updates will reflect immediately.

## 📂 Recommended Directory Layout

If you'd like to contribute or fork for your own setup, follow this convention:

- `bin/`: Scripts and CLI tools
- `zsh/`, `bash/`, etc.: Shell-specific configs
- `nvim/`, `vim/`: Editor configs
- `tmux/`: Multiplexer configs
- `systemd/`: User-level systemd services
- `git/`: Global git config

## 🧰 Tools I Use

- [Zsh](https://www.zsh.org/)
- [Neovim](https://neovim.io/)
- [Tmux](https://github.com/tmux/tmux)
- [Starship](https://starship.rs/)
- [fzf](https://github.com/junegunn/fzf)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [bat](https://github.com/sharkdp/bat)

## 🤝 Contributions

Feel free to fork or raise PRs if you find useful enhancements. Suggestions welcome!
