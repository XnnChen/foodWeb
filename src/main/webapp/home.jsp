<%--
  Created by IntelliJ IDEA.
  User: xc
  Date: 2018/10/4
  Time: 18:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Custom Theme files -->
    <link href="css/home-style.css" rel='stylesheet' type='text/css' />
    <!-- Custom Theme files -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<!--- Header Starts Here --->
<div class="header" id="home">
    <div class="container">
        <div class="logo">
            <a href="home.jsp"><img src="images/logo.png" alt=""></a>
        </div>
        <div class="menu">
            <ul class="menu-top">
                <li><a class="play-icon popup-with-zoom-anim" href="#small-dialog">Log In</a></li>
                <li><a class="play-icon popup-with-zoom-anim" href="#small-dialog1">Sign up</a></li>
                <li><div class="main">
                    <section>
                        <button id="showRight" class="navig"></button>
                    </section>
                </div></li>
            </ul>
            <!---pop-up-box---->
            <script type="text/javascript" src="js/modernizr.custom.min.js"></script>
            <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all"/>
            <script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
            <!---//pop-up-box---->
            <div id="small-dialog" class="mfp-hide">
                <div class="login">
                    <h3>Log In</h3>
                    <h4>Already a Member</h4>
                    <form action="user?action=logIn" method="post">
                        <input name="email" type="text" value="Email" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Email';}" />
                        <input name="password" type="password" value="Password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}"/>
                        <input type="submit" value="Login" />
                    </form>
                    ${requestScope.message}
                </div>
            </div>
            <div id="small-dialog1" class="mfp-hide">
                <div class="signup">
                    <h3>Sign Up</h3>
                    <h4>Enter Your Details Here</h4>
                    <form action="user" method="post">
                        <input type="hidden" name="action" value="signUp">
                        <input name="firstname" type="text" value="First Name" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'First Name';}" />
                        <input name="lastname" type="text" value="Second Name" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Second Name';}" />
                        <input name="email" type="text" class="email" value="Enter Email" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Enter Email';}"  /><br>
                        <span></span>
                        <input name="password" type="password" value="Password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}"/>
                        <input type="submit"  value="SignUp"/>
                    </form>
                    ${requestScope.message}
                    <script>
                        $(function () {
                            $(".email").on('blur',function () {
                                var email = $(this).val();
                                $.ajax({
                                    url:'user?action=checkEmail',
                                    type:'post',
                                    data:{'email':email},
                                    dataType: 'json',
                                    success:function (data) {
                                        if(data.isEmailExisted){
                                            $('span').text('Email is already existed.').css('color','#900');
                                        }
                                    }
                                });
                            });
                        });
                    </script>
                </div>
            </div>
            <script>
                $(document).ready(function() {
                    $('.popup-with-zoom-anim').magnificPopup({
                        type: 'inline',
                        fixedContentPos: false,
                        fixedBgPos: true,
                        overflowY: 'auto',
                        closeBtnInside: true,
                        preloader: false,
                        midClick: true,
                        removalDelay: 300,
                        mainClass: 'my-mfp-zoom-in'
                    });
                });
            </script>

        </div>
        <div class="clearfix"></div>
        <div class="header-bottom">
            <p>Find your favorite</p>
            <h1>RECIPES</h1>
            <a href="index.jsp">Get Started</a>
            <p class="reward">OR SEND US YOUR OWN RECIPES AND <u>GET REWARDED!</u></p>
        </div>
    </div>
</div>
<!--- Header Ends Here --->
</body>
</html>
