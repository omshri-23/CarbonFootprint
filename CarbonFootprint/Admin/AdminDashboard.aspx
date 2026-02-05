<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="CarbonFootprint.Admin.AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Admin Dashboard | EcoTrack</title>
<link rel="stylesheet" href="admin.css" />
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=JetBrains+Mono:wght@400;600&display=swap" rel="stylesheet">
<style>
/* ================= ROOT & RESET ================= */
:root {
    --forest: #0f3d2e;
    --forest-soft: #1f6f54;
    --accent: #2ecc71;
    --accent-dark: #27ae60;
    --blue: #3498db;
    --blue-dark: #2980b9;
    --red: #e74c3c;
    --orange: #f39c12;
    --purple: #9b59b6;
    --yellow: #f1c40f;
    --bg-dark: #0a0f14;
    --bg-card: #12181f;
    --bg-card-hover: #1a2329;
    --border: rgba(46, 204, 113, 0.15);
    --border-hover: rgba(46, 204, 113, 0.3);
    --text-primary: #e8e8e8;
    --text-secondary: #a0a0a0;
    --text-muted: #6b6b6b;
    --glass: rgba(18, 24, 31, 0.85);
    --shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
    --shadow-lg: 0 10px 40px rgba(0, 0, 0, 0.5);
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: 'DM Sans', system-ui, -apple-system, sans-serif;
    background: var(--bg-dark);
    color: var(--text-primary);
    line-height: 1.6;
    overflow-x: hidden;
}

/* ================= LAYOUT ================= */
.admin-container {
    display: grid;
    grid-template-columns: 280px 1fr;
    min-height: 100vh;
}

/* ================= SIDEBAR ================= */
.sidebar {
    background: var(--bg-card);
    border-right: 1px solid var(--border);
    padding: 30px 0;
    position: sticky;
    top: 0;
    height: 100vh;
    overflow-y: auto;
    z-index: 100;
}

.sidebar::-webkit-scrollbar {
    width: 6px;
}

.sidebar::-webkit-scrollbar-track {
    background: transparent;
}

.sidebar::-webkit-scrollbar-thumb {
    background: var(--accent);
    border-radius: 10px;
}

.sidebar-brand {
    padding: 0 30px 30px;
    border-bottom: 1px solid var(--border);
    margin-bottom: 30px;
}

.sidebar-brand h1 {
    color: var(--accent);
    font-size: 24px;
    font-weight: 700;
    letter-spacing: -0.5px;
}

.sidebar-brand p {
    color: var(--text-secondary);
    font-size: 13px;
    margin-top: 5px;
    font-family: 'JetBrains Mono', monospace;
}

.sidebar-nav {
    padding: 0 15px;
}

.nav-section {
    margin-bottom: 25px;
}

.nav-section-title {
    color: var(--text-muted);
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    padding: 0 15px 10px;
}

.nav-item {
    display: flex;
    align-items: center;
    padding: 12px 15px;
    color: var(--text-secondary);
    text-decoration: none;
    border-radius: 10px;
    margin-bottom: 5px;
    transition: all 0.3s ease;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
}

.nav-item:hover {
    background: var(--bg-card-hover);
    color: var(--text-primary);
    transform: translateX(5px);
}

.nav-item.active {
    background: linear-gradient(135deg, var(--accent) 0%, var(--forest-soft) 100%);
    color: white;
    box-shadow: 0 4px 15px rgba(46, 204, 113, 0.3);
}

.nav-item-icon {
    font-size: 18px;
    margin-right: 12px;
    width: 20px;
    text-align: center;
}

.nav-item-badge {
    margin-left: auto;
    background: var(--red);
    color: white;
    font-size: 11px;
    padding: 2px 8px;
    border-radius: 10px;
    font-family: 'JetBrains Mono', monospace;
    font-weight: 600;
}

/* ================= MAIN CONTENT ================= */
.main-content {
    padding: 30px 40px;
    background: var(--bg-dark);
    overflow-y: auto;
}

/* ================= HEADER ================= */
.content-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 35px;
    flex-wrap: wrap;
    gap: 20px;
}

.header-title h2 {
    font-size: 32px;
    font-weight: 700;
    color: var(--text-primary);
    margin-bottom: 5px;
}

.header-title p {
    color: var(--text-secondary);
    font-size: 14px;
}

.header-actions {
    display: flex;
    gap: 12px;
}

.btn {
    padding: 10px 20px;
    border: none;
    border-radius: 10px;
    font-weight: 600;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    font-family: 'DM Sans', sans-serif;
}

.btn-primary {
    background: linear-gradient(135deg, var(--accent) 0%, var(--forest-soft) 100%);
    color: white;
    box-shadow: 0 4px 15px rgba(46, 204, 113, 0.3);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 25px rgba(46, 204, 113, 0.4);
}

.btn-secondary {
    background: var(--bg-card);
    color: var(--text-primary);
    border: 1px solid var(--border);
}

.btn-secondary:hover {
    background: var(--bg-card-hover);
    border-color: var(--border-hover);
}

/* ================= STATS GRID ================= */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 24px;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 3px;
    background: linear-gradient(90deg, var(--accent) 0%, transparent 100%);
    opacity: 0;
    transition: opacity 0.3s ease;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: var(--shadow-lg);
    border-color: var(--border-hover);
}

.stat-card:hover::before {
    opacity: 1;
}

.stat-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 15px;
}

.stat-icon {
    width: 50px;
    height: 50px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    background: rgba(46, 204, 113, 0.1);
}

.stat-trend {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 12px;
    font-weight: 600;
    padding: 4px 10px;
    border-radius: 20px;
    font-family: 'JetBrains Mono', monospace;
}

.trend-up {
    background: rgba(46, 204, 113, 0.15);
    color: var(--accent);
}

.trend-down {
    background: rgba(231, 76, 60, 0.15);
    color: var(--red);
}

.stat-value {
    font-size: 32px;
    font-weight: 700;
    color: var(--text-primary);
    margin-bottom: 5px;
    font-family: 'JetBrains Mono', monospace;
}

.stat-label {
    color: var(--text-secondary);
    font-size: 13px;
    font-weight: 500;
}

/* ================= CHARTS SECTION ================= */
.charts-section {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.chart-card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 25px;
    transition: all 0.3s ease;
}

.chart-card:hover {
    box-shadow: var(--shadow-lg);
    border-color: var(--border-hover);
}

.chart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.chart-title {
    font-size: 18px;
    font-weight: 600;
    color: var(--text-primary);
}

.chart-filter {
    display: flex;
    gap: 8px;
}

.filter-btn {
    padding: 6px 14px;
    border: 1px solid var(--border);
    background: transparent;
    color: var(--text-secondary);
    border-radius: 8px;
    font-size: 12px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
}

.filter-btn:hover,
.filter-btn.active {
    background: var(--accent);
    color: white;
    border-color: var(--accent);
}

.chart-placeholder {
    height: 280px;
    background: linear-gradient(135deg, rgba(46, 204, 113, 0.05) 0%, rgba(15, 61, 46, 0.1) 100%);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--text-muted);
    font-size: 14px;
    border: 1px dashed var(--border);
}

/* ================= TABLES ================= */
.table-section {
    margin-bottom: 30px;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.section-title {
    font-size: 20px;
    font-weight: 600;
    color: var(--text-primary);
}

.table-card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 16px;
    overflow: hidden;
}

.table-controls {
    padding: 20px 25px;
    border-bottom: 1px solid var(--border);
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
}

.search-box {
    position: relative;
    flex: 1;
    max-width: 350px;
}

.search-box input {
    width: 100%;
    padding: 10px 15px 10px 40px;
    background: var(--bg-dark);
    border: 1px solid var(--border);
    border-radius: 10px;
    color: var(--text-primary);
    font-size: 14px;
    font-family: 'DM Sans', sans-serif;
    transition: all 0.3s ease;
}

.search-box input:focus {
    outline: none;
    border-color: var(--accent);
    box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
}

.search-icon {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-muted);
}

.table-actions {
    display: flex;
    gap: 10px;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
}

.data-table thead {
    background: rgba(46, 204, 113, 0.05);
}

.data-table th {
    padding: 15px 25px;
    text-align: left;
    font-size: 12px;
    font-weight: 600;
    color: var(--text-secondary);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border-bottom: 1px solid var(--border);
}

.data-table td {
    padding: 18px 25px;
    border-bottom: 1px solid var(--border);
    color: var(--text-primary);
    font-size: 14px;
}

.data-table tbody tr {
    transition: all 0.2s ease;
}

.data-table tbody tr:hover {
    background: var(--bg-card-hover);
}

.user-cell {
    display: flex;
    align-items: center;
    gap: 12px;
}

.user-avatar {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--accent) 0%, var(--blue) 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
    font-size: 14px;
    color: white;
}

.user-info {
    display: flex;
    flex-direction: column;
}

.user-name {
    font-weight: 600;
    color: var(--text-primary);
}

.user-email {
    font-size: 12px;
    color: var(--text-secondary);
}

.status-badge {
    display: inline-block;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
    font-family: 'JetBrains Mono', monospace;
}

.status-active {
    background: rgba(46, 204, 113, 0.15);
    color: var(--accent);
}

.status-pending {
    background: rgba(243, 156, 18, 0.15);
    color: var(--orange);
}

.status-inactive {
    background: rgba(231, 76, 60, 0.15);
    color: var(--red);
}

.action-buttons {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.action-btn {
    min-height: 32px;
    padding: 6px 10px;
    border: 1px solid var(--border);
    background: transparent;
    color: var(--text-secondary);
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    line-height: 1;
    white-space: nowrap;
    text-decoration: none;
}

.action-btn:hover {
    background: var(--bg-dark);
    border-color: var(--accent);
    color: var(--accent);
    transform: translateY(-2px);
}

/* ================= ACTIVITY FEED ================= */
.activity-section {
    margin-bottom: 30px;
}

.activity-card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 25px;
}

.activity-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.activity-item {
    display: flex;
    gap: 15px;
    padding: 15px;
    border-radius: 12px;
    transition: all 0.3s ease;
}

.activity-item:hover {
    background: var(--bg-card-hover);
}

.activity-icon-wrapper {
    width: 40px;
    height: 40px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 18px;
    flex-shrink: 0;
}

.activity-icon-user {
    background: rgba(46, 204, 113, 0.15);
    color: var(--accent);
}

.activity-icon-calc {
    background: rgba(52, 152, 219, 0.15);
    color: var(--blue);
}

.activity-icon-alert {
    background: rgba(243, 156, 18, 0.15);
    color: var(--orange);
}

.activity-content {
    flex: 1;
}

.activity-text {
    color: var(--text-primary);
    font-size: 14px;
    margin-bottom: 5px;
}

.activity-text strong {
    color: var(--accent);
    font-weight: 600;
}

.activity-time {
    color: var(--text-muted);
    font-size: 12px;
    font-family: 'JetBrains Mono', monospace;
}

/* ================= QUICK ACTIONS ================= */
.quick-actions {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-bottom: 30px;
}

.quick-action-card {
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 20px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
    text-decoration: none;
}

.quick-action-card:hover {
    transform: translateY(-5px);
    border-color: var(--accent);
    box-shadow: 0 8px 25px rgba(46, 204, 113, 0.2);
}

.quick-action-icon {
    font-size: 32px;
    margin-bottom: 12px;
}

.quick-action-title {
    color: var(--text-primary);
    font-size: 15px;
    font-weight: 600;
}

/* ================= RESPONSIVE ================= */
@media (max-width: 1200px) {
    .charts-section {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 968px) {
    .admin-container {
        grid-template-columns: 1fr;
    }

    .sidebar {
        position: relative;
        height: auto;
        border-right: none;
        border-bottom: 1px solid var(--border);
    }

    .main-content {
        padding: 20px;
    }

    .stats-grid {
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    }
}

@media (max-width: 640px) {
    .content-header {
        flex-direction: column;
        align-items: flex-start;
    }

    .header-actions {
        width: 100%;
        flex-wrap: wrap;
    }

    .btn {
        flex: 1;
        justify-content: center;
    }

    .stats-grid {
        grid-template-columns: 1fr;
    }

    .table-controls {
        flex-direction: column;
    }

    .search-box {
        max-width: 100%;
    }

    .data-table {
        font-size: 12px;
    }

    .data-table th,
    .data-table td {
        padding: 12px 15px;
    }
}

/* ================= ANIMATIONS ================= */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.stat-card,
.chart-card,
.table-card,
.activity-card,
.quick-action-card {
    animation: fadeInUp 0.6s ease forwards;
    opacity: 0;
}

.stat-card:nth-child(1) { animation-delay: 0.1s; }
.stat-card:nth-child(2) { animation-delay: 0.2s; }
.stat-card:nth-child(3) { animation-delay: 0.3s; }
.stat-card:nth-child(4) { animation-delay: 0.4s; }

.chart-card:nth-child(1) { animation-delay: 0.5s; }
.chart-card:nth-child(2) { animation-delay: 0.6s; }

/* ================= UTILITY CLASSES ================= */
.mb-30 { margin-bottom: 30px; }
.mt-20 { margin-top: 20px; }
.text-center { text-align: center; }
.text-muted { color: var(--text-muted); }
</style>
</head>

<body>
<form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
    
<div class="admin-container">
    <!-- ================= SIDEBAR ================= -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <h1>🌿 EcoTrack</h1>
            <p>Admin Control Panel</p>
        </div>

        <nav class="sidebar-nav">
            <div class="nav-section">
                <div class="nav-section-title">Admin</div>
                <a href="AdminDashboard.aspx" class="nav-item active">
                    <span class="nav-item-icon">📊</span>
                    Dashboard
                </a>
                <a href="Reports.aspx" class="nav-item">
                    <span class="nav-item-icon">📋</span>
                    Reports
                </a>
                <a href="Viewusers.aspx" class="nav-item">
                    <span class="nav-item-icon">👥</span>
                    View Users
                </a>
                <a href="ViewFeedback.aspx" class="nav-item">
                    <span class="nav-item-icon">💬</span>
                    View Feedback
                </a>
                <a href="ViewContact.aspx" class="nav-item">
                    <span class="nav-item-icon">✉️</span>
                    View Contact
                </a>
                <a href="Emissionfactor.aspx" class="nav-item">
                    <span class="nav-item-icon">🌍</span>
                    Emission Factors
                </a>
                <a href="../Home.aspx" class="nav-item">
                    <span class="nav-item-icon">🏠</span>
                    Back to Site
                </a>
                <a href="../Logout.aspx" class="nav-item">
                    <span class="nav-item-icon">🚪</span>
                    Logout
                </a>
            </div>
        </nav>
    </aside>

    <!-- ================= MAIN CONTENT ================= -->
    <main class="main-content">
        <!-- Header -->
        <div class="content-header">
            <div class="header-title">
                <h2>Dashboard Overview</h2>
                <p>Live system metrics and user activity</p>
            </div>
            <div class="header-actions">
                <asp:Button ID="btnExportCsv" runat="server" CssClass="btn btn-secondary" Text="📥 Export CSV" OnClick="ExportCsv_Click" />
                <asp:Button ID="btnRefresh" runat="server" CssClass="btn btn-primary" Text="🔄 Refresh Data" OnClick="Refresh_Click" />
            </div>
        </div>

        <!-- Filters -->
        <div class="table-card mb-30">
            <div class="table-controls">
                <div class="search-box">
                    <span class="search-icon">🗓️</span>
                    <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" />
                    <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" />
                </div>
                <div class="table-actions">
                    <asp:DropDownList ID="ddlMonth" runat="server" CssClass="btn btn-secondary" />
                    <asp:DropDownList ID="ddlYear" runat="server" CssClass="btn btn-secondary" />
                    <asp:Button ID="btnApplyFilters" runat="server" CssClass="btn btn-secondary" Text="Apply Filters" OnClick="ApplyFilters_Click" />
                    <asp:Button ID="btnClearFilters" runat="server" CssClass="btn btn-secondary" Text="Clear" OnClick="ClearFilters_Click" />
                </div>
            </div>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">👥</div>
                    <div class="stat-trend trend-up">
                        <span>↑</span> 12.5%
                    </div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Total Users</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">🧮</div>
                    <div class="stat-trend trend-up">
                        <span>↑</span> 23.4%
                    </div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblTotalCalculations" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Calculations Done</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">🌱</div>
                    <div class="stat-trend trend-down">
                        <span>↓</span> 8.2%
                    </div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblAvgFootprint" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Avg. Carbon Footprint</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">⚡</div>
                    <div class="stat-trend trend-up">
                        <span>↑</span> 15.7%
                    </div>
                </div>
                <div class="stat-value">
                    <asp:Label ID="lblActiveToday" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Active Today</div>
            </div>
        </div>

        <!-- Recent Users Table -->
        <div class="table-section">
            <div class="section-header">
                <h3 class="section-title">Recent Users</h3>
                <a href="Viewusers.aspx" class="btn btn-secondary">View All</a>
            </div>

            <div class="table-card">
                <div class="table-controls">
                    <div class="search-box">
                        <span class="search-icon">🔍</span>
                        <input type="text" placeholder="Search users by name or email...">
                    </div>
                    <div class="table-actions">
                        <span class="text-muted">Use filters above</span>
                    </div>
                </div>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Registration</th>
                            <th>Calculations</th>
                            <th>Avg. Footprint</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <asp:Repeater ID="rptRecentUsers" runat="server" OnItemCommand="rptRecentUsers_ItemCommand">
                        <HeaderTemplate>
                            <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <div class="user-cell">
                                        <div class="user-avatar"><%# Eval("Initials") %></div>
                                        <div class="user-info">
                                            <span class="user-name"><%# Eval("FullName") %></span>
                                            <span class="user-email"><%# Eval("Email") %></span>
                                        </div>
                                    </div>
                                </td>
                                <td><%# Eval("CreatedDate", "{0:MMM d, yyyy}") %></td>
                                <td><%# Eval("CalcCount") %></td>
                                <td><%# Eval("AvgFootprintText") %></td>
                                <td><span class="status-badge <%# Eval("StatusClass") %>"><%# Eval("StatusText") %></span></td>
                                <td>
                                    <div class="action-buttons">
                                        <asp:LinkButton ID="btnToggle" runat="server"
                                            CssClass="action-btn action-toggle"
                                            CommandName="ToggleStatus"
                                            CommandArgument='<%# Eval("UserID") %>'
                                            Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate" : "Activate" %>' />
                                        <asp:LinkButton ID="btnEdit" runat="server"
                                            CssClass="action-btn action-edit"
                                            CommandName="EditUser"
                                            CommandArgument='<%# Eval("UserID") %>'
                                            Text="Edit" />
                                        <asp:LinkButton ID="btnDelete" runat="server"
                                            CssClass="action-btn action-delete"
                                            CommandName="DeleteUser"
                                            CommandArgument='<%# Eval("UserID") %>'
                                            OnClientClick="return confirm('Delete this user?');"
                                            Text="Delete" />
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                        </FooterTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </div>

        

    </main>
</div>

<script>
    function refreshStats() {
        if (!window.PageMethods) return;
        PageMethods.GetLatestStats(function (result) {
            try {
                var data = JSON.parse(result);
                document.getElementById('<%= lblTotalUsers.ClientID %>').innerText = data.totalUsers;
                document.getElementById('<%= lblTotalCalculations.ClientID %>').innerText = data.totalCalculations;
                document.getElementById('<%= lblAvgFootprint.ClientID %>').innerText = data.avgFootprint;
                document.getElementById('<%= lblActiveToday.ClientID %>').innerText = data.activeToday;
            } catch (e) { }
        });
    }

    setInterval(refreshStats, 30000);

    // Search functionality
    const searchInputs = document.querySelectorAll('.search-box input');
    searchInputs.forEach(input => {
        input.addEventListener('input', function () {
            const searchTerm = this.value.toLowerCase();
            const rows = document.querySelectorAll('.data-table tbody tr');

            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    });
</script>

</form>
</body>
</html>

