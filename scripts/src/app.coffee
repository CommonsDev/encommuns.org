angular.element(document).on('ready page:load', ->
        angular.module('webappscenter', ['webappscenter.services','webappscenter.controllers'])

        angular.module('unisson_webappscenter', ['webappscenter', 'ui.router', 'ngAnimate', 'restangular', 'angular-unisson-auth'])

        # CORS
        .config(['$httpProvider', ($httpProvider) ->
                $httpProvider.defaults.useXDomain = true
                delete $httpProvider.defaults.headers.common['X-Requested-With']
        ])

        # Tastypie
        .config((RestangularProvider) ->
                RestangularProvider.setBaseUrl(config.rest_uri)
                # RestangularProvider.setDefaultHeaders({"Authorization": "ApiKey pipo:46fbf0f29a849563ebd36176e1352169fd486787"});
                # Tastypie patch
                RestangularProvider.setResponseExtractor((response, operation, what, url) ->
                        newResponse = null;

                        if operation is "getList"
                                newResponse = response.objects
                                newResponse.metadata = response.meta
                        else
                                newResponse = response

                        return newResponse
                )
        )


        # URI config
        .config(['$locationProvider', '$stateProvider', '$urlRouterProvider', ($locationProvider, $stateProvider, $urlRouterProvider) ->
                $locationProvider.html5Mode(config.useHtml5Mode)
                $urlRouterProvider.otherwise("/usages")

                $stateProvider.state('apps',
                        url: '/apps'
                        views:
                                rightcol:
                                        templateUrl: "views/apps.html"
                )
                .state('collaborators',
                        url: '/collaborators'
                        views:
                                rightcol:
                                        templateUrl: 'views/collaborators.html'
                        )
                .state('usages',
                        url: '/usages'
                        views:
                                rightcol:
                                        templateUrl: 'views/usages.html'
                        )
        ])

        # Google auth config
        .config(['TokenProvider', '$locationProvider', (TokenProvider, $locationProvider) ->
                TokenProvider.extendConfig(
                        clientId: '645581170749.apps.googleusercontent.com',
                        redirectUri: 'http://localhost:8080/oauth2callback.html',
                        scopes: ["https://www.googleapis.com/auth/userinfo.email",
                                "https://www.googleapis.com/auth/userinfo.profile"],
                )
        ])

        # Unisson auth config
        .config((loginServiceProvider) ->
                loginServiceProvider.setBaseUrl(config.loginBaseUrl)
        )

        .run(['$rootScope', '$state', '$stateParams', 'loginService', ($rootScope, $state, $stateParams, loginService) ->

                $rootScope.homeStateName = 'apps'

                $rootScope.config = config
                $rootScope.$state = $state
                $rootScope.$stateParams = $stateParams
                $rootScope.loginService = loginService
        ])

        # Ugly Fix for autofill on forms
        .directive('formAutofillFix', ->
                (scope, elem, attrs) ->
                        # Fixes Chrome bug: https://groups.google.com/forum/#!topic/angular/6NlucSskQjY
                        elem.prop 'method', 'POST'

                        # Fix autofill issues where Angular doesn't know about autofilled inputs
                        if attrs.ngSubmit
                                setTimeout ->
                                        elem.unbind('submit').submit (e) ->
                                                e.preventDefault()
                                                elem.find('input, textarea, select').trigger('input').trigger('change').trigger 'keydown'
                                                scope.$apply attrs.ngSubmit
                                , 0
        )

        console.debug("running angular app...")
        angular.bootstrap(document, ['unisson_webappscenter'])


)
