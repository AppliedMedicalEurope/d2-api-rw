const express = require('express');
const bodyParser = require('body-parser');
const { exec } = require('child_process');
const fs = require('fs');
const app = express();
const PORT = process.env.PORT || 9090;

app.use(bodyParser.json());

app.post('/render', (req, res) => {
  const { src, format = 'svg' } = req.body;
  if (!src) return res.status(400).send('Missing "src" field');

  const inputPath = '/tmp/input.d2';
  const outputPath = `/tmp/output.${format}`;
  fs.writeFileSync(inputPath, src);

  exec(`d2 ${inputPath} ${outputPath}`, (error, stdout, stderr) => {
    if (error) {
      console.error(stderr);
      return res.status(500).send('Render failed');
    }
    const mime = format === 'svg' ? 'image/svg+xml' : 'image/png';
    res.setHeader('Content-Type', mime);
    fs.createReadStream(outputPath).pipe(res);
  });
});

app.listen(PORT, () => {
  console.log(`D2 Render API listening on port ${PORT}`);
});
