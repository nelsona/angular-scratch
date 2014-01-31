class OtherController
	@$inject: ['$scope']
	constructor: (@scope) ->
		@scope.testtitle = 'Another Simple title'

angular.module('myApp').controller 'OtherController', OtherController