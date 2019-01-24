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
    </ul>
</head>
<body>
<div>
    <div>
        <div>
            <div>
                <label for = sharedVal> Shared Statistic Link</label>
                <input type="text" id = sharedVal>
                <script>
                    $('#sharedVal').val(document.location.hostname + "/poll/" + ${voting.votingId} + "/statistic")
                </script>
                <input type="button" id = copy value="Copy Statistic Link">
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