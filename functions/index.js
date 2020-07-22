const functions = require('firebase-functions');


exports.myFunction = functions.firestore
    .document('chat/{message}')
    .onCreate((change, context) => {
        console.log(change.after.data());
    });

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
