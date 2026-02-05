<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DigitalE.aspx.cs" Inherits="CarbonFootprint.DigitalE" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>EcoTrack | Digital Carbon Footprint</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
<style>
/* ================= ROOT ================= */
:root{
    --forest:#0f3d2e;
    --accent:#2ecc71;
    --accent-light:#a8e6cf;
    --glass:rgba(255,255,255,0.18);
    --glass-border:rgba(255,255,255,0.3);a
}

/* ================= GLOBAL ================= */
*{box-sizing:border-box;}
body{
    margin:0;
    font-family:"Segoe UI", system-ui;
    color:#e8e8e8;
    min-height:100vh;
    position:relative;
    background:
        radial-gradient(circle at top right, rgba(15,61,46,0.6), transparent 50%),
        radial-gradient(circle at bottom left, rgba(46,204,113,0.4), transparent 50%),
        linear-gradient(135deg, #1a1a1a, #0d2818);
}

body::before{
    content:"";
    position:fixed;
    top:0; left:0;
    width:100%; height:100%;
    background-image: url('images/digital-bg.jpg');
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
nav a{
    margin-left:26px;
    text-decoration:none;
    color:#e8e8e8;
    font-weight:500;
    position:relative;
    transition:.3s;
}
nav a::after{
    content:"";
    position:absolute;
    left:0; bottom:-6px;
    width:0; height:2px;
    background:var(--accent);
    transition:.3s;
}
nav a:hover::after{width:100%;}
nav a:hover{color:var(--accent);text-shadow:0 0 10px rgba(46,204,113,0.5);}

/* ================= MAIN CONTAINER ================= */
.container{
    max-width:1200px;
    margin:70px auto;
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(30px) saturate(180%);
    -webkit-backdrop-filter:blur(30px) saturate(180%);
    border:1px solid rgba(255,255,255,0.18);
    border-radius:30px;
    padding:50px;
    box-shadow:0 20px 60px rgba(0,0,0,0.4), inset 0 1px 0 rgba(255,255,255,0.1);
}

h2{
    color:var(--accent);
    margin-bottom:15px;
    font-size:32px;
    display:flex;
    align-items:center;
    gap:15px;
}

.subtitle{
    color:rgba(255,255,255,0.6);
    margin-bottom:40px;
    font-size:16px;
}

/* ================= STATS CARDS ================= */
.stats-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(250px, 1fr));
    gap:25px;
    margin-bottom:50px;
}

.stat-card{
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(20px);
    padding:25px;
    border-radius:20px;
    border:1px solid rgba(255,255,255,0.15);
    text-align:center;
    transition:.3s;
    box-shadow:0 8px 32px rgba(0,0,0,0.1);
}

.stat-card:hover{
    transform:translateY(-5px);
    border-color:rgba(46,204,113,0.5);
    box-shadow:0 12px 40px rgba(46,204,113,0.2);
}

.stat-icon{
    font-size:48px;
    margin-bottom:15px;
}

.stat-card h3{
    color:#fff;
    font-size:16px;
    margin:0 0 10px 0;
}

.stat-value{
    font-size:36px;
    font-weight:900;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
    background-clip:text;
}

.stat-unit{
    font-size:14px;
    color:rgba(255,255,255,0.6);
    margin-top:5px;
}

/* ================= INPUT SECTIONS ================= */
.input-section{
    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(20px);
    padding:35px;
    border-radius:20px;
    border:1px solid rgba(255,255,255,0.18);
    margin-bottom:30px;
    box-shadow:0 8px 32px rgba(0,0,0,0.1);
}

.input-section h3{
    color:#fff;
    font-size:22px;
    margin:0 0 25px 0;
    display:flex;
    align-items:center;
    gap:12px;
}

.section-icon{
    width:50px;
    height:50px;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    border-radius:12px;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:24px;
}

.form-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(280px, 1fr));
    gap:20px;
}

.form-group{
    margin-bottom:0;
}

.form-group label{
    display:block;
    color:#fff;
    font-weight:600;
    margin-bottom:10px;
    font-size:14px;
}

.form-group input, .form-group select{
    width:100%;
    padding:14px 16px;
    border-radius:12px;
    border:1px solid rgba(255,255,255,0.2);
    background:rgba(255,255,255,0.08);
    color:#fff;
    outline:none;
    font-size:14px;
    transition:.3s;
    font-family:"Segoe UI", system-ui;
}

.form-group select{
    appearance:none;
    cursor:pointer;
    background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%232ecc71' d='M1.41 0L6 4.59L10.59 0L12 1.42l-6 6l-6-6z'/%3E%3C/svg%3E");
    background-repeat:no-repeat;
    background-position:right 16px center;
    padding-right:45px;
}

.form-group input:focus, .form-group select:focus{
    border-color:#2ecc71;
    box-shadow:0 0 0 3px rgba(46,204,113,0.2);
}

.form-group input::placeholder{
    color:rgba(255,255,255,0.3);
}

/* Time input special styling */
.time-input-group{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:15px;
}

.time-input-group input{
    text-align:center;
}

/* ================= RESULT SECTION ================= */
.result-container{
    background:linear-gradient(135deg, rgba(46,204,113,0.15), rgba(168,230,207,0.15));
    backdrop-filter:blur(20px);
    padding:40px;
    border-radius:20px;
    border:2px solid rgba(46,204,113,0.5);
    margin:40px 0;
    text-align:center;
    box-shadow:0 8px 32px rgba(46,204,113,0.2);
}

.result-container h3{
    color:#fff;
    margin:0 0 20px 0;
    font-size:24px;
}

.total-emission{
    font-size:64px;
    font-weight:900;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
    background-clip:text;
    margin:10px 0;
}

.emission-breakdown{
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(200px, 1fr));
    gap:20px;
    margin-top:30px;
}

.breakdown-item{
    background:rgba(255,255,255,0.08);
    padding:20px;
    border-radius:15px;
    border:1px solid rgba(255,255,255,0.15);
}

.breakdown-item h4{
    color:rgba(255,255,255,0.8);
    font-size:14px;
    margin:0 0 10px 0;
}

.breakdown-value{
    font-size:28px;
    font-weight:700;
    color:#2ecc71;
}

/* ================= CHART SECTION ================= */
.chart-container{
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(20px);
    padding:35px;
    border-radius:20px;
    border:1px solid rgba(255,255,255,0.18);
    margin-top:40px;
    box-shadow:0 8px 32px rgba(0,0,0,0.1);
}

.chart-container h3{
    color:#fff;
    margin:0 0 25px 0;
    font-size:22px;
}

/* ================= TIPS SECTION ================= */
.tips-container{
    background:rgba(16,185,129,0.1);
    backdrop-filter:blur(15px);
    padding:30px;
    border-radius:20px;
    border:1px solid rgba(16,185,129,0.3);
    margin-top:40px;
}

.tips-container h3{
    color:#10b981;
    margin:0 0 20px 0;
    display:flex;
    align-items:center;
    gap:10px;
}

.tips-list{
    list-style:none;
    padding:0;
    margin:0;
}

.tips-list li{
    padding:12px 0 12px 35px;
    color:rgba(255,255,255,0.8);
    position:relative;
    border-bottom:1px solid rgba(255,255,255,0.1);
}

.tips-list li:last-child{
    border-bottom:none;
}

.tips-list li::before{
    content:"💡";
    position:absolute;
    left:0;
    font-size:20px;
}

/* ================= BUTTONS ================= */
.btn{
    padding:16px 48px;
    border-radius:50px;
    border:none;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    color:#fff;
    font-weight:700;
    cursor:pointer;
    transition:.3s;
    box-shadow:0 10px 30px rgba(46,204,113,0.4);
    font-size:16px;
    margin-top:20px;
}

.btn:hover{
    transform:translateY(-3px);
    box-shadow:0 15px 40px rgba(46,204,113,0.6);
}

.btn-full{
    width:100%;
    padding:18px;
}

.btn-secondary{
    background:rgba(255,255,255,0.1);
    border:1px solid rgba(255,255,255,0.3);
    box-shadow:none;
}

.btn-secondary:hover{
    background:rgba(255,255,255,0.15);
    box-shadow:0 8px 20px rgba(255,255,255,0.1);
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
.container{
    animation:fadeIn 0.6s ease;
}
</style>

<script>
    let emissionChart;

    function calculateDigitalEmissions() {
        // Screen time inputs
        var screenHours = parseFloat(document.getElementById('<%= txtScreenHours.ClientID %>').value) || 0;
        var screenMinutes = parseFloat(document.getElementById('<%= txtScreenMinutes.ClientID %>').value) || 0;
        var totalScreenTime = screenHours + (screenMinutes / 60);

        // Video streaming
        var streamingHours = parseFloat(document.getElementById('<%= txtStreamingHours.ClientID %>').value) || 0;
        var streamingQuality = document.getElementById('<%= ddlStreamingQuality.ClientID %>').value;

        // Social media
        var socialMediaHours = parseFloat(document.getElementById('<%= txtSocialMediaHours.ClientID %>').value) || 0;

        // Gaming
        var gamingHours = parseFloat(document.getElementById('<%= txtGamingHours.ClientID %>').value) || 0;
        var gamingPlatform = document.getElementById('<%= ddlGamingPlatform.ClientID %>').value;

        // Video calls
        var videoCallHours = parseFloat(document.getElementById('<%= txtVideoCallHours.ClientID %>').value) || 0;
    
    // Email
    var emailsSent = parseInt(document.getElementById('<%= txtEmailsSent.ClientID %>').value) || 0;
    var emailsReceived = parseInt(document.getElementById('<%= txtEmailsReceived.ClientID %>').value) || 0;
    
    // Cloud storage
    var cloudStorage = parseFloat(document.getElementById('<%= txtCloudStorage.ClientID %>').value) || 0;
    
    // Device charging
    var deviceCharges = parseInt(document.getElementById('<%= txtDeviceCharges.ClientID %>').value) || 0;
    var deviceType = document.getElementById('<%= ddlDeviceType.ClientID %>').value;

    // Calculate emissions (kg CO2 per activity)
    var screenEmission = totalScreenTime * 0.05; // 50g per hour
    var streamingEmission = streamingHours * getStreamingFactor(streamingQuality);
    var socialMediaEmission = socialMediaHours * 0.08; // 80g per hour
    var gamingEmission = gamingHours * getGamingFactor(gamingPlatform);
    var videoCallEmission = videoCallHours * 0.15; // 150g per hour
    var emailEmission = ((emailsSent * 0.004) + (emailsReceived * 0.0001)); // 4g sent, 0.1g received
    var cloudEmission = cloudStorage * 0.02; // 20g per GB per day
    var chargingEmission = deviceCharges * getChargingFactor(deviceType);
    
    var totalEmission = screenEmission + streamingEmission + socialMediaEmission + 
                        gamingEmission + videoCallEmission + emailEmission + 
                        cloudEmission + chargingEmission;

    // Update results
    document.getElementById('<%= lblTotalEmission.ClientID %>').innerText = totalEmission.toFixed(2);
    document.getElementById('screen-emission').innerText = screenEmission.toFixed(2);
    document.getElementById('streaming-emission').innerText = streamingEmission.toFixed(2);
    document.getElementById('social-emission').innerText = socialMediaEmission.toFixed(2);
    document.getElementById('gaming-emission').innerText = gamingEmission.toFixed(2);
    document.getElementById('call-emission').innerText = videoCallEmission.toFixed(2);
    document.getElementById('email-emission').innerText = emailEmission.toFixed(2);
    document.getElementById('cloud-emission').innerText = cloudEmission.toFixed(2);
    document.getElementById('charging-emission').innerText = chargingEmission.toFixed(2);
    
    // Update stats
    document.getElementById('total-screen-time').innerText = totalScreenTime.toFixed(1);
    document.getElementById('total-data-usage').innerText = ((streamingHours * 3) + (videoCallHours * 2) + (socialMediaHours * 0.5)).toFixed(1);
    document.getElementById('total-emails').innerText = emailsSent + emailsReceived;
    
    // Update chart
    updateChart(screenEmission, streamingEmission, socialMediaEmission, gamingEmission, 
                videoCallEmission, emailEmission, cloudEmission, chargingEmission);
    
    // Show results section
    document.querySelector('.result-container').style.display = 'block';
    document.querySelector('.chart-container').style.display = 'block';
}

function getStreamingFactor(quality) {
    switch(quality) {
        case 'SD': return 0.1; // 100g per hour
        case 'HD': return 0.25; // 250g per hour
        case '4K': return 0.5; // 500g per hour
        default: return 0.25;
    }
}

function getGamingFactor(platform) {
    switch(platform) {
        case 'Mobile': return 0.05; // 50g per hour
        case 'Console': return 0.2; // 200g per hour
        case 'PC': return 0.3; // 300g per hour
        case 'Cloud': return 0.4; // 400g per hour
        default: return 0.2;
    }
}

function getChargingFactor(device) {
    switch(device) {
        case 'Smartphone': return 0.008; // 8g per charge
        case 'Tablet': return 0.015; // 15g per charge
        case 'Laptop': return 0.05; // 50g per charge
        case 'Smartwatch': return 0.002; // 2g per charge
        default: return 0.01;
    }
}

function updateChart(screen, streaming, social, gaming, calls, email, cloud, charging) {
    if (emissionChart) {
        emissionChart.destroy();
    }
    
    const ctx = document.getElementById('emissionChart').getContext('2d');
    emissionChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Screen Time', 'Streaming', 'Social Media', 'Gaming', 'Video Calls', 'Email', 'Cloud Storage', 'Device Charging'],
            datasets: [{
                data: [screen, streaming, social, gaming, calls, email, cloud, charging],
                backgroundColor: [
                    '#2ecc71',
                    '#a8e6cf',
                    '#1abc9c',
                    '#16a085',
                    '#27ae60',
                    '#229954',
                    '#1e8449',
                    '#186a3b'
                ],
                borderColor: 'rgba(255,255,255,0.1)',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: '#fff',
                        padding: 15,
                        font: {
                            size: 12
                        }
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(30, 27, 75, 0.95)',
                    titleColor: '#fff',
                    bodyColor: '#a8e6cf',
                    padding: 12,
                    borderColor: '#2ecc71',
                    borderWidth: 1,
                    callbacks: {
                        label: function(context) {
                            return context.label + ': ' + context.parsed.toFixed(2) + ' kg CO₂';
                        }
                    }
                }
            }
        }
    });
}

function resetDigitalUI() {
    document.getElementById('<%= lblTotalEmission.ClientID %>').innerText = '0';
    document.getElementById('<%= lblTotalEmissionDisplay.ClientID %>').innerText = '0';
    document.getElementById('screen-emission').innerText = '0';
    document.getElementById('streaming-emission').innerText = '0';
    document.getElementById('social-emission').innerText = '0';
    document.getElementById('gaming-emission').innerText = '0';
    document.getElementById('call-emission').innerText = '0';
    document.getElementById('email-emission').innerText = '0';
    document.getElementById('cloud-emission').innerText = '0';
    document.getElementById('charging-emission').innerText = '0';

    document.getElementById('total-screen-time').innerText = '0';
    document.getElementById('total-data-usage').innerText = '0';
    document.getElementById('total-emails').innerText = '0';

    if (emissionChart) {
        emissionChart.destroy();
        emissionChart = null;
    }

    var result = document.querySelector('.result-container');
    var chart = document.querySelector('.chart-container');
    if (result) result.style.display = 'none';
    if (chart) chart.style.display = 'none';
}
window.onload = function() {
    document.getElementById('<%= btnCalculate.ClientID %>').addEventListener('click', function () {
            calculateDigitalEmissions();
        });

        // Hide results initially
        document.querySelector('.result-container').style.display = 'none';
        document.querySelector('.chart-container').style.display = 'none';
    };
</script>
</head>

<body>
<form runat="server">

<header>
    <h1>💻 EcoTrack Digital</h1>
    <nav>
        <a href="Home.aspx">Home</a>
        <a href="user/Dashboard.aspx">Dashboard</a>
        <a href="user/CalculationAI.aspx">Calculator</a>
        <a href="Logout.aspx">Logout</a>
    </nav>
</header>

<div class="container">
    <h2>
        <span>📱</span>
        Digital Carbon Footprint Calculator
    </h2>
    <p class="subtitle">Track your digital activities and their environmental impact</p>

    <!-- QUICK STATS -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">⏱️</div>
            <h3>Total Screen Time</h3>
            <div class="stat-value" id="total-screen-time">0</div>
            <div class="stat-unit">hours/day</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">📊</div>
            <h3>Data Usage</h3>
            <div class="stat-value" id="total-data-usage">0</div>
            <div class="stat-unit">GB/day</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">📧</div>
            <h3>Email Activity</h3>
            <div class="stat-value" id="total-emails">0</div>
            <div class="stat-unit">emails/day</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🌍</div>
            <h3>Carbon Impact</h3>
            <div class="stat-value">
                <asp:Label ID="lblTotalEmission" runat="server" Text="0" />
            </div>
            <div class="stat-unit">kg CO₂/day</div>
        </div>
    </div>

    <!-- SCREEN TIME INPUT -->
    <div class="input-section">
        <h3>
            <div class="section-icon">📺</div>
            General Screen Time
        </h3>
        <div class="form-grid">
            <div class="form-group">
                <label>Daily Screen Time</label>
                <div class="time-input-group">
                    <asp:TextBox ID="txtScreenHours" runat="server" TextMode="Number" placeholder="Hours" min="0" max="24" />
                    <asp:TextBox ID="txtScreenMinutes" runat="server" TextMode="Number" placeholder="Minutes" min="0" max="59" />
                </div>
            </div>
        </div>
    </div>

    <!-- VIDEO STREAMING INPUT -->
    <div class="input-section">
        <h3>
            <div class="section-icon">🎬</div>
            Video Streaming
        </h3>
        <div class="form-grid">
            <div class="form-group">
                <label>Streaming Hours/Day (Netflix, YouTube, etc.)</label>
                <asp:TextBox ID="txtStreamingHours" runat="server" TextMode="Number" placeholder="Enter hours" step="0.5" />
            </div>
            <div class="form-group">
                <label>Streaming Quality</label>
                <asp:DropDownList ID="ddlStreamingQuality" runat="server">
                    <asp:ListItem Value="SD">📱 SD (480p)</asp:ListItem>
                    <asp:ListItem Value="HD" Selected="True">📺 HD (1080p)</asp:ListItem>
                    <asp:ListItem Value="4K">🖥️ 4K (2160p)</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>

    <!-- SOCIAL MEDIA INPUT -->
    <div class="input-section">
        <h3>
            <div class="section-icon">📱</div>
            Social Media
        </h3>
        <div class="form-grid">
            <div class="form-group">
                <label>Social Media Hours/Day (Instagram, Facebook, Twitter, TikTok)</label>
                <asp:TextBox ID="txtSocialMediaHours" runat="server" TextMode="Number" placeholder="Enter hours" step="0.5" />
            </div>
        </div>
    </div>

    <!-- GAMING INPUT -->
    <div class="input-section">
        <h3>
            <div class="section-icon">🎮</div>
            Gaming
        </h3>
        <div class="form-grid">
            <div class="form-group">
                <label>Gaming Hours/Day</label>
                <asp:TextBox ID="txtGamingHours" runat="server" TextMode="Number" placeholder="Enter hours" step="0.5" />
            </div>
            <div class="form-group">
                <label>Gaming Platform</label>
                <asp:DropDownList ID="ddlGamingPlatform" runat="server">
                    <asp:ListItem Value="Mobile">📱 Mobile</asp:ListItem>
                    <asp:ListItem Value="Console">🎮 Console</asp:ListItem>
                    <asp:ListItem Value="PC" Selected="True">💻 PC</asp:ListItem>
                    <asp:ListItem Value="Cloud">☁️ Cloud Gaming</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>

    <!-- VIDEO CALLS INPUT -->
    <div class="input-section">
        <h3>
            <div class="section-icon">📞</div>
            Video Calls & Meetings
        </h3>
        <div class="form-grid">
            <div class="form-group">
                <label>Video Call Hours/Day (Zoom, Teams, Meet)</label>
                <asp:TextBox ID="txtVideoCallHours" runat="server" TextMode="Number" placeholder="Enter hours" step="0.5" />
            </div>
        </div>
    </div>

    <!-- EMAIL INPUT -->
    <div class="input-section">
        <h3>
            <div class="section-icon">✉️</div>
            Email Usage
        </h3>
        <div class="form-grid">
            <div class="form-group">
                <label>Emails Sent/Day</label>
                <asp:TextBox ID="txtEmailsSent" runat="server" TextMode="Number" placeholder="Enter count" />
            </div>
            <div class="form-group">
                <label>Emails Received/Day</label>
                <asp:TextBox ID="txtEmailsReceived" runat="server" TextMode="Number" placeholder="Enter count" />
            </div>
        </div>
    </div>

    <!-- CLOUD STORAGE INPUT -->
    <div class="input-section">
        <h3>
            <div class="section-icon">☁️</div>
            Cloud Storage
        </h3>
        <div class="form-grid">
            <div class="form-group">
                <label>Cloud Storage Used (GB) - Google Drive, Dropbox, iCloud</label>
                <asp:TextBox ID="txtCloudStorage" runat="server" TextMode="Number" placeholder="Enter GB" />
            </div>
        </div>
    </div>

    <!-- DEVICE CHARGING INPUT -->
    <div class="input-section">
        <h3>
            <div class="section-icon">🔋</div>
            Device Charging
        </h3>
        <div class="form-grid">
            <div class="form-group">
                <label>Number of Device Charges/Day</label>
                <asp:TextBox ID="txtDeviceCharges" runat="server" TextMode="Number" placeholder="Enter count" />
            </div>
            <div class="form-group">
                <label>Primary Device Type</label>
                <asp:DropDownList ID="ddlDeviceType" runat="server">
                    <asp:ListItem Value="Smartphone" Selected="True">📱 Smartphone</asp:ListItem>
                    <asp:ListItem Value="Tablet">📲 Tablet</asp:ListItem>
                    <asp:ListItem Value="Laptop">💻 Laptop</asp:ListItem>
                    <asp:ListItem Value="Smartwatch">⌚ Smartwatch</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
    </div>

    <asp:Button ID="btnCalculate" runat="server" Text="🔍 Calculate Digital Footprint" CssClass="btn btn-full" OnClick="Calculate_Click" />

    <!-- RESULTS SECTION -->
    <div class="result-container">
        <h3>📊 Your Digital Carbon Footprint</h3>
        <div class="total-emission">
            <asp:Label ID="lblTotalEmissionDisplay" runat="server" Text="0" />
        </div>
        <p style="color:rgba(255,255,255,0.7);font-size:18px;">kg CO₂ per day</p>

        <div class="emission-breakdown">
            <div class="breakdown-item">
                <h4>📺 Screen Time</h4>
                <div class="breakdown-value"><span id="screen-emission">0</span> kg</div>
            </div>
            <div class="breakdown-item">
                <h4>🎬 Streaming</h4>
                <div class="breakdown-value"><span id="streaming-emission">0</span> kg</div>
            </div>
            <div class="breakdown-item">
                <h4>📱 Social Media</h4>
                <div class="breakdown-value"><span id="social-emission">0</span> kg</div>
            </div>
            <div class="breakdown-item">
                <h4>🎮 Gaming</h4>
                <div class="breakdown-value"><span id="gaming-emission">0</span> kg</div>
            </div>
            <div class="breakdown-item">
                <h4>📞 Video Calls</h4>
                <div class="breakdown-value"><span id="call-emission">0</span> kg</div>
            </div>
            <div class="breakdown-item">
                <h4>✉️ Email</h4>
                <div class="breakdown-value"><span id="email-emission">0</span> kg</div>
            </div>
            <div class="breakdown-item">
                <h4>☁️ Cloud Storage</h4>
                <div class="breakdown-value"><span id="cloud-emission">0</span> kg</div>
            </div>
            <div class="breakdown-item">
                <h4>🔋 Charging</h4>
                <div class="breakdown-value"><span id="charging-emission">0</span> kg</div>
            </div>
        </div>
    </div>

    <!-- CHART SECTION -->
    <div class="chart-container">
        <h3>📊 Emission Distribution</h3>
        <canvas id="emissionChart"></canvas>
    </div>

    <!-- ECO TIPS SECTION -->
    <div class="tips-container">
        <h3>💡 Digital Carbon Reduction Tips</h3>
        <ul class="tips-list">
            <li>Reduce streaming quality to HD or SD when possible - 4K uses 50% more energy</li>
            <li>Turn off video in calls when not needed - audio-only uses 96% less data</li>
            <li>Unsubscribe from unwanted emails - each spam email generates 0.3g CO₂</li>
            <li>Delete old emails and files from cloud storage regularly</li>
            <li>Use dark mode on OLED screens - saves up to 60% battery</li>
            <li>Download music/videos for offline use instead of repeated streaming</li>
            <li>Close unused browser tabs and apps</li>
            <li>Enable auto-brightness on devices</li>
            <li>Charge devices only when needed, avoid overnight charging</li>
            <li>Use WiFi instead of mobile data when possible - it uses less energy</li>
            <li>Schedule digital detox hours - reduces both emissions and improves wellbeing</li>
            <li>Choose eco-friendly search engines like Ecosia (plants trees)</li>
        </ul>
    </div>

    <div style="margin-top:30px;text-align:center;">
        <asp:Button ID="btnSaveToHistory" runat="server" Text="💾 Save to History" CssClass="btn" OnClick="SaveToHistory_Click" />
        <asp:Button ID="btnReset" runat="server" Text="🔄 Reset" CssClass="btn btn-secondary" OnClick="Reset_Click" />
    </div>
</div>

<footer>
    <div class="footer-grid">
        <div>
            <h4>EcoTrack</h4>
            <p>Carbon Footprint Management System</p>
            <p style="margin-top:15px;">Making sustainability measurable and actionable.</p>
        </div>
        <div>
            <h4>Quick Links</h4>
            <a href="Home.aspx">Home</a>
            <a href="user/Dashboard.aspx">Dashboard</a>
            <a href="user/CalculationAI.aspx">Calculator</a>
            <a href="user/ProfileHR.aspx">Reports</a>
        </div>
        <div>
            <h4>Resources</h4>
            <a href="user/Guide.aspx">Carbon Tips</a>
            <a href="user/Guide.aspx">Green Living Guide</a>
            <a href="user/Guide.aspx">Sustainability Blog</a>
            <a href="user/Guide.aspx">FAQ</a>
        </div>
        <div>
            <h4>Contact</h4>
            <p>📧 eco@ecotrack.com</p>
            <p>📞 +91 98765 43210</p>
            <p>📍 Mumbai, India</p>
        </div>
    </div>
    <div class="footer-bottom">
        💻 Digital activities account for ~4% of global greenhouse gas emissions<br>
        © 2026 EcoTrack | Sustainable Future Initiative | All Rights Reserved
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
