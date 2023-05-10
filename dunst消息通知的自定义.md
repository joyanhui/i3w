
```
mkdir ~/.config/dunst/
```
参考 https://github.com/catppuccin/dunst/tree/main/src
我这里字体用的 pacman -S  ttf-jetbrains-mono 
```
cat > ~/.config/dunst/dunstrc << \EOF
[global]
frame_color = "#8AADF4"
separator_color= frame
# 跟随鼠标所在的显示器 默认是none
#follow = mouse
#显示隐藏的消息数
#indicate_hidden = yes
#和空闲有关的
#idle_threshold = 120
#圆角图标
#icon_corner_radius =5
#半透明
#transparency=90
#字体
font = JetBrains Mono NL Regular 10

[urgency_low]
background = "#24273A"
foreground = "#CAD3F5"

[urgency_normal]
background = "#24273A"
foreground = "#CAD3F5"

[urgency_critical]
background = "#24273A"
foreground = "#CAD3F5"
frame_color = "#F5A97F"
EOF


```
