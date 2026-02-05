<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="CarbonFootprint.user.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard | EcoTrack</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        /* ================= ROOT ================= */
        :root {
            --forest: #0f3d2e;
            --accent: #2ecc71;
            --accent-light: #a8e6cf;
            --glass: rgba(255, 255, 255, 0.18);
            --glass-border: rgba(255, 255, 255, 0.3);
            --text-dark: #0f3d2e;
            --text-light: #eaeaea;
        }

        /* ================= GLOBAL ================= */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: "Segoe UI", system-ui, -apple-system, sans-serif;
            color: #2d2d2d;
            min-height: 100vh;
            background:
                radial-gradient(circle at top right, rgba(168, 230, 207, 0.3), transparent 50%),
                radial-gradient(circle at bottom left, rgba(46, 204, 113, 0.2), transparent 50%),
                linear-gradient(135deg, #f0fff4, #e8f5e9);
            position: relative;
        }

        /* Background subtle pattern */
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                radial-gradient(circle at 20% 50%, rgba(46, 204, 113, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(168, 230, 207, 0.08) 0%, transparent 50%);
            z-index: -1;
        }

        /* ================= HEADER ================= */
        header {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(20px);
            padding: 20px 70px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(46, 204, 113, 0.15);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        header h1 {
            color: var(--forest);
            font-size: 24px;
            letter-spacing: 1px;
            margin: 0;
        }

        nav {
            display: flex;
            gap: 26px;
        }

        nav a {
            text-decoration: none;
            color: #2d2d2d;
            font-weight: 500;
            position: relative;
            transition: color 0.3s;
        }

        nav a::after {
            content: "";
            position: absolute;
            left: 0;
            bottom: -6px;
            width: 0;
            height: 2px;
            background: var(--accent);
            transition: width 0.3s;
        }

        nav a:hover::after {
            width: 100%;
        }

        nav a:hover {
            color: var(--accent);
        }

        /* ================= DASHBOARD WRAPPER ================= */
        .dashboard {
            padding: 50px 70px;
            max-width: 1600px;
            margin: 0 auto;
        }

        .dashboard-header {
            margin-bottom: 40px;
        }

        .dashboard h2 {
            font-size: 38px;
            color: var(--forest);
            margin-bottom: 8px;
            font-weight: 700;
        }

        .subtitle {
            color: #666;
            font-size: 16px;
        }

        /* ================= PROFILE SNAPSHOT ================= */
        .profile-snapshot {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(30px);
            border: 1px solid rgba(46, 204, 113, 0.2);
            border-radius: 20px;
            padding: 25px 35px;
            margin-bottom: 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 10px 35px rgba(46, 204, 113, 0.1);
            transition: all 0.3s ease;
        }

        .profile-snapshot:hover {
            box-shadow: 0 15px 45px rgba(46, 204, 113, 0.15);
            transform: translateY(-3px);
        }

        .profile-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .profile-avatar {
            width: 55px;
            height: 55px;
            background: linear-gradient(135deg, #2ecc71, #a8e6cf);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            box-shadow: 0 8px 20px rgba(46, 204, 113, 0.3);
        }

        .profile-details h4 {
            font-size: 18px;
            margin-bottom: 5px;
            color: var(--forest);
        }

        .profile-details p {
            font-size: 13px;
            color: #666;
        }

        .profile-link {
            background: linear-gradient(135deg, #2ecc71, #a8e6cf);
            padding: 11px 26px;
            border-radius: 25px;
            text-decoration: none;
            color: #ffffff;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 6px 18px rgba(46, 204, 113, 0.25);
        }

        .profile-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(46, 204, 113, 0.35);
        }

        /* ================= SUMMARY CARDS ================= */
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .summary-card {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(46, 204, 113, 0.2);
            border-radius: 20px;
            padding: 30px;
            position: relative;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 10px 35px rgba(46, 204, 113, 0.1);
        }

        .summary-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(46, 204, 113, 0.2);
            border-color: rgba(46, 204, 113, 0.35);
        }

        .summary-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #2ecc71, #a8e6cf);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .summary-card:hover::before {
            transform: scaleX(1);
        }

        .summary-icon {
            font-size: 42px;
            margin-bottom: 15px;
            display: block;
        }

        .summary-card h3 {
            font-size: 15px;
            color: #666;
            margin-bottom: 6px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .summary-card p {
            font-size: 13px;
            color: #888;
            margin-bottom: 15px;
        }

        .value {
            font-size: 32px;
            font-weight: 700;
            color: var(--forest);
            display: flex;
            align-items: baseline;
            gap: 8px;
        }

        .value-unit {
            font-size: 14px;
            color: #666;
            font-weight: 400;
        }

        .trend {
            font-size: 14px;
            margin-top: 10px;
            display: flex;
            align-items: center;
            gap: 6px;
            font-weight: 600;
        }

        .trend.positive {
            color: #2ecc71;
        }

        .trend.negative {
            color: #e74c3c;
        }

        /* ================= TOTAL FOOTPRINT BOX ================= */
        .total-box {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(30px);
            border: 2px solid rgba(46, 204, 113, 0.25);
            border-radius: 24px;
            padding: 50px;
            margin-bottom: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: 0 15px 50px rgba(46, 204, 113, 0.15);
        }

        .total-box::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(46, 204, 113, 0.08), rgba(168, 230, 207, 0.08));
            z-index: 0;
        }

        .total-box > * {
            position: relative;
            z-index: 1;
        }

        .total-box h3 {
            font-size: 18px;
            margin-bottom: 15px;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: 600;
        }

        .total-value {
            font-size: 56px;
            font-weight: 800;
            color: var(--forest);
            margin-bottom: 15px;
            display: flex;
            align-items: baseline;
            justify-content: center;
            gap: 10px;
        }

        .total-value .unit {
            font-size: 24px;
            opacity: 0.7;
            font-weight: 600;
        }

        .eco-score {
            display: inline-block;
            padding: 10px 24px;
            background: rgba(46, 204, 113, 0.15);
            border: 1px solid rgba(46, 204, 113, 0.3);
            border-radius: 25px;
            font-size: 14px;
            font-weight: 700;
            margin-top: 15px;
            color: #2ecc71;
        }

        /* ================= PERSONALIZED INSIGHT ================= */
        .insight-box {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(46, 204, 113, 0.25);
            border-left: 4px solid #2ecc71;
            border-radius: 18px;
            padding: 25px 35px;
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            gap: 20px;
            box-shadow: 0 10px 35px rgba(46, 204, 113, 0.1);
            transition: all 0.3s ease;
        }

        .insight-box:hover {
            transform: translateX(8px);
            box-shadow: 0 12px 40px rgba(46, 204, 113, 0.15);
        }

        .insight-icon {
            font-size: 38px;
            flex-shrink: 0;
        }

        .insight-text h4 {
            font-size: 16px;
            margin-bottom: 8px;
            color: #2ecc71;
            font-weight: 700;
        }

        .insight-text p {
            font-size: 14px;
            color: #555;
            line-height: 1.5;
        }

        /* ================= QUICK ACTIONS ================= */
        .section-title {
            font-size: 24px;
            margin-bottom: 22px;
            color: var(--forest);
            font-weight: 700;
        }

        .actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 50px;
        }

        .action-btn {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(46, 204, 113, 0.2);
            border-radius: 18px;
            padding: 32px 24px;
            text-align: center;
            text-decoration: none;
            color: var(--forest);
            font-weight: 700;
            font-size: 15px;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
            box-shadow: 0 8px 25px rgba(46, 204, 113, 0.1);
        }

        .action-btn:hover {
            background: rgba(255, 255, 255, 0.95);
            border-color: rgba(46, 204, 113, 0.4);
            transform: scale(1.05);
            box-shadow: 0 12px 35px rgba(46, 204, 113, 0.2);
        }

        .action-icon {
            font-size: 34px;
        }

        /* ================= DASHBOARD GRID ================= */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 1.3fr 1fr;
            gap: 25px;
            margin-bottom: 40px;
        }

        .chart-container,
        .activity {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(46, 204, 113, 0.2);
            padding: 32px;
            border-radius: 20px;
            box-shadow: 0 10px 35px rgba(46, 204, 113, 0.1);
        }

        .chart-container h3,
        .activity h3 {
            margin-bottom: 25px;
            color: var(--forest);
            font-size: 20px;
            font-weight: 700;
        }

        #emissionChart {
            max-height: 270px;
        }

        .activity ul {
            list-style: none;
        }

        .activity ul li {
            padding: 16px 0;
            border-bottom: 1px solid rgba(46, 204, 113, 0.15);
            color: #555;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: all 0.3s ease;
        }

        .activity ul li:hover {
            color: #2ecc71;
            transform: translateX(8px);
        }

        .activity ul li:last-child {
            border-bottom: none;
        }

        .activity ul li span:first-child {
            color: #2ecc71;
            font-size: 16px;
        }

/* ================= FOOTER (NO BLANK SPACE) ================= */
footer{
    position:relative;
    background:linear-gradient(180deg, rgba(10,20,15,0.95) 0%, rgba(5,15,10,1) 100%);
    backdrop-filter:blur(20px);
    padding:70px 80px 30px;
    border-top:2px solid rgba(46,204,113,0.5);
    margin-top:0;
    box-shadow:0 -10px 50px rgba(0,0,0,0.8);
}

footer::before{
    content:"";
    position:absolute;
    bottom:0;
    left:0;
    right:0;
    height:0;
    background:linear-gradient(180deg, transparent, rgba(46,204,113,0.12));
    transition:height 1.5s ease;
    z-index:0;
}

footer.in-view::before{
    height:100%;
}

.footer-content{
    position:relative;
    z-index:1;
}

.footer-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:50px;
    margin-bottom:40px;
}

.footer-column{
    opacity:0;
    transform:translateY(40px);
    transition:all 0.8s ease;
}

footer.in-view .footer-column{
    opacity:1;
    transform:translateY(0);
}

footer.in-view .footer-column:nth-child(1){transition-delay:0.1s;}
footer.in-view .footer-column:nth-child(2){transition-delay:0.25s;}
footer.in-view .footer-column:nth-child(3){transition-delay:0.4s;}
footer.in-view .footer-column:nth-child(4){transition-delay:0.55s;}

footer h4{
    color:var(--accent);
    margin-bottom:20px;
    font-size:18px;
    text-transform:uppercase;
    letter-spacing:1.5px;
    position:relative;
    padding-bottom:15px;
}

footer h4::after{
    content:"";
    position:absolute;
    left:0;
    bottom:0;
    width:50px;
    height:3px;
    background:linear-gradient(90deg, var(--accent), transparent);
    transition:width 0.5s ease;
}

.footer-column:hover h4::after{
    width:100px;
}

footer a{
    display:block;
    color:#bbb;
    text-decoration:none;
    margin-bottom:12px;
    transition:all .3s;
    padding-left:0;
    position:relative;
    font-size:15px;
}

footer a::before{
    content:"→";
    position:absolute;
    left:-25px;
    opacity:0;
    color:var(--accent);
    transition:all .3s;
    font-weight:bold;
}

footer a:hover{
    color:var(--accent);
    padding-left:30px;
    text-shadow:0 0 8px rgba(46,204,113,0.4);
}

footer a:hover::before{
    left:0;
    opacity:1;
}

footer p{
    color:#999;
    font-size:14px;
    margin:10px 0;
    line-height:1.8;
}

.footer-social{
    display:flex;
    gap:15px;
    margin-top:25px;
    flex-wrap:wrap;
}

.footer-social a{
    width:45px;
    height:45px;
    display:flex;
    align-items:center;
    justify-content:center;
    background:rgba(46,204,113,0.15);
    border:2px solid rgba(46,204,113,0.4);
    border-radius:50%;
    color:var(--accent);
    transition:all .4s;
    margin-bottom:0;
    padding:0;
    font-size:18px;
    font-weight:bold;
}

.footer-social a::before{
    display:none;
}

.footer-social a:hover{
    background:var(--accent);
    color:#0f3d2e;
    transform:translateY(-8px) rotate(360deg);
    box-shadow:0 8px 25px rgba(46,204,113,0.6);
    padding:0;
}

.footer-newsletter{
    margin-top:25px;
}

.footer-newsletter p{
    color:var(--accent);
    font-weight:600;
    font-size:15px;
    margin-bottom:15px;
}

.newsletter-form{
    display:flex;
    gap:10px;
    margin-top:15px;
}

.newsletter-form input{
    flex:1;
    padding:14px 18px;
    background:rgba(255,255,255,0.08);
    border:1px solid rgba(255,255,255,0.25);
    border-radius:10px;
    color:#fff;
    font-size:14px;
    transition:all .3s;
}

.newsletter-form input::placeholder{
    color:#888;
}

.newsletter-form input:focus{
    outline:none;
    border-color:var(--accent);
    background:rgba(255,255,255,0.12);
    box-shadow:0 0 15px rgba(46,204,113,0.3);
}

.newsletter-form button{
    padding:14px 28px;
    background:linear-gradient(135deg,var(--accent),var(--blue));
    border:none;
    border-radius:10px;
    color:#fff;
    font-weight:600;
    cursor:pointer;
    transition:all .3s;
    font-size:14px;
}

.newsletter-form button:hover{
    transform:translateY(-3px);
    box-shadow:0 8px 25px rgba(46,204,113,0.5);
}

.footer-bottom{
    margin-top:50px;
    padding-top:30px;
    text-align:center;
    font-size:14px;
    color:#888;
    border-top:1px solid rgba(46,204,113,0.3);
    opacity:0;
    transform:translateY(30px);
    transition:all 1s ease 0.7s;
}

footer.in-view .footer-bottom{
    opacity:1;
    transform:translateY(0);
}

.footer-bottom p{
    margin:8px 0;
    color:#888;
}

.footer-links{
    margin-top:12px;
}

.footer-links a{
    color:#999;
    margin:0 12px;
    font-size:13px;
    display:inline;
    padding:0;
}

.footer-links a:hover{
    color:var(--accent);
    padding:0;
}

.footer-links a::before{
    display:none;
}

/* ================= ANIMATIONS ================= */
@keyframes fadeUp{
    from{opacity:0;transform:translateY(40px);}
    to{opacity:1;transform:translateY(0);}
}

    /* ================= ANIMATIONS ================= */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ================= RESPONSIVE ================= */
        @media(max-width: 1024px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        @media(max-width: 768px) {
            header,
            .dashboard {
                padding-left: 30px;
                padding-right: 30px;
            }

            nav {
                gap: 15px;
            }

            nav a {
                font-size: 14px;
            }

            .dashboard h2 {
                font-size: 30px;
            }

            .summary-grid {
                grid-template-columns: 1fr;
            }

            .profile-snapshot {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .total-value {
                font-size: 42px;
            }

            footer {
                padding: 50px 30px 20px;
            }
        }
    </style>
</head>

<body>
<form runat="server">

<!-- ================= HEADER ================= -->
<header>
    <h1><a href="../Home.aspx" style="color:inherit; text-decoration:none;">🌱 EcoTrack</a></h1>
    <nav>
        <a href="../Home.aspx">Home</a>
        <a href="Dashboard.aspx">Dashboard</a>
        <a href="ProfileHR.aspx">Profile</a>
        <a href="ContactAF.aspx">Contact</a>
        <a href="../DigitalE.aspx">DigitalE</a>
        <a href="../Logout.aspx">Logout</a>
    </nav>
</header>

<!-- ================= DASHBOARD ================= -->
<div class="dashboard">
    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h2>Dashboard</h2>
        <p class="subtitle">Overview of your carbon footprint activities</p>
    </div>

    <!-- Profile Snapshot -->
    <div class="profile-snapshot">
        <div class="profile-info">
            <div class="profile-avatar">👤</div>
            <div class="profile-details">
                <h4><asp:Label ID="lblUserName" runat="server" Text="" /></h4>
                <p>📧 <asp:Label ID="lblEmail" runat="server" Text="" /> • Last login: <asp:Label ID="lblLastLogin" runat="server" Text="" /></p>
            </div>
        </div>
        <a href="ProfileHR.aspx" class="profile-link">View Full Profile</a>
    </div>

    <!-- Summary Cards -->
    <div class="summary-grid">
        <!-- Today's Carbon -->
        <div class="summary-card">
            <span class="summary-icon">🌍</span>
            <h3>Today's Carbon</h3>
            <p>Current day emissions</p>
            <div class="value">
                <asp:Label ID="lblTodayCarbon" runat="server" Text="0" />
                <span class="value-unit">kg CO₂</span>
            </div>
        </div>

        <!-- This Month -->
        <div class="summary-card">
            <span class="summary-icon">📅</span>
            <h3>This Month</h3>
            <p>Monthly total emissions</p>
            <div class="value">
                <asp:Label ID="lblMonthCarbon" runat="server" Text="0" />
                <span class="value-unit">kg CO₂</span>
            </div>
            <div class="trend positive">
                ↓ <asp:Label ID="lblMonthTrend" runat="server" Text="" />
            </div>
        </div>

        <!-- Change vs Last Month -->
        <div class="summary-card">
            <span class="summary-icon">📉</span>
            <h3>Monthly Change</h3>
            <p>Compared to last month</p>
            <div class="value">
                <asp:Label ID="lblMonthChange" runat="server" Text="0" />
                <span class="value-unit">%</span>
            </div>
            <div class="trend positive">
                Great progress! 🎯
            </div>
        </div>

        <!-- Eco Score -->
        <div class="summary-card">
            <span class="summary-icon">🌱</span>
            <h3>Eco Score</h3>
            <p>Your environmental rating</p>
            <div class="value">
                <asp:Label ID="lblEcoScore" runat="server" Text="" />
            </div>
            <div class="trend positive">
                Keep it up! 💚
            </div>
        </div>
    </div>

    <!-- Total Footprint -->
    <div class="total-box">
        <h3>Total Carbon Footprint</h3>
        <div class="total-value">
            <asp:Label ID="lblTotalFootprint" runat="server" Text="0" />
            <span class="unit">kg CO₂/month</span>
        </div>
        <div class="eco-score">
            🌿 <asp:Label ID="lblEcoRating" runat="server" Text="" />
        </div>
    </div>

    <!-- Personalized Insight -->
    <div class="insight-box">
        <div class="insight-icon">💡</div>
        <div class="insight-text">
            <h4>Personalized Tip</h4>
            <p><asp:Label ID="lblInsight" runat="server" Text="" /></p>
        </div>
    </div>

    <!-- Quick Actions -->
    <h3 class="section-title">Quick Actions</h3>
    <div class="actions">
        <a href="CalculationAI.aspx" class="action-btn">
            <span class="action-icon">⚡</span>
            Calculate Electricity
        </a>
        <a href="CalculationAI.aspx" class="action-btn">
            <span class="action-icon">🚗</span>
            Calculate Travel
        </a>
        <a href="CalculationAI.aspx" class="action-btn">
            <span class="action-icon">🍽️</span>
            Calculate Food
        </a>
        <a href="../DigitalE.aspx" class="action-btn">
            <span class="action-icon">💻</span>
            Calculate Digital
        </a>
    </div>

    <!-- Mini Chart & Recent Activity -->
    <div class="dashboard-grid">
        <!-- Chart -->
        <div class="chart-container">
            <h3>Last 7 Days Emissions</h3>
            <canvas id="emissionChart"></canvas>
        </div>

        <!-- Recent Activity -->
        <div class="activity">
            <h3>Recent Activity</h3>
            <ul>
                <li>
                    <span>✔</span>
                    <span>Electricity calculation updated - 45 kg CO₂</span>
                </li>
                <li>
                    <span>✔</span>
                    <span>Travel footprint calculated - 32 kg CO₂</span>
                </li>
                <li>
                    <span>✔</span>
                    <span>Food habits analyzed - 28 kg CO₂</span>
                </li>
                <li>
                    <span>✔</span>
                    <span>Digital usage recorded - 12 kg CO₂</span>
                </li>
                <li>
                    <span>✔</span>
                    <span>Monthly report generated</span>
                </li>
            </ul>
        </div>
    </div>
</div>

<footer>
    <div class="footer-content">
        <div class="footer-grid">
            <div class="footer-column">
                <h4>🌿 ECOTRACK</h4>
                <p>Your comprehensive carbon footprint management system dedicated to creating a sustainable future.</p>
                <p style="margin-top:15px;">Making sustainability measurable, actionable, and achievable for everyone.</p>
                <div class="footer-social">
                    <a href="#" title="Facebook">f</a>
                    <a href="#" title="Twitter">𝕏</a>
                    <a href="#" title="Instagram">📷</a>
                    <a href="#" title="LinkedIn">in</a>
                </div>
            </div>
            
            <div class="footer-column">
                <h4>QUICK LINKS</h4>
                <a href="../Home.aspx">Home</a>
                <a href="../Login.aspx">Sign Up</a>
                <a href="ContactAF.aspx">About Us</a>
                <a href="ProfileHR.aspx">Download Reports</a>
            </div>
            
            <div class="footer-column">
                <h4>RESOURCES</h4>
                 <a href="ContactAF.aspx">Contact US</a>
                 <a href="ContactAF.aspx">Send Feedback</a>
                <a href="Guide.aspx">Carbon Reduction Tips</a>
                <a href="Guide.aspx">Green Living Guide</a>
                
            </div>
            
            <div class="footer-column">
                <h4>CONTACT US</h4>
                <p>📧 info@ecotrack.com</p>
                <p>📞 +91 98765 43210</p>
                
                <p>📍 Mumbai, Maharashtra, India</p>
                <p>🕐 Mon-Fri: 9:00 AM - 6:00 PM IST</p>
                
                <div class="footer-newsletter">
                    <p>Subscribe to Our Newsletter</p>
                    <div class="newsletter-form">
                        <input type="email" placeholder="Enter your email" />
                        <button type="button">Subscribe</button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p>© 2026 EcoTrack - Sustainable Future Initiative | All Rights Reserved</p>
            <div class="footer-links">
                <a href="#">Privacy Policy</a> | 
                <a href="#">Terms of Service</a> | 
                <a href="#">Cookie Policy</a> | 
                <a href="#">Disclaimer</a>
            </div>
        </div>
    </div>
</footer>

<script type="text/javascript">
  

    // Footer reveal animation on scroll
    window.addEventListener('scroll', function () {
        var footer = document.querySelector('footer');
        if (footer) {
            var footerTop = footer.getBoundingClientRect().top;
            var windowHeight = window.innerHeight;

            if (footerTop < windowHeight * 1.2) {
                footer.classList.add('in-view');
            }
        }
    });

    // Check footer visibility on page load
    window.addEventListener('load', function () {
        var footer = document.querySelector('footer');
        if (footer) {
            var footerTop = footer.getBoundingClientRect().top;
            var windowHeight = window.innerHeight;

            if (footerTop < windowHeight * 1.2) {
                footer.classList.add('in-view');
            }
        }
    });
</script>

</form>

<!-- Chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
<script>
    // Mini Emission Chart
    const ctx = document.getElementById('emissionChart').getContext('2d');
    const emissionChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                label: 'Emissions (kg CO₂)',
                data: [45, 52, 38, 65, 48, 55, 42], // Replace with server-side data
                borderColor: '#2ecc71',
                backgroundColor: 'rgba(46, 204, 113, 0.1)',
                borderWidth: 3,
                tension: 0.4,
                fill: true,
                pointBackgroundColor: '#2ecc71',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 6,
                pointHoverRadius: 8
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    backgroundColor: 'rgba(15, 61, 46, 0.9)',
                    padding: 12,
                    titleColor: '#fff',
                    bodyColor: '#a8e6cf',
                    borderColor: '#2ecc71',
                    borderWidth: 1
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(46, 204, 113, 0.1)',
                        drawBorder: false
                    },
                    ticks: {
                        color: '#666',
                        font: {
                            size: 12,
                            weight: '500'
                        }
                    }
                },
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: '#666',
                        font: {
                            size: 12,
                            weight: '500'
                        }
                    }
                }
            }
        }
    });
</script>
</body>
</html>
