```
sudo pacman -S  ttf-jetbrains-mono 
mkdir ~/.config/alacritty/
```
alacritty ssh远程nano vim 等无法使用的问题 在.bashrc 或者 [.zshrc ](https://github.com/joyanhui/oh-my-zsh/blob/f35093a98cb25ec7e727116ddb6c466a52a4c0e3/.zshrc#LL111C1-L111C45)添加别名
```
alias ssh="TERM=xterm-256color $(which ssh)"
```

```
cat > ~/.config/alacritty/alacritty.yml<< \EOF
# Colors (Aura Theme)
colors:
  # Default colors
  primary:
    background: "#15141b"
    foreground: "#edecee"

  cursor:
    cursor: "#a277ff"

  selection:
    text: CellForeground
    background: "#9A8FE2"

  # Normal colors
  normal:
    black: "#110f18"
    red: "#ff6767"
    green: "#61ffca"
    yellow: "#ffca85"
    blue: "#a277ff"
    magenta: "#a277ff"
    cyan: "#61ffca"
    white: "#edecee"

  # Bright colors
  bright:
    black: "#4d4d4d"
    red: "#ff6767"
    green: "#61ffca"
    yellow: "#ffca85"
    blue: "#a277ff"
    magenta: "#a277ff"
    cyan: "#61ffca"
    white: "#edecee"

  search:
    matches:
      foreground: "#000000"
      background: "#ffffff"
    focused_match:
      foreground: "#ffffff"
      background: "#9F7AF5"

# 设置字体
font:
  normal:
    family: "JetBrains Mono"
    style: Regular
  bold:
    family: "JetBrains Mono"
    style: Regular
  italic:
    family: "JetBrains Mono"
    style: Italic
  bold_italic:
    family: "JetBrains Mono"
    style: Italic

  # 字大小
  size: 11.0
  # 字间距
  offset:
    x: 0
    y: 0
  glyph_offset:
    x: 0
    y: 0

window:
  opacity: 0.9
  padding:
    x: 10
    y: 10
scrolling:
  # 回滚缓冲区中的最大行数,指定“0”将禁用滚动。
  history: 100000
  # 滚动行数
  multiplier: 4

cursor:
  style:
    blinking: Always
    blink_interval: 500

# 如果为‘true’，则使用亮色变体绘制粗体文本。
draw_bold_text_with_bright_colors: false

selection:
  semantic_escape_chars: ',│`|:"'' ()[]{}<>'
  save_to_clipboard: true

live_config_reload: true

# 设置键盘映射
key_bindings:
  - { key: R, mods: Command, mode: ~Vi|~Search, chars: "\x0c" }
  - { key: R, mods: Command, mode: ~Vi|~Search, action: ClearHistory }
  # - { key: W, mods: Command, action: Hide }
  - { key: W, mods: Command|Shift, action: Quit }
  - { key: T, mods: Command, action: SpawnNewInstance }
  - { key: N, mods: Command, action: CreateNewWindow }
  - { key: Left, mods: Alt, chars: "\x1bb" } # Skip word left
  - { key: Right, mods: Alt, chars: "\x1bf" } # Skip word right
  - { key: Left, mods: Command, chars: "\x1bOH", mode: AppCursor } # Home
  - { key: Right, mods: Command, chars: "\x1bOF", mode: AppCursor } # End
  - { key: Back, mods: Command, chars: "\x15" } # Delete line
  - { key: Back, mods: Alt, chars: "\x1b\x7f" } # Delete word
EOF

```
