const { exec } = require("child_process");
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    exec("./pan-sandbox-backups.sh", (error, stdout, stderr) => {
        if (error) {
            console.log(`error: ${error.message}`);
            return;
        }
        if (stderr) {
            console.log(`stderr: ${stderr}`);
            return;
        }
        console.log(`stdout: ${stdout}`);
    });
});

const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log(`gcloud-pantheon-backups: listening on port ${port}`);
});