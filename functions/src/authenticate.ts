// Express middleware that validates Firebase ID Tokens passed in the Authorization HTTP header.
// The Firebase ID token needs to be passed as a Bearer token in the Authorization HTTP header like this:
// `Authorization: Bearer <Firebase ID Token>`.
// when decoded successfully, the ID Token content will be added as `req.user`.
import * as admin from 'firebase-admin';
import { Response } from 'express';
import * as dotenv from 'dotenv';

// Load the .env
dotenv.config();

console.log(process.env.SERVICE_ACCOUNT_JSON);
const serviceAccount = require(process.env.SERVICE_ACCOUNT_JSON!);
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: process.env.DATABASE_URL,
});

export const authenticate = async (req: any, res: Response, next: Function) => {
  if (
    !req.headers.authorization ||
    !req.headers.authorization.startsWith('Bearer ')
  ) {
    res.status(403).send('Unauthorized, token was not provided');
    return;
  }

  const idToken = req.headers.authorization.split('Bearer ')[1];
  try {
    console.log(idToken);
    req.user = await admin.auth().verifyIdToken(idToken);
    next();
    return;
  } catch (e) {
    res.status(403).send('Unauthorized, idToken: ' + idToken);
    return;
  }
};
