# edu.rgo.pt maintenance

This repository is the static source for `https://edu.rgo.pt/`. Keep the existing plain HTML/CSS/JavaScript structure; `public/index.html`, `public/main.html`, `public/site-lib/scripts/webpage.js`, `public/site-lib/styles/main-styles.css`, and `public/content/main.canvas` are the minimum deployable files checked by CI.

## Verification and push-to-deploy

Pushes to `main` are deployed automatically by the Git-integrated Cloudflare Pages project `edu`. Cloudflare uses `main` as the production branch, runs `bash scripts/verify-site.sh`, and publishes `public/`; other branches receive preview deployments. The custom production domain is `edu.rgo.pt`, with `https://edu-6em.pages.dev/` as the direct Pages fallback.

GitHub also runs `.github/workflows/deploy.yml` as an independent verification check. Keep the GitHub and Cloudflare gates pointed at the same `scripts/verify-site.sh` entrypoint so their acceptance criteria cannot drift.

This site has no package manager, Docker build, or Devenv environment, so adding those only for cache uniformity would slow the current sub-minute verification. If a build tool is introduced, declare it with Devenv/Nix, use its frozen lockfile, and add dependency/build caching keyed by all lock and environment inputs. Validate workflow edits with `actionlint` and confirm both the Cloudflare deployment and the public custom domain after deployment.

Preserve unrelated changes, use scoped commits, and do not put credentials or local Wrangler state in the repository. Cloudflare authentication belongs in the account integration, not application configuration.
