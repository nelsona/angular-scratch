class AudioDirective
	if window.document.addEventListener
		audio = new Audio()

		progressUpdater = () ->
			progress = angular.element(document.getElementById "duration-progress")
			progress[0].style.width = window.getCurrentProgressValue(audio) + "%"

		timeUpdater = () ->
			range = angular.element(document.querySelector "#duration-current-position")
			range[0].value = audio.currentTime

		metadataUpdater = () ->
			label = angular.element(document.getElementById "duration-label")
			label.html window.formatSecondsAsTime audio.duration
			range = angular.element(document.querySelector "#duration-current-position")
			range[0].max = audio.duration

		controller = ($scope, $element) ->
			audio.controls = "controls"
			audio.style.width = 0
			audio.volume = 0.5
			audio.preload = "auto"

			audio.addEventListener 'loadedmetadata', metadataUpdater
			audio.addEventListener 'progress', progressUpdater
			audio.addEventListener 'timeupdate', timeUpdater

			$scope.audioplaypause = () ->
				if audio.paused then audio.play() else audio.pause()
			$scope.audiochangevolume = () ->
				inputs = angular.element(document.querySelector "#volume-changer")
				audio.volume = inputs[0].value
			$scope.audioupdateposition = () ->
				range = angular.element(document.querySelector "#duration-current-position")
				audio.currentTime = range[0].value
			$scope.$on '$destroy', () ->
				audio.pause()
				audio.removeEventListener 'loadedmetadata', metadataUpdater
				audio.removeEventListener 'progress', progressUpdater
				audio.removeEventListener 'timeupdate', timeUpdater

			$scope.audio = audio

		link = (scope, element, attrs) ->
			scope.audio.src = attrs.audioSrc
	else
		link = (scope, element, attrs) ->
			element.html('<div class="jumbotron"><h2>IE8 Audio Directive</h2><object width="100%" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="20"><param name="movie" value="player.swf"></param><param name="flashvars" value="soundFile=' + attrs.audioSrc + '"</param></object></div>')

	if window.document.addEventListener
		@options: () -> 
			restrict: "A"
			templateUrl: "audio-player.tmpl"
			replace: true
			link: link
			scope: '='
			controller: controller
	else
		@options: () -> 
			restrict: "A"
			templateUrl: "ie-media.tmpl"
			link: link

angular.module('myApp').directive 'audioplayer', AudioDirective.options

