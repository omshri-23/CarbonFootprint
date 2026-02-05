<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfileHR.aspx.cs" Inherits="CarbonFootprint.user.ProfileHR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>EcoTrack | Profile • History • Recommendations</title>
<style>
/* ================= ROOT ================= */
:root{
    --forest:#0f3d2e;
    --accent:#2ecc71;
    --accent-light:#a8e6cf;
    --glass:rgba(255,255,255,0.18);
    --glass-border:rgba(255,255,255,0.3);
    --text-dark:#0f3d2e;
    --text-light:#eaeaea;
}

/* ================= GLOBAL ================= */
*{box-sizing:border-box;}
body{
    margin:0;
    font-family:"Segoe UI", system-ui;
    color:#2d2d2d;
    min-height:100vh;
    background:
        radial-gradient(circle at top right, rgba(168,230,207,0.3), transparent 50%),
        radial-gradient(circle at bottom left, rgba(46,204,113,0.2), transparent 50%),
        linear-gradient(135deg, #f0fff4, #e8f5e9);
    position:relative;
}

/* Background subtle pattern */
body::before{
    content:"";
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:
        radial-gradient(circle at 20% 50%, rgba(46,204,113,0.05) 0%, transparent 50%),
        radial-gradient(circle at 80% 80%, rgba(168,230,207,0.08) 0%, transparent 50%);
    z-index:-1;
}

/* ================= HEADER ================= */
header{
    background:rgba(255,255,255,0.85);
    backdrop-filter:blur(20px);
    padding:20px 70px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    position:sticky;
    top:0;
    z-index:1000;
    border-bottom:1px solid rgba(46,204,113,0.15);
    box-shadow:0 4px 20px rgba(0,0,0,0.05);
}
header h1{
    color:var(--forest);
    font-size:24px;
    letter-spacing:1px;
    margin:0;
}
nav a{
    margin-left:26px;
    text-decoration:none;
    color:#2d2d2d;
    font-weight:500;
    position:relative;
}
nav a::after{
    content:"";
    position:absolute;
    left:0; 
    bottom:-6px;
    width:0; 
    height:2px;
    background:var(--accent);
    transition:.3s;
}
nav a:hover::after{width:100%;}
nav a:hover{color:var(--accent);}

/* ================= MAIN GLASS BOX ================= */
.container{
    max-width:900px;
    margin:70px auto;
    background:rgba(255,255,255,0.75);
    backdrop-filter:blur(30px);
    border:1px solid rgba(46,204,113,0.2);
    border-radius:30px;
    padding:50px;
    box-shadow:0 20px 60px rgba(46,204,113,0.15);
}

/* ================= TOGGLE ================= */
.toggle{
    display:flex;
    background:rgba(255,255,255,0.6);
    backdrop-filter:blur(15px);
    border-radius:50px;
    padding:6px;
    width:480px;
    margin:0 auto 50px;
    border:1px solid rgba(46,204,113,0.25);
    box-shadow:0 8px 25px rgba(46,204,113,0.1);
}
.toggle button{
    flex:1;
    border:none;
    padding:14px;
    font-weight:700;
    font-size:14px;
    border-radius:40px;
    cursor:pointer;
    background:transparent;
    color:#555;
    transition:.35s;
}
.toggle button.active{
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    color:#fff;
    box-shadow:0 8px 20px rgba(46,204,113,0.35);
}

/* ================= SECTIONS ================= */
.section{
    display:none;
    animation:fadeSlide .5s ease;
}
.section.active{display:block;}

h2{
    color:var(--forest);
    margin-bottom:25px;
    font-size:28px;
}

/* ================= PROFILE SECTION ================= */
.profile-header{
    display:flex;
    align-items:center;
    gap:30px;
    margin-bottom:35px;
    padding:30px;
    background:rgba(168,230,207,0.15);
    border-radius:20px;
    border:1px solid rgba(46,204,113,0.2);
}
.avatar{
    width:100px;
    height:100px;
    border-radius:50%;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:40px;
    color:#fff;
    box-shadow:0 10px 30px rgba(46,204,113,0.3);
}
.profile-info h3{
    color:var(--forest);
    margin:0 0 8px 0;
    font-size:26px;
}
.profile-info p{
    color:#555;
    margin:4px 0;
}

.info-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:20px;
    margin-top:25px;
}
.info-item{
    background:rgba(255,255,255,0.7);
    padding:20px;
    border-radius:15px;
    border:1px solid rgba(46,204,113,0.15);
}
.info-item label{
    display:block;
    font-weight:600;
    color:var(--forest);
    margin-bottom:8px;
    font-size:14px;
}
.info-item input{
    width:100%;
    padding:12px 14px;
    border-radius:10px;
    border:1px solid rgba(46,204,113,0.25);
    background:rgba(255,255,255,0.9);
    color:#2d2d2d;
    outline:none;
    font-size:14px;
    transition:.3s;
}
.info-item input:focus{
    border-color:#2ecc71;
    box-shadow:0 0 12px rgba(46,204,113,0.2);
}

/* ================= HISTORY SECTION ================= */
.history-list{
    display:flex;
    flex-direction:column;
    gap:15px;
}
.history-card{
    background:rgba(255,255,255,0.7);
    backdrop-filter:blur(10px);
    padding:25px;
    border-radius:18px;
    border:1px solid rgba(46,204,113,0.2);
    display:flex;
    justify-content:space-between;
    align-items:center;
    transition:.3s;
}
.history-card:hover{
    transform:translateX(8px);
    box-shadow:0 10px 30px rgba(46,204,113,0.2);
}
.history-icon{
    width:50px;
    height:50px;
    border-radius:12px;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:24px;
}
.history-details h4{
    color:var(--forest);
    margin:0 0 5px 0;
    font-size:16px;
}
.history-details p{
    color:#666;
    margin:0;
    font-size:13px;
}
.history-value{
    text-align:right;
}
.history-value .amount{
    font-size:20px;
    font-weight:700;
    color:#2ecc71;
}
.history-value .date{
    font-size:12px;
    color:#888;
}

/* ================= RECOMMENDATIONS SECTION ================= */
.rec-cards{
    display:grid;
    grid-template-columns:1fr;
    gap:20px;
}
.rec-card{
    background:rgba(255,255,255,0.7);
    backdrop-filter:blur(10px);
    padding:25px;
    border-radius:18px;
    border-left:4px solid #2ecc71;
    border:1px solid rgba(46,204,113,0.2);
    border-left:4px solid #2ecc71;
    transition:.3s;
}
.rec-card:hover{
    transform:translateY(-5px);
    box-shadow:0 12px 35px rgba(46,204,113,0.2);
}
.rec-header{
    display:flex;
    align-items:center;
    gap:15px;
    margin-bottom:12px;
}
.rec-icon{
    width:45px;
    height:45px;
    border-radius:10px;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:22px;
}
.rec-card h4{
    color:var(--forest);
    margin:0;
    font-size:18px;
}
.rec-card p{
    color:#555;
    line-height:1.6;
    margin:8px 0;
}
.impact{
    display:inline-block;
    margin-top:10px;
    padding:6px 14px;
    background:rgba(46,204,113,0.15);
    color:#2ecc71;
    border-radius:20px;
    font-size:13px;
    font-weight:600;
}

/* ================= BUTTONS ================= */
.btn{
    padding:14px 42px;
    border-radius:40px;
    border:none;
    background:linear-gradient(135deg,#2ecc71,#a8e6cf);
    color:#fff;
    font-weight:700;
    cursor:pointer;
    transition:.3s;
    box-shadow:0 10px 25px rgba(46,204,113,0.25);
    margin-top:20px;
}
.btn:hover{
    transform:translateY(-3px);
    box-shadow:0 15px 35px rgba(46,204,113,0.4);
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
<script>
    function showSection(id, btn) {
        document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
        document.querySelectorAll('.toggle button').forEach(b => b.classList.remove('active'));
        document.getElementById(id).classList.add('active');
        btn.classList.add('active');
    }
</script>
</head>
<body>
<form runat="server">
<header>
    <h1><a href="../Home.aspx" style="color:inherit; text-decoration:none;">EcoTrack</a></h1>
    <nav>
        <a href="../Home.aspx">Home</a>
        <asp:PlaceHolder ID="phUserLinks" runat="server">
            <a href="Dashboard.aspx">Dashboard</a>
            <a href="ProfileHR.aspx">Profile</a>
            <a href="ContactAF.aspx">Contact</a>
            <a href="../DigitalE.aspx">DigitalE</a>
        </asp:PlaceHolder>
        <asp:PlaceHolder ID="phAdminLinks" runat="server">
            <a href="../Admin/AdminDashboard.aspx">Admin</a>
            <a href="../Admin/Reports.aspx">Reports</a>
        </asp:PlaceHolder>
        <a href="../Logout.aspx">Logout</a>
    </nav>
</header>

<div class="container">
    <!-- TOGGLE -->
    <div class="toggle">
        <button class="active" onclick="showSection('profile',this)" type="button">Profile</button>
        <button onclick="showSection('history',this)" type="button">History</button>
        <button onclick="showSection('recommendations',this)" type="button">Recommendations</button>
    </div>

    <!-- PROFILE SECTION -->
    <div id="profile" class="section active">
        <div class="profile-header">
            <div class="avatar">👤</div>
            <div class="profile-info">
                <h3><asp:Label ID="lblProfileName" runat="server" Text="" /></h3>
                <p>📧 <asp:Label ID="lblProfileEmail" runat="server" Text="" /></p>
                <p>📅 Member since: <asp:Label ID="lblMemberSince" runat="server" Text="" /></p>
            </div>
        </div>

        <h2>Personal Information</h2>
        <div class="info-grid">
            <div class="info-item">
                <label>Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" Placeholder="Enter your name" />
            </div>
            <div class="info-item">
                <label>Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" Placeholder="your@email.com" />
            </div>
            <div class="info-item">
                <label>Phone Number</label>
                <asp:TextBox ID="txtPhone" runat="server" Placeholder="+91 XXXXX XXXXX" />
            </div>
            <div class="info-item">
                <label>Location</label>
                <asp:TextBox ID="txtLocation" runat="server" Placeholder="City, Country" />
            </div>
        </div>
        <asp:Button ID="btnSaveProfile" runat="server" CssClass="btn" Text="Save Changes" OnClick="SaveProfile_Click" />
        <asp:Label ID="lblProfileStatus" runat="server" />
    </div>

    <!-- HISTORY SECTION -->
    <div id="history" class="section">
        <h2>Your Carbon History</h2>
        <asp:Repeater ID="rptHistory" runat="server">
            <HeaderTemplate>
                <div class="history-list">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="history-card">
                    <div style="display:flex; align-items:center; gap:20px;">
                        <div class="history-icon"><%# Eval("Icon") %></div>
                        <div class="history-details">
                            <h4><%# Eval("Title") %></h4>
                            <p><%# Eval("Description") %></p>
                        </div>
                    </div>
                    <div class="history-value">
                        <div class="amount"><%# Eval("AmountText") %></div>
                        <div class="date"><%# Eval("DateText") %></div>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Label ID="lblHistoryEmpty" runat="server" Text="No history yet." />
    </div>

    <!-- RECOMMENDATIONS SECTION -->
    <div id="recommendations" class="section">
        <h2>Personalized Recommendations</h2>
        <asp:Repeater ID="rptRecommendations" runat="server">
            <HeaderTemplate>
                <div class="rec-cards">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="rec-card">
                    <div class="rec-header">
                        <div class="rec-icon"><%# Eval("Icon") %></div>
                        <h4><%# Eval("Title") %></h4>
                    </div>
                    <p><%# Eval("Text") %></p>
                    <span class="impact"><%# Eval("ImpactText") %></span>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Label ID="lblRecEmpty" runat="server" Text="No recommendations yet." />
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
</script></form>
</body>
</html>

