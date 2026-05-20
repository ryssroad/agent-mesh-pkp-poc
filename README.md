# Agent Mesh PKP PoC

**Status:** draft concept / PoC seed  
**Working primitive:** `PKP` — Packed Knowledge/KV Packet  
**Goal:** let trusted AI agents hand off conclusions, evidence, computation trails, and optional sealed same-runtime KV accelerators without forcing a human to manually repeat context.

## Short version

Most multi-agent systems share chat logs. This project proposes a stronger old-school primitive:

```text
subject → claim → evidence → computation trail → optional sealed KV capsule → replay recipe
```

The valuable object is not “what an agent said”. It is:

```text
what the agent concluded,
why it concluded that,
which computation/evidence supports it,
and how another agent can verify, dispute, or continue it.
```

## Layers

```text
L0 Claim Capsule       compact conclusion about a subject
L1 Context Capsule     readable handoff context for another agent
L2 Evidence Capsule    excerpts, diffs, files, tests, source refs
L3 Compute Capsule     tool calls, prompts, commands, retrievals, intermediate artifacts
L4 KV Capsule          optional sealed same-runtime KV tensors for local acceleration
L5 Replay Capsule      recipe to reproduce/recompute from canonical artifacts
```

Default handoff should send L0–L1. L2–L5 are dereferenced only when needed.

## Why not just share KV-cache?

KV-cache is useful as a local accelerator, but it is not durable memory and not a safe cross-agent exchange format. It is model/runtime/tokenizer/template specific and can carry sensitive latent state.

This PoC treats KV as:

```text
optional sealed runtime accelerator, never canonical memory
```

Canonical exchange is claim/evidence/computation/replay.

## Example UX

```text
User: Claude, inspect what Codex concluded about the parser.

Mesh:
  1. find Codex ClaimPack for subject=parser
  2. send L0/L1 to Claude
  3. let Claude request L2/L3 if it wants evidence
  4. attach L4 only if same-owner, same-runtime, policy-compatible
  5. store Claude response as claim/counterclaim
```

## Repository contents

- [`docs/POC_CONCEPT.md`](docs/POC_CONCEPT.md) — main concept draft.
- [`docs/PACKET_LAYERS.md`](docs/PACKET_LAYERS.md) — layer breakdown and handoff modes.
- [`schemas/pkp.claim.v1.example.json`](schemas/pkp.claim.v1.example.json) — example claim capsule.
- [`schemas/pkp.kv.v1.example.json`](schemas/pkp.kv.v1.example.json) — example sealed KV capsule manifest.
- [`examples/codex-to-claude-handoff.md`](examples/codex-to-claude-handoff.md) — sample handoff packet.

## MVP path

1. `ClaimPack`: create/show/handoff compact claims.
2. `ComputePack`: attach evidence, diffs, tool calls, command logs.
3. `KVCapsule policy simulator`: validate compatibility/security without real tensors.
4. Real local same-runtime KV acceleration for one model/runtime.

## Security baseline

```text
private by default
no cross-user KV
no unsigned KV import
no owner-private KV in shareable packets
strict model/runtime/tokenizer/template matching
TTL required for KV
claim/evidence/replay must work without KV
```

## License

Draft concept. License TBD.
