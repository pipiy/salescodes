application.controller 'ProfileController', [
  '$scope', '$window', '$rootScope'
  ($scope, $window, $rootScope) ->
    $scope.tab = 1;

    $scope.selectTab = (setTab)->
      $scope.tab = setTab;
    $scope.isSelected = (isSet)->
      return $scope.tab == isSet;
]
