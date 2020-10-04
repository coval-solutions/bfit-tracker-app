import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

const endpoint = functions.region(process.env.REGION ?? 'europe-west2').https;

/**
 * This cloud function shall get number of times a workout has been started
 */
export const getWorkoutCount = endpoint.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});
