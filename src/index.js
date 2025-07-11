const express = require('express');
const bodyParser = require('body-parser');
const { exec } = require('child_process');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 9090;

app.use(bodyParser.json());

app.post('/render', (req, res) => {
  const { src, format = 'svg', theme } = req.body;
  if (!src) return res.status(400).send('Missing "src" field');

  const inputPath = '/tmp/input.d2';
  const outputPath = `/tmp/output.${format}`;
  fs.writeFileSync(inputPath, src);

  // Apply --theme if provided
  const themeArg = theme ? `--theme=${theme}` : '';
  const cmd = `d2 ${themeArg} ${inputPath} ${outputPath}`;

  exec(cmd, (error) => {
    if (error) {
      console.error('D2 render error:', error);
      return res.status(500).send('Render failed');
    }

    const mime = format === 'svg' ? 'image/svg+xml' : 'image/png';
    res.setHeader('Content-Type', mime);
    fs.createReadStream(outputPath).pipe(res);
  });
});

app.listen(PORT, () => {
  console.log(`D2 Render API running on port ${PORT}`);
});
