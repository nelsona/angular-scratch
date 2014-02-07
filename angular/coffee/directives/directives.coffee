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


angular.module('myApp').directive 'audioplayer', AudioPlayer.options

class VideoPlayer
	if window.document.addEventListener
		progressUpdater = () ->
			progress = angular.element(document.getElementById "video-duration-progress")
			progress[0].style.width = window.getCurrentProgressValue(this) + "%"

		metadataUpdater = () ->
			label = angular.element(document.getElementById "video-duration-label")
			label.html window.formatSecondsAsTime this.duration
			range = angular.element(document.querySelector "#video-duration-current-position")
			range[0].max = this.duration

		timeUpdater = () ->
			range = angular.element(document.querySelector "#video-duration-current-position")
			range[0].value = this.currentTime

		controller = ($scope, $element) ->
			video = document.querySelector('#video-player')
			video.controls = false
			video.volume = 0.5
			video.preload = "auto"
			video.width = 640

			video.addEventListener 'loadedmetadata', metadataUpdater
			video.addEventListener 'progress', progressUpdater
			video.addEventListener 'timeupdate', timeUpdater

			$scope.videoplaypause = () ->
				if video.paused then video.play() else video.pause()
			$scope.videomute = () ->
				if video.muted then video.muted = false else video.muted = true
			$scope.videochangevolume = () ->
				inputs = angular.element(document.querySelector "#video-volume-changer")
				video.volume = inputs[0].value
			$scope.videoupdateposition = () ->
				range = angular.element(document.querySelector "#video-duration-current-position")
				video.currentTime = range[0].value

			$scope.video = video
		link = (scope, element, attrs) ->
			scope.video.src = attrs.videoSrc

			console.log "look at the events " + scope.video.eventListenerList

			scope.$on '$destroy', () ->
				scope.video.pause()
				scope.video.removeEventListener 'loadedmetadata', metadataUpdater
				scope.video.removeEventListener 'progress', progressUpdater
				scope.video.removeEventListener 'timeupdate', timeUpdater

	else
		link = ($scope, element, attrs) ->
			element.html('<div class="jumbotron"><h2>IE8 Video Directive</h2><object width="100%" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height = "400"><param name="movie" value="video-player.swf"></param><param name="flashvars" value="file=' + attrs.videoSrc + '"</param></object></div>')

	if window.document.addEventListener
		@options: () -> 
			restrict: "A"
			templateUrl: "video-player.tmpl"
			replace: true
			link: link
			scope: '='
			controller: controller
	else
		@options: () -> 
			restrict: "A"
			templateUrl: "ie-media.tmpl"
			link: link

angular.module('myApp').directive 'videoplayer', VideoPlayer.options

