import * as express from 'express';
import * as functions from 'firebase-functions';
import { authenticate } from './authenticate';
import { BigQuery } from '@google-cloud/bigquery';

const app = express();
app.use(authenticate);

// GET /api/workout-started-count/{workoutDocRef}
// Get details about a message
app.get('/api/workout-started-count/:workoutDocRef', async (req, res) => {
  const workoutDocRef = req.params.workoutDocRef;

  console.log(`Looking up Workout started count for DocRef "${workoutDocRef}"`);

  try {
    const bigQuery = new BigQuery();
    const query = `SELECT name
      FROM \`bfit-tracker-app.analytics_211868704.workouts_started\`
      WHERE workout_doc_ref = ${workoutDocRef}`;

    // Run the query as a job
    const [job] = await bigQuery.createQueryJob({ query });
    console.log(`Job ${job.id} started.`);

    // Wait for the query to finish
    const [rows] = await job.getQueryResults();

    // Print the results
    console.log('Rows:');
    rows.forEach((row: any) => console.log(row));

    // Cache response for 30 mins
    res.set('Cache-Control', 'private, max-age=1800');
    return res.status(200).json(rows);
  } catch (error) {
    console.log(
      'Error getting workout started count',
      workoutDocRef,
      error.message
    );

    return res.sendStatus(500);
  }
});

// Expose the API as a function
exports.api = functions
  .region(process.env.REGION ?? 'europe-west2')
  .https.onRequest(app);
