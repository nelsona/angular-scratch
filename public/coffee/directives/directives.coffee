class NavDirective
	@primaryoptions: () ->
		restrict: "E"
		templateUrl: "primarynav.tmpl"
		scope:
			navtitle: "@"

	@secondaryoptions: () ->
		restrict: "E"
		templateUrl: "secondarynav.tmpl"
		scope:
			navtitle: "@"

angular.module('myApp').directive 'primarynav', NavDirective.primaryoptions

angular.module('myApp').directive 'secondarynav', NavDirective.secondaryoptions

class AudioPlayer

	formatSecondsAsTime = (secs) ->
		hours = Math.floor(secs / 3600)
		minutes = Math.floor((secs - (hours * 3600)) / 60)
		seconds = Math.floor(secs - (hours * 3600) - (minutes * 60))

		if seconds < 10 then seconds = "0" + seconds

		minutes + ":" + seconds

	getCurrentProgressValue = (audio) ->
		console.log audio.duration
		console.log audio.buffered.end(0)
		if audio.duration == NaN 
			progressValue = 0
		else
			progressValue = (audio.buffered.end(0) / audio.duration) * 100
		console.log "progress: " + progressValue
		progressValue

	link = ($scope, element, attrs) ->
		audio = new Audio()

		audio.addEventListener 'loadedmetadata', () ->
			label = angular.element(document.getElementById "duration-label")
			label.html formatSecondsAsTime audio.duration

		audio.addEventListener 'progress', () ->
			progress = angular.element(document.getElementById "duration-progress")
			progress[0].value = getCurrentProgressValue(audio)

		audio.addEventListener 'timeupdate', () ->
			label = angular.element(document.getElementById "duration-label")
			label.html formatSecondsAsTime audio.duration

		$scope.audio = audio
		attrs.$observe('audioSrc', (value) ->
			audio.src = value
			audio.controls = "controls"
			audio.style.width = 0
			audio.volume = 0.5
			audio.preload = "auto"
			element[0].appendChild(audio))
		$scope.playpause = () ->
			if audio.paused then audio.play() else audio.pause()
		$scope.changevolume = () ->
			inputs = element.find("input")
			audio.volume = inputs[0].value

	@options: () -> 
		restrict: "E"
		templateUrl: "audio-player.tmpl"
		replace: true
		link: link

angular.module('myApp').directive 'audioplayer', AudioPlayer.options

