# Example Handoff: Codex → Claude

## Intent

Review a claim produced by Codex. Do not assume it is true. Request deeper evidence if needed.

## Claim

Codex proposes that the parser should remain version-aware instead of forcing all source variants into one lossy normalized representation.

## Rationale

- Version-specific semantics may affect downstream analysis.
- Lossy normalization can hide edge cases.
- A derived common IR can still exist, but should not replace version-aware source modeling.

## Evidence refs

- `evidence/diff.patch`
- `evidence/tests.jsonl`
- `evidence/transcript.refs.jsonl`

## Open loops

- Verify concrete source-version edge cases.
- Decide whether common IR is useful as a secondary derived view.
- Add regression tests for the selected edge cases.

## Requested response

Please produce:

1. agreement/disagreement;
2. missing risks;
3. tests to add;
4. proposed counterclaim if needed;
5. final next action.
