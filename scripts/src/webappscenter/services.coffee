module = angular.module('webappscenter.services', ['restangular'])

module.factory('Usages', (Restangular) ->
        return Restangular.service('project/commons/usage')
)

module.factory('Projects', (Restangular) ->
        return Restangular.service('project/project')
)

module.factory('Pertinences', (Restangular) ->
    return Restangular.service('project/commons/pertinence')
)

module.factory('Prestations', (Restangular) ->
    return Restangular.service('project/commons/prestation')
)

module.factory('ProjectTools', (Restangular) ->
    return Restangular.service('project/tool')
)

module.factory('EvaluationIngredient', (Restangular) ->
    return Restangular.service('unisson/evaluation')
)


