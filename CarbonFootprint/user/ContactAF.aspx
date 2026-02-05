<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactAF.aspx.cs" Inherits="CarbonFootprint.user.ContactAF" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>EcoTrack | About • Contact • Feedback</title>
<style>
/* ================= ROOT ================= */
:root{
    --forest:#0f3d2e;
    --accent:#2ecc71;
    --glass:rgba(255,255,255,0.15);
    --glass-border:rgba(255,255,255,0.25);
    --text:#eafaf3;
}

/* ================= GLOBAL ================= */
*{box-sizing:border-box;}
body{
    margin:0;
    font-family:"Segoe UI", system-ui;
    color:#eaeaea;
    min-height:100vh;
    background:
        radial-gradient(circle at top, rgba(46,204,113,0.15), transparent 40%),
        linear-gradient(135deg,#0f3d2e,#000);
    /* background:
     url("image/bg.jpg"); /* <-- your image path */
 /* background-size: cover;
 background-position: center;
 background-repeat: no-repeat;
 background-attachment: fixed; */
    position:relative;
}

/* Background image overlay */
body::before{
    content:"";
    position:fixed;
    top:0;
    left:0;
    width:100%;
    height:100%;
    background:url('images/bg.jpg') center/cover no-repeat fixed;
    opacity:0.3;
    z-index:-1;
}

/* ================= HEADER ================= */
header{
    background:rgba(0,0,0,0.55);
    backdrop-filter:blur(14px);
    padding:20px 70px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    position:sticky;
    top:0;
    z-index:1000;
    border-bottom:1px solid rgba(255,255,255,0.15);
}
header h1{
    color:#fff;
    font-size:24px;
    letter-spacing:1px;
    margin:0;
}
nav a{
    margin-left:26px;
    text-decoration:none;
    color:#e0e0e0;
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
nav a:hover{color:#fff;}

/* ================= MAIN GLASS BOX ================= */
.container{
    max-width:900px;
    margin:70px auto;
    background:rgba(255,255,255,0.12);
    backdrop-filter:blur(30px);
    border:1px solid rgba(255,255,255,.25);
    border-radius:30px;
    padding:50px;
    box-shadow:0 30px 90px rgba(0,0,0,.5);
}

/* ================= TOGGLE ================= */
.toggle{
    display:flex;
    background:rgba(255,255,255,.2);
    backdrop-filter:blur(15px);
    border-radius:50px;
    padding:6px;
    width:420px;
    margin:0 auto 50px;
    border:1px solid rgba(255,255,255,.3);
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
    color:rgba(255,255,255,0.7);
    transition:.35s;
}
.toggle button.active{
    background:rgba(46,204,113,0.9);
    color:#fff;
    box-shadow:0 8px 25px rgba(46,204,113,.4);
}

/* ================= SECTIONS ================= */
.section{
    display:none;
    animation:fadeSlide .5s ease;
}
.section.active{display:block;}

h2{
    color:#2ecc71;
    margin-bottom:20px;
    font-size:28px;
}
p{
    line-height:1.8;
    color:#e6f2ec;
    margin-bottom:15px;
}

/* ================= FORMS ================= */
.form-group{
    margin-bottom:20px;
}
label{
    display:block;
    margin-bottom:8px;
    color:#d4f1e3;
    font-weight:600;
}
input,textarea{
    width:100%;
    padding:14px 16px;
    border-radius:12px;
    border:1px solid rgba(255,255,255,.25);
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(10px);
    color:#fff;
    outline:none;
    font-size:14px;
    transition:.3s;
}
input:focus,textarea:focus{
    border-color:#2ecc71;
    background:rgba(255,255,255,0.12);
    box-shadow:0 0 15px rgba(46,204,113,.3);
}
input::placeholder,textarea::placeholder{
    color:rgba(255,255,255,0.4);
}
textarea{resize:none;height:120px;}

.btn{
    margin-top:10px;
    padding:14px 42px;
    border-radius:40px;
    border:none;
    background:linear-gradient(135deg,#2ecc71,#1abc9c);
    color:#000;
    font-weight:700;
    cursor:pointer;
    transition:.3s;
    box-shadow:0 10px 30px rgba(46,204,113,.3);
}
.btn:hover{
    transform:translateY(-3px);
    box-shadow:0 15px 40px rgba(46,204,113,.5);
}

/* ================= CTA SECTION ================= */
.cta{
    max-width:900px;
    margin:60px auto 80px;
    padding:60px 70px;
    border-radius:30px;
    text-align:center;
    background:rgba(255,255,255,0.12);
    backdrop-filter:blur(30px);
    border:1px solid rgba(255,255,255,0.25);
    box-shadow:0 30px 90px rgba(0,0,0,0.4);
    animation:ctaFloat 6s ease-in-out infinite;
}
.cta h2{
    font-size:36px;
    color:#2ecc71;
    margin-bottom:15px;
}
.cta p{
    font-size:17px;
    color:#d4f1e3;
    max-width:600px;
    margin:0 auto 30px;
}
.cta a{
    display:inline-block;
    padding:16px 50px;
    border-radius:50px;
    font-size:16px;
    font-weight:800;
    background:linear-gradient(135deg,#2ecc71,#1abc9c);
    color:#000;
    text-decoration:none;
    box-shadow:0 15px 40px rgba(46,204,113,0.4);
    transition:all .4s ease;
}
.cta a:hover{
    transform:translateY(-4px) scale(1.03);
    box-shadow:0 25px 60px rgba(46,204,113,0.6);
}

@keyframes ctaFloat{
    0%,100%{transform:translateY(0);}
    50%{transform:translateY(-8px);}
}

/* ================= FOOTER ================= */
footer{
    background:rgba(0,0,0,0.85);
    backdrop-filter:blur(14px);
    padding:70px 80px 30px;
    border-top:1px solid rgba(255,255,255,0.15);
}
.footer-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:40px;
}
footer h4{
    color:#fff;
    margin-bottom:15px;
    font-size:16px;
}
footer h4::before{
    content:"➤ ";
    color:var(--accent);
}
footer a{
    display:block;
    color:#bfbfbf;
    text-decoration:none;
    margin-bottom:8px;
    transition:.3s;
}
footer a:hover{
    color:var(--accent);
    transform:translateX(6px);
}
footer p{
    color:#9adfc1;
    font-size:14px;
    margin:5px 0;
}
.footer-bottom{
    margin-top:35px;
    padding-top:20px;
    text-align:center;
    font-size:13px;
    color:#888;
    border-top:1px solid rgba(255,255,255,0.1);
}

/* ================= ANIMATION ================= */
@keyframes fadeSlide{
    from{opacity:0;transform:translateY(20px);}
    to{opacity:1;transform:translateY(0);}
}

/* ================= RATING CIRCLES ================= */
.rating-container{
    display:flex;
    justify-content:center;
    gap:20px;
    margin:20px 0;
}

.rating-circle{
    width:70px;
    height:70px;
    border-radius:50%;
    border:3px solid rgba(255,255,255,0.3);
    position:relative;
    cursor:pointer;
    overflow:hidden;
    transition:.4s;
    background:rgba(255,255,255,0.05);
}

.rating-circle:hover{
    transform:translateY(-5px);
    border-color:rgba(46,204,113,0.6);
}

.rating-circle .water{
    position:absolute;
    bottom:0;
    left:0;
    width:100%;
    height:0%;
    background:linear-gradient(180deg, rgba(46,204,113,0.3), rgba(46,204,113,0.8));
    transition:.5s ease;
    border-radius:50%;
}

.rating-circle.active .water{
    animation:waterRise 0.6s ease-out forwards;
}

.rating-circle .rating-num{
    position:absolute;
    top:50%;
    left:50%;
    transform:translate(-50%,-50%);
    font-size:22px;
    font-weight:800;
    color:rgba(255,255,255,0.5);
    z-index:2;
    transition:.3s;
}

.rating-circle.active .rating-num{
    color:#fff;
    text-shadow:0 2px 10px rgba(0,0,0,0.3);
}

.rating-circle.active{
    border-color:#2ecc71;
    box-shadow:0 8px 25px rgba(46,204,113,0.5);
}

@keyframes waterRise{
    0%{height:0%;}
    100%{height:100%;}
}
</style>
<script>
    function showSection(id, btn) {
        document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
        document.querySelectorAll('.toggle button').forEach(b => b.classList.remove('active'));
        document.getElementById(id).classList.add('active');
        btn.classList.add('active');
    }

    function setRating(rating) {
        // Remove active class from all circles
        document.querySelectorAll('.rating-circle').forEach(circle => {
            circle.classList.remove('active');
        });

        // Add active class to selected circle and all before it
        for (let i = 1; i <= rating; i++) {
            const circle = document.querySelector(`.rating-circle[data-rating="${i}"]`);
            if (circle) {
                circle.classList.add('active');
            }
        }

        // Store the rating value
        document.getElementById('<%= hdnRating.ClientID %>').value = rating;
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
        <button class="active" onclick="showSection('about',this)" type="button">About</button>
        <button onclick="showSection('contact',this)" type="button">Contact</button>
        <button onclick="showSection('feedback',this)" type="button">Feedback</button>
    </div>

    <!-- ABOUT -->
    <div id="about" class="section active">
        <h2>About EcoTrack</h2>
        <p>
            EcoTrack is a smart carbon footprint management platform designed to help
            individuals and organizations measure, analyze, and reduce environmental
            impact using real‑world data and verified emission factors.
        </p>
        <p>
            Our mission is to make sustainability actionable, measurable, and visual
            — empowering users to build greener habits every day.
        </p>
    </div>

    <!-- CONTACT -->
    <div id="contact" class="section">
        <h2>Contact Us</h2>
        <div class="form-group">
            <label>Full Name</label>
            <asp:TextBox ID="txtContactName" runat="server" Placeholder="John Doe" />
        </div>
        <div class="form-group">
            <label>Email Address</label>
            <asp:TextBox ID="txtContactEmail" runat="server" TextMode="Email" Placeholder="you@example.com" />
        </div>
        <div class="form-group">
            <label>Subject</label>
            <asp:TextBox ID="txtContactSubject" runat="server" Placeholder="Subject" />
        </div>
        <div class="form-group">
            <label>Message</label>
            <asp:TextBox ID="txtContactMessage" runat="server" TextMode="MultiLine" Placeholder="Write your message..." />
        </div>
        <asp:Button ID="btnContactSubmit" runat="server" CssClass="btn" Text="Send Message" OnClick="ContactSubmit_Click" />
        <asp:Label ID="lblContactStatus" runat="server" />
    </div>

    <!-- FEEDBACK -->
    <div id="feedback" class="section">
        <h2>Feedback</h2>
        <div class="form-group">
            <label>Subject</label>
            <asp:TextBox ID="txtFeedbackSubject" runat="server" Placeholder="Feedback subject" />
        </div>
        <div class="form-group">
            <label>Your Experience</label>
            <asp:TextBox ID="txtFeedbackMessage" runat="server" TextMode="MultiLine" Placeholder="Share your feedback..." />
        </div>
        <div class="form-group">
            <label>Feedback Type</label>
            <asp:DropDownList ID="ddlFeedbackType" runat="server">
                <asp:ListItem>General</asp:ListItem>
                <asp:ListItem>Bug Report</asp:ListItem>
                <asp:ListItem>Feature Request</asp:ListItem>
                <asp:ListItem>Complaint</asp:ListItem>
                <asp:ListItem>Appreciation</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="form-group">
            <label>Rate Your Experience</label>
            <div class="rating-container">
                <div class="rating-circle" data-rating="1" onclick="setRating(1)">
                    <div class="water"></div>
                    <span class="rating-num">1</span>
                </div>
                <div class="rating-circle" data-rating="2" onclick="setRating(2)">
                    <div class="water"></div>
                    <span class="rating-num">2</span>
                </div>
                <div class="rating-circle" data-rating="3" onclick="setRating(3)">
                    <div class="water"></div>
                    <span class="rating-num">3</span>
                </div>
                <div class="rating-circle" data-rating="4" onclick="setRating(4)">
                    <div class="water"></div>
                    <span class="rating-num">4</span>
                </div>
                <div class="rating-circle" data-rating="5" onclick="setRating(5)">
                    <div class="water"></div>
                    <span class="rating-num">5</span>
                </div>
            </div>
            <asp:HiddenField ID="hdnRating" runat="server" Value="0" />
        </div>
        <asp:Button ID="btnFeedbackSubmit" runat="server" CssClass="btn" Text="Submit Feedback" OnClick="FeedbackSubmit_Click" />
        <asp:Label ID="lblFeedbackStatus" runat="server" />
    </div>
</div>

<section class="cta">
    <h2>Every Action Counts 🌍</h2>
    <p>Start measuring today and reduce tomorrow.</p>
    <a href="CalculationAI.aspx">Calculate Now</a>
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
</body>
</html>
