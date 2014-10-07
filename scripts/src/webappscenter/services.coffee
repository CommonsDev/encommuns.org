module = angular.module('webappscenter.services', ['restangular'])

module.factory('Usages', (Restangular) ->
        return Restangular.service('usage')
)

module.factory('Projects', (Restangular) ->
        return Restangular.service('project')
)

module.factory('Pertinences', (Restangular) ->
    return Restangular.service('pertinence')
)

module.factory('EvaluationIngredient', (Restangular) ->
    return Restangular.service('evaluationingredient')
)

class UsageManagerCtrl
        constructor: (@$scope, @Pertinences, @Projects, @Usages) ->
                @$scope.pertinences = @Pertinences.getList().$object
                @$scope.usages = @Usages.getList().$object
                @$scope.projects = @Projects.getList().$object  

module.controller("UsageManagerCtrl", ['$scope', 'Pertinences', 'Projects', 'Usages', 'EvaluationIngredient', UsageManagerCtrl])

