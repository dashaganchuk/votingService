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
    <ul>
        <li><a href="/">View list of polls</a></li>
        <li id="statistic" hidden><a href="/poll/${voting.votingId}/statistic"  >View statistics for this poll</a></li>
    </ul>
</head>
<body>
<div>
        <div>
            <div>
                <div>
                    <label for = sharedVal> Shared Link</label>
                    <input type="text" id = sharedVal>
                    <script>
                        var votingId =  ${voting.votingId}
                        $('#sharedVal').val(document.location.hostname + "/poll/" + votingId)
                    </script>
                    <input type="button" id = copy value="Copy Link">
                    <script>
                        $('#copy').click(function(event) {
                            var sharedVal = document.getElementById("sharedVal");
                            sharedVal.select();
                            document.execCommand("copy");
                        });
                    </script>
                </div>

                <div class="form-group">
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