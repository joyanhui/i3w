## 配置文件依赖
```
pacman -S libnotify dunst   
pacman -S  ttf-jetbrains-mono # 终端和i3标题栏用字体
pacman -S i3-wm feh flameshot compton polybar  alacritty  rofi
pacman -S  thunar 
mkdir ~/bg && cd ~/bg
wget  https://ghproxy.com/https://raw.githubusercontent.com/joyanhui/file.leiyanhui.com/dwm-wallpaper/zifa.jpg
```


```
cat > ~/.config/i3/config << \EOF
# 左alt Mod1
set $mod Mod4
font pango:JetBrains Mono NL Italic 8 #font pango:monospace 8 字体
# 跟随启动
exec_always --no-startup-id compton
exec --no-startup-id dex --autostart --environment i3
exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
#exec --no-startup-id nm-applet
exec --no-startup-id fcitx5 #输入法
#exec --no-startup-id pulseaudio
exec_always --no-startup-id feh --randomize --bg-fill ~/bg/* #壁纸
#exec --no-startup-id xfce4-panel --disable-wm-check #banner
#设置窗口边框等等
#new_window none
#new_float normal
#hide_edge_borders both
#设置窗口间距
gaps inner 2
gaps outer 2
# 窗口标题和颜色
title_align center
#  class                 border    background   text      indicator  child_border
client.focused           #4c7899    #285577    #ffffff    #2e9ef4    #285577
client.focused_inactive  #81c2d6    #5f676a    #ffffff    #484e50    #0b6e48
client.unfocused         #c9cabb    #222222    #888888    #292d2e    #222222
client.urgent            #2f343a    #900000    #ffffff    #199475    #900000
client.placeholder       #a2b4ba    #0c0c0c    #ffffff    #1793d0    #0c0c0c
client.background        #82abba

exec_always --no-startup-id sh $HOME/.config/polybar/polybar_run.sh


# 音量
set $refresh_i3status killall -SIGUSR1 i3status
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

#应用程序 绑定
bindsym Print --release exec /usr/bin/flameshot gui # 截图
#bindsym $mod+Return exec xfce4-terminal  --drop-down #终端 下拉 alacritty
bindsym $mod+Return exec alacritty
#bindsym Control+Mod1+t exec xfce4-terminal	#终端窗口 兼容xfce和gnome
#bindsym $mod+t exec xfce4-terminal	#新
bindsym $mod+t exec alacritty
bindsym $mod+e exec thunar #文件管理器

#启动器 xfce4-appfinder  会自己记住窗口大小 Control+Mod1+space 和mac下一致
#bindsym Control+Mod1+space exec xfce4-appfinder 
#bindsym $mod+d exec  xfce4-appfinder -c
#  rofi-theme-selector 可以选择自带的样式
bindsym $mod+d exec --no-startup-id rofi -show drun -run-shell-command '{terminal} -e zsh -ic "{cmd} && read"'
#焦点跟随鼠标 关闭掉 打开容易误操作
focus_follows_mouse no
#关闭活动窗口 
bindsym $mod+Shift+q kill
# 全屏
bindsym $mod+f fullscreen toggle
# 切换浮动和停靠
bindsym $mod+Shift+space floating toggle
# 隐藏和显示窗口 (minus is "-" and plus is "+".)
bindsym $mod+minus move scratchpad
bindsym $mod+plus  scratchpad show
# 窗口样式 边框样式  只保留一个 循环切
#bindsym $mod+u border none
#bindsym $mod+n border normal
#bindsym $mod+o border 1pixel
bindsym $mod+b border toggle
# 自动处理窗口边框只有一个的时候自动隐藏  好像没啥用
hide_edge_borders  smart
## 弹出窗口的设置 
for_window [window_role="pop-up"]	floating enable
for_window [window_role="task_dialog"]	floating enable
## 个别程序的配置 xprop|grep CLASS 加鼠标点击 可以获取窗口的class
#for_window [class="Xfce4-terminal"]	floating enable
for_window [class="Thunar"]		floating enable
for_window [class="Xfce4-appfinder"]	floating enable
for_window [class="QQ"]  		floating enable
for_window [class="Xarchiver"]        	floating enable
for_window [class="Google-chrome"]	border pixel 1
for_window [class="Pavucontrol"]        floating enable
for_window [class="TelegramDesktop"]    floating enable
for_window [class="Xfce4-panel"]        floating enable
for_window [class="fcitx5-config-qt"]   floating enable
for_window [class="Plank"]   floating enable


#---移动窗口--
# 鼠标+$mod 拖动窗口 
floating_modifier $mod
# 或者拖动标题 也可以移动
tiling_drag modifier titlebar
# mod+shit 快捷键移动 到容器 同时 可以 10px左右移动浮动窗口
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right
# mod + alt 左右修改窗口大小
bindsym $mod+Mod1+a           resize shrink width 10 px or 10 ppt
bindsym $mod+Mod1+s           resize grow height 10 px or 10 ppt
bindsym $mod+Mod1+w           resize shrink height 10 px or 10 ppt
bindsym $mod+Mod1+d           resize grow width 10 px or 10 ppt

bindsym $mod+Mod1+Left        resize shrink width 10 px or 10 ppt
bindsym $mod+Mod1+Down        resize grow height 10 px or 10 ppt
bindsym $mod+Mod1+Up          resize shrink height 10 px or 10 ppt
bindsym $mod+Mod1+Right       resize grow width 10 px or 10 ppt
# 修改窗口固定大小 $mod+Alt 左键 大长 右键小长
bindsym --whole-window $mod+Mod1+button1 resize set width 1280 px  height 1000 px 
bindsym --whole-window $mod+Mod1+button3 resize set width 630 px  height 1000 px 

#&&  move position 10px 10px &&mode "default" 
# 修改焦点
bindsym $mod+Left  focus left
bindsym $mod+Down  focus down
bindsym $mod+Up    focus up
bindsym $mod+Right focus right
# 切换相邻工作区
bindsym $mod+Tab workspace next
bindsym $mod+Shift+Tab workspace prev
# alt+tab 需要用rofi
bindsym Mod1+Tab exec --no-startup-id rofi -show window
# 切换目标工作区
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10
# 再次按下当前工作区 可以返回上一个工作区
workspace_auto_back_and_forth yes
# 移动窗口到工作区
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# 重载配置文件
bindsym $mod+Shift+r reload
# 重启i3
bindsym $mod+Shift+s restart
# 退出i3
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m '是否要推出i3? 将会推出所有x程序.' -B 'Yes, 推出 i3' 'i3-msg exit'"
EOF


```
