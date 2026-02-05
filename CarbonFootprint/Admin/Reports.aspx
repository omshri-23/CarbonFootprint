<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="CarbonFootprint.Admin.Reports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>System Reports - EcoTrack</title>
    <link rel="stylesheet" href="admin.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .container { max-width:1300px; margin:auto; }
        .card { margin-bottom:25px; }
        h2 { margin-bottom:15px; color: var(--text-primary); }
        .grid { display:grid; grid-template-columns:1fr 1fr; gap:20px; }
        .filters { display:flex; gap:12px; flex-wrap:wrap; align-items:center; }
        .filters input, .filters select { padding:8px 10px; border:1px solid var(--border); border-radius:6px; background:#0f151c; color:var(--text-primary); }
        .btn { padding:8px 12px; border:0; border-radius:6px; cursor:pointer; }
        .btn-primary { background:#27ae60; color:#fff; }
        .btn-secondary { background:#1a2329; color:#e8e8e8; border:1px solid var(--border); }
        .stat-box { text-align:center; padding:20px; }
        .stat-box h3 { color:var(--text-secondary); font-size:14px; }
        .stat-box .value { font-size:30px; font-weight:bold; color:#27ae60; }
        table { width:100%; border-collapse:collapse; }
        th, td { padding:10px; border-bottom:1px solid var(--border); text-align:left; }
        th { background:#0f151c; color: var(--text-primary); }
        td { color: var(--text-secondary); }
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
                <a href="Reports.aspx" class="nav-item active"><span class="nav-item-icon">📋</span>Reports</a>
                <a href="Viewusers.aspx" class="nav-item"><span class="nav-item-icon">👥</span>View Users</a>
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
                <h2>System Reports</h2>
                <p>Summary and analytics</p>
            </div>
        </div>

        <div class="container">

    <!-- FILTERS -->
    <div class="card">
        <h2>Filters</h2>
        <div class="filters">
            <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" />
            <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" />
            <asp:DropDownList ID="ddlMonth" runat="server" />
            <asp:DropDownList ID="ddlYear" runat="server" />
            <asp:Button ID="btnApply" runat="server" CssClass="btn btn-secondary" Text="Apply Filters" OnClick="ApplyFilters_Click" />
            <asp:Button ID="btnClear" runat="server" CssClass="btn btn-secondary" Text="Clear" OnClick="ClearFilters_Click" />
            <asp:Button ID="btnExportCsv" runat="server" CssClass="btn btn-primary" Text="Export CSV" OnClick="ExportCsv_Click" />
        </div>
    </div>

    <!-- TOP STATS -->
    <div class="card grid">
        <div class="stat-box">
            <h3>Total Users</h3>
            <div class="value"><asp:Label ID="lblUsers" runat="server" /></div>
        </div>
        <div class="stat-box">
            <h3>Total Calculations</h3>
            <div class="value"><asp:Label ID="lblCalculations" runat="server" /></div>
        </div>
        <div class="stat-box">
            <h3>Total CO₂e Emissions</h3>
            <div class="value"><asp:Label ID="lblEmissions" runat="server" /></div>
        </div>
        <div class="stat-box">
            <h3>Active Users</h3>
            <div class="value"><asp:Label ID="lblActiveUsers" runat="server" /></div>
        </div>
    </div>

    <!-- EMISSION TREND CHART -->
    <div class="card">
        <h2>Monthly Emission Trend</h2>
        <canvas id="emissionChart"></canvas>
    </div>

    <!-- CATEGORY BREAKDOWN -->
    <div class="card">
        <h2>Category-wise Emissions</h2>
        <asp:GridView ID="gvCategory" runat="server" AutoGenerateColumns="true"></asp:GridView>
    </div>

    <!-- TOP POLLUTERS -->
    <div class="card">
        <h2>Top 10 Users by Emissions</h2>
        <asp:GridView ID="gvTopUsers" runat="server" AutoGenerateColumns="true"></asp:GridView>
    </div>

</div>
    </main>
</div>
</form>
</body>
</html>
