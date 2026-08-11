#!/usr/bin/env bash
set -euo pipefail

git diff --check

required_files=(
  public/index.html
  public/main.html
  public/site-lib/scripts/webpage.js
  public/site-lib/styles/main-styles.css
  public/site-lib/media/favicon.svg
  public/content/main.canvas
)

for required_file in "${required_files[@]}"; do
  test -s "$required_file"
done

node --check public/site-lib/scripts/webpage.js

grep -Fq 'src="https://analytics.rgo.pt/script.js"' public/index.html
grep -Fq 'data-website-id="01ab2edc-295f-49be-847c-c5d864a59106"' public/index.html
grep -Fq 'data-domains="edu.rgo.pt"' public/index.html
grep -Fq "script-src 'self' https://analytics.rgo.pt" public/_headers
grep -Fq "connect-src 'self' https://analytics.rgo.pt" public/_headers
grep -Fq "font-src 'self' https://fonts.gstatic.com" public/_headers
grep -Fq -- '--bg: #fcf2c7' public/site-lib/styles/main-styles.css
grep -Fq -- '--bg: #282828' public/site-lib/styles/main-styles.css
grep -Fq 'font-family: "Bricolage Grotesque"' public/site-lib/styles/main-styles.css
grep -Fq 'data-callout=' public/site-lib/scripts/webpage.js

node <<'NODE'
const fs = require("node:fs");

const canvas = JSON.parse(fs.readFileSync("public/content/main.canvas", "utf8"));
const errors = [];
const nodeIds = new Set();
const allIds = new Set();

if (!Array.isArray(canvas.nodes) || !Array.isArray(canvas.edges)) {
  throw new Error("Canvas must contain node and edge arrays.");
}

for (const node of canvas.nodes) {
  if (!node.id || allIds.has(node.id)) errors.push(`Duplicate or missing node ID: ${node.id || "unknown"}`);
  allIds.add(node.id);
  nodeIds.add(node.id);
}

for (const edge of canvas.edges) {
  if (!edge.id || allIds.has(edge.id)) errors.push(`Duplicate or missing edge ID: ${edge.id || "unknown"}`);
  allIds.add(edge.id);
  if (!nodeIds.has(edge.fromNode) || !nodeIds.has(edge.toNode)) errors.push(`Dangling edge: ${edge.id}`);
}

if (errors.length) throw new Error(errors.join("\n"));
console.log(`Verified ${canvas.nodes.length} nodes and ${canvas.edges.length} edges.`);
NODE
