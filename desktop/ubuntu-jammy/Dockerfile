FROM lscr.io/linuxserver/webtop:ubuntu-kde

ARG USER=abc
ARG HOME=/config

ENV USER=${USER}
ENV SHELL=/usr/bin/zsh

RUN apt update && \
    apt install -y \
    git \
    curl \
    wget \
    zsh \
    unzip

# Install fonts
COPY --chown=${USER} ./fonts/FiraCode.zip /tmp/FiraCode.zip
RUN mkdir ${HOME}/.fonts && \
    unzip /tmp/FiraCode.zip -d ${HOME}/.fonts && \
    rm /tmp/FiraCode.zip

# Install neovim (0.9.0)
ADD --chown=${USER} ./programs/nvim-linux64.tar.gz /tmp/neovim/
RUN cp /tmp/neovim/nvim-linux64/bin/nvim /usr/bin/nvim && \
    rm -rf /tmp/neovim

# Oh-My-Zsh installation and setup
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-history-substring-search && \
    sed -i "s/plugins=.*/plugins=(git git-flow zsh-syntax-highlighting zsh-autosuggestions dirhistory zsh-history-substring-search)/g" ${HOME}/.zshrc

# Install starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

# ---

# Copy .config folder
COPY --chown=${USER} ./.config ${HOME}/.config

# Load config files in .zshrc
RUN echo "[[ ! -f ~/.config/aliases.zsh  ]] || source ~/.config/aliases.zsh" >> ${HOME}/.zshrc && \
    echo "[[ ! -f ~/.config/functions.zsh  ]] || source ~/.config/functions.zsh" >> ${HOME}/.zshrc && \
    echo "eval \"\$(starship init zsh)\"" >> ${HOME}/.zshrc

# ---

# Copy configuration files
COPY --chown=${USER} ./configuration /tmp/configuration

# Install ripgrep
COPY --chown=${USER} ./programs/ripgrep_13.0.0_amd64.deb /tmp/ripgrep_13.0.0_amd64.deb

# Customize the Konsole terminal & KDE
RUN mkdir -p ${HOME}/.local/share/konsole && \
    cp /tmp/configuration/Catppuccin-Frappe.colorscheme ${HOME}/.local/share/konsole/Catppuccin-Frappe.colorscheme && \
    cp /tmp/configuration/main.profile ${HOME}/.local/share/konsole/main.profile && \
    cp /tmp/configuration/konsolerc ${HOME}/.config/konsolerc

# Change home directory ownership recursively
RUN chown -R ${USER}:${USER} ${HOME}
