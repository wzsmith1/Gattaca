
//autocomplete
$(document).ready(function () {
    $("#input2").on('input', function () {
        val = $("#input2").val();
        $("#output2").html(val);
        
        var options = {};
        options.url = "/api/Food/GetFoods/" + val;
        options.type = "GET";
        options.datatype = "json";
        options.success = function (data) {
            jsonValue = JSON.stringify(data);
            //alert(data[0].Name);
            for(var i=0; i<data.length; i++)
            {
                $("#foodList2").append(
                    "<option value='" + data[i].Name + "'></option>");
            }
        }
        options.failure = function (data) {
            alert("failure");
        }
        $.ajax(options);
    });
});




//typeahead
$(document).ready(function () {
    var substringMatcher = function (strs) {
        return function findMatches(q, cb) {
            var matches, substrRegex;

            // an array that will be populated with substring matches
            matches = [];

            // regex used to determine if a string contains the substring `q`
            substrRegex = new RegExp(q, 'i');

            // iterate through the pool of strings and for any string that
            // contains the substring `q`, add it to the `matches` array
            $.each(strs, function (i, str) {
                if (substrRegex.test(str)) {
                    // the typeahead jQuery plugin expects suggestions to a
                    // JavaScript object, refer to typeahead docs for more info
                    matches.push({ value: str });
                }
            });

            cb(matches);
        };
    };

    var states = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
      'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii',
      'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
      'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
      'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
      'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota',
      'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island',
      'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont',
      'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'
    ];

    var names = ['Alex', 'Brian', 'Charlie', 'Debbie',
        'Eddie', 'Fred', 'George', 'Harriet'
    ];

    $('#typeahead .typeahead').typeahead({
        hint: true,
        highlight: true,
        minLength: 1
    },
    {
        name: 'states',
        displayKey: 'value',
        source: substringMatcher(states)
    });
});

//typeahead - remote
$(document).ready(function () {
    var foods = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('Name'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: "/api/Food/GetLookup/A",
        remote: "/api/Food/GetLookup/%QUERY"
    });

    foods.initialize();

    $('#remote .typeahead').typeahead({
        hint: true,
        highlight: true,
        //minLength: 1
    },
    {
        name: 'Foods',
        displayKey: 'Name',
        source: foods.ttAdapter()
    });
});

//submission
$(document).ready(function () {
    $('#FoodForm').on('submit', function () {
        var inputValue = $('#typeaheadValue').val();
        //alert(inputValue);

        var options = {};
        options.url = "/api/Food/GetFoodByName/" + inputValue;
        options.type = "GET";
        options.datatype = "json";
        options.success = function (data) {
            jsonValue = JSON.stringify(data);
            alert(data[0].Name);
            //$("#returnValue").html("<p>" + data[0].Name + "</p>");
        }
        options.failure = function (data) {
            alert("failure");
        }
        $.ajax(options);
    });

});















