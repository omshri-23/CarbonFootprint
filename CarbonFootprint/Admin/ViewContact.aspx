<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewContact.aspx.cs" Inherits="CarbonFootprint.Admin.ViewContact" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Contact Messages</title>
    <link rel="stylesheet" href="admin.css" />
    <style>
        .panel { background:var(--bg-card); padding:25px; border-radius:12px; border:1px solid var(--border); }
        h2 { margin-bottom:20px; color: var(--text-primary); }
        table { width:100%; border-collapse:collapse; }
        th { background:#0f151c; padding:10px; text-align:left; color: var(--text-primary); }
        td { padding:10px; border-bottom:1px solid var(--border); color: var(--text-secondary); }
        .btn { padding:6px 12px; border:none; border-radius:4px; cursor:pointer; }
        .btn-read { background:#3498db; color:white; }
        .btn-delete { background:#e74c3c; color:white; }
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
                    <a href="ViewFeedback.aspx" class="nav-item"><span class="nav-item-icon">💬</span>View Feedback</a>
                    <a href="ViewContact.aspx" class="nav-item active"><span class="nav-item-icon">✉️</span>View Contact</a>
                    <a href="Emissionfactor.aspx" class="nav-item"><span class="nav-item-icon">🌍</span>Emission Factors</a>
                    <a href="../Home.aspx" class="nav-item"><span class="nav-item-icon">🏠</span>Back to Site</a>
                    <a href="../Logout.aspx" class="nav-item"><span class="nav-item-icon">🚪</span>Logout</a>
                </div>
            </nav>
        </aside>

        <main class="main-content">
            <div class="content-header">
                <div>
                    <h2>Contact Messages</h2>
                    <p>Review and manage contact requests</p>
                </div>
            </div>

            <div class="container card">
                <div class="panel">
                    <h2>📧 Contact Messages</h2>

        <asp:GridView ID="gvContacts" runat="server" AutoGenerateColumns="False"
            DataKeyNames="MessageID" OnRowCommand="gvContacts_RowCommand">

            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Subject" HeaderText="Subject" />
                <asp:BoundField DataField="CreatedDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                <asp:BoundField DataField="Status" HeaderText="Status" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnRead" runat="server" Text="Mark Read"
                            CssClass="btn btn-read"
                            CommandName="ReadMsg"
                            CommandArgument='<%# Eval("MessageID") %>' />

                        <asp:Button ID="btnDelete" runat="server" Text="Delete"
                            CssClass="btn btn-delete"
                            CommandName="DeleteMsg"
                            CommandArgument='<%# Eval("MessageID") %>'
                            OnClientClick="return confirm('Delete this message?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>
                </div>
            </div>
        </main>
    </div>
</form>
</body>
</html>

