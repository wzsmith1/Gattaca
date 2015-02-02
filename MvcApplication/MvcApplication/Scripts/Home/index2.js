
function foodController($scope, $http)
{
    $scope.sample1 = "Sample 1";
    $scope.sample2 = "Sample 2";

    $scope.dataSingle;
    $http.get("/api/Food/GetFood/10")
        .then(function (result) {
            //Successful
            $scope.dataSingle = result.data;
            //angular.copy(result.data, $scope.dataSingle);
        },
        function () {
            //Failure
            alert("failure")
        });

    $scope.dataMultiple = [];
    $http.get("/api/Food/GetFoods/Butter")
        .then(function (result) {
            //Successful
            angular.copy(result.data, $scope.dataMultiple);
        },
        function () {
            //Failure
            alert("failure")
        });



    //$scope.data = [
    //    {
    //        id: 1,
    //        name: "one"
    //    },
    //    {
    //        id: 2,
    //        name: "two"
    //    },
    //    {
    //        id: 3,
    //        name: "three"
    //    }
    //];
}