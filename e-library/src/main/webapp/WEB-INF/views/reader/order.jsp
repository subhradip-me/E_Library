<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
<h2>Processing Payment</h2>
<script>
    var options = {
        "key": "${key}",
        "amount": "${amount*100}", 
        "currency": "INR",
        "name": "Test Company",
        "description": "Demo Transaction",
        "handler": function (response){
            window.location.href = "/orderdetails?payment_id=" + response.razorpay_payment_id;
        },
        "prefill": {
            "name": "${custName}",
            "email": "${custEmail}",
            "contact": "${custContact}"
        },
        "theme": {
            "color": "#3399cc"
        }
    };
    var rzp1 = new Razorpay(options);
    rzp1.open();
</script>
</body>
</html>
