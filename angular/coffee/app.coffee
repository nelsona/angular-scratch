angular.module('myApp', ['ui.router', 'ui.bootstrap'])
	.config ($stateProvider, $urlRouterProvider) -> 
		$stateProvider
			.state('home', {
				url: '/'
				templateUrl: 'templates/home.html'
			})
			.state('video', {
				url: '/video'
				templateUrl: 'templates/video.html'
			})
			.state('audio', {
				url: '/audio'
				templateUrl: 'templates/audio.html'
			})
