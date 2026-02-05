<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CarbonFootprint.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EcoTrack | Login/Signup</title>
<style>
/* ================= ROOT ================= */
:root{
    --forest:#0f3d2e;
    --accent:#2ecc71;
    --dark:#0f0f0f;
    --glass:rgba(255,255,255,0.25);
    --glass-border:rgba(255,255,255,0.4);
}

/* ================= GLOBAL ================= */
*{box-sizing:border-box;}
body{
    margin:0;
    font-family:"Segoe UI",system-ui;
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:
        radial-gradient(circle at top, rgba(46,204,113,0.15), transparent 40%),
        linear-gradient(135deg,#0f3d2e,#000);
}

/* ================= WRAPPER ================= */
.auth-wrapper{
    width:420px;
    text-align:center;
}

/* ================= BRAND ================= */
.brand{
    display:flex;
    justify-content:center;
    gap:12px;
    margin-bottom:14px;
}
.brand a{
    text-decoration:none;
    font-weight:800;
    letter-spacing:1px;
    color:#e8ffe9;
}
.brand .home-link{
    padding:6px 12px;
    border-radius:999px;
    background:rgba(255,255,255,0.15);
    border:1px solid rgba(255,255,255,0.35);
    font-size:12px;
}

/* ================= CAPSULE TOGGLE ================= */
.nav-wrap{
    margin:0 auto 25px;
    position:relative;
    width:100%;
    padding:6px;
    border-radius:999px;
    background:rgba(255,255,255,0.25);
    backdrop-filter:blur(18px);
    border:1px solid var(--glass-border);
    box-shadow:0 20px 40px rgba(0,0,0,.35);
}

.nav{
    display:flex;
    position:relative;
}

.nav a{
    flex:1;
    padding:14px 0;
    text-decoration:none;
    font-weight:800;
    color:#0f3d2e;
    cursor:pointer;
    z-index:2;
}

.nav a.active{
    color:#000;
}

/* Bubble */
.bubble{
    position:absolute;
    top:6px;
    bottom:6px;
    width:50%;
    background:white;
    border-radius:999px;
    z-index:1;
    transition:.35s ease;
}
.bubble.signup{left:6px;}
.bubble.login{left:50%;}

/* ================= CARD ================= */
.auth-card{
    background:rgba(255,255,255,0.92);
    border-radius:20px;
    padding:40px;
    box-shadow:0 30px 80px rgba(0,0,0,.35);
    animation:fadeUp .6s ease;
}

/* ================= TITLES ================= */
.auth-card h2{
    margin-bottom:6px;
    color:var(--forest);
}
.auth-card p{
    color:#607d8b;
    font-size:14px;
    margin-bottom:28px;
}

/* ================= FORM ================= */
.input-group{
    margin-bottom:16px;
    text-align:left;
}
label{
    display:block;
    font-weight:600;
    color:#00695c;
    margin-bottom:6px;
}
input{
    width:100%;
    padding:12px;
    border-radius:10px;
    border:1px solid #cfd8dc;
    outline:none;
}
input:focus{
    border-color:var(--accent);
    box-shadow:0 0 8px rgba(46,204,113,.4);
}

/* ================= BUTTON ================= */
.auth-btn{
    width:100%;
    padding:14px;
    margin-top:10px;
    border:none;
    border-radius:40px;
    background:linear-gradient(135deg,#2ecc71,#1abc9c);
    color:#000;
    font-weight:800;
    cursor:pointer;
    transition:.3s;
}
.auth-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 18px 40px rgba(46,204,113,.55);
}

/* ================= VISIBILITY ================= */
.form{display:none;}
.form.active{display:block;}

/* ================= ANIMATION ================= */
@keyframes fadeUp{
    from{opacity:0;transform:translateY(30px);}
    to{opacity:1;transform:translateY(0);}
}
</style>

<script>
    function switchForm(type) {
        const bubble = document.querySelector(".bubble");
        const loginBtn = document.getElementById("btnLogin");
        const signupBtn = document.getElementById("btnSignup");

        document.querySelectorAll(".form").forEach(f => f.classList.remove("active"));

        if (type === "login") {
            bubble.className = "bubble login";
            loginBtn.classList.add("active");
            signupBtn.classList.remove("active");
            document.getElementById("loginForm").classList.add("active");
        } else {
            bubble.className = "bubble signup";
            signupBtn.classList.add("active");
            loginBtn.classList.remove("active");
            document.getElementById("signupForm").classList.add("active");
        }
    }
</script>

</head>
<body>
<form runat="server">

<div class="auth-wrapper">

    <div class="brand">
        <a class="logo-link" href="Home.aspx">ECOTRACK</a>
        <a class="home-link" href="Home.aspx">Home</a>
    </div>

    <!-- TOGGLE -->
    <div class="nav-wrap">
        <div class="bubble signup"></div>
        <nav class="nav">
            <a id="btnSignup" class="active" onclick="switchForm('signup')">Signup</a>
            <a id="btnLogin" onclick="switchForm('login')">Login</a>
        </nav>
    </div>

    <!-- CARD -->
    <div class="auth-card">

      <!-- SIGNUP -->
<div id="signupForm" class="form active">
    <h2>🌍 Create EcoTrack Account</h2>
    <p>Join us in reducing carbon footprint</p>

    <div class="input-group">
        <label>Full Name</label>
        <asp:TextBox ID="txtSignupName" runat="server" CssClass="input" placeholder="John Doe" />
    </div>

    <div class="input-group">
        <label>Email</label>
        <asp:TextBox ID="txtSignupEmail" runat="server" CssClass="input" TextMode="Email" placeholder="example@gmail.com" />
    </div>

    <div class="input-group">
        <label>Password</label>
        <asp:TextBox ID="txtSignupPassword" runat="server" CssClass="input" TextMode="Password" placeholder="Enter your password" />
    </div>

    <div class="input-group">
        <label>Confirm Password</label>
        <asp:TextBox ID="txtSignupConfirm" runat="server" CssClass="input" TextMode="Password" placeholder="Confirm your password" />
    </div>

    <asp:Button
        ID="btnSignupSubmit"
        runat="server"
        Text="Create Account"
        CssClass="auth-btn"
        OnClick="Signup_Click" />
</div>

        <!-- LOGIN -->
<div id="loginForm" class="form">
    <h2>🔐 Welcome Back</h2>
    <p>Login to continue your eco journey</p>

    <div class="input-group">
        <label>Email</label>
        <asp:TextBox ID="txtLoginEmail" runat="server" CssClass="input" TextMode="Email" placeholder="example@gmail.com" />
    </div>

    <div class="input-group">
        <label>Password</label>
        <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="input" TextMode="Password" placeholder="Enter your password" />
    </div>

    <asp:Button
        ID="btnLoginSubmit"
        runat="server"
        Text="Login"
        CssClass="auth-btn"
        OnClick="Login_Click" />
</div>

    </div>
</div>

</form>
</body>
</html>


