-- Montior wiki https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
	output = "HDMI-A-1",
	mode = "3840x2160@143.86Hz",
	position = "4480x0",
	scale = "auto",
	disabled = false,
})

hl.monitor({
	output = "DP-2",
	mode = "2560x1440@143",
	position = "0x0",
	scale = "auto",
})

hl.monitor({
	output = "DP-1",
	mode = "1920x1080@239",
	position = "2560x600",
	scale = "auto",
})
