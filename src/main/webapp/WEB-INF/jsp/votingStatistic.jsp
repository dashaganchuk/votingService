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
            </div>
        </div>
    </nav>
</head>
<body>
<div>
    <div>
        <div class="container">
            <div class="container">
                <label for = sharedVal> Shared Statistic Link</label>
                <input type="text" id = sharedVal>
                <script>
                    $('#sharedVal').val(document.location.hostname + "/poll/" + ${voting.votingId} + "/statistic")
                </script>
                <input type="button"  class="btn btn-primary" id = copy value="Copy Statistic Link">
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
                <form>
                <div id = "options">
                    <c:forEach items="${voting.options}" var="option" varStatus="loop">
                        <div>
                            <label>${option.name}</label> -
                            <label>${option.count}</label>
                        </div>
                    </c:forEach>
                </div>
                </form>
            </div>
        </div>

    </div>
</div>
</form>


</body>

</html>