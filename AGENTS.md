# edu.rgo.pt maintenance

This repository is the static source for `https://edu.rgo.pt/`. Keep the existing plain HTML/CSS/JavaScript structure; `public/index.html`, `public/main.html`, `public/site-lib/scripts/webpage.js`, `public/site-lib/styles/main-styles.css`, and `public/content/main.canvas` are the minimum deployable files checked by CI.

## Verification and push-to-deploy

Pushes to `main` are deployed automatically by the Git-integrated Cloudflare Pages project `edu`. Cloudflare uses `main` as the production branch, runs `bash scripts/verify-site.sh`, and publishes `public/`; other branches receive preview deployments. The custom production domain is `edu.rgo.pt`, with `https://edu-6em.pages.dev/` as the direct Pages fallback.

GitHub also runs `.github/workflows/deploy.yml` as an independent verification check. Keep the GitHub and Cloudflare gates pointed at the same `scripts/verify-site.sh` entrypoint so their acceptance criteria cannot drift.

Production analytics use the self-hosted Umami instance at `analytics.rgo.pt` with website ID `01ab2edc-295f-49be-847c-c5d864a59106`. Keep `data-domains="edu.rgo.pt"` on the tracker so Pages previews and local development do not pollute production analytics, and keep the matching script/connect origins in `public/_headers`.

This site has no package manager, Docker build, or Devenv environment, so adding those only for cache uniformity would slow the current sub-minute verification. If a build tool is introduced, declare it with Devenv/Nix, use its frozen lockfile, and add dependency/build caching keyed by all lock and environment inputs. Validate workflow edits with `actionlint` and confirm both the Cloudflare deployment and the public custom domain after deployment.

Preserve unrelated changes, use scoped commits, and do not put credentials or local Wrangler state in the repository. Cloudflare authentication belongs in the account integration, not application configuration.

---

## Meaning-preserving writing rules

Use these rules whenever you reorganize, rewrite, simplify, summarize, or edit project notes.

### Source of truth

The original text is the source of truth. Preserve its meaning, claims, examples, uncertainty, emphasis, status, and point of view. Do not replace it with what you think the author should have meant.

### Main rule

Improve structure and readability with the smallest necessary rewrite. Prefer moving, grouping, splitting, labeling, and adding headings before changing the wording.

### Required behavior

1. Keep every distinct idea. Do not delete a point because it feels repetitive, weak, informal, controversial, or unfinished.
2. Preserve qualifiers such as “I think”, “might”, “in my experience”, “probably”, “ymmv”, and “I do not know”. Do not turn an opinion into a fact or uncertainty into confidence.
3. Preserve the status of each thought. A possible idea must stay a possible idea. Do not turn an idea, example, research lead, or thought experiment into a proposal, plan, roadmap, pilot, recommendation, or commitment unless the source clearly does so.
4. Preserve examples, numbers, links, names, caveats, jokes, strong language, and personal details unless the user explicitly asks to remove them.
5. Keep external source notes separate from the author's own views. Never make a quoted or summarized source sound like the author personally endorses it.
6. Do not fact-check, reconcile contradictions, or silently correct claims unless the user explicitly asks for research or verification.
7. Read nearby notes and the surrounding section before deciding that a sentence is incomplete. Informal or compressed wording is not automatically missing content.
8. Only add a clarification marker when there are at least two materially different readings and the distinction affects the meaning or organization. Do not invent a missing word merely to improve the grammar.
9. When a point is genuinely ambiguous or unfinished, keep the original wording and add a short `[Clarify: ...]` note or ask one precise question.
10. Any new idea must be clearly labeled as `Added suggestion`, `Working synthesis`, or `Open question`. Do not blend additions into the author's original writing.
11. Use simple words, short sentences, and clear headings. Keep the author's natural tone. Do not make the text corporate, academic, inflated, or AI-like.
12. Do not use em dashes or en dashes. Use commas, full stops, colons, parentheses, or separate sentences.
13. Avoid decorative punctuation and unnecessary symbols. Preserve symbols that are part of quoted or source material.
14. Do not add generic introductions, conclusions, motivational language, or filler.
15. Do not compress several specific points into one vague sentence.
16. Keep Markdown simple. Use headings and bullets only when they improve the hierarchy.
17. When the author later clarifies an ambiguous note, treat that clarification as authoritative. Apply it to the organized version. If a verbatim copy exists, keep the original wording there and add the clarification separately.

### Preferred workflow

1. Read all source material before editing.
2. Build a content inventory of every distinct idea.
3. Identify the status of each item, such as observation, problem, question, source note, possible idea, or active plan.
4. Group related ideas into a clear hierarchy.
5. Move the original text into that hierarchy.
6. Make only the smallest wording changes needed for clarity.
7. Use surrounding context before raising clarification questions.
8. Mark genuine ambiguities instead of guessing.
9. Check every source idea against the final version.
10. Report anything omitted, merged, interpreted, newly added, or given a different status.

### JSON Canvas rules

When editing a `.canvas` file:

- Preserve every original node ID whenever possible.
- Preserve every original link URL and file path.
- Do not delete a node merely because it is redundant. Move it into the right section or label it as a duplicate.
- Groups and heading nodes may be added for organization.
- Connections may be rebuilt when the original layout is unclear, but do not create a relationship that changes the meaning.
- Keep external source summaries in a clearly labeled source area.
- Do not make one speculative node the center of the Canvas unless the source treats it as the central idea.
- Validate unique IDs, required fields, and all edge references before finishing.

### Final preservation check

Before returning the result, verify all of the following:

- Every original idea still exists.
- No opinion became a fact.
- No uncertainty was removed.
- No possible idea became an active plan.
- No external claim became the author's claim.
- No example, caveat, or link disappeared.
- Every added idea is labeled.
- Every genuine ambiguity is marked.
- No clarification was invented from unusual grammar alone.
- The writing uses simple punctuation and contains no em dashes.
