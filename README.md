***i3 in manjaro***

**some basic programs**
>- *[polybar](https://github.com/polybar/polybar)*
>- *[feh](https://github.com/derf/feh)*
>- *[compton](https://github.com/chjj/compton)*
>- *[dmenu](https://tools.suckless.org/dmenu/)*

***alacritty:***
- Terminal written in rust
- Configuration is dynamic, you don't need to relaunch the terminal to see the changes
- Configuring with yaml is very easy
- GPU accelerated rendering is great

\
***zsh***\
To enable vi mode
> Replace **$HOME/.oh-my-zsh/lib/key-bindings.zsh** `bindkey -e` to `bindkey -v`\
> add `export KEYTIMEOUT=1` *(remove timeout issue when changing modes)*.

***vim***
(neovim)

also, as an alternative to vscode, is use vscodium

---

**installation**
```bash
$ sudo ./install.sh (--init-system to install programs)
```

***et voila***
![alt text](.github/screenshot.png?raw=true "screenshot")


---