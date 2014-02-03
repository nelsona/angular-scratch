window.formatSecondsAsTime = (secs) ->
	hours = Math.floor(secs / 3600)
	minutes = Math.floor((secs - (hours * 3600)) / 60)
	seconds = Math.floor(secs - (hours * 3600) - (minutes * 60))

	if seconds < 10 then seconds = "0" + seconds

	minutes + ":" + seconds

window.getCurrentProgressValue = (media) ->
	if media.duration == NaN or media.buffered.length == 0
		progressValue = 0
	else
		console.log media.buffered.end(0)
		progressValue = (media.buffered.end(0) / media.duration) * 100
	progressValue