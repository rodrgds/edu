# edu.rgo.pt maintenance

This repository is the static source for `https://edu.rgo.pt/`. Keep the existing plain HTML/CSS/JavaScript structure; `index.html`, `main.html`, `site-lib/scripts/webpage.js`, and `site-lib/styles/main-styles.css` are the minimum deployable files checked by CI.

## Verification and push-to-deploy

Pushes to `main` run `.github/workflows/deploy.yml`. The verification job performs whitespace and required-file checks, then the deploy job signs a request to `https://webhooks.rgo.pt/hooks/deploy-edu`. The NixOS service fetches the verified main revision, syncs it to the dedicated site root, and checks `https://edu.rgo.pt/`; its source of truth is `~/.config/home/modules/hosting/sites/edu.nix` and `~/.config/home/modules/hosting/deployments/default.nix`.

This site has no package manager, Docker build, or Devenv environment, so adding those only for cache uniformity would slow the current sub-minute verification. If a build tool is introduced, declare it with Devenv/Nix, use its frozen lockfile, add dependency/build caching keyed by all lock and environment inputs, and change both the workflow and Nix deploy service together. Validate workflow edits with `actionlint` and confirm the public page after deployment.

Preserve unrelated changes, use scoped commits, and do not put credentials in the repository. The GitHub `DEPLOY_WEBHOOK_SECRET` and the VPS webhook allow-list are deployment infrastructure, not application configuration.
