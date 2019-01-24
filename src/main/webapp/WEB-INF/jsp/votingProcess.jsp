<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

    <!-- Access the bootstrap Css like this,
        Spring boot will handle the resource mapping automcatically -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">Menu</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                 <a class="nav-item nav-link" href="/">View list of polls</a>
                 <a id="statistic" hidden class="nav-item nav-link" href="/poll/${voting.votingId}/statistic"  >View statistics for this poll</a>
            </div>
        </div>
    </nav>
</head>
<body>
<div>
        <div>
            <div class="container">
                <div class="container">
                    <label for = sharedVal> Shared Link</label>
                    <input type="text" id = sharedVal>
                    <script>
                        var votingId =  ${voting.votingId}
                        $('#sharedVal').val(document.location.hostname + "/poll/" + votingId)
                    </script>
                    <input type="button"  class="btn btn-primary" id = copy value="Copy Link">
                    <script>
                        $('#copy').click(function(event) {
                            var sharedVal = document.getElementById("sharedVal");
                            sharedVal.select();
                            document.execCommand("copy");
                        });
                    </script>
                </div>

                <div class="container">
                    <h1 for="description">${voting.description}</h1>
                    <br>
                    <h3>Choose your option.</h3><br>

                    <form id = "options">
                        <c:forEach items="${voting.options}" var="option" varStatus="loop">
                               <div>
                                <input type="radio" name="option" id=${loop.index + 1}>
                                ${option.name}
                               </div>
                        </c:forEach>
                    </form>
                    <br>
                </div>
                <div >
                    <button id="registerVote" type="button" class="btn btn-primary">Register my vote</button>
                    <label id="success" hidden>Your vote is successfully registered</label>
                    <script>
                        $('#registerVote').click(function(event) {
                            var optionNo;
                            var radio = document.getElementById("1");
                            var radioCounter = 1;
                            while (radio != null){
                                if (radio.checked){
                                    optionNo = radioCounter-1;
                                    break;
                                }
                                radioCounter = radioCounter+1;
                                radio = document.getElementById(radioCounter);
                            }
                            if (optionNo == null){
                                alert("Please, choose the option");
                                return;
                            }
                            $.ajax({
                                url: window.location.pathname  + '/' +optionNo,
                                type: "POST",
                                success: function(data){
                                    var radio = document.getElementById("1");
                                    var radioCounter = 1;
                                    while (radio != null){
                                        radio.disabled = true;
                                        radioCounter = radioCounter+1;
                                        radio = document.getElementById(radioCounter);
                                    }
                                    registerVote = document.getElementById("registerVote");
                                    registerVote.style.display = 'none';
                                    success = document.getElementById("success");
                                    success.hidden = false;
                                    statistic = document.getElementById("statistic");
                                    statistic.hidden = false;
                                }
                            });

                            event.preventDefault();
                        });
                    </script>
                </div>
            </div>

        </div>
    </div>
</form>


</body>

</html>