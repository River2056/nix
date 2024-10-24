setopt hist_verify

# yazi: exit in browsing directory
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"


function showdiff() {
    git diff-tree --no-commit-id --name-only $1 -r
}

function gitgraph() {
    git log --all --decorate --oneline --graph
}

function darwin() {
    darwin-rebuild switch --flake ~/nix#river2056
}

function hm() {
    home-manager switch --flake ~/nix
}

function rebuild() {
    darwin
    hm
}

function nixupdate() {
    nix flake update
}
