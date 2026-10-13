# Working with an AI assistant on a research project

Why this template asks you to verify and understand work that an AI assistant
produced, and what that looks like in practice. This is the written version
of an argument we expect to present to the research team; the ideas here
should match what Claude is told in [`../CLAUDE.md`](../CLAUDE.md).

---

## Where this comes from

The framing is Scott Cunningham's, from his lecture *AI Methods for Research
Workers* (Texas A&M, October 2026; slides dated 2 October 2026). What follows
is our reading of his slides, not a transcript. Where we paraphrase him we say
so; the applications to foundry10 are ours.

## Three things that used to come as one

Cunningham's central point is that doing research used to bundle three
activities. We call them by his names.

**Production** is making the thing: writing the code, running the model,
building the table. **Understanding** is knowing what the thing is and why it
is right. **Verification** is checking that it is right. Before AI, a
researcher could not produce an analysis without understanding it, and the
habits of producing it (looking at the data, watching the model converge,
reading the table as it came out) verified it along the way. Nobody did these
as separate steps. They were a byproduct of sitting there.

An AI agent separates them. It can read your files, write and run the code,
and hand you a table in less time than it takes to read this paragraph.
Production is now nearly free. But you did not do it, so you cannot be sure it
is right, and if it cost you no time, you almost certainly do not understand
it. Verification and understanding no longer come along with the work. Each
is now something you do on purpose, or do not do at all.

Cunningham draws the consequence for standards: if producing output is free,
tolerating a small error rate means producing a large number of errors. His
position is that zero errors has to be the constraint the workflow is built
around, not a cost to trade against speed.

## The errors are not typos

The errors an agent introduces are mostly not the ones a careful human makes.
Cunningham lists four, and we have seen all of them:

- **Cherry-picking.** The agent reports the results that look best and leaves
  out the others.
- **Cue-driven analysis.** The agent runs analyses in response to stray
  remarks in the conversation, including beliefs the researcher expressed
  about what the literature says.
- **Specification searching.** The agent tries outcomes, covariates, or
  samples until something matches the signal it picked up.
- **Rule-breaking.** The agent quietly violates a rule it was given, such as
  a preregistered exclusion or a sample definition.

None of these is visible in the table the agent hands you. His experiments
with agents doing causal inference found that cues the researcher never
considered, such as a methodology document sitting in the folder, changed
which estimator the agent chose, and the agent did not report that it had.

## What this means for a foundry10 project

The template is built so that verification and understanding are part of the
workflow rather than acts of will. Each piece maps onto one of the three legs.

| Leg | What the template does |
|---|---|
| Production | `code/run_all.R` rebuilds everything from raw data. If an output is not produced by the pipeline, it is not evidence. |
| Verification | Every number in `reports/full_report.qmd` is inline code reading from `results/`, so a number cannot drift from the code that made it. `stopifnot()` checks make silent data loss fail loudly. `/check-report` compares the report against `docs/reporting-standards.md` and flags analyses that were run but not reported. |
| Understanding | Code uses packages a researcher already knows before anything written for the project, and stays at the level of `lm()`, dplyr, and ggplot2 unless the researcher chooses otherwise. `docs/decisions.md` records why, not just what. |

### Three habits we ask of researchers

**Read what changed.** When Claude edits a script, read the diff before you
run it, the way you would read a collaborator's pull request. If the change is
too large to read, ask for it in smaller pieces, one table or figure at a
time. Cunningham's phrase for this is that the diff is the unit of
observation.

**Verify through the pipeline, not by eye.** Do not ask whether a table looks
right. Re-run `run_all.R`, read the rendered report, run `/check-report`. For
a headline number, ask Claude to refit the model a second way (a different
package, or base R against a package) and compare. The two will agree when
both are right and disagree when one is wrong, and the disagreement tells you
where to look.

**Understand before you accept.** If you cannot explain a piece of code or a
method to a colleague, you are not ready to put its output in a report. Ask
Claude to explain it in plain language, and ask for the simpler version if one
exists. Start with tasks whose output you can judge, and work outward from
there.

### What we ask of Claude

The corresponding instructions are in [`../CLAUDE.md`](../CLAUDE.md) under
*Working with the researcher*. In short: report every analysis that was run,
not only the ones that look good; never change a specification, sample, or
estimator in response to a conversational cue without naming the cue and
asking; follow the stated rules and say so when one cannot be followed; make
every change small enough to review and say what to look at; explain anything
new before using it; and never describe output as checked unless the check was
actually run.

## Prose does not enforce

Cunningham is blunt about the limits of instruction files. A `CLAUDE.md` is a
briefing the agent reads at the start of a session, and Anthropic's own
documentation describes it as context rather than enforced configuration. An
agent under load will skip an instruction, apologize, and skip it again. For a
rule that must hold every time, the tool to reach for is a *hook*: a shell
command Claude Code runs automatically before or after an action, which can
block the action regardless of what the model decided.

We have not added hooks to the template yet. The candidates, in order of
value, are a hook that blocks any edit to an existing file in `data/raw/`, a
hook that blocks `git add -f` on anything matching the data-file patterns,
and a hook that blocks writing a `.csv` with a participant-ID column into
`results/`. Each is structural (it matches a file path, not words), narrow,
and hands back one plain sentence. Until then, the rules in `CLAUDE.md` are
requests, and the researcher's review is the gate.

## Notes toward the team presentation

The argument, in the order we expect to tell it:

1. Production, verification, and understanding used to be one activity. AI
   makes production free and leaves the other two to be done on purpose.
2. The errors are hidden choices, not typos: cherry-picking, cue-driven
   analysis, specification searching, rule-breaking. The table does not show
   them.
3. Zero errors is the constraint, because free production turns a small error
   rate into many errors.
4. The template is the workflow: pipeline, numbers from code, full report,
   checker, decisions log, simple code.
5. Three habits: read the diff, verify through the pipeline, understand before
   you accept.
6. The scarce skill is no longer producing output. It is knowing what to
   delegate, what to constrain, what to check independently, and when the
   judgment has to be human.
