#pacman -S noto-fonts-emoji pavucontrol #ttf-jetbrains-mono 
mkdir ~/.config/polybar/
cat > ~/.config/polybar/config.ini << \EOF
[colors]
;background = ${xrdb:color0:#222}
background = #cc222222
background-alt = #444
;foreground = ${xrdb:color7:#222}
foreground = #b6a49b
foreground-alt = #555
primary = #ffb52a
secondary = #e60053
alert = #bd2c40

[settings]
screenchange-reload = true
;compositing-background = xor
;compositing-background = screen
;compositing-foreground = source
;compositing-border = over
;pseudo-transparency = false

[global/wm]
margin-top = 1
;margin-bottom = 3
margin-bottom = 3
[bar/mybar]
;monitor = ${env:MONITOR:HDMI-1}
;width = 100%
;height = 25
;offset-x = 1%
;offset-y = 1%
radius = 10
fixed-center = true

background = ${colors.background}
foreground = ${colors.foreground}
# 这个线可以区分工作区激活
line-size = 4
line-color = #f00
# 外框 和颜色 这里直接去掉了
border-size = 0
border-color = #00000000
# 左右留白 右侧 会影响和托盘的距离
padding-left = 5
padding-right = 5
# 模块之间的左右间隙
module-margin-left = 1
module-margin-right = 1
#字体定义
; https://www.nerdfonts.com/cheat-sheet https://github.com/ryanoasis/nerd-fonts
font-0 = fixed:pixelsize=10;1
font-1 = unifont:fontformat=truetype:size=10:antialias=false;0
font-2 = Noto Sans Symbols2:style=Regular:size=12
font-3 = Font Awesome 5 Free:style=Solid:size=12
font-4 = Font Awesome 5 Brands:style=Regular:size=12
font-5 = DejaVu Sans:style=Bold:size=12
font-6 = NotoColorEmoji:pixelsize=5;1:fontformat=truetype:scale=10:antialias=true;1
# 排列
modules-left =  i3 menu-apps
;modules-center = wireless-network wired-network cpu memory
;modules-right = system-usb-udev xkeyboard pulseaudio backlight date battery
modules-center =  cpu temperature memory wired-network weather
modules-right = pulseaudio xkeyboard date
# 托盘
tray-position = right
tray-padding = 2
tray-background = ${colors.background}
transparent = true

cursor-click = pointer
cursor-scroll = ns-resize

;====================================
; ===天气预报 需要单独的pyhtone插件===
[module/weather]
type = custom/script
exec = python3 ~/.config/polybar/weather-plugin.py
interval = 960
tail = true
click-left= exec firefox https://openweathermap.org/city/1793724

; ===菜单===
; https://github.com/polybar/polybar/wiki/Module:-menu
[module/menu-apps]
type = custom/menu

; 若为 true, <label-toggle> 将在左边,若为 false, 将在右边
expand-right = true

; menu-LEVEL-N 与 label-NAME 属性相同，并附加 exec 属性
; 命令将使用 /bin/sh -c $COMMAND

menu-0-0 = 聊天软件
menu-0-0-exec = #menu-apps.open.1
menu-0-1 = 浏览器
menu-0-1-exec = #menu-apps.open.2
menu-0-2 = 系统/附件
menu-0-2-exec = #menu-apps.open.3

menu-1-0 = QQ
menu-1-0-exec = linuxqq
menu-1-1 =  Telegram
menu-1-1-exec = telegram-desktop 
menu-1-2 =  微信Rdp
menu-1-2-exec = xfreerdp  /u:yanhui  /dynamic-resolution /v:10.1.1.10:3389 +clipboard /sound:sys:alsa +compression  /drive:root,/

menu-2-0 = Firefox
menu-2-0-exec = firefox
menu-2-1 = Chrome
menu-2-1-exec = google-chrome-stable

menu-3-0 = 终端
menu-3-0-exec = alacritty
menu-3-1 = 文件管理
menu-3-1-exec = thunar
menu-3-2 = rofi-drun
menu-3-2-exec = rofi -show drun -run-shell-command '{terminal} -e zsh -ic "{cmd} && read"'
menu-3-3 = rofi-show
menu-3-3-exec = rofi -show window
menu-3-4 = NotepadNext
menu-3-4-exec = NotepadNext
menu-3-5 = 随机换壁纸
menu-3-5-exec =  feh --randomize --bg-fill ~/bg/* 
menu-3-6 = 注销
menu-3-6-exec = i3-msg exit



; <label-toggle> 可替换为 <label-(open|close)>
; 如果 expand-right 为 true ，则默认值为"<label-toggle><menu>"。注意，如果使用<label-toggle> 就必须定义 <label-open>
; format = <label-toggle> <menu>

label-open = Apps
label-close = ❌
; 分隔元件
label-separator = 🔸


; ===i3 工作区===
; https://github.com/polybar/polybar/wiki/Module:-i3
[module/i3]
type = internal/i3
format = <label-state> <label-mode>
index-sort = true
wrapping-scroll = false

label-mode-padding = 2
label-mode-foreground = #000
label-mode-background = ${colors.primary}

; 聚焦在显示器上的活动工作区
label-focused = %index%
label-focused-background = ${colors.background-alt}
label-focused-underline= ${colors.primary}
label-focused-padding = 2

; 任何显示器上的非活动工作区
label-unfocused = %index%
label-unfocused-padding = 2

; 未聚焦在显示器生的活动工作区
label-visible = %index%
label-visible-background = ${self.label-focused-background}
label-visible-underline = ${self.label-focused-underline}
label-visible-padding = ${self.label-focused-padding}
; 有提示消息的 工作区
label-urgent = %index%
label-urgent-background = ${colors.alert}
label-urgent-padding = 2
; 工作区之间的分隔符
; label-separator = |



; ===有线网络===
; https://github.com/polybar/polybar/wiki/Module:-network
[module/wired-network]
type = internal/network
interface = eth0
interval = 3.0
; 间隔宽度
udspeed-minwidth = 1
; 端口累计
accumulate-stats = true
; 对未知状态的网络设备启用
unknown-as-up = true
format-connected = <label-connected>
format-disconnected = <label-disconnected>
;label-connected =   %linkspeed%  %upspeed% %downspeed%
label-connected = ↘%upspeed% ↗%downspeed%
label-connected-foreground = #00FFFF
label-disconnected = 
label-disconnected-foreground = #66ffffff
; ===wifi===
;[module/wireless-network]
;type = internal/network
;interface = wlp3s0
;interval = 3.0
; 间隔宽度
;udspeed-minwidth = 3
; 所有端口累计
;accumulate-stats = true
; 对未知状态的网络设备启用
;unknown-as-up = true
;format-connected = <ramp-signal> <label-connected>
;format-disconnected = <label-disconnected>
;label-connected =  %essid% %upspeed% %downspeed%
;label-connected-foreground = #00FFFF
;label-disconnected = 
;label-disconnected-foreground = #66ffffff
;ramp-signal-0 = 
;ramp-signal-1 = 
;ramp-signal-2 = 
;ramp-signal-3 = 
;ramp-signal-4 = 
;ramp-signal-5 = 
;ramp-signal-0-foreground = #ff5555
;ramp-signal-1-foreground = #ff5555
;ramp-signal-2-foreground = #fba922
;ramp-signal-3-foreground = #fba922
;ramp-signal-4-foreground = #aaff77
;ramp-signal-5-foreground = #aaff77

; ===键盘提示===
; https://github.com/polybar/polybar/wiki/Module:-xkeyboard
[module/xkeyboard]
type = internal/xkeyboard
; 忽略列表
blacklist-0 = scroll lock
; <label-indicator>
format = <label-indicator>
format-spacing = 1
label-indicator-on-capslock = 🔓
label-indicator-off-capslock = 
label-indicator-on-numlock = 🔢
label-indicator-off-numlock =
label-indicator-on-capslock-foreground = #ff5555

; ===音量===
; https://github.com/polybar/polybar/wiki/Module:-pulseaudio
[module/pulseaudio]
type = internal/pulseaudio
sink = alsa_output.pci-0000_12_00.3.analog-stereo
use-ui-max = true
interval = 5
format-volume = <ramp-volume> <label-volume>
label-muted = 🔇0%
label-muted-foreground = #FFF
ramp-volume-0 = 🔈
ramp-volume-1 = 🔉
ramp-volume-2 = 🔊
; 左键静音 滚轮调音量  右键打开 pavucontrol
click-right = pavucontrol
; click-middle =

; ===CPU===
; https://github.com/polybar/polybar/wiki/Module:-cpu
[module/cpu]
type = internal/cpu

; 刷新间隔，默认: 1
interval = 2

format = <label> <ramp-coreload>

label = CPU %percentage%%
label-foreground = #9A32DB

; 间距 默认1  可以用px
ramp-coreload-spacing = 1px
ramp-coreload-0 = ▁
ramp-coreload-1 = ▂
ramp-coreload-2 = ▃
ramp-coreload-3 = ▄
ramp-coreload-4 = ▅
ramp-coreload-5 = ▆
ramp-coreload-6 = ▇
ramp-coreload-7 = █

ramp-coreload-0-foreground = #aaff77
ramp-coreload-1-foreground = #aaff77
ramp-coreload-2-foreground = #aaff77
ramp-coreload-3-foreground = #aaff77
ramp-coreload-4-foreground = #fba922
ramp-coreload-5-foreground = #fba922
ramp-coreload-6-foreground = #ff5555
ramp-coreload-7-foreground = #ff5555

; ===内存===
; https://github.com/polybar/polybar/wiki/Module:-memory
[module/memory]
type = internal/memory

; 刷新间隔，默认: 1
interval = 3

format = <label> <ramp-used> / <ramp-free>

label = RAM  %gb_used%/%gb_free%
label-foreground = #9A32DB

; 用于 <ramp-used>
ramp-used-0 = ▁
ramp-used-1 = ▂
ramp-used-2 = ▃
ramp-used-3 = ▄
ramp-used-4 = ▅
ramp-used-5 = ▆
ramp-used-6 = ▇
ramp-used-7 = █

ramp-used-0-foreground = #aaff77
ramp-used-1-foreground = #aaff77
ramp-used-2-foreground = #aaff77
ramp-used-3-foreground = #aaff77
ramp-used-4-foreground = #fba922
ramp-used-5-foreground = #fba922
ramp-used-6-foreground = #ff5555
ramp-used-7-foreground = #ff5555

; 用于 <ramp-free>
ramp-free-0 = ▁
ramp-free-1 = ▂
ramp-free-2 = ▃
ramp-free-3 = ▄
ramp-free-4 = ▅
ramp-free-5 = ▆
ramp-free-6 = ▇
ramp-free-7 = █

ramp-free-0-foreground = #ff5555
ramp-free-1-foreground = #ff5555
ramp-free-2-foreground = #fba922
ramp-free-3-foreground = #fba922
ramp-free-4-foreground = #aaff77
ramp-free-5-foreground = #aaff77
ramp-free-6-foreground = #aaff77
ramp-free-7-foreground = #aaff77


; ===屏幕亮度===
; https://github.com/polybar/polybar/wiki/Module:-xbacklight
;[module/backlight]
;type = internal/backlight

; 使用命令查询到设备文件:
; ls -1 /sys/class/backlight/
;card = intel_backlight

; 滚轮调节亮度
; sudo chown video /sys/class/backlight/intel_backlight/brightness
; sudo chmod g+w /sys/class/backlight/intel_backlight/brightness
; usermod -a -G video eonun
; Default: false
;enable-scroll = true

;format = <ramp> <label>

;label = %percentage%%

; 用于 <ramp>
;ramp-0 = 🌕
;ramp-1 = 🌔
;ramp-2 = 🌓
;ramp-3 = 🌒
;ramp-4 = 🌑

; 用于 <bar>
;bar-width = 10
;bar-indicator = |
;bar-fill = -
;bar-empty = -


; ===日期时间===
; https://github.com/polybar/polybar/wiki/Module:-date
[module/date]
type = internal/date

; 更新间隔, 默认: 1.0
interval = 1.0
format = <label>

date = %Y-%m-%d 周 %u
time = %H:%M

; 另一中格式
date-alt = %A, %d %B %Y
time-alt = %H:%M:%S

label = %date% %time%
label-font = 1
label-foreground = #eefafafa


; ===电源提示===
; https://github.com/polybar/polybar/wiki/Module:-battery
;[module/battery]
;type = internal/battery

; 电量大于 99% 显示充电完成
;full-at = 99

; 使用以下命令列出电池和适配器:
; ls -1 /sys/class/power_supply/
;battery = BAT1
;adapter = ACAD

;poll-interval = 3

; 时间过格式,默认: %H:%M:%S
time-format = %H:%M

; 充电
;format-charging =  <animation-charging> <label-charging>

; 放电
;format-discharging = <animation-discharging> <label-discharging>

; 充电完成
;format-full = <ramp-capacity> <label-full>

; 充电状态
;label-charging =  %percentage%(%time%)


; 放电状态
;label-discharging = %percentage%(%time%)

;充电完成
;label-full =  %percentage%
;label-full-foreground = #aaff77

;ramp-capacity-0 = 
;ramp-capacity-1 = 
;ramp-capacity-2 = 
;ramp-capacity-3 = 
;ramp-capacity-4 = 

;bar-capacity-width = 10

;animation-charging-0 = 
;animation-charging-1 = 
;animation-charging-2 = 
;animation-charging-3 = 
;animation-charging-4 = 
; 动画帧率(毫秒)
;animation-charging-framerate = 750

;animation-discharging-0 = 
;animation-discharging-1 = 
;animation-discharging-2 = 
;animation-discharging-3 = 
;animation-discharging-4 = 
; 动画帧率(毫秒)
;animation-discharging-framerate = 500

; ===USB===
; https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/system-usb-udev
;[module/system-usb-udev]
;type = custom/script
;exec = ~/.config/polybar/scripts/system-usb-udev.sh
;tail = true
;click-left = ~/.config/polybar/scripts/system-usb-udev.sh --mount &
;click-right = ~/.config/polybar/scripts/system-usb-udev.sh --unmount &


[module/temperature]
type = internal/temperature
interval = 2
thermal-zone = 0
hwmon-path = /sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input
base-temperature = 20
warn-temperature = 60
units = false
format = <ramp> <label>
format-warn = <ramp> <label-warn>
label =  %temperature-c%℃
label-warn =  %temperature-c%℃
label-warn-foreground = #f00s.
ramp-0 = 
ramp-1 = 
ramp-2 = ♨
ramp-foreground = #55
EOF
sh $HOME/.config/polybar/polybar_run.sh
