angular.module('Notes', []).directive('editableDiv', function() {
  return {
    restrict: 'E',  // restrict this directive to elements only
    scope: {
      model: '=ngModel'
    },
    templateUrl: 'editable-div.html',
  };
});
