<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Guide.aspx.cs" Inherits="CarbonFootprint.user.Guide" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>EcoTrack | Tips • Guide • Recommendations</title>
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
    max-width:1100px;
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
    width:100%;
    max-width:650px;
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

/* ================= TIPS CARDS ================= */
.tips-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(300px, 1fr));
    gap:25px;
}

.tip-card{
    background:rgba(255,255,255,0.7);
    backdrop-filter:blur(10px);
    padding:30px;
    border-radius:18px;
    border:1px solid rgba(46,204,113,0.2);
    transition:.3s;
    position:relative;
    overflow:hidden;
}

.tip-card::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:5px;
    height:100%;
    background:linear-gradient(180deg, #2ecc71, #a8e6cf);
    transform:scaleY(0);
    transition:.3s;
}

.tip-card:hover::before{
    transform:scaleY(1);
}

.tip-card:hover{
    transform:translateY(-8px);
    box-shadow:0 15px 40px rgba(46,204,113,0.25);
}

.tip-icon{
    width:60px;
    height:60px;
    border-radius:15px;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:28px;
    margin-bottom:20px;
    box-shadow:0 8px 20px rgba(46,204,113,0.3);
}

.tip-card h3{
    color:var(--forest);
    margin-bottom:12px;
    font-size:20px;
}

.tip-card p{
    color:#555;
    line-height:1.7;
    margin-bottom:15px;
    font-size:14px;
}

.impact-badge{
    display:inline-block;
    padding:8px 16px;
    background:rgba(46,204,113,0.15);
    color:#2ecc71;
    border-radius:20px;
    font-size:12px;
    font-weight:700;
    margin-top:10px;
}

/* ================= GUIDE SECTION ================= */
.guide-content{
    display:flex;
    flex-direction:column;
    gap:30px;
}

.guide-category{
    background:rgba(255,255,255,0.7);
    backdrop-filter:blur(10px);
    padding:35px;
    border-radius:20px;
    border:1px solid rgba(46,204,113,0.2);
    border-left:5px solid #2ecc71;
    transition:.3s;
}

.guide-category:hover{
    transform:translateX(10px);
    box-shadow:0 12px 35px rgba(46,204,113,0.2);
}

.guide-header{
    display:flex;
    align-items:center;
    gap:20px;
    margin-bottom:20px;
}

.guide-icon{
    width:65px;
    height:65px;
    border-radius:15px;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:32px;
    box-shadow:0 8px 20px rgba(46,204,113,0.3);
}

.guide-category h3{
    color:var(--forest);
    font-size:24px;
    margin:0;
}

.guide-category h4{
    color:#2ecc71;
    font-size:18px;
    margin:25px 0 15px 0;
}

.guide-category ul{
    list-style:none;
    padding:0;
}

.guide-category ul li{
    padding:12px 0;
    padding-left:30px;
    color:#555;
    line-height:1.7;
    position:relative;
    border-bottom:1px solid rgba(46,204,113,0.1);
}

.guide-category ul li:last-child{
    border-bottom:none;
}

.guide-category ul li::before{
    content:"✓";
    position:absolute;
    left:0;
    color:#2ecc71;
    font-weight:bold;
    font-size:18px;
}

/* ================= RECOMMENDATIONS ================= */
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

/* ================= FOOTER ================= */
footer{
    position:relative;
    background:linear-gradient(180deg, rgba(10,20,15,0.95) 0%, rgba(5,15,10,1) 100%);
    backdrop-filter:blur(20px);
    padding:70px 80px 30px;
    border-top:2px solid rgba(46,204,113,0.5);
    margin-top:80px;
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
    background:linear-gradient(135deg,var(--accent),#a8e6cf);
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

/* ================= ANIMATION ================= */
@keyframes fadeSlide{
    from{opacity:0;transform:translateY(20px);}
    to{opacity:1;transform:translateY(0);}
}

/* ================= RESPONSIVE ================= */
@media(max-width:768px){
    header{padding:15px 25px;}
    .container{padding:30px 25px;margin:40px 20px;}
    .toggle{flex-direction:column;width:100%;padding:8px;}
    .toggle button{margin:4px 0;}
    .tips-grid{grid-template-columns:1fr;}
    footer{padding:50px 25px 25px;}
    .footer-grid{grid-template-columns:1fr;gap:35px;}
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

<div class="container">
    <!-- TOGGLE -->
    <div class="toggle">
        <button class="active" onclick="showSection('tips',this)" type="button">Carbon Reduction Tips</button>
        <button onclick="showSection('guide',this)" type="button">Green Living Guide</button>
        <button onclick="showSection('recommendations',this)" type="button">Recommendations</button>
    </div>

    <!-- CARBON REDUCTION TIPS SECTION -->
    <div id="tips" class="section active">
        <h2>🌍 Carbon Reduction Tips</h2>
        <div class="tips-grid">
            <div class="tip-card">
                <div class="tip-icon">💡</div>
                <h3>Switch to LED Lighting</h3>
                <p>Replace all incandescent bulbs with LED alternatives. LEDs use 75% less energy and last 25 times longer, dramatically reducing both energy consumption and waste.</p>
                <span class="impact-badge">Save ~18 kg CO₂/month</span>
            </div>

            <div class="tip-card">
                <div class="tip-icon">🚴</div>
                <h3>Choose Active Transportation</h3>
                <p>Walk, bike, or use public transport for short trips. Just 2-3 days a week can reduce your carbon footprint by 40% while improving your health.</p>
                <span class="impact-badge">Save ~25 kg CO₂/month</span>
            </div>

            <div class="tip-card">
                <div class="tip-icon">🌡️</div>
                <h3>Optimize Home Temperature</h3>
                <p>Adjust your thermostat by 2°C in winter (lower) and summer (higher). Use programmable thermostats to automatically reduce energy when you're away.</p>
                <span class="impact-badge">Save ~22 kg CO₂/month</span>
            </div>

            <div class="tip-card">
                <div class="tip-icon">🥗</div>
                <h3>Eat More Plant-Based Meals</h3>
                <p>Reduce meat consumption, especially red meat. Try "Meatless Mondays" or replace one meat meal per day with plant-based alternatives.</p>
                <span class="impact-badge">Save ~15 kg CO₂/month</span>
            </div>

            <div class="tip-card">
                <div class="tip-icon">💧</div>
                <h3>Reduce Water Waste</h3>
                <p>Fix leaky faucets, take shorter showers, and install low-flow fixtures. Heating water accounts for 18% of home energy use.</p>
                <span class="impact-badge">Save ~12 kg CO₂/month</span>
            </div>

            <div class="tip-card">
                <div class="tip-icon">🔌</div>
                <h3>Unplug Idle Electronics</h3>
                <p>Phantom power from devices on standby mode wastes significant energy. Use power strips to completely disconnect devices when not in use.</p>
                <span class="impact-badge">Save ~8 kg CO₂/month</span>
            </div>
        </div>
    </div>

    <!-- GREEN LIVING GUIDE SECTION -->
    <div id="guide" class="section">
        <h2>🌿 Green Living Guide</h2>
        <div class="guide-content">
            
            <div class="guide-category">
                <div class="guide-header">
                    <div class="guide-icon">🏠</div>
                    <h3>Sustainable Home Living</h3>
                </div>
                <h4>Energy Efficiency</h4>
                <ul>
                    <li>Install solar panels or explore community solar programs</li>
                    <li>Upgrade to Energy Star certified appliances</li>
                    <li>Improve home insulation to reduce heating/cooling needs</li>
                    <li>Use natural lighting during daytime hours</li>
                    <li>Install smart thermostats for automated temperature control</li>
                </ul>
                <h4>Water Conservation</h4>
                <ul>
                    <li>Collect rainwater for garden irrigation</li>
                    <li>Install dual-flush toilets to reduce water usage</li>
                    <li>Use washing machines only with full loads</li>
                    <li>Choose native, drought-resistant plants for landscaping</li>
                </ul>
            </div>

            <div class="guide-category">
                <div class="guide-header">
                    <div class="guide-icon">🛒</div>
                    <h3>Conscious Consumption</h3>
                </div>
                <h4>Shopping Habits</h4>
                <ul>
                    <li>Buy local and seasonal produce to reduce transportation emissions</li>
                    <li>Choose products with minimal or recyclable packaging</li>
                    <li>Support brands with strong sustainability commitments</li>
                    <li>Avoid single-use plastics and bring reusable bags</li>
                    <li>Consider second-hand options for clothing and furniture</li>
                </ul>
                <h4>Food Choices</h4>
                <ul>
                    <li>Reduce food waste by planning meals and proper storage</li>
                    <li>Compost organic waste to reduce landfill methane</li>
                    <li>Choose organic and sustainably farmed products</li>
                    <li>Grow your own herbs and vegetables if possible</li>
                </ul>
            </div>

            <div class="guide-category">
                <div class="guide-header">
                    <div class="guide-icon">🚗</div>
                    <h3>Eco-Friendly Transportation</h3>
                </div>
                <h4>Daily Commute</h4>
                <ul>
                    <li>Use public transportation, carpool, or bike when possible</li>
                    <li>Consider electric or hybrid vehicles for your next car</li>
                    <li>Maintain proper tire pressure for better fuel efficiency</li>
                    <li>Combine errands into single trips to reduce driving</li>
                    <li>Work from home when possible to eliminate commute emissions</li>
                </ul>
                <h4>Travel Smart</h4>
                <ul>
                    <li>Choose direct flights when flying is necessary</li>
                    <li>Offset your carbon emissions through certified programs</li>
                    <li>Explore local destinations to reduce travel distance</li>
                    <li>Use trains instead of planes for shorter distances</li>
                </ul>
            </div>

            <div class="guide-category">
                <div class="guide-header">
                    <div class="guide-icon">♻️</div>
                    <h3>Waste Reduction & Recycling</h3>
                </div>
                <h4>Reduce & Reuse</h4>
                <ul>
                    <li>Adopt a zero-waste mindset: refuse, reduce, reuse, recycle</li>
                    <li>Use reusable water bottles, coffee cups, and food containers</li>
                    <li>Repair items instead of replacing them when possible</li>
                    <li>Donate or sell items you no longer need</li>
                    <li>Choose durable, long-lasting products over disposable ones</li>
                </ul>
                <h4>Proper Recycling</h4>
                <ul>
                    <li>Learn your local recycling guidelines and follow them carefully</li>
                    <li>Clean containers before recycling to prevent contamination</li>
                    <li>Recycle electronics, batteries, and hazardous materials properly</li>
                    <li>Compost food scraps and yard waste</li>
                </ul>
            </div>

        </div>
    </div>

    <!-- RECOMMENDATIONS SECTION -->
    <div id="recommendations" class="section">
        <h2>💡 Personalized Recommendations</h2>
        <div class="rec-cards">
            <div class="rec-card">
                <div class="rec-header">
                    <div class="rec-icon">💡</div>
                    <h4>Switch to LED Bulbs</h4>
                </div>
                <p>Replace traditional bulbs with energy-efficient LEDs to reduce electricity consumption by up to 75%. This simple change can significantly lower your monthly carbon footprint.</p>
                <span class="impact">Save ~18 kg CO₂/month</span>
            </div>

            <div class="rec-card">
                <div class="rec-header">
                    <div class="rec-icon">🚴</div>
                    <h4>Use Public Transport</h4>
                </div>
                <p>Consider using public transportation or carpooling 2-3 days a week. This can reduce your transportation emissions by nearly 40% while also saving on fuel costs.</p>
                <span class="impact">Save ~25 kg CO₂/month</span>
            </div>

            <div class="rec-card">
                <div class="rec-header">
                    <div class="rec-icon">🥗</div>
                    <h4>Reduce Meat Consumption</h4>
                </div>
                <p>Try implementing "Meatless Mondays" or reducing red meat intake. Plant-based meals have a significantly lower carbon footprint than meat-heavy diets.</p>
                <span class="impact">Save ~15 kg CO₂/month</span>
            </div>

            <div class="rec-card">
                <div class="rec-header">
                    <div class="rec-icon">♻️</div>
                    <h4>Start Composting</h4>
                </div>
                <p>Begin composting organic waste at home. This reduces methane emissions from landfills and creates nutrient-rich soil for your garden.</p>
                <span class="impact">Save ~8 kg CO₂/month</span>
            </div>

            <div class="rec-card">
                <div class="rec-header">
                    <div class="rec-icon">🌡️</div>
                    <h4>Optimize Thermostat Settings</h4>
                </div>
                <p>Adjust your home temperature by 2°C and use a programmable thermostat. Small temperature changes can lead to significant energy savings throughout the year.</p>
                <span class="impact">Save ~22 kg CO₂/month</span>
            </div>

            <div class="rec-card">
                <div class="rec-header">
                    <div class="rec-icon">☀️</div>
                    <h4>Consider Solar Energy</h4>
                </div>
                <p>Explore solar panel installation or community solar programs. Renewable energy can dramatically reduce your household carbon emissions while providing long-term savings.</p>
                <span class="impact">Save ~150 kg CO₂/month</span>
            </div>
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
</script></form>
</body>
</html>
