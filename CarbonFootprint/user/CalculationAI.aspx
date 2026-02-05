<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CalculationAI.aspx.cs" Inherits="CarbonFootprint.user.CalculationAI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>EcoTrack | Carbon Calculator</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
<style>
/* ================= ROOT ================= */
:root{
    --forest:#0f3d2e;
    --accent:#2ecc71;
    --accent-light:#a8e6cf;
    --glass:rgba(255,255,255,0.18);
    --glass-border:rgba(255,255,255,0.3);
}

/* ================= GLOBAL ================= */

*{box-sizing:border-box;}
html{
    scroll-behavior: smooth;

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
    background-image: url('YOUR_IMAGE_URL_HERE.jpg');
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
    max-width:1000px;
    margin:70px auto;
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(30px) saturate(180%);
    -webkit-backdrop-filter:blur(30px) saturate(180%);
    border:1px solid rgba(255,255,255,0.18);
    border-radius:30px;
    padding:50px;
    box-shadow:0 20px 60px rgba(0,0,0,0.3), inset 0 1px 0 rgba(255,255,255,0.1);
}

/* ================= TOGGLE ================= */
.toggle{
    display:flex;
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(20px) saturate(180%);
    -webkit-backdrop-filter:blur(20px) saturate(180%);
    border-radius:50px;
    padding:6px;
    width:580px;
    margin:0 auto 50px;
    border:1px solid rgba(255,255,255,0.18);
    box-shadow:0 8px 25px rgba(0,0,0,0.15), inset 0 1px 0 rgba(255,255,255,0.1);
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
    color:#aaa;
    transition:all .4s cubic-bezier(0.4, 0, 0.2, 1);
}
.toggle button.active{
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    color:#fff;
    box-shadow:0 8px 20px rgba(46,204,113,0.5);
    transform:scale(1.02);
}

/* ================= SECTIONS ================= */
.section{
    display:none;
    animation:fadeSlide .4s ease;
}
.section.active{
    display:block;
}

h2{
    color:var(--accent);
    margin-bottom:25px;
    font-size:28px;
}

/* ================= ACTIVITY INPUT ================= */
.input-card{
    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(20px) saturate(180%);
    -webkit-backdrop-filter:blur(20px) saturate(180%);
    padding:30px;
    border-radius:20px;
    border:1px solid rgba(255,255,255,0.18);
    margin-bottom:25px;
    box-shadow:0 8px 32px rgba(0,0,0,0.1), inset 0 1px 0 rgba(255,255,255,0.1);
}
.input-card h3{
    color:#fff;
    margin:0 0 20px 0;
    font-size:20px;
    display:flex;
    align-items:center;
    gap:10px;
}
.input-icon{
    width:40px;
    height:40px;
    border-radius:10px;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:20px;
}
.form-row{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:15px;
    margin-bottom:15px;
}
.form-group{
    margin-bottom:15px;
}
label{
    display:block;
    font-weight:600;
    color:#fff;
    margin-bottom:8px;
    font-size:14px;
}
input, select{
    width:100%;
    padding:12px 14px;
    border-radius:10px;
    border:1px solid rgba(255,255,255,0.2);
    background:rgba(255,255,255,0.08);
    color:#fff;
    outline:none;
    font-size:14px;
    transition:.3s;
    font-family:"Segoe UI", system-ui;
    cursor:pointer;
}
select {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%232ecc71' d='M1.41 0L6 4.59L10.59 0L12 1.42l-6 6l-6-6z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 14px center;
    padding-right: 40px;
}
select:hover {
    border-color:#2ecc71;
}
input[type="number"] {
    -moz-appearance: textfield;
}
input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
input:focus, select:focus{
    border-color:#2ecc71;
    box-shadow:0 0 12px rgba(46,204,113,0.4);
}
input::placeholder{
    color:rgba(255,255,255,0.3);
}

/* Number input with custom controls */
.number-input-wrapper {
    position: relative;
    width: 100%;
}
.number-input-wrapper input {
    padding-right: 45px;
}
.number-controls {
    position: absolute;
    right: 8px;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    flex-direction: column;
    gap: 2px;
}
.number-btn {
    width: 28px;
    height: 20px;
    border: none;
    background: linear-gradient(135deg, #2ecc71, #a8e6cf);
    color: white;
    border-radius: 4px;
    cursor: pointer;
    font-size: 10px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: .2s;
}
.number-btn:hover {
    transform: scale(1.1);
    box-shadow: 0 2px 8px rgba(46,204,113,0.6);
}
.number-btn:active {
    transform: scale(0.95);
}

/* ================= VIEW TOGGLE (Daily/Monthly) ================= */
.view-toggle {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-bottom: 25px;
}
.view-toggle button {
    padding: 10px 24px;
    border: 1px solid rgba(255,255,255,0.2);
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    color: #fff;
    border-radius: 20px;
    cursor: pointer;
    font-weight: 600;
    transition: .3s;
}
.view-toggle button.active {
    background: linear-gradient(135deg, #2ecc71, #a8e6cf);
    color: #fff;
    border-color: transparent;
}

/* ================= CALCULATION RESULTS ================= */
.result-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(200px, 1fr));
    gap:20px;
    margin-bottom:30px;
}
.result-card{
    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(20px) saturate(180%);
    -webkit-backdrop-filter:blur(20px) saturate(180%);
    padding:25px;
    border-radius:18px;
    border:1px solid rgba(255,255,255,0.18);
    text-align:center;
    transition:.3s;
    box-shadow:0 8px 32px rgba(0,0,0,0.1), inset 0 1px 0 rgba(255,255,255,0.1);
}
.result-card:hover{
    transform:translateY(-5px);
    box-shadow:0 12px 40px rgba(46,204,113,0.2), inset 0 1px 0 rgba(255,255,255,0.15);
    border-color:rgba(46,204,113,0.4);
}
.result-icon{
    width:60px;
    height:60px;
    margin:0 auto 15px;
    border-radius:15px;
    background:linear-gradient(135deg, #2ecc71, #a8e6cf);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:28px;
}
.result-card h4{
    color:#fff;
    margin:0 0 8px 0;
    font-size:16px;
}
.result-value{
    font-size:28px;
    font-weight:800;
    color:#2ecc71;
    margin:5px 0;
}
.result-unit{
    font-size:13px;
    color:rgba(255,255,255,0.7);
}
.result-percentage {
    font-size: 12px;
    color: rgba(255,255,255,0.6);
    margin-top: 5px;
}

.total-card{
    background:rgba(46,204,113,0.15);
    backdrop-filter:blur(20px) saturate(180%);
    -webkit-backdrop-filter:blur(20px) saturate(180%);
    border:2px solid rgba(46,204,113,0.5);
    padding:35px;
    text-align:center;
    border-radius:20px;
    margin-top:25px;
    box-shadow:0 8px 32px rgba(46,204,113,0.2), inset 0 1px 0 rgba(255,255,255,0.1);
}
.total-card h3{
    color:#fff;
    margin:0 0 15px 0;
}
.total-value{
    font-size:48px;
    font-weight:900;
    color:#2ecc71;
}
.projection-info {
    margin-top: 20px;
    padding: 15px;
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    border-radius: 12px;
    border: 1px solid rgba(255,255,255,0.15);
}
.projection-info h4 {
    color: #fff;
    margin: 0 0 10px 0;
    font-size: 16px;
}
.projection-value {
    font-size: 24px;
    font-weight: 700;
    color: #2ecc71;
}

/* ================= COMPARISON INDICATOR ================= */
.comparison-box {
    margin-top: 20px;
    padding: 15px 20px;
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    border-radius: 12px;
    border: 1px solid rgba(255,255,255,0.18);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    box-shadow:0 8px 32px rgba(0,0,0,0.1);
}
.comparison-box.higher {
    border-color: rgba(255,100,100,0.5);
    background: rgba(255,100,100,0.1);
}
.comparison-box.lower {
    border-color: rgba(46,204,113,0.5);
    background: rgba(46,204,113,0.1);
}
.comparison-icon {
    font-size: 24px;
}
.comparison-text {
    font-size: 14px;
    color: #fff;
}

/* Tree offset suggestion */
.tree-offset {
    margin-top: 20px;
    padding: 15px 20px;
    background: rgba(46,204,113,0.12);
    backdrop-filter: blur(15px);
    border-radius: 12px;
    border: 1px solid rgba(46,204,113,0.4);
    display: flex;
    align-items: center;
    gap: 12px;
    box-shadow:0 8px 32px rgba(46,204,113,0.15);
}
.tree-offset-icon {
    font-size: 28px;
}
.tree-offset-text {
    flex: 1;
    color: #fff;
    font-size: 14px;
}

/* ================= GRAPH SECTION ================= */
.graph-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    flex-wrap: wrap;
    gap: 15px;
}
.chart-type-buttons, .time-filter {
    display: flex;
    gap: 10px;
}
.chart-type-buttons button, .time-filter select {
    padding: 10px 20px;
    border: 1px solid rgba(255,255,255,0.2);
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    color: #fff;
    border-radius: 10px;
    cursor: pointer;
    font-weight: 600;
    transition: .3s;
}
.chart-type-buttons button.active {
    background: linear-gradient(135deg, #2ecc71, #a8e6cf);
    color: #fff;
    border-color: transparent;
}
.chart-type-buttons button:hover, .time-filter select:hover {
    border-color: #2ecc71;
    background: rgba(255,255,255,0.12);
}
.time-filter select {
    cursor: pointer;
    appearance: none;
    padding-right: 35px;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%232ecc71' d='M1.41 0L6 4.59L10.59 0L12 1.42l-6 6l-6-6z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 14px center;
}
.category-toggles {
    display: flex;
    gap: 15px;
    justify-content: center;
    margin-bottom: 20px;
    flex-wrap: wrap;
}
.category-toggle {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    border: 1px solid rgba(255,255,255,0.18);
    border-radius: 20px;
    cursor: pointer;
    transition: .3s;
    box-shadow:0 4px 15px rgba(0,0,0,0.1);
}
.category-toggle input {
    width: auto;
    cursor: pointer;
}
.category-toggle label {
    margin: 0;
    cursor: pointer;
    color: #fff;
}
.category-toggle:hover {
    background: rgba(255,255,255,0.12);
    border-color: rgba(46,204,113,0.4);
}
.graph-container{
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(20px) saturate(180%);
    -webkit-backdrop-filter:blur(20px) saturate(180%);
    padding:35px;
    border-radius:20px;
    border:1px solid rgba(255,255,255,0.18);
    box-shadow:0 8px 32px rgba(0,0,0,0.1), inset 0 1px 0 rgba(255,255,255,0.1);
}
#emissionChart{
    max-height:400px;
}
.graph-insights {
    margin-top: 25px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
}
.insight-card {
    padding: 20px;
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    border-radius: 12px;
    border: 1px solid rgba(255,255,255,0.18);
    box-shadow:0 8px 32px rgba(0,0,0,0.1);
}
.insight-card h4 {
    margin: 0 0 10px 0;
    color: #fff;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 8px;
}
.insight-value {
    font-size: 20px;
    font-weight: 700;
    color: #2ecc71;
}
.insight-date {
    font-size: 12px;
    color: rgba(255,255,255,0.6);
    margin-top: 5px;
}
.insight-card.worst .insight-value {
    color: #e74c3c;
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
    box-shadow:0 10px 25px rgba(46,204,113,0.3);
    margin-top:15px;
    font-size:15px;
}
.btn:hover{
    transform:translateY(-3px);
    box-shadow:0 15px 35px rgba(46,204,113,0.5);
}
.btn-calculate{
    width:100%;
    padding:16px;
    font-size:16px;
}
.btn-secondary {
    background: rgba(60,60,60,0.8);
    border: 1px solid rgba(46,204,113,0.4);
    box-shadow: none;
}
.btn-secondary:hover {
    background: rgba(70,70,70,0.9);
    box-shadow: 0 8px 20px rgba(46,204,113,0.2);
}
.action-buttons {
    display: flex;
    gap: 15px;
    margin-top: 20px;
}
.action-buttons .btn {
    flex: 1;
    margin-top: 0;
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
    let emissionChart;
    let currentChartType = 'line';
    let currentView = 'daily';
    const DAILY_GOAL = 40;
    const AVERAGE_USER_EMISSION = 50;

    function showSection(id, btn) {
        document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
        document.querySelectorAll('.toggle button').forEach(b => b.classList.remove('active'));
        document.getElementById(id).classList.add('active');
        btn.classList.add('active');
    }

    function toggleView(view, btn) {
        currentView = view;
        document.querySelectorAll('.view-toggle button').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        updateProjections();
    }

    function updateProjections() {
        var totalEmission = parseFloat(document.getElementById('<%= lblTotalEmission.ClientID %>').innerText) || 0;
        var projectionElement = document.querySelector('.projection-value');

        if (currentView === 'daily') {
            projectionElement.innerHTML = totalEmission.toFixed(2) + ' <span style="font-size:16px;">kg CO₂ / day</span>';
        } else {
            var monthlyProjection = totalEmission * 30;
            projectionElement.innerHTML = monthlyProjection.toFixed(2) + ' <span style="font-size:16px;">kg CO₂ / month</span>';
        }
    }

    function initChart() {
        const ctx = document.getElementById('emissionChart').getContext('2d');
        emissionChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan 1', 'Jan 5', 'Jan 10', 'Jan 15', 'Jan 20', 'Jan 24'],
                datasets: [
                    {
                        label: 'Transport',
                        data: [15, 18, 12, 22, 16, 19],
                        borderColor: '#3498db',
                        backgroundColor: 'rgba(52, 152, 219, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#3498db',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Electricity',
                        data: [20, 22, 18, 28, 22, 24],
                        borderColor: '#f39c12',
                        backgroundColor: 'rgba(243, 156, 18, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#f39c12',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Food',
                        data: [10, 12, 8, 15, 10, 12],
                        borderColor: '#2ecc71',
                        backgroundColor: 'rgba(46, 204, 113, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#2ecc71',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Water',
                        data: [5, 6, 4, 7, 5, 6],
                        borderColor: '#3498db',
                        backgroundColor: 'rgba(52, 152, 219, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#3498db',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Lifestyle',
                        data: [8, 9, 7, 10, 8, 9],
                        borderColor: '#9b59b6',
                        backgroundColor: 'rgba(155, 89, 182, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#9b59b6',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Waste',
                        data: [6, 7, 5, 8, 6, 7],
                        borderColor: '#e67e22',
                        backgroundColor: 'rgba(230, 126, 34, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#e67e22',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Daily Goal',
                        data: [40, 40, 40, 40, 40, 40],
                        borderColor: 'rgba(255, 255, 255, 0.5)',
                        borderDash: [5, 5],
                        borderWidth: 2,
                        fill: false,
                        pointRadius: 0,
                        pointHoverRadius: 0
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top',
                        labels: {
                            color: '#a8e6cf',
                            font: {
                                size: 14,
                                weight: 'bold'
                            },
                            filter: function (item) {
                                return item.text !== 'Daily Goal';
                            }
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(15, 61, 46, 0.95)',
                        titleColor: '#fff',
                        bodyColor: '#a8e6cf',
                        padding: 12,
                        borderColor: '#2ecc71',
                        borderWidth: 1,
                        callbacks: {
                            label: function (context) {
                                if (context.dataset.label === 'Daily Goal') {
                                    return 'Recommended Daily Limit: ' + context.parsed.y + ' kg';
                                }
                                return context.dataset.label + ': ' + context.parsed.y + ' kg';
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: '#a8e6cf',
                            callback: function (value) {
                                return value + ' kg';
                            }
                        },
                        grid: {
                            color: 'rgba(46, 204, 113, 0.1)'
                        }
                    },
                    x: {
                        ticks: {
                            color: '#a8e6cf'
                        },
                        grid: {
                            color: 'rgba(46, 204, 113, 0.1)'
                        }
                    }
                }
            }
        });
    }

    function changeChartType(type, btn) {
        currentChartType = type;
        document.querySelectorAll('.chart-type-buttons button').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        emissionChart.config.type = type;

        if (type === 'doughnut' || type === 'pie') {
            var totalTransport = 19;
            var totalElectricity = 24;
            var totalFood = 12;
            var totalWater = 6;
            var totalLifestyle = 9;
            var totalWaste = 7;

            emissionChart.data = {
                labels: ['Transport', 'Electricity', 'Food', 'Water', 'Lifestyle', 'Waste'],
                datasets: [{
                    data: [totalTransport, totalElectricity, totalFood, totalWater, totalLifestyle, totalWaste],
                    backgroundColor: ['#3498db', '#f39c12', '#2ecc71', '#3498db', '#9b59b6', '#e67e22'],
                    borderColor: ['#2c3e50', '#2c3e50', '#2c3e50', '#2c3e50', '#2c3e50', '#2c3e50'],
                    borderWidth: 2
                }]
            };

            emissionChart.options.plugins.legend.display = true;
            emissionChart.options.plugins.legend.labels.filter = null;
        } else {
            emissionChart.data = {
                labels: ['Jan 1', 'Jan 5', 'Jan 10', 'Jan 15', 'Jan 20', 'Jan 24'],
                datasets: [
                    {
                        label: 'Transport',
                        data: [15, 18, 12, 22, 16, 19],
                        borderColor: '#3498db',
                        backgroundColor: 'rgba(52, 152, 219, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#3498db',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Electricity',
                        data: [20, 22, 18, 28, 22, 24],
                        borderColor: '#f39c12',
                        backgroundColor: 'rgba(243, 156, 18, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#f39c12',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Food',
                        data: [10, 12, 8, 15, 10, 12],
                        borderColor: '#2ecc71',
                        backgroundColor: 'rgba(46, 204, 113, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#2ecc71',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Water',
                        data: [5, 6, 4, 7, 5, 6],
                        borderColor: '#3498db',
                        backgroundColor: 'rgba(52, 152, 219, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#3498db',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Lifestyle',
                        data: [8, 9, 7, 10, 8, 9],
                        borderColor: '#9b59b6',
                        backgroundColor: 'rgba(155, 89, 182, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#9b59b6',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Waste',
                        data: [6, 7, 5, 8, 6, 7],
                        borderColor: '#e67e22',
                        backgroundColor: 'rgba(230, 126, 34, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#e67e22',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    },
                    {
                        label: 'Daily Goal',
                        data: [40, 40, 40, 40, 40, 40],
                        borderColor: 'rgba(255, 255, 255, 0.5)',
                        borderDash: [5, 5],
                        borderWidth: 2,
                        fill: false,
                        pointRadius: 0,
                        pointHoverRadius: 0
                    }
                ]
            };

            emissionChart.options.plugins.legend.labels.filter = function (item) {
                return item.text !== 'Daily Goal';
            };
        }

        emissionChart.update();
    }

    function toggleCategory(checkbox, index) {
        emissionChart.setDatasetVisibility(index, checkbox.checked);
        emissionChart.update();
    }

    function changeTimeRange(select) {
        var range = select.value;
        var labels, datasets;

        if (range === '7days') {
            labels = ['Jan 18', 'Jan 19', 'Jan 20', 'Jan 21', 'Jan 22', 'Jan 23', 'Jan 24'];
            datasets = [
                { label: 'Transport', data: [18, 16, 20, 17, 19, 21, 19], borderColor: '#3498db', backgroundColor: 'rgba(52, 152, 219, 0.1)', tension: 0.4, fill: true, pointBackgroundColor: '#3498db', pointBorderColor: '#fff', pointBorderWidth: 2, pointRadius: 5 },
                { label: 'Electricity', data: [22, 24, 26, 23, 25, 27, 24], borderColor: '#f39c12', backgroundColor: 'rgba(243, 156, 18, 0.1)', tension: 0.4, fill: true, pointBackgroundColor: '#f39c12', pointBorderColor: '#fff', pointBorderWidth: 2, pointRadius: 5 },
                { label: 'Food', data: [10, 11, 13, 12, 10, 14, 12], borderColor: '#2ecc71', backgroundColor: 'rgba(46, 204, 113, 0.1)', tension: 0.4, fill: true, pointBackgroundColor: '#2ecc71', pointBorderColor: '#fff', pointBorderWidth: 2, pointRadius: 5 },
                { label: 'Daily Goal', data: [40, 40, 40, 40, 40, 40, 40], borderColor: 'rgba(255, 255, 255, 0.5)', borderDash: [5, 5], borderWidth: 2, fill: false, pointRadius: 0 }
            ];
        } else if (range === '30days') {
            labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
            datasets = [
                { label: 'Transport', data: [120, 135, 128, 140], borderColor: '#3498db', backgroundColor: 'rgba(52, 152, 219, 0.1)', tension: 0.4, fill: true, pointBackgroundColor: '#3498db', pointBorderColor: '#fff', pointBorderWidth: 2, pointRadius: 5 },
                { label: 'Electricity', data: [160, 170, 165, 175], borderColor: '#f39c12', backgroundColor: 'rgba(243, 156, 18, 0.1)', tension: 0.4, fill: true, pointBackgroundColor: '#f39c12', pointBorderColor: '#fff', pointBorderWidth: 2, pointRadius: 5 },
                { label: 'Food', data: [80, 85, 82, 90], borderColor: '#2ecc71', backgroundColor: 'rgba(46, 204, 113, 0.1)', tension: 0.4, fill: true, pointBackgroundColor: '#2ecc71', pointBorderColor: '#fff', pointBorderWidth: 2, pointRadius: 5 },
                { label: 'Daily Goal', data: [280, 280, 280, 280], borderColor: 'rgba(255, 255, 255, 0.5)', borderDash: [5, 5], borderWidth: 2, fill: false, pointRadius: 0 }
            ];
        } else {
            labels = ['Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan'];
            datasets = [
                { label: 'Transport', data: [550, 580, 520, 610, 590, 600], borderColor: '#3498db', backgroundColor: 'rgba(52, 152, 219, 0.1)', tension: 0.4, fill: true, pointBackgroundColor: '#3498db', pointBorderColor: '#fff', pointBorderWidth: 2, pointRadius: 5 },
                { label: 'Electricity', data: [700, 720, 690, 750, 730, 740], borderColor: '#f39c12', backgroundColor: 'rgba(243, 156, 18, 0.1)', tension: 0.4, fill: true, pointBackgroundColor: '#f39c12', pointBorderColor: '#fff', pointBorderWidth: 2, pointRadius: 5 },
                { label: 'Food', data: [350, 370, 340, 380, 360, 370], borderColor: '#2ecc71', backgroundColor: 'rgba(46, 204, 113, 0.1)', tension: 0.4, fill: true, pointBackgroundColor: '#2ecc71', pointBorderColor: '#fff', pointBorderWidth: 2, pointRadius: 5 },
                { label: 'Daily Goal', data: [1200, 1200, 1200, 1200, 1200, 1200], borderColor: 'rgba(255, 255, 255, 0.5)', borderDash: [5, 5], borderWidth: 2, fill: false, pointRadius: 0 }
            ];
        }

        emissionChart.data.labels = labels;
        emissionChart.data.datasets = datasets;
        emissionChart.update();
    }

    window.onload = function () {
        initChart();

        document.getElementById('<%= btnSaveActivity.ClientID %>').addEventListener('click', function () {
            calculateEmissions();
        });
    };

    function calculateEmissions() {
        var transportType = document.getElementById('<%= ddlTransportType.ClientID %>').value;
        var distance = parseFloat(document.getElementById('<%= txtTransportDistance.ClientID %>').value) || 0;
        var electricityUnits = parseFloat(document.getElementById('<%= txtElectricityUnits.ClientID %>').value) || 0;
        var foodType = document.getElementById('<%= ddlFoodType.ClientID %>').value;
        var meals = parseInt(document.getElementById('<%= txtMealsPerDay.ClientID %>').value) || 0;

        // New inputs
        var waterUsage = parseFloat(document.getElementById('<%= txtWaterUsage.ClientID %>').value) || 0;
        var showerDuration = parseFloat(document.getElementById('<%= txtShowerDuration.ClientID %>').value) || 0;
        var shoppingFreq = document.getElementById('<%= ddlShoppingFrequency.ClientID %>').value;
        var onlineShopping = parseInt(document.getElementById('<%= txtOnlineShopping.ClientID %>').value) || 0;
        var heatingCooling = document.getElementById('<%= ddlHeatingCooling.ClientID %>').value;
        var wasteGenerated = parseFloat(document.getElementById('<%= txtWasteGenerated.ClientID %>').value) || 0;
        var recycling = document.getElementById('<%= ddlRecycling.ClientID %>').value;
        var composting = document.getElementById('<%= ddlComposting.ClientID %>').value;

        if (!transportType || !foodType || !shoppingFreq || !heatingCooling || !recycling || !composting) {
            alert('Please fill all required fields!');
            return;
        }

        var transportEmission = distance * getTransportFactor(transportType);
        var electricityEmission = electricityUnits * 0.82;
        var foodEmission = meals * getFoodFactor(foodType);
        
        // Water emission (0.0003 kg CO2 per liter)
        var waterEmission = (waterUsage * 0.0003) + (showerDuration * 10 * 0.0003);
        
        // Lifestyle emission
        var lifestyleEmission = getShoppingFactor(shoppingFreq) + (onlineShopping * 0.5) + getHeatingCoolingFactor(heatingCooling);
        
        // Waste emission (0.5 kg CO2 per kg waste, reduced by recycling)
        var wasteEmission = wasteGenerated * 0.5 * getRecyclingMultiplier(recycling) * getCompostingMultiplier(composting);
        
        var totalEmission = transportEmission + electricityEmission + foodEmission + waterEmission + lifestyleEmission + wasteEmission;

        var transportPercent = ((transportEmission / totalEmission) * 100).toFixed(1);
        var electricityPercent = ((electricityEmission / totalEmission) * 100).toFixed(1);
        var foodPercent = ((foodEmission / totalEmission) * 100).toFixed(1);
        var waterPercent = ((waterEmission / totalEmission) * 100).toFixed(1);
        var lifestylePercent = ((lifestyleEmission / totalEmission) * 100).toFixed(1);
        var wastePercent = ((wasteEmission / totalEmission) * 100).toFixed(1);

        document.getElementById('<%= lblTransportEmission.ClientID %>').innerText = transportEmission.toFixed(2);
        document.getElementById('transport-percent').innerText = transportPercent + '%';
        
        document.getElementById('<%= lblElectricityEmission.ClientID %>').innerText = electricityEmission.toFixed(2);
        document.getElementById('electricity-percent').innerText = electricityPercent + '%';
        
        document.getElementById('<%= lblFoodEmission.ClientID %>').innerText = foodEmission.toFixed(2);
        document.getElementById('food-percent').innerText = foodPercent + '%';
        
        document.getElementById('<%= lblWaterEmission.ClientID %>').innerText = waterEmission.toFixed(2);
        document.getElementById('water-percent').innerText = waterPercent + '%';
        
        document.getElementById('<%= lblLifestyleEmission.ClientID %>').innerText = lifestyleEmission.toFixed(2);
        document.getElementById('lifestyle-percent').innerText = lifestylePercent + '%';
        
        document.getElementById('<%= lblWasteEmission.ClientID %>').innerText = wasteEmission.toFixed(2);
        document.getElementById('waste-percent').innerText = wastePercent + '%';
        
        document.getElementById('<%= lblTotalEmission.ClientID %>').innerText = totalEmission.toFixed(2);

        updateComparison(totalEmission);
        updateTreeOffset(totalEmission);
        updateProjections();

        showSection('calculation', document.querySelectorAll('.toggle button')[1]);
    }

    function updateComparison(totalEmission) {
        var comparisonBox = document.querySelector('.comparison-box');
        var comparisonIcon = comparisonBox.querySelector('.comparison-icon');
        var comparisonText = comparisonBox.querySelector('.comparison-text');

        var difference = ((totalEmission - AVERAGE_USER_EMISSION) / AVERAGE_USER_EMISSION * 100);

        if (totalEmission > AVERAGE_USER_EMISSION) {
            comparisonBox.className = 'comparison-box higher';
            comparisonIcon.innerText = '🔼';
            comparisonText.innerText = Math.abs(difference).toFixed(1) + '% higher than average user';
        } else {
            comparisonBox.className = 'comparison-box lower';
            comparisonIcon.innerText = '🔽';
            comparisonText.innerText = Math.abs(difference).toFixed(1) + '% lower than average user';
        }
    }

    function updateTreeOffset(totalEmission) {
        var treesNeeded = Math.ceil(totalEmission / 20);
        document.getElementById('trees-needed').innerText = treesNeeded;
    }

    function resetCalculationUI() {
        // Reset server-rendered labels
        document.getElementById('<%= lblTransportEmission.ClientID %>').innerText = '0';
        document.getElementById('<%= lblElectricityEmission.ClientID %>').innerText = '0';
        document.getElementById('<%= lblFoodEmission.ClientID %>').innerText = '0';
        document.getElementById('<%= lblWaterEmission.ClientID %>').innerText = '0';
        document.getElementById('<%= lblLifestyleEmission.ClientID %>').innerText = '0';
        document.getElementById('<%= lblWasteEmission.ClientID %>').innerText = '0';
        document.getElementById('<%= lblTotalEmission.ClientID %>').innerText = '0';

        // Reset percentages
        document.getElementById('transport-percent').innerText = '0%';
        document.getElementById('electricity-percent').innerText = '0%';
        document.getElementById('food-percent').innerText = '0%';
        document.getElementById('water-percent').innerText = '0%';
        document.getElementById('lifestyle-percent').innerText = '0%';
        document.getElementById('waste-percent').innerText = '0%';

        // Reset projection
        var projectionElement = document.querySelector('.projection-value');
        if (projectionElement) {
            projectionElement.innerHTML = '0 <span style="font-size:16px;">kg CO₂ / day</span>';
        }

        // Reset comparison
        var comparisonBox = document.querySelector('.comparison-box');
        if (comparisonBox) {
            comparisonBox.className = 'comparison-box';
            var comparisonIcon = comparisonBox.querySelector('.comparison-icon');
            var comparisonText = comparisonBox.querySelector('.comparison-text');
            if (comparisonIcon) comparisonIcon.innerText = '📊';
            if (comparisonText) comparisonText.innerText = 'Compared to average user';
        }

        // Reset trees
        var trees = document.getElementById('trees-needed');
        if (trees) trees.innerText = '0';

        // Go back to input section
        var buttons = document.querySelectorAll('.toggle button');
        if (buttons && buttons.length) {
            showSection('input', buttons[0]);
        }
    }

    function getTransportFactor(type) {
        switch (type) {
            case 'Car': return 0.21;
            case 'Bus': return 0.089;
            case 'Train': return 0.041;
            case 'Bike': return 0.59;
            case 'Flight': return 0.255;
            default: return 0.15;
        }
    }

    function getFoodFactor(type) {
        switch (type) {
            case 'Vegetarian': return 1.5;
            case 'Non-Vegetarian': return 2.5;
            case 'Vegan': return 1.0;
            default: return 1.5;
        }
    }

    function getShoppingFactor(freq) {
        switch (freq) {
            case 'Daily': return 3.0;
            case 'Weekly': return 2.0;
            case 'BiWeekly': return 1.5;
            case 'Monthly': return 1.0;
            default: return 2.0;
        }
    }

    function getHeatingCoolingFactor(usage) {
        switch (usage) {
            case 'None': return 1.0;
            case 'Moderate': return 5.0;
            case 'Heavy': return 10.0;
            default: return 5.0;
        }
    }

    function getRecyclingMultiplier(habit) {
        switch (habit) {
            case 'Never': return 1.0;
            case 'Sometimes': return 0.75;
            case 'Often': return 0.5;
            case 'Always': return 0.25;
            default: return 1.0;
        }
    }

    function getCompostingMultiplier(composting) {
        return composting === 'Yes' ? 0.7 : 1.0;
    }

    function incrementValue(fieldId) {
        var field = document.getElementById(fieldId);
        if (field) {
            var currentValue = parseFloat(field.value) || 0;
            field.value = currentValue + 1;
        }
    }

    function decrementValue(fieldId) {
        var field = document.getElementById(fieldId);
        if (field) {
            var currentValue = parseFloat(field.value) || 0;
            if (currentValue > 0) {
                field.value = currentValue - 1;
            }
        }
    }
</script>
</head>
<body>
<form runat="server">
<header>
    <h1><a href="../Home.aspx" style="color:inherit; text-decoration:none;">🌿 EcoTrack</a></h1>
    <nav>
        <a href="../Home.aspx">Home</a>
        <a href="Dashboard.aspx">Dashboard</a>
        <a href="ProfileHR.aspx">Profile</a>
        <a href="../DigitalE.aspx">DigitalE</a>
        <a href="../Logout.aspx">Logout</a>
    </nav>
</header>

<div class="container">
    <div class="toggle">
        <button class="active" onclick="showSection('input',this)" type="button">📝 Activity Input</button>
        <button onclick="showSection('calculation',this)" type="button">📊 Calculation</button>
        <button onclick="showSection('graph',this)" type="button">📈 Emission Graph</button>
    </div>

    <!-- ACTIVITY INPUT SECTION -->
    <div id="input" class="section active">
        <h2>Input Your Activities</h2>
        
        <div class="input-card">
            <h3><div class="input-icon">🚗</div> Transportation</h3>
            <div class="form-row">
                <div class="form-group">
                    <label>Transport Type</label>
                    <asp:DropDownList ID="ddlTransportType" runat="server" CssClass="input">
                        <asp:ListItem Value="">Select Type</asp:ListItem>
                        <asp:ListItem Value="Car">🚗 Car</asp:ListItem>
                        <asp:ListItem Value="Bus">🚌 Bus</asp:ListItem>
                        <asp:ListItem Value="Train">🚆 Train</asp:ListItem>
                        <asp:ListItem Value="Bike">🏍️ Bike</asp:ListItem>
                        <asp:ListItem Value="Flight">✈️ Flight</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Distance (km)</label>
                    <div class="number-input-wrapper">
                        <asp:TextBox ID="txtTransportDistance" runat="server" TextMode="Number" placeholder="Enter distance" CssClass="number-input" />
                        <div class="number-controls">
                            <button type="button" class="number-btn" onclick="incrementValue('<%= txtTransportDistance.ClientID %>')">▲</button>
                            <button type="button" class="number-btn" onclick="decrementValue('<%= txtTransportDistance.ClientID %>')">▼</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="input-card">
            <h3><div class="input-icon">⚡</div> Electricity Usage</h3>
            <div class="form-group">
                <label>Units Consumed (kWh)</label>
                <div class="number-input-wrapper">
                    <asp:TextBox ID="txtElectricityUnits" runat="server" TextMode="Number" placeholder="Enter kWh units" CssClass="number-input" />
                    <div class="number-controls">
                        <button type="button" class="number-btn" onclick="incrementValue('<%= txtElectricityUnits.ClientID %>')">▲</button>
                        <button type="button" class="number-btn" onclick="decrementValue('<%= txtElectricityUnits.ClientID %>')">▼</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="input-card">
            <h3><div class="input-icon">🍽️</div> Food Consumption</h3>
            <div class="form-row">
                <div class="form-group">
                    <label>Food Type</label>
                    <asp:DropDownList ID="ddlFoodType" runat="server" CssClass="input">
                        <asp:ListItem Value="">Select Type</asp:ListItem>
                        <asp:ListItem Value="Vegetarian">🥗 Vegetarian</asp:ListItem>
                        <asp:ListItem Value="Non-Vegetarian">🍖 Non-Vegetarian</asp:ListItem>
                        <asp:ListItem Value="Vegan">🌱 Vegan</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Meals per Day</label>
                    <div class="number-input-wrapper">
                        <asp:TextBox ID="txtMealsPerDay" runat="server" TextMode="Number" placeholder="Number of meals" CssClass="number-input" />
                        <div class="number-controls">
                            <button type="button" class="number-btn" onclick="incrementValue('<%= txtMealsPerDay.ClientID %>')">▲</button>
                            <button type="button" class="number-btn" onclick="decrementValue('<%= txtMealsPerDay.ClientID %>')">▼</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- WATER USAGE INPUT -->
        <div class="input-card">
            <h3><div class="input-icon">💧</div> Water Usage</h3>
            <div class="form-row">
                <div class="form-group">
                    <label>Daily Water Consumption (Liters)</label>
                    <div class="number-input-wrapper">
                        <asp:TextBox ID="txtWaterUsage" runat="server" TextMode="Number" placeholder="Enter liters" CssClass="number-input" />
                        <div class="number-controls">
                            <button type="button" class="number-btn" onclick="incrementValue('<%= txtWaterUsage.ClientID %>')">▲</button>
                            <button type="button" class="number-btn" onclick="decrementValue('<%= txtWaterUsage.ClientID %>')">▼</button>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>Shower Duration (Minutes/Day)</label>
                    <div class="number-input-wrapper">
                        <asp:TextBox ID="txtShowerDuration" runat="server" TextMode="Number" placeholder="Enter minutes" CssClass="number-input" />
                        <div class="number-controls">
                            <button type="button" class="number-btn" onclick="incrementValue('<%= txtShowerDuration.ClientID %>')">▲</button>
                            <button type="button" class="number-btn" onclick="decrementValue('<%= txtShowerDuration.ClientID %>')">▼</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- LIFESTYLE INPUT -->
        <div class="input-card">
            <h3><div class="input-icon">🏠</div> Lifestyle</h3>
            <div class="form-row">
                <div class="form-group">
                    <label>Shopping Frequency</label>
                    <asp:DropDownList ID="ddlShoppingFrequency" runat="server" CssClass="input">
                        <asp:ListItem Value="">Select Frequency</asp:ListItem>
                        <asp:ListItem Value="Daily">🛒 Daily</asp:ListItem>
                        <asp:ListItem Value="Weekly">📅 Weekly</asp:ListItem>
                        <asp:ListItem Value="BiWeekly">📆 Bi-Weekly</asp:ListItem>
                        <asp:ListItem Value="Monthly">🗓️ Monthly</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>Online Shopping (Packages/Month)</label>
                    <div class="number-input-wrapper">
                        <asp:TextBox ID="txtOnlineShopping" runat="server" TextMode="Number" placeholder="Enter packages" CssClass="number-input" />
                        <div class="number-controls">
                            <button type="button" class="number-btn" onclick="incrementValue('<%= txtOnlineShopping.ClientID %>')">▲</button>
                            <button type="button" class="number-btn" onclick="decrementValue('<%= txtOnlineShopping.ClientID %>')">▼</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label>Heating/Cooling Usage</label>
                <asp:DropDownList ID="ddlHeatingCooling" runat="server" CssClass="input">
                    <asp:ListItem Value="">Select Usage</asp:ListItem>
                    <asp:ListItem Value="None">❄️ None/Minimal</asp:ListItem>
                    <asp:ListItem Value="Moderate">🌡️ Moderate (4-8 hrs/day)</asp:ListItem>
                    <asp:ListItem Value="Heavy">🔥 Heavy (8+ hrs/day)</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- WASTE MANAGEMENT INPUT -->
        <div class="input-card">
            <h3><div class="input-icon">♻️</div> Waste Management</h3>
            <div class="form-row">
                <div class="form-group">
                    <label>Waste Generated (kg/day)</label>
                    <div class="number-input-wrapper">
                        <asp:TextBox ID="txtWasteGenerated" runat="server" TextMode="Number" placeholder="Enter kg" CssClass="number-input" step="0.1" />
                        <div class="number-controls">
                            <button type="button" class="number-btn" onclick="incrementValue('<%= txtWasteGenerated.ClientID %>')">▲</button>
                            <button type="button" class="number-btn" onclick="decrementValue('<%= txtWasteGenerated.ClientID %>')">▼</button>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>Recycling Habits</label>
                    <asp:DropDownList ID="ddlRecycling" runat="server" CssClass="input">
                        <asp:ListItem Value="">Select Habit</asp:ListItem>
                        <asp:ListItem Value="Never">❌ Never Recycle</asp:ListItem>
                        <asp:ListItem Value="Sometimes">🔄 Sometimes (25-50%)</asp:ListItem>
                        <asp:ListItem Value="Often">♻️ Often (50-75%)</asp:ListItem>
                        <asp:ListItem Value="Always">✅ Always (75-100%)</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <label>Composting</label>
                <asp:DropDownList ID="ddlComposting" runat="server" CssClass="input">
                    <asp:ListItem Value="">Select Option</asp:ListItem>
                    <asp:ListItem Value="Yes">✅ Yes, I compost</asp:ListItem>
                    <asp:ListItem Value="No">❌ No composting</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <asp:Button ID="btnSaveActivity" runat="server" Text="💾 Save & Calculate" CssClass="btn btn-calculate" OnClick="SaveActivity_Click" />
    </div>

    <!-- CALCULATION SECTION -->
    <div id="calculation" class="section">
        <h2>Emission Calculation Results</h2>
        
        <div class="view-toggle">
            <button class="active" onclick="toggleView('daily', this)" type="button">📅 Daily View</button>
            <button onclick="toggleView('monthly', this)" type="button">📆 Monthly Projection</button>
        </div>
        
        <div class="result-grid">
            <div class="result-card">
                <div class="result-icon">🚗</div>
                <h4>Transport Emission</h4>
                <div class="result-value">
                    <asp:Label ID="lblTransportEmission" runat="server" Text="0" />
                </div>
                <div class="result-unit">kg CO₂</div>
                <div class="result-percentage" id="transport-percent">0%</div>
            </div>

            <div class="result-card">
                <div class="result-icon">⚡</div>
                <h4>Electricity Emission</h4>
                <div class="result-value">
                    <asp:Label ID="lblElectricityEmission" runat="server" Text="0" />
                </div>
                <div class="result-unit">kg CO₂</div>
                <div class="result-percentage" id="electricity-percent">0%</div>
            </div>

            <div class="result-card">
                <div class="result-icon">🍽️</div>
                <h4>Food Emission</h4>
                <div class="result-value">
                    <asp:Label ID="lblFoodEmission" runat="server" Text="0" />
                </div>
                <div class="result-unit">kg CO₂</div>
                <div class="result-percentage" id="food-percent">0%</div>
            </div>

            <div class="result-card">
                <div class="result-icon">💧</div>
                <h4>Water Emission</h4>
                <div class="result-value">
                    <asp:Label ID="lblWaterEmission" runat="server" Text="0" />
                </div>
                <div class="result-unit">kg CO₂</div>
                <div class="result-percentage" id="water-percent">0%</div>
            </div>

            <div class="result-card">
                <div class="result-icon">🏠</div>
                <h4>Lifestyle Emission</h4>
                <div class="result-value">
                    <asp:Label ID="lblLifestyleEmission" runat="server" Text="0" />
                </div>
                <div class="result-unit">kg CO₂</div>
                <div class="result-percentage" id="lifestyle-percent">0%</div>
            </div>

            <div class="result-card">
                <div class="result-icon">♻️</div>
                <h4>Waste Emission</h4>
                <div class="result-value">
                    <asp:Label ID="lblWasteEmission" runat="server" Text="0" />
                </div>
                <div class="result-unit">kg CO₂</div>
                <div class="result-percentage" id="waste-percent">0%</div>
            </div>
        </div>

        <div class="total-card">
            <h3>Total Carbon Footprint</h3>
            <div class="total-value">
                <asp:Label ID="lblTotalEmission" runat="server" Text="0" /> <span style="font-size:24px;">kg CO₂</span>
            </div>
            
            <div class="projection-info">
                <h4>Projection</h4>
                <div class="projection-value">
                    0 <span style="font-size:16px;">kg CO₂ / day</span>
                </div>
            </div>
        </div>

        <div class="comparison-box">
            <div class="comparison-icon">📊</div>
            <div class="comparison-text">Compared to average user</div>
        </div>

        <div class="tree-offset">
            <div class="tree-offset-icon">🌳</div>
            <div class="tree-offset-text">
                <strong>Plant <span id="trees-needed">0</span> trees</strong> to offset today's emissions
            </div>
        </div>

        <div class="action-buttons">
            <asp:Button ID="btnSaveToHistory" runat="server" Text="💾 Save to History" CssClass="btn" OnClick="SaveActivity_Click" />
            <asp:Button ID="btnRecalculate" runat="server" Text="🔄 Recalculate" CssClass="btn btn-secondary" OnClick="Recalculate_Click" />
            <asp:HyperLink ID="lnkViewRecommendations" runat="server" Text="💡 View Recommendations" CssClass="btn btn-secondary" NavigateUrl="Guide.aspx" />
        </div>
    </div>

    <!-- GRAPH SECTION -->
    <div id="graph" class="section">
        <h2>Emission Trend Analysis</h2>
        
        <div class="graph-controls">
            <div class="chart-type-buttons">
                <button class="active" type="button" onclick="changeChartType('line', this)">📈 Line</button>
                <button type="button" onclick="changeChartType('bar', this)">📊 Bar</button>
                <button type="button" onclick="changeChartType('doughnut', this)">🍩 Doughnut</button>
            </div>
            
            <div class="time-filter">
                <select onchange="changeTimeRange(this)">
                    <option value="7days">Last 7 Days</option>
                    <option value="30days">Last 30 Days</option>
                    <option value="6months">Last 6 Months</option>
                </select>
            </div>
        </div>

        <div class="category-toggles">
            <div class="category-toggle">
                <input type="checkbox" id="toggle-transport" checked onchange="toggleCategory(this, 0)">
                <label for="toggle-transport">🚗 Transport</label>
            </div>
            <div class="category-toggle">
                <input type="checkbox" id="toggle-electricity" checked onchange="toggleCategory(this, 1)">
                <label for="toggle-electricity">⚡ Electricity</label>
            </div>
            <div class="category-toggle">
                <input type="checkbox" id="toggle-food" checked onchange="toggleCategory(this, 2)">
                <label for="toggle-food">🍽️ Food</label>
            </div>
            <div class="category-toggle">
                <input type="checkbox" id="toggle-water" checked onchange="toggleCategory(this, 3)">
                <label for="toggle-water">💧 Water</label>
            </div>
            <div class="category-toggle">
                <input type="checkbox" id="toggle-lifestyle" checked onchange="toggleCategory(this, 4)">
                <label for="toggle-lifestyle">🏠 Lifestyle</label>
            </div>
            <div class="category-toggle">
                <input type="checkbox" id="toggle-waste" checked onchange="toggleCategory(this, 5)">
                <label for="toggle-waste">♻️ Waste</label>
            </div>
        </div>
        
        <div class="graph-container">
            <canvas id="emissionChart"></canvas>
        </div>

        <div class="graph-insights">
            <div class="insight-card">
                <h4>🌱 Lowest Emission Day</h4>
                <div class="insight-value">32 kg</div>
                <div class="insight-date">January 10, 2026</div>
            </div>
            <div class="insight-card worst">
                <h4>⚠️ Highest Emission Day</h4>
                <div class="insight-value">65 kg</div>
                <div class="insight-date">January 15, 2026</div>
            </div>
        </div>

        <p style="text-align:center; color:#999; margin-top:25px; font-size:14px;">
            💡 <strong>Daily Goal:</strong> 40 kg CO₂ | Track your carbon footprint over time to identify patterns and improvement opportunities.
        </p>
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
</body>
</html>
