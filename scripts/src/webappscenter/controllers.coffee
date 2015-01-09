module = angular.module('webappscenter.controllers', ['angular-loading-bar','restangular', 'angular-unisson-auth','chartjs', 'ui.bootstrap'])



module.controller("TestCtrl", ($scope) =>
    $scope.lineChartData = {
      labels: [
        'Gouvernance'
        'Technique'
        'Contribution'
        'Partage'
        'Juridique'
        'Mutualisation'
        'Financement'
        'Prestation'
        'Partenaires'
        'Evaluation'
      ]
      datasets: [
        {
          data: [0, 0, 0, 0, 0, 0,0,0,0,0]
        }            
      ]
    }
    $scope.activeData = $scope.lineChartData;
)


module.controller("UserManagerCtrl", ($scope, Users) =>
        $scope.created = false

        $scope.new_user =
                username: ""
                password: ""

        $scope.createUser = ->
                Users.post($scope.new_user).then(->
                        $scope.new_user.username = ""
                        $scope.new_user.password = ""
                        $scope.created = true
                )
)

class UsageManagerCtrl
        constructor: (@$scope, @Pertinences, @Projects, @Usages, @ProjectsTools) ->
                @$scope.pertinences = @Pertinences.getList().$object
                @$scope.usages = @Usages.getList().$object
                @$scope.projects = @Projects.getList().$object  
                @$scope.projectstools = @ProjectsTools.getList().$object 
                @$scope.filterWithTags = this.filterWithTags
                @$scope.searchForm =
                tags: []
                @$scope.updateTagsFilter = this.updateTagsFilter

         updateTagsFilter: ($event, tag) =>
                @$scope.searchForm.tags.push(tag)
         
         filterWithTags: (actual, expected) =>
                return _.every(@$scope.searchForm.tags, (tags_uri) =>
                        return _.find(actual.tags, (tag) =>
                                return tag.resource_uri == tag_uri
                        )
                )
               
module.controller("UsageManagerCtrl", ['$scope', 'Pertinences', 'Projects', 'Usages', 'ProjectTools', 'EvaluationIngredient', UsageManagerCtrl])


module.controller("ProjectManagerCtrl", ($scope, $stateParams,  Projects) ->
         $scope.project = Projects.one($stateParams.slug).get().$object
)

class GroupManagerCtrl
        constructor: (@$scope, @Groups, @Users) ->
                @$scope.groups = @Groups.getList().$object

                @$scope.deleteUser = this.deleteUser
                @$scope.addUser = this.addUser

                @$scope.new_user = {}

        deleteUser: (group_id, user_rid) =>
                group = _.find(@$scope.groups, (group) ->
                        return group.id == group_id
                )

                user = _.find(group.users, (user) ->
                        return user.resource_uri == user_rid
                )

                # Remove user from local list
                updated_users = _.without(group.users, user)

                # Get resource path
                updated_users_rids = _.map(updated_users, (user) -> user.resource_uri)

                group.patch(users: updated_users_rids).then(->
                        group.users = updated_users
                )

        addUser: (group_id) =>
                group = _.find(@$scope.groups, (group) ->
                        return group.id == group_id
                )

                @Users.one(@$scope.new_user.username).get().then((user) =>
                        user_rids = _.map(group.users, (user) -> user.resource_uri)
                        updated_user_rids = _.clone(user_rids)
                        updated_user_rids.push(user.resource_uri)

                        group.patch(users: updated_user_rids).then(->
                                group.users = _.union(group.users, user)
                        )
                )


module.controller("GroupManagerCtrl", ['$scope', 'Groups', 'Users', GroupManagerCtrl])

#module.controller("EvaluationDetailCtrl", ($scope, $stateParams, Pertinences) ->
#$scope.pertinence = Pertinences.one($stateParams.id).get().$object)
