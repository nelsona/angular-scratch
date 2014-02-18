angular.module('myApp', ['ui.router', 'ui.bootstrap'])
	.config ($stateProvider, $urlRouterProvider) -> 
		$stateProvider
			.state('home', {
				templateUrl: 'templates/home.html'
			})
			.state('video', {
				templateUrl: 'templates/video.html'
			})
			.state('audio', {
				templateUrl: 'templates/audio.html'
			})
