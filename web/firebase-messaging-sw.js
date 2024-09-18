importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyBRobgZqIC-dFsr05MzxUQXxQITjKpnDH0",
      authDomain: "emarket-e420c.firebaseapp.com",
      projectId: "emarket-e420c",
      storageBucket: "emarket-e420c.appspot.com",
      messagingSenderId: "151590191214",
      appId: "1:151590191214:web:6d2f54d2dd45fc7aa5667f",
      measurementId: "G-RQ899NQVHN"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});