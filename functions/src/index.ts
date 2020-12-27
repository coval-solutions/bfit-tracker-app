import * as express from 'express';
import * as functions from 'firebase-functions';
import { BigQuery } from '@google-cloud/bigquery';
import authenticate from './authenticate';

const app = express();

// Use the middleware `authenticate`
app.use(authenticate);

// GET /api/workout-started-count/{workoutDocRef}
app.get('/workout-started-count/:workoutDocRef', async (req, res) => {
  const { workoutDocRef } = req.params;

  functions.logger.info(
    `Looking up Workout started count for DocRef "${workoutDocRef}"`,
  );

  try {
    const bigQuery = new BigQuery();
    const query = `SELECT count
      FROM \`bfit-tracker-app.analytics_211868704.workouts_started\`
      WHERE workout_doc_ref = '${workoutDocRef}'
      LIMIT 1`;

    // Run the query as a job
    const [job] = await bigQuery.createQueryJob({ query });
    functions.logger.info(`Job ${job.id} started.`);

    // Wait for the query to finish
    const [rows] = await job.getQueryResults();

    if (rows === undefined) {
      return res.sendStatus(500);
    }

    if (rows.length === 0) {
      return res.json({ count: 0 });
    }

    // Cache response for 30 mins
    res.set('Cache-Control', 'private, max-age=1800');
    return res.json(rows[0]);
  } catch (error) {
    functions.logger.error(
      'Error getting workout started count',
      workoutDocRef,
      error.message,
    );

    return res.sendStatus(500);
  }
});

// GET /api/article-viewed-counts
app.get('/article-viewed-counts', async (req, res) => {
  functions.logger.info('Looking up Article viewed counts');

  try {
    const bigQuery = new BigQuery();
    const query = 'SELECT article_doc_ref, count FROM bfit-tracker-app.analytics_211868704.articles_viewed';

    // Run the query as a job
    const [job] = await bigQuery.createQueryJob({ query });
    functions.logger.info(`Job ${job.id} started.`);

    // Wait for the query to finish
    const [rows] = await job.getQueryResults();

    if (rows === undefined) {
      return res.sendStatus(500);
    }

    // Cache response for 30 mins
    res.set('Cache-Control', 'private, max-age=1800');
    return res.json(rows);
  } catch (error) {
    functions.logger.error('Error getting article viewed count', error.message);

    return res.sendStatus(500);
  }
});

// Expose the API as a function
exports.api = functions
  .region(process.env.REGION ?? 'europe-west2')
  .https.onRequest(app);
