formatSecondsAsTime = (secs) ->
	hours = Math.floor(secs / 3600)
	minutes = Math.floor((secs - (hours * 3600)) / 60)
	seconds = Math.floor(secs - (hours * 3600) - (minutes * 60))

	if seconds < 10 then seconds = "0" + seconds

	minutes + ":" + seconds

getCurrentProgressValue = (audio) ->
	if audio.duration == NaN 
		progressValue = 0
	else
		progressValue = (audio.buffered.end(0) / audio.duration) * 100
	progressValue