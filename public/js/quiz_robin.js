var answeredCorrectly = 0;

$(document).ready(function() {

    var informationIndex = 0;
    var answeredCorrectly = 0;

    function switchToNextInformation() {
        var information = quiz_json.informations[informationIndex];
        if(!information) {
            $("#containerInformations").hide();
            $("#containerFinish").show();
        } else {
            $('#informationCount').html("Frage " + (informationIndex + 1));
            $('#challengeText').html(information.challenge_text);
            $('#resultText').html(information.result_text);
            $('.answer').each(function (index) {
                $(this).data('answer-id', information.answers[index].id);
            });
            $("#challengeText").data("information-id", information.id);
            $('.answer').click(function (event) {
                if ($(this).data('answer-id') == information.correct_answer.id)
                    answeredCorrectly++;
            });
        }
        var progress = informationIndex / quiz_json.informations.length * 100;
        $(".progress-bar").css("width", progress + "%");
        informationIndex++;

    }

    $("#containerStart").find("button").click(function(event) {
        $("#containerStart").hide();
        $("#containerInformations").show();
        switchToNextInformation();
    });

    $(".answer").click(function (event) {
        $("#result").show();
        var data = {};
        data.answer_id = $(this).data("answer-id");
        data.information_id = $("#challengeText").data("information-id");
        $.post('/api/v1/answer_given.json', data);
    });

    $("#continue").click(function (event) {
        $("#result").hide();
        switchToNextInformation();
    });
});

