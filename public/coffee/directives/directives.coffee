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
			label.html formatSecondsAsTime $scope.audio.duration
			range = angular.element(document.querySelector "#duration-current-position")
			range[0].max = $scope.audio.duration

		$scope.audio.addEventListener 'progress', () ->
			progress = angular.element(document.getElementById "duration-progress")
			progress[0].value = getCurrentProgressValue($scope.audio)

		$scope.audio.addEventListener 'timeupdate', () ->
			range = angular.element(document.querySelector "#duration-current-position")
			range[0].value = $scope.audio.currentTime

		attrs.$observe('audioSrc', (value) ->
			$scope.audio.src = value)

		$scope.playpause = () ->
			if $scope.audio.paused then $scope.audio.play() else $scope.audio.pause()
		$scope.changevolume = () ->
			inputs = angular.element(document.querySelector "#volume-changer")
			$scope.audio.volume = inputs[0].value
		$scope.updateposition = () ->
			range = angular.element(document.querySelector "#duration-current-position")
			$scope.audio.currentTime = range[0].value

	@options: () -> 
		restrict: "A"
		templateUrl: "audio-player.tmpl"
		replace: true
		link: link

angular.module('myApp').directive 'audioplayer', AudioPlayer.options

