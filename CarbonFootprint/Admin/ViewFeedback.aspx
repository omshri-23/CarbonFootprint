<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewFeedback.aspx.cs" Inherits="CarbonFootprint.Admin.ViewFeedback" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Feedback - Admin</title>
    <link rel="stylesheet" href="admin.css" />
    <style>
        .container { max-width:1200px; margin:auto; }
        h2 { margin-bottom:20px; }
        table { width:100%; border-collapse:collapse; background:var(--bg-card); }
        th, td { padding:10px; border-bottom:1px solid var(--border); text-align:left; }
        th { background:#0f151c; color:var(--text-primary); }
        td { color: var(--text-secondary); }
        tr:hover { background:var(--bg-card-hover); }
        .btn { padding:5px 10px; border:none; border-radius:4px; cursor:pointer; }
        .btn-update { background:#27ae60; color:white; }
        .status-pending { color:#e74c3c; font-weight:bold; }
        .status-resolved { color:#2ecc71; font-weight:bold; }
        textarea { width:100%; height:60px; background:#0f151c; color:var(--text-primary); border:1px solid var(--border); }
    </style>
</head>
<body>
<form runat="server">
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
                <a href="ViewFeedback.aspx" class="nav-item active"><span class="nav-item-icon">💬</span>View Feedback</a>
                <a href="ViewContact.aspx" class="nav-item"><span class="nav-item-icon">✉️</span>View Contact</a>
                <a href="Emissionfactor.aspx" class="nav-item"><span class="nav-item-icon">🌍</span>Emission Factors</a>
                <a href="../Home.aspx" class="nav-item"><span class="nav-item-icon">🏠</span>Back to Site</a>
                <a href="../Logout.aspx" class="nav-item"><span class="nav-item-icon">🚪</span>Logout</a>
            </div>
        </nav>
    </aside>

    <main class="main-content">
        <div class="content-header">
            <div>
                <h2>User Feedback</h2>
                <p>Review and update feedback status</p>
            </div>
        </div>

        <div class="container">

    <asp:GridView ID="gvFeedback" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="FeedbackID" OnRowCommand="gvFeedback_RowCommand">

        <Columns>
            <asp:BoundField DataField="FullName" HeaderText="User" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Subject" HeaderText="Subject" />
            <asp:BoundField DataField="Message" HeaderText="Message" />
            <asp:BoundField DataField="Rating" HeaderText="Rating" />
            
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' 
                        CssClass='<%# Eval("Status").ToString()=="Pending" ? "status-pending" : "status-resolved" %>' />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Admin Reply">
                <ItemTemplate>
                    <asp:TextBox ID="txtReply" runat="server" TextMode="MultiLine" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="btnReply" runat="server" Text="Reply"
                        CssClass="btn btn-update"
                        CommandName="ReplyFeedback"
                        CommandArgument='<%# Eval("FeedbackID") %>' />
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
        </div>
    </main>
</div>
</form>
</body>
</html>
