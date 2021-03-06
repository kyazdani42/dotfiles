[global/wm]
margin-top = 0
margin-bottom = 0

[settings]
throttle-output = 5
throttle-output-for = 10
throttle-input-for = 30
screenchange-reload = true
compositing-background = over
compositing-foreground = over
compositing-overline = over
compositing-underline = over
compositing-border = over

[colors]
background = #181a28
foreground = ${xrdb:color15:#fff}
foreground-alt = ${xrdb:color7:#abc}
cyan = ${xrdb:color6:#5df}
green = ${xrdb:color2:#6f6}

[bar/main]
monitor = ${env:MONITOR}
monitor-strict = false
override-redirect = false
bottom = true
enable-ipc = true
offset-y = 10
offset-x = 20
width = 100%
height = 50
background = ${colors.background}
foreground = ${colors.foreground}
font-0 = "Lato Medium:size=15;2"
font-1 = "Font Awesome 5 Free:style=Solid:pixelsize=15;2"
font-2 = "UbuntuMono Nerd Font:size=15;2"
font-3 = "NotoEmoji Nerd Font Mono:size=15;2"
padding-left = 2
padding-right = 2
separator = %{F#42455d}  ▰  %{F-}
modules-left = date xwindow
modules-center = i3
modules-right = pavolume battery mpd mail arch-aur-updates wifi

[module/battery]
type = internal/battery
label-charging = %percentage%% %{F#959dcb}
format-discharging = <label-discharging> <ramp-capacity> 
ramp-capacity-0 = %{F#f07178}
ramp-capacity-1 = %{F#f78c6c}
ramp-capacity-2 = %{F#ffcb6b}
ramp-capacity-3 = %{F#c3e88d}
ramp-capacity-4 = %{F#c3e88d}

[module/wifi]
type = custom/script
exec = wifi.sh
interval = 360

[module/mail]
type = custom/script
interval = 1200
exec = syncmail
label =   %output%

[module/date]
type = internal/date
interval = 10
date = %a %d
time = %H:%M
format-foreground = ${colors.foreground}
format-background = ${colors.background}
label = "%date% %time%"

[module/arch-aur-updates]
type = custom/script
exec = check-all-updates.sh
interval = 1000
label =   %output%
format-foreground = ${colors.foreground}
format-background = ${colors.background}

[module/pavolume]
type = custom/script
tail = true
label = %output%
exec = pavolume.sh --listen
click-right = exec pavucontrol
click-left = pavolume.sh --togmute
scroll-up = pavolume.sh --up
scroll-down = pavolume.sh --down
format-foreground = ${colors.foreground}
format-background = ${colors.background}

[module/xwindow]
type = internal/xwindow
format-background = ${colors.background}
label-maxlen = 28

[module/mpd]
type = internal/mpd
; Host where mpd is running (either ip or domain name)
; Can also be the full path to a unix socket where mpd is running.
host = 127.0.0.1
port = 6600
format-online = <icon-prev> <toggle> <icon-next> <icon-random> <label-song>
icon-prev = 
icon-stop = 
icon-play = 
icon-pause = 
icon-next = 
icon-random = 
toggle-on-foreground = ${colors.green}
toggle-off-foreground = ${colors.foreground-alt}
label-song =%artist% - %title%
label-song-maxlen = 40
label-song-ellipsis = true

[module/i3]
type = internal/i3
pin-workspaces = true
strip-wsnumbers = false
index-sort = false
enable-click = false
enable-scroll = false
wrapping-scroll = false
reverse-scroll = false
fuzzy-match = false

ws-icon-0 = "1;1 - "
ws-icon-1 = "2;2 - "
ws-icon-2 = "3;3 - "
ws-icon-3 = "4;4 - "
ws-icon-4 = "5;5 - "
ws-icon-5 = "6;6 - "

format-foreground = ${colors.foreground}
format-background = ${colors.background}
format = <label-state>

label-focused = %icon%
label-focused-padding = 2
label-focused-background = ${colors.background}
label-focused-foreground = ${colors.cyan}
label-focused-underline =

label-unfocused = %icon%
label-unfocused-padding = 2
label-unfocused-background = ${colors.background}
label-unfocused-foreground = ${colors.foreground}
label-unfocused-underline =

label-visible = %icon%
label-visible-padding = 2
label-visible-background = ${colors.background}
label-visible-foreground = ${colors.foreground}
label-visible-underline =

# vim:ft=dosini
