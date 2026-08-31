# Decisions log

Substantive choices made while running this study, recorded as they happen.

## What goes here

Analytic decisions that a reader could reasonably question:

- Exclusion criteria, and why
- How missing data was handled
- Operationalizations — which items formed a scale and why those
- Model specification choices
- Deviations from the preregistration
- How an unexpected data problem was resolved
- Decisions made in response to peer review

## What does not

Git already records changes to code, in more detail than you could write by hand. This file is for the reasoning that does not appear in a diff.

## Why bother

Reviewers ask about these, usually a year after everyone has forgotten. So do collaborators, new team members, and you.

The reasoning behind an exclusion feels obvious and unforgettable on the day you make it. It is neither, six months later. Write the entry the day you make the decision — a log reconstructed at the end is a reconstruction, not a record.

---

## Format

Newest at the top. One entry per decision.

```markdown
## YYYY-MM-DD — Short title

**Decision:** What was decided.

**Rationale:** Why. Include what was considered and rejected.

**Preregistered:** Yes / No / Deviation (with explanation)

**Impact:** What this changes — sample size, which analyses are affected.

**Decided by:** Names
```

---

# Entries

## [YYYY-MM-DD] — Example entry (delete this)

**Decision:** Exclude participants who completed the survey in under three minutes.

**Rationale:** Pilot testing established that careful completion takes at least five minutes. Responses under three minutes showed straight-lining across reverse-coded items, indicating non-engagement rather than fast reading. Three minutes was chosen over five as a conservative threshold that removes clear non-response without discarding genuinely quick readers.

**Preregistered:** Yes — Section 4.2 of the preregistration.

**Impact:** Removes 22 of 250 cases. Analytic n = 228. Applied in `code/01_clean.R`.

**Decided by:** [Names]
