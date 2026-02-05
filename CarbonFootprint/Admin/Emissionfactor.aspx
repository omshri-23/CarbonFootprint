<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Emissionfactor.aspx.cs" Inherits="CarbonFootprint.Admin.Emissionfactor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Emission Factors</title>
    <link rel="stylesheet" href="admin.css" />
    <style>
        h2 { color: var(--text-primary); margin-bottom:10px; }
        .msg { margin:10px 0; color:#e74c3c; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <aside class="sidebar">
                <div class="sidebar-brand">
                    <h1>🌿 EcoTrack</h1>
                    <p>Admin Control Panel</p>
                </div>
                <nav class="sidebar-nav">
                    <div class="nav-section">
                        <div class="nav-section-title">Admin</div>
                        <a href="AdminDashboard.aspx" class="nav-item"><span class="nav-item-icon">📊</span>Dashboard</a>
                        <a href="Reports.aspx" class="nav-item"><span class="nav-item-icon">📋</span>Reports</a>
                        <a href="Viewusers.aspx" class="nav-item"><span class="nav-item-icon">👥</span>View Users</a>
                        <a href="ViewFeedback.aspx" class="nav-item"><span class="nav-item-icon">💬</span>View Feedback</a>
                        <a href="ViewContact.aspx" class="nav-item"><span class="nav-item-icon">✉️</span>View Contact</a>
                        <a href="Emissionfactor.aspx" class="nav-item active"><span class="nav-item-icon">🌍</span>Emission Factors</a>
                        <a href="../Home.aspx" class="nav-item"><span class="nav-item-icon">🏠</span>Back to Site</a>
                        <a href="../Logout.aspx" class="nav-item"><span class="nav-item-icon">🚪</span>Logout</a>
                    </div>
                </nav>
            </aside>

            <main class="main-content">
                <div class="content-header">
                    <div>
                        <h2>Emission Factors</h2>
                        <p>Reference data used in calculations</p>
                    </div>
                </div>

                <div class="container card">
                    <asp:Label ID="lblMessage" runat="server" CssClass="msg" Visible="false"></asp:Label>
                    <asp:GridView ID="gvFactors" runat="server" AutoGenerateColumns="true" CssClass="table"></asp:GridView>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
