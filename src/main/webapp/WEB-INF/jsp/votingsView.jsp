<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

    <!-- Access the bootstrap Css like this,
        Spring boot will handle the resource mapping automcatically -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <style>
        input[type=radio] {
            margin: 5px;
        }
            </style>
</head>
<body>
<table id="voting" class="table">
    <thead>
    <th>#</th>
    <th>Voiting Name</th>
    <th>Action</th>
    </thead>
<c:forEach items="${votings}" var="voting" varStatus="loop">
    <form class="table">
        <tbody>
        <th scope="col">${loop.index + 1}</th>
        <th>${voting.name}</th>
        <c:choose>
            <c:when test ="${voting.status == 'isVoting'}">
        <th><button id="stop${voting.votingId}" onclick="stop(${voting.votingId})">Stop</button>
        <a href="/poll/${voting.votingId}" ><input type="button" value="Vote"  id="vote"></a>
            </c:when>
            <c:when test ="${voting.status == 'isClosed'}">
        <th><a href="/poll/${voting.votingId}/statistic" ><input type="button" value="Statistic" ></a>
            </c:when>
            <c:when test ="${voting.status == 'isNotStarted'}">
        <th><a href="/poll/${voting.votingId}" ><input type="button" value="Start" ></a>
            </c:when>
        </c:choose>

        </th>
        </tbody>
    </form>
</c:forEach>
</table>
<script>
    function stop (votingId) {
        $.ajax({
            url: '/stop/' + votingId,
            type: "POST",
            success: function (data) {
                stopButton = document.getElementById("stop" + votingId);
                stopButton.style.display = 'none';
                voteButton = document.getElementById("vote" + votingId);
                voteButton.value = "Statistic";
            }
        })
    }
</script>
<form action="//addNewVoiting">
<button id=openModal  type="button" class="btn btn-primary" data-toggle="modal" data-target="#dialog">Add New Voting</button>
    <script>
        var optionsCount;
        $('#openModal').click(function(event) {
            $('#name').val("");
            $('#description').val("")
            var div = document.getElementById("options");
            div.innerHTML = "<div>" +
                "                        <input type = radio disabled>" +
                "                        <input id=\"option1\" type=\"text\" placeholder=\"Option1\">" +
                "                        </div>"
            optionsCount = 1;
        });
    </script>
    <div id="dialog" class="modal fade" role="dialog" title="Dialog box">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                       <h4 class="modal-title">Add new voting</h4>
                </div>
                <div class="modal-body form-group">
                    <h3>Name:</h3>
                        <br><input type="text" id="name"><br>
                    <h3 for="description">Description:</h3>
                    <br><textarea id="description" rows="4" cols="50"></textarea><br>
                    <h3>Options:</h3><br>
                    <div id = "options">
                    </div><br>
                    <button type="button" class="btn btn-primary" id="addOption" >AddNewOption</button>
                    <script>
                        $('#addOption').click(function(event) {
                            optionsCount++;
                           var radio = document.createElement("input");
                           radio.type = "radio";
                           radio.disabled = true;
                           var option = document.createElement("input");
                           option.type = "text";
                           option.placeholder = "Option" + optionsCount;
                           option.id = "option" + optionsCount;
                           var div1 = document.createElement("div");
                           var div = document.getElementById("options");
                           div1.appendChild(radio);
                           div1.appendChild(option);
                           div.appendChild(div1);
                        });
                    </script>
                </div>
                <div class="modal-footer">
                    <button id="addVoting" type="button" class="btn btn-primary" data-dismiss="modal">Add</button>
                    <script>
                        $('#addVoting').click(function(event) {
                            var name = $('#name').val();
                            var description = $('#description').val();
                            var options = [];
                            for (var i = 1; i <= optionsCount; i++) {
                                options[i-1] = {"name": $('#option' + i).val()};
                            }
                            var json = { "name" : name, "description" : description, "options": options};
                            $.ajax({
                                url: '/addNewVoiting',
                                data: JSON.stringify(json),
                                type: "POST",
                                beforeSend: function(xhr) {
                                    xhr.setRequestHeader("Accept", "application/json");
                                    xhr.setRequestHeader("Content-Type", "application/json");
                                },
                                success: function(data){
                                    var voting = document.getElementById("voting");
                                    var form  = document.createElement("form");
                                    form.classList.add("table");
                                    voting.appendChild(form);
                                    var tbody = document.createElement("tbody");
                                    voting.appendChild(tbody);
                                    var tr = document.createElement("tr");
                                    var th1 = document.createElement("th");
                                    th1.scope = "col";
                                    th1.innerText = (voting.children.length-1)/2;
                                    var th2 = document.createElement("th");
                                    th2.innerText = data.name
                                    var th3 = document.createElement("th");
                                    var a = document.createElement("a");
                                    a.href = "/poll/"+data.votingId;
                                    var input = document.createElement("input");
                                    input.type = "button";
                                    input.value = "Start";
                                    a.appendChild(input);
                                    th3.appendChild(a);
                                    tr.appendChild(th1);
                                    tr.appendChild(th2);
                                    tr.appendChild(th3);
                                    tbody.appendChild(tr);

                                }
                            });

                            event.preventDefault();
                        });
                    </script>
                    <button id="myInput" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
</form>


</body>

</html>