
// Minimaler Test-SW
console.log('[SW] Geladen!');

importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js');

firebase.initializeApp({
    apiKey: "AIzaSyD2LRPL7EOQM-Z-ZpAGbKw4FygByLOfUDc",
    authDomain: "projekti-6bb4c.firebaseapp.com",
    projectId: "projekti-6bb4c",
    storageBucket: "projekti-6bb4c.firebasestorage.app",
    messagingSenderId: "584129027887",
    appId: "1:584129027887:web:5bdad06a3cd3ccac8ecbda",
});

firebase.messaging();

self.addEventListener('install', () => {
  console.log('[SW] Installiert');
  self.skipWaiting();
});

self.addEventListener('activate', () => {
  console.log('[SW] Aktiviert');
});