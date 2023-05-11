## 配置文件依赖
```
pacman -S libnotify dunst   
pacman -S ttf-jetbrains-mono # 终端和i3标题栏用字体
pacman -S i3-wm feh flameshot compton polybar  alacritty  rofi # 背景 截图 半透明 状态栏 终端 运行he切换
pacman -S thunar gvfs gvfs-smb sshfs thunar-volman #包括smb webdav sftp等支持
pacman -S pavucontrol #音量控制检查polybar音量配置右键调用 非必须
mkdir ~/bg && cd ~/bg && wget  https://raw.githubusercontent.com/joyanhui/file.leiyanhui.com/dwm-wallpaper/zifa.jpg # 壁纸
```

用这里的脚本直接[创建配置文件](https://github.com/joyanhui/i3w/blob/main/i3config.sh)
