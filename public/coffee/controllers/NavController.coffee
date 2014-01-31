class NavController
	@$inject: ['$scope']
	constructor: (@scope) ->
		@scope.testtitle = 'Simple title changed'

angular.module('myApp').controller 'NavController', NavController


