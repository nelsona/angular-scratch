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
		if audio.duration == NaN 
			progressValue = 0
		else
			progressValue = (audio.buffered.end(0) / audio.duration) * 100
		progressValue

	link = ($scope, element, attrs) ->
		$scope.audio = new Audio()
		$scope.audio.controls = "controls"
		$scope.audio.style.width = 0
		$scope.audio.volume = 0.5
		$scope.audio.preload = "auto"

		$scope.audio.addEventListener 'loadedmetadata', () ->
			label = angular.element(document.getElementById "duration-label")
			label.html formatSecondsAsTime $scope.audio.duration

		$scope.audio.addEventListener 'progress', () ->
			progress = angular.element(document.getElementById "duration-progress")
			progress[0].value = getCurrentProgressValue($scope.audio)

		$scope.audio.addEventListener 'timeupdate', () ->
			label = angular.element(document.getElementById "duration-current-position")
			label.html formatSecondsAsTime $scope.audio.currentTime

		attrs.$observe('audioSrc', (value) ->
			$scope.audio.src = value)

		$scope.playpause = () ->
			if $scope.audio.paused then $scope.audio.play() else $scope.audio.pause()
		$scope.changevolume = () ->
			inputs = element.find("input")
			$scope.audio.volume = inputs[0].value

	@options: () -> 
		restrict: "A"
		templateUrl: "audio-player.tmpl"
		replace: true
		link: link

angular.module('myApp').directive 'audioplayer', AudioPlayer.options

