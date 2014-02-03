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
	link = ($scope, element, attrs) ->
		$scope.audio = new Audio()
		$scope.audio.controls = "controls"
		$scope.audio.style.width = 0
		$scope.audio.volume = 0.5
		$scope.audio.preload = "auto"

		$scope.audio.addEventListener 'loadedmetadata', () ->
			label = angular.element(document.getElementById "duration-label")
			label.html window.formatSecondsAsTime $scope.audio.duration
			range = angular.element(document.querySelector "#duration-current-position")
			range[0].max = $scope.audio.duration

		$scope.audio.addEventListener 'progress', () ->
			progress = angular.element(document.getElementById "duration-progress")
			progress[0].value = window.getCurrentProgressValue($scope.audio)

		$scope.audio.addEventListener 'timeupdate', () ->
			range = angular.element(document.querySelector "#duration-current-position")
			range[0].value = $scope.audio.currentTime

		attrs.$observe('audioSrc', (value) ->
			$scope.audio.src = value)

		$scope.audioplaypause = () ->
			if $scope.audio.paused then $scope.audio.play() else $scope.audio.pause()
		$scope.audiochangevolume = () ->
			inputs = angular.element(document.querySelector "#volume-changer")
			$scope.audio.volume = inputs[0].value
		$scope.audioupdateposition = () ->
			range = angular.element(document.querySelector "#duration-current-position")
			$scope.audio.currentTime = range[0].value

	@options: () -> 
		restrict: "A"
		templateUrl: "audio-player.tmpl"
		replace: true
		link: link

angular.module('myApp').directive 'audioplayer', AudioPlayer.options

class VideoPlayer
	link = ($scope, element, attrs) ->
		$scope.video = document.querySelector('#video-player')
		$scope.video.controls = false
		$scope.video.volume = 0.5
		$scope.video.preload = "auto"
		$scope.video.width = 640

		$scope.video.addEventListener 'loadedmetadata', () ->
			label = angular.element(document.getElementById "video-duration-label")
			label.html window.formatSecondsAsTime $scope.video.duration
			range = angular.element(document.querySelector "#video-duration-current-position")
			range[0].max = $scope.video.duration

		$scope.video.addEventListener 'progress', () ->
			progress = angular.element(document.getElementById "video-duration-progress")
			progress[0].value = window.getCurrentProgressValue($scope.video)

		$scope.video.addEventListener 'timeupdate', () ->
			range = angular.element(document.querySelector "#video-duration-current-position")
			range[0].value = $scope.video.currentTime


		attrs.$observe('videoSrc', (value) ->
			$scope.video.src = value)

		$scope.videoplaypause = () ->
			if $scope.video.paused then $scope.video.play() else $scope.video.pause()
		$scope.videomute = () ->
			if $scope.video.muted then $scope.video.muted = false else $scope.video.muted = true
		$scope.videochangevolume = () ->
			inputs = angular.element(document.querySelector "#video-volume-changer")
			$scope.video.volume = inputs[0].value
		$scope.videoupdateposition = () ->
			range = angular.element(document.querySelector "#video-duration-current-position")
			$scope.video.currentTime = range[0].value

	@options: () -> 
		restrict: "A"
		templateUrl: "video-player.tmpl"
		replace: true
		link: link

angular.module('myApp').directive 'videoplayer', VideoPlayer.options

