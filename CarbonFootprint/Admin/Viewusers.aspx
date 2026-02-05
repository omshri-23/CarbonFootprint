<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Viewusers.aspx.cs" Inherits="CarbonFootprint.Admin.Viewusers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Users</title>
    <link rel="stylesheet" href="admin.css" />
    <style>
        h2 { color: var(--text-primary); }
        table { width:100%; border-collapse:collapse; background:var(--bg-card); }
        th { background:#0f151c; color:var(--text-primary); padding:10px; }
        td { padding:10px; border-bottom:1px solid var(--border); color:var(--text-secondary); }
        tr:hover { background:var(--bg-card-hover); }
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
                <a href="Viewusers.aspx" class="nav-item active"><span class="nav-item-icon">👥</span>View Users</a>
                <a href="ViewFeedback.aspx" class="nav-item"><span class="nav-item-icon">💬</span>View Feedback</a>
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
                <h2>Manage Registered Users</h2>
                <p>Activate, deactivate, or remove users</p>
            </div>
        </div>

        <div class="container card">

    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
        DataKeyNames="UserID"
        OnRowCommand="gvUsers_RowCommand"
        OnRowDataBound="gvUsers_RowDataBound">

        <Columns>
            <asp:BoundField DataField="UserID" HeaderText="ID" />
            <asp:BoundField DataField="FullName" HeaderText="Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Country" HeaderText="Country" />
            <asp:BoundField DataField="Role" HeaderText="Role" />
            <asp:BoundField DataField="CreatedDate" HeaderText="Registered" DataFormatString="{0:dd MMM yyyy}" />

            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnToggle" runat="server"
                        Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate" : "Activate" %>'
                        CssClass='<%# "action-btn " + (Convert.ToBoolean(Eval("IsActive")) ? "action-toggle" : "action-edit") %>'
                        CommandName="ToggleStatus"
                        CommandArgument='<%# Eval("UserID") %>' />

                    <asp:Button ID="btnDelete" runat="server"
                        Text="Delete"
                        CssClass="action-btn action-delete"
                        CommandName="DeleteUser"
                        CommandArgument='<%# Eval("UserID") %>'
                        OnClientClick="return confirm('Delete this user?');" />
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

