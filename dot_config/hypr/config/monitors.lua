-- Montior wiki https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
	output = "HDMI-A-1",
	mode = "3840x2160@143.86Hz",
	position = "0x0",
	scale = "auto",
	disabled = true,
})

hl.monitor({
	output = "DP-3",
	mode = "2560x1440@143",
	position = "3841x0",
	scale = "auto",
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@239",
	position = "auto",
	scale = "auto",
})
