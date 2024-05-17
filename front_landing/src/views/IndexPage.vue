<script setup></script>

<template>
  <section
    class="container d-flex flex-column justify-content-center align-items-center text-center vh-100"
  >
    <section class="title">
      <img src="/src/assets/logo/logo_with_title.png" alt="logo" />
    </section>
    <section class="qr">
      <img src="/src/assets/qrcode.png" alt="QR Code" />
    </section>
    <section class="download">
      <a href="https://dl06ulexuxmdt.cloudfront.net/app/runTime.apk" class="gradient-button">DOWNLOAD</a> 
    </section>
  </section>
</template>

<style scoped>
html,
body {
  height: 100%;
}

.container {
  height: 100%;
}

.title img {
  width: 256px;
  margin-bottom: 40px;
}

.qr img {
  width: 200px;
  margin-bottom: 40px;
}

.gradient-button {
  background: linear-gradient(
    to right,
    #0088ff,
    #9056e6
  );
  border: none;
  border-radius: 20px;
  color: white;
  width: 200px;
  display: inline-flex;
  padding: 15px 30px;
  font-size: 24px;
  font-weight: bold;
  text-decoration: none;
  cursor: pointer;
}

.gradient-button:hover {
  transform: scale(1.1);
}
</style>