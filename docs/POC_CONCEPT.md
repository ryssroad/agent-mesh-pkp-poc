# PKP PoC Concept: Packed Knowledge/KV Packet

## 1. Problem

In a small agent mesh, a human often becomes the message bus:

```text
Agent A writes something → human copies/summarizes → Agent B reacts → human copies again
```

This loses nuance, provenance, and auditability. Raw transcripts are too bulky; plain summaries are too weak; raw KV-cache is too model-specific and sensitive.

## 2. Proposed primitive

Create a packed object that can be passed between agents:

```text
PKP = Claim Capsule + Context Capsule + Evidence Capsule + Compute Capsule + optional KV Capsule + Replay Capsule
```

A PKP should answer:

- What is the concrete conclusion?
- What subject/object is it about?
- Who produced it?
- What evidence supports it?
- What computation produced it?
- What uncertainty remains?
- Can another agent verify, dispute, or continue it?
- Is there compatible sealed KV for local acceleration?

## 3. Object semantics

### Subject

The object being reasoned about:

```text
code area, document, task, architectural decision, user intent, market, incident, memory item
```

### Claim

A compact conclusion about the subject:

```text
"The parser should remain version-aware; a lossy normalized AST would hide version-specific vulnerability patterns."
```

### Evidence

References to artifacts that support or challenge the claim:

```text
diffs, test output, source excerpts, transcript ranges, command logs, retrieved docs
```

### Computation

How the claim was produced:

```text
prompt, tools, commands, retrievals, intermediate outputs, model/run metadata
```

### KV Capsule

Optional runtime accelerator:

```text
compressed/sealed KV tensors for exact same model/runtime/tokenizer/template/trust boundary
```

### Replay

Recipe to rebuild or audit the result without trusting the packet blindly.

## 4. Handoff modes

### `claim_only`

Smallest packet: claim, rationale, confidence, evidence refs.

### `claim_plus_evidence`

Normal review: claim plus key excerpts/diffs/tests.

### `full_compute_bundle`

Deep audit: prompts, tool calls, commands, retrieval logs, artifacts.

### `sealed_kv_accelerator`

Ultra mode: add KV only when policy-compatible.

## 5. Claim graph

Claims should be addressable and disputable:

```text
claim → review → counterclaim → synthesis → accepted decision
```

This turns agent dialogue into a graph of verifiable computational assertions, not a pile of chat logs.

## 6. Old-school chain angle

Each packet can be committed into an append-only hash chain:

```text
record = hash(prev_hash + payload_hash + actor + timestamp + signature)
```

This gives:

- provenance;
- tamper evidence;
- audit trail;
- optional later Merkle-root anchoring.

No private transcripts, secrets, or KV tensors should be placed on a public chain.

## 7. Non-goals for PoC

- No public multi-tenant KV sharing.
- No universal model memory.
- No raw chain-of-thought persistence by default.
- No blockchain-first implementation.
- No replacement for Git/Honcho/vector DBs.

## 8. PoC success criterion

The PoC works when a coordinator can do:

```text
handoff --from codex --to claude --subject parser --mode claim_plus_evidence
```

And Claude receives:

- the claim;
- the rationale;
- evidence refs;
- open questions;
- optional deeper computation links;
- no unrelated transcript flood.
