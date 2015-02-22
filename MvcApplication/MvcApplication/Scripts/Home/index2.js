
function foodController($scope, $http)
{
    $scope.isBusy = true;
    $scope.foodInput = {};
    $scope.dataSingle;
    $scope.dataMultiple = [];

    $scope.change = function () {
        $http.get("/api/Food/GetFoods/" + $scope.foodInput.Value)
            .then(function (result) {
                //Successful
                $scope.dataMultiple = {};
                //angular.copy(result.data, $scope.dataMultiple);
                $scope.dataMultiple = result.data;
            },
        function () {
            //Failure
            //alert("failure")
        });
    }

    $scope.click = function () {
        alert("clicked");
    }

    $scope.submit = function () {
        var foodId = $scope.dataMultiple[0]["FoodID"];
        $http.get("/api/Food/GetFood/" + foodId)
            .then(function (result) {
                //Successful
                $scope.dataSingle = result.data;
            },
        function () {
            //Failure
            alert("failure")
        });
    }

}