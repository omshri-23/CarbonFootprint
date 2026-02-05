<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="CarbonFootprint.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>EcoTrack | Carbon Footprint Management</title>

<style>
/* ================= ROOT ================= */
:root{
    --forest:#0f3d2e;
    --forest-soft:#1f6f54;
    --accent:#2ecc71;
    --accent-light:#a8e6cf;
    --blue:#4facfe;
    --glass:rgba(255,255,255,0.12);
    --glass-light:rgba(255,255,255,0.55);
    --glass-border:rgba(255,255,255,0.35);
    --text-dark:#0f3d2e;
    --text-light:#eaeaea;
}

/* ================= GLOBAL ================= */
*{box-sizing:border-box;}
html{
    scroll-behavior: smooth;
}
body{
    margin:0;
    padding:0;
    font-family:"Segoe UI",system-ui;
    color:#e8e8e8;
    min-height:100vh;
    position:relative;
    /*/background:
        radial-gradient(circle at top right, rgba(15,61,46,0.6), transparent 50%),
        radial-gradient(circle at bottom left, rgba(46,204,113,0.4), transparent 50%),
        linear-gradient(135deg, #1a1a1a, #0d2818);*/
     background:
     url("images/bg.jpg"); /* <-- your image path */
 background-size: cover;
 background-position: center;
 background-repeat: no-repeat;
 background-attachment: fixed;
}

body::before{
    content:"";
    position:fixed;
    top:0; left:0;
    width:100%; height:100%;
    background-image: url('images/home-bg2.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    filter: blur(8px);
    opacity: 0.3;
    z-index:-2;
}

body::after{
    content:"";
    position:fixed;
    top:0; left:0;
    width:100%; height:100%;
    background:
        radial-gradient(circle at 20% 50%, rgba(46,204,113,0.08) 0%, transparent 50%),
        radial-gradient(circle at 80% 80%, rgba(168,230,207,0.05) 0%, transparent 50%);
    z-index:-1;
}

/* ================= HEADER ================= */
header{
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(25px) saturate(180%);
    -webkit-backdrop-filter:blur(25px) saturate(180%);
    padding:20px 70px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    position:sticky;
    top:0;
    z-index:1000;
    border:1px solid rgba(255,255,255,0.18);
    border-left:none;
    border-right:none;
    box-shadow:0 8px 32px rgba(0,0,0,0.1);
}

header h1{
    color:var(--accent);
    font-size:24px;
    letter-spacing:1px;
    margin:0;
    text-shadow:0 2px 10px rgba(46,204,113,0.3);
}

/* Navigation */
nav{
    display:flex;
    align-items:center;
    gap:26px;
}

nav > a{
    text-decoration:none;
    color:#e8e8e8;
    font-weight:500;
    position:relative;
    transition:.3s;
}

nav > a::after{
    content:"";
    position:absolute;
    left:0; bottom:-6px;
    width:0; height:2px;
    background:var(--accent);
    transition:.3s;
}

nav > a:hover::after{width:100%;}
nav > a:hover{color:var(--accent);text-shadow:0 0 10px rgba(46,204,113,0.5);}

/* Dropdown Container */
.dropdown{
    position:relative;
    display:inline-block;
}

.dropdown-toggle{
    background:rgba(46,204,113,0.15);
    border:2px solid rgba(46,204,113,0.4);
    color:#e8e8e8;
    font-size:15px;
    cursor:pointer;
    padding:8px 14px;
    font-family:"Segoe UI",system-ui;
    display:flex;
    align-items:center;
    justify-content:center;
    position:relative;
    transition:.3s;
    border-radius:8px;
}

.dropdown-toggle:hover{
    color:var(--accent);
    background:rgba(46,204,113,0.25);
    border-color:var(--accent);
    box-shadow:0 0 15px rgba(46,204,113,0.3);
}

.dropdown-arrow{
    display:none;
}

.dropdown.active .dropdown-arrow{
    transform:rotate(180deg);
}

.dropdown-menu{
    position:absolute;
    top:calc(100% + 10px);
    right:0;
    background:rgba(15,30,25,0.98);
    backdrop-filter:blur(25px) saturate(180%);
    -webkit-backdrop-filter:blur(25px) saturate(180%);
    border:2px solid rgba(46,204,113,0.5);
    border-radius:12px;
    min-width:220px;
    padding:8px 0;
    opacity:0;
    visibility:hidden;
    transform:translateY(-10px);
    transition:all .3s ease;
    box-shadow:0 15px 40px rgba(0,0,0,0.7);
}

.dropdown.active .dropdown-menu{
    opacity:1;
    visibility:visible;
    transform:translateY(0);
}

.dropdown:hover .dropdown-menu{
    opacity:1;
    visibility:visible;
    transform:translateY(0);
}

.dropdown-menu a{
    display:block;
    padding:14px 20px;
    color:#e8e8e8;
    text-decoration:none;
    transition:.3s;
    border-left:3px solid transparent;
    font-size:15px;
}

.dropdown-menu a:hover{
    background:rgba(46,204,113,0.25);
    color:var(--accent);
    border-left-color:var(--accent);
    padding-left:26px;
}

.dropdown-menu a i{
    margin-right:10px;
    font-style:normal;
    font-size:16px;
}

/* ================= HERO ================= */
.hero{
    min-height:85vh;
    display:flex;
    align-items:center;
    padding:0 80px;
}

.hero-content{
    max-width:720px;
    animation:fadeUp 1.2s ease;
}

.hero-content h2{
    font-size:52px;
    line-height:1.1;
    color:#fff;
}

.hero-content span{color:var(--accent);}

.hero-content p{
    font-size:18px;
    color:#dddddd;
    line-height:1.7;
    margin-top:20px;
}

.hero-actions{
    margin-top:30px;
}

.hero-actions a{
    display:inline-block;
    margin-right:15px;
    padding:14px 36px;
    border-radius:30px;
    text-decoration:none;
    font-weight:600;
    transition:.3s;
}

.btn-primary{
    background:linear-gradient(135deg,var(--accent),var(--blue));
    color:#fff;
    box-shadow:0 10px 25px rgba(46,204,113,0.3);
}

.btn-outline{
    border:2px solid rgba(255,255,255,0.3);
    color:#fff;
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(10px);
}

.btn-primary:hover{
    opacity:.9;
    transform:translateY(-3px);
    box-shadow:0 15px 35px rgba(46,204,113,0.5);
}

.btn-outline:hover{
    background:rgba(255,255,255,0.15);
    border-color:var(--accent);
}

/* ================= STATS ================= */
.stats{
    padding:70px 80px;
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:30px;
}

.stat{
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(25px) saturate(180%);
    -webkit-backdrop-filter:blur(25px) saturate(180%);
    border:1px solid rgba(255,255,255,0.18);
    border-radius:22px;
    padding:38px 25px;
    text-align:center;
    box-shadow:0 20px 50px rgba(0,0,0,0.45);
    transition:.45s;
}

.stat:hover{
    transform:translateY(-10px);
    box-shadow:0 35px 70px rgba(46,204,113,0.45);
    border-color:rgba(46,204,113,0.4);
}

.stat i{font-size:42px;}
.stat h3{font-size:38px;color:var(--accent);margin:10px 0;}
.stat p{color:#d0d0d0;}

/* ================= FEATURES ================= */
.features-section{
    padding:80px 80px;
    text-align:center;
}

.features-section h3{
    font-size:36px;
    margin-bottom:10px;
    color:#fff;
}

.features-section .subtitle{
    color:#cccccc;
    max-width:700px;
    margin:0 auto 40px;
}

.features-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:30px;
}

.feature-card{
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(25px) saturate(180%);
    -webkit-backdrop-filter:blur(25px) saturate(180%);
    border:1px solid rgba(255,255,255,0.18);
    border-radius:24px;
    padding:35px 30px;
    text-align:left;
    box-shadow:0 20px 50px rgba(0,0,0,0.4);
    transition:.45s;
}

.feature-card:hover{
    transform:translateY(-10px);
    border-color:rgba(46,204,113,0.4);
    box-shadow:0 25px 60px rgba(46,204,113,0.3);
}

.feature-icon{font-size:40px;margin-bottom:12px;}

.feature-card h4{
    color:var(--accent);
    margin-bottom:8px;
}

.feature-card p{color:#dddddd;font-size:15px;line-height:1.6;}

/* ================= CALCULATORS ================= */
.calc-section{
    padding:70px 80px;
    background:rgba(255,255,255,0.03);
    backdrop-filter:blur(22px);
    border-top:1px solid rgba(255,255,255,0.15);
}

.calc-section h2{
    text-align:center;
    font-size:36px;
    color:#fff;
    margin-bottom:45px;
}

.calc-cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:30px;
}

.calc-card{
    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(28px) saturate(180%);
    -webkit-backdrop-filter:blur(28px) saturate(180%);
    border:1px solid rgba(255,255,255,0.18);
    border-radius:26px;
    padding:35px;
    color:#fff;
    box-shadow:0 25px 60px rgba(0,0,0,0.12);
    transition:.45s;
    text-align:center;
    font-size:20px;
    font-weight:600;
}

.calc-card:hover{
    transform:translateY(-12px);
    box-shadow:0 40px 90px rgba(46,204,113,0.35);
    border-color:rgba(46,204,113,0.4);
}

.calc-card a{
    display:inline-block;
    margin-top:15px;
    font-weight:700;
    color:var(--accent);
    text-decoration:none;
    font-size:16px;
    transition:.3s;
}

.calc-card a:hover{
    color:var(--accent-light);
    text-shadow:0 0 10px rgba(46,204,113,0.5);
}

/* ================= CTA ================= */
.cta{
    padding:90px 40px;
    text-align:center;
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(24px);
    border-top:1px solid rgba(255,255,255,0.15);
}

.cta h2{
    font-size:38px;
    color:#fff;
}

.cta p{
    font-size:18px;
    color:#ccc;
    margin-top:15px;
}

.cta a{
    margin-top:28px;
    display:inline-block;
    padding:16px 46px;
    border-radius:40px;
    background:linear-gradient(135deg,var(--accent),var(--blue));
    color:#fff;
    text-decoration:none;
    font-weight:700;
    box-shadow:0 20px 45px rgba(79,172,254,0.5);
    transition:.4s;
}

.cta a:hover{
    transform:translateY(-6px);
    box-shadow:0 30px 70px rgba(79,172,254,0.7);
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

/* ================= RESPONSIVE ================= */
@media(max-width:768px){
    header{padding:15px 25px;}
    
    nav{
        gap:15px;
    }
    
    .hero{padding:0 25px;}
    .hero-content h2{font-size:38px;}
    
    .stats{
        padding:40px 25px;
        grid-template-columns:repeat(2,1fr);
    }
    
    .features-section{padding:50px 25px;}
    .calc-section{padding:50px 25px;}
    .cta{padding:60px 25px;}
    
    footer{
        padding:50px 25px 25px;
    }
    
    .footer-grid{
        grid-template-columns:1fr;
        gap:35px;
    }
    
    .dropdown-menu{
        right:-20px;
    }
}
</style>
</head>

<body>
<form id="form1" runat="server">

<header>
    <h1>🌿 EcoTrack</h1>
    <nav>
        <a href="Home.aspx">Home</a>
        
        <asp:PlaceHolder ID="phAnonLinks" runat="server">
            <a href="Login.aspx">Login / Signup</a>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="phAuthLinks" runat="server" Visible="false">
            <div class="dropdown">
                <button class="dropdown-toggle" type="button" onclick="toggleDropdown(event)">
                    Menu
                </button>
                <div class="dropdown-menu">
                    <a href="user/ProfileHR.aspx"><i>👤</i> Profile</a>
                    <a href="user/CalculationAI.aspx"><i>📊</i> Calculator</a>
                    <a href="user/Dashboard.aspx"><i>📈</i> Dashboard</a>
                    <a href="user/ContactAF.aspx"><i>📧</i> Contact</a>
                    <a href="DigitalE.aspx"><i>📚</i> Digital</a>
                    <a href="Logout.aspx"><i>🚪</i> Logout</a>
                </div>
            </div>
        </asp:PlaceHolder>
    </nav>
</header>

<section class="hero">
    <div class="hero-content">
        <h2>Track Your <span>Carbon Footprint</span><br>Build a Greener Future</h2>
        <p>Understand how daily activities impact the environment and take smarter actions towards sustainability.</p>
        <div class="hero-actions">
            <a href="user/CalculationAI.aspx" class="btn-primary">Start Calculating</a>
            <a href="Login.aspx" class="btn-outline">Join EcoTrack</a>
        </div>
    </div>
</section>

<section class="stats">
    <div class="stat">
        <i>🌱</i>
        <h3><asp:Label ID="lblTotalFactors" runat="server" Text="0"></asp:Label>+</h3>
        <p>Emission Factors</p>
    </div>
    <div class="stat">
        <i>📊</i>
        <h3>100%</h3>
        <p>Accurate Analysis</p>
    </div>
    <div class="stat">
        <i>👥</i>
        <h3><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>+</h3>
        <p>Active Users</p>
    </div>
    <div class="stat">
        <i>🌍</i>
        <h3><asp:Label ID="lblTotalCalculations" runat="server" Text="0"></asp:Label>+</h3>
        <p>Calculations Done</p>
    </div>
</section>

<section class="features-section">
    <h3>What We Measure</h3>
    <p class="subtitle">Everyday activities that directly impact the environment</p>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">🚗</div>
            <h4>Transportation</h4>
            <p>Track emissions from cars, bikes, buses, trains, and flights with accurate emission factors.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">⚡</div>
            <h4>Energy Usage</h4>
            <p>Monitor electricity consumption and fuel-based emissions from your daily energy usage.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">♻️</div>
            <h4>Waste Management</h4>
            <p>Calculate emissions from waste disposal, recycling, and composting activities.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🍽️</div>
            <h4>Food Habits</h4>
            <p>Measure your diet's carbon footprint based on food choices and consumption patterns.</p>
        </div>
    </div>
</section>

<section class="calc-section">
    <h2>Carbon Calculators</h2>
    <div class="calc-cards">
        <div class="calc-card">
            ⚡ Electricity
            <br><a href="user/CalculationAI.aspx">Calculate →</a>
        </div>
        <div class="calc-card">
            🚗 Transportation
            <br><a href="user/CalculationAI.aspx">Calculate →</a>
        </div>
        <div class="calc-card">
            🍽️ Food
            <br><a href="user/CalculationAI.aspx">Calculate →</a>
        </div>
        <div class="calc-card">
            ♻️ Waste
            <br><a href="user/CalculationAI.aspx">Calculate →</a>
        </div>
    </div>
</section>

<section class="cta">
    <h2>Every Action Counts 🌍</h2>
    <p>Start measuring today and reduce tomorrow. Join thousands making a difference.</p>
    <a href="user/DigitalE.aspx">Calculate Now</a>
</section>

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
                <a href="Home.aspx">Home</a>
                <a href="Login.aspx">Sign Up</a>
                <a href="user/ContactAF.aspx">About Us</a>
                <a href="user/ProfileHR.aspx">Download Reports</a>
            </div>
            
            <div class="footer-column">
                <h4>RESOURCES</h4>
                 <a href="user/ContactAF.aspx">Contact US</a>
                 <a href="user/ContactAF.aspx">Send Feedback</a>
                <a href="user/Guide.aspx">Carbon Reduction Tips</a>
                <a href="user/Guide.aspx">Green Living Guide</a>
                
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
    // Dropdown Menu Toggle
    function toggleDropdown(event) {
        event.preventDefault();
        event.stopPropagation();

        var dropdown = event.target.closest('.dropdown');
        if (dropdown) {
            dropdown.classList.toggle('active');
        }
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function (event) {
        var dropdowns = document.querySelectorAll('.dropdown');
        dropdowns.forEach(function (dropdown) {
            if (!dropdown.contains(event.target)) {
                dropdown.classList.remove('active');
            }
        });
    });

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
</body>
</html>
