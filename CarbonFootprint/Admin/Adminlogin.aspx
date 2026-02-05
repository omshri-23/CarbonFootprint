<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Adminlogin.aspx.cs" Inherits="CarbonFootprint.Admin.Adminlogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login | EcoTrack</title>
    <link rel="stylesheet" href="admin.css" />
    <style>
        body{
            font-family:"Segoe UI";
            background:linear-gradient(135deg,#0f3d2e,#000);
            display:flex; justify-content:center; align-items:center;
            height:100vh; margin:0;
        }
        .card{
            background:#fff;
            padding:40px;
            border-radius:15px;
            width:350px;
            box-shadow:0 20px 50px rgba(0,0,0,.4);
        }
        h2{text-align:center;color:#0f3d2e;}
        input{
            width:100%; padding:12px; margin-bottom:15px;
            border-radius:8px; border:1px solid #ccc;
        }
        .btn{
            width:100%; padding:12px;
            background:#2ecc71; border:none;
            border-radius:30px; font-weight:bold;
            cursor:pointer;
        }
        .error{color:red;text-align:center;}
    </style>
</head>
<body>
<form runat="server">
    <div class="card">
        <h2>Admin Login</h2>
        <asp:TextBox ID="txtEmail" runat="server" Placeholder="Admin Email" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password" />
        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="Login_Click"/>
        <asp:Label ID="lblError" runat="server" CssClass="error"/>
    </div>
</form>
</body>
</html>

