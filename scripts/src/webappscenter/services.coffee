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


class UsageManagerCtrl
        constructor: (@$scope, @Pertinences, @Projects, @Usages) ->
                @$scope.pertinences = @Pertinences.getList().$object
                @$scope.usages = @Usages.getList().$object
                @$scope.projects = @Projects.getList().$object  



module.controller("UsageManagerCtrl", ['$scope', 'Pertinences', Projects', 'Usages', UsageManagerCtrl])


function Ctrl($scope,  $timeout) {
    $scope.minPertinence = 0;
    $scope.priceRangeFilter = function (location) {
        return location.price >= $scope.minPrice;
    };

    $timeout(function () {
        $scope.minPrice = 1.5;
    }, 2000);
}