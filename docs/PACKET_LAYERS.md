# Packet Layers

## L0 — Claim Capsule

Compact conclusion about a subject.

Fields:

- packet_id
- subject
- claim text
- claim type
- status: proposed / accepted / rejected / superseded
- confidence
- rationale
- counterpoints
- producer
- created_at
- privacy
- evidence refs

## L1 — Context Capsule

Readable handoff context for another agent.

Contains:

- task intent;
- project/subject summary;
- relevant claim;
- requested output format;
- constraints and privacy label.

## L2 — Evidence Capsule

Inspectable support material.

Contains:

- source excerpts;
- transcript refs, not necessarily whole transcript;
- diffs/patches;
- test output;
- file refs;
- artifact hashes.

## L3 — Compute Capsule

How the conclusion was produced.

Contains:

- prompts/messages used for the run;
- tool calls;
- command invocations;
- retrieval queries/results;
- intermediate artifacts;
- environment metadata.

## L4 — KV Capsule

Optional sealed acceleration layer.

Rules:

- exact model hash match;
- exact tokenizer/template match;
- exact runtime/layout match;
- same owner/trust boundary;
- short TTL;
- signed and encrypted;
- never required for correctness.

## L5 — Replay Capsule

A recipe to recompute or audit.

Contains:

- repo/artifact refs;
- environment lock;
- commands;
- expected outputs;
- source hashes;
- verification steps.

## Default dereference policy

```text
Agent receives L0/L1 by default.
Agent may request L2 if skeptical.
Agent may request L3 for audit/replay.
Agent may receive L4 only if policy-compatible.
Agent uses L5 to rebuild from canonical artifacts.
```
