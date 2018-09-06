const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.sendPushNotification = functions.database.ref('/reports')
    .onWrite((snapshot, context) => {

      // var report = snapshot.val();
      //
      // var carBrand = JSON.stringify(child.carBrand)
      // var carSeries = JSON.stringify(child.carSeries)
      //
      // console.log('Car brand: ' + carBrand)
      // console.log('Report: ' + report)
      // console.log('Car series: ' + carSeries)
      // console.log('Report car brand: ' + child.carBrand)
      // console.log('Report car series: ' + child.carSeries)


      const topic = 'RBEriksen';
      var payload = {
        topic: topic,
        notification: {
          title: 'Ny rapport uploadet!',
          body: 'Besigtigelse af *bil navn* er nu klar.',
        }
      }

      admin.messaging().send(payload)
        .then((response) => {
        return console.log('Successfully sent notification:', response);
      })
      .catch((error) => {
        return console.log('Error sending notification:', error);
    });
});
