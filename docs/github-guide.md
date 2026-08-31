# Using GitHub for research projects

A guide for researchers who have never used GitHub before. No prior experience assumed.

Read the first four sections before you start a project. Come back to the rest when you need them.

**Contents**

1. [What Git and GitHub actually are](#1-what-git-and-github-actually-are)
2. [One-time setup](#2-one-time-setup)
3. [Creating your project repository](#3-creating-your-project-repository)
4. [Private and public](#4-private-and-public)
5. [Cloning to your computer](#5-cloning-to-your-computer)
6. [The daily loop](#6-the-daily-loop)
7. [Writing commit messages](#7-writing-commit-messages)
8. [Undoing things](#8-undoing-things)
9. [Working with other people](#9-working-with-other-people)
10. [Merge conflicts](#10-merge-conflicts)
11. [Branches](#11-branches)
12. [When something goes wrong](#12-when-something-goes-wrong)
13. [Glossary](#13-glossary)
14. [Appendix: the command line](#14-appendix-the-command-line)

---

## 1. What Git and GitHub actually are

**Git** is a program on your computer that takes snapshots of a folder. Each snapshot records what every file looked like at that moment and why you saved it. You can look back at any snapshot, compare two of them, or return to an earlier one.

**GitHub** is a website that stores copies of those snapshots online, so your work is backed up and other people can get it.

The distinction matters mostly because the error messages assume you know it. Git is the tool; GitHub is the place your files go.

### What this replaces

I used to have a version control system. It looked like this:

```
analysis.R
analysis_v2.R
analysis_v2_FINAL.R
analysis_v2_FINAL_sara_edits.R
analysis_v2_FINAL_sara_edits_USE_THIS_ONE.R
```

With Git there is one file, `analysis.R`, and a complete history behind it. I
can see what it looked like last Tuesday, what changed since, who changed it,
and why. I can go back. Nothing is lost by editing.

### The vocabulary, in one place

| Word | What it means |
|---|---|
| **repository** (repo) | A project folder that Git is tracking |
| **commit** | One snapshot, with a note explaining it |
| **push** | Send your commits to GitHub |
| **pull** | Get other people's commits from GitHub |
| **clone** | Download a repository to your computer for the first time |
| **remote** | The copy on GitHub (as opposed to yours) |
| **branch** | A parallel version, for work in progress |
| **merge** | Combine two lines of work |

### The most important thing to understand

**Git history is permanent.** When you commit a file, it stays in the repository's history forever. Deleting the file later removes it from the current version but not from the history — anyone who has the repository can still recover it.

This is a feature: it is why nothing is ever lost. It is also why **research data must never be committed**. If the repository is ever made public, its entire history becomes public with it, including files you deleted years ago.

The template's `.gitignore` prevents this automatically. Please do not disable it.

---

## 2. One-time setup

Fifteen minutes, once per computer.

### Create a GitHub account

Go to [github.com](https://github.com) and sign up. You can use your personal email or your foundry10 email, whichever you prefer.

Pick a professional username — it appears on everything you do, and if you
publish code with a paper, reviewers will see it. `sweston-f10` is good;
`dogmom1990` is a decision you will revisit.

### Get added to the foundry10 organization

Ask the research admin (currently Amy Ly) to add you. Being in the organization is what lets you see and create foundry10 repositories.

### Turn on two-factor authentication

GitHub requires it for organization members. Settings → Password and authentication → Two-factor authentication. Use an authenticator app rather than SMS if you have the choice.

**Save your recovery codes somewhere you will actually find them.** Losing access to 2FA without recovery codes is genuinely difficult to resolve.

### Install GitHub Desktop

Download from [desktop.github.com](https://desktop.github.com). It works on Mac and Windows.

This guide uses GitHub Desktop throughout. There is a command-line version of everything, and it is more powerful, but it also has an authentication setup step that stops more first-time users than any other part of Git. GitHub Desktop handles that for you. If you would rather use the terminal, see the [appendix](#14-appendix-the-command-line).

Open it and sign in with your GitHub account.

---

## 3. Creating your project repository

You are not going to build a project structure from scratch. Start from the foundry10 research template.

### Use the template

1. Go to the template repository on github.com
2. Click the green **Use this template** button → **Create a new repository**
3. Fill in:
   - **Owner:** `foundry10` (not your personal account — this makes it an organization project, so it survives anyone leaving)
   - **Repository name:** lowercase, hyphens, descriptive, permanent. `teen-media-use-2026`, not `study1` or `Saras Project`
   - **Description:** one line a colleague would understand
   - **Visibility: Private.** Always. See the next section.
4. Click **Create repository**

### "Use this template," not "Fork"

You will see a **Fork** button too. It does something similar and is the wrong choice here.

Forking creates a permanent link back to the original template. The practical consequence: when you later go to propose a change to your own project, GitHub helpfully defaults to sending it **to the template repository** instead. People do this constantly, and it is confusing to undo.

"Use this template" gives you an independent repository with a clean history.

---

## 4. Private and public

### Every foundry10 research repository starts private

Private means only you and people you explicitly add can see it. This is the default and it is not negotiable while a study is active.

Public means **anyone on the internet** can see every file and the entire history.

### The asymmetry

You can make a private repository public at any time. You cannot un-see something that has been public. Between search engines, GitHub's own APIs, and services that continuously archive public code, a repository that is public for an hour may be permanently mirrored somewhere you cannot reach.

So: private by default, public deliberately.

### Adding collaborators

Settings → Collaborators and teams → Add people. Type their GitHub username.

They need a GitHub account and organization membership first.

**Adding someone to the repository is not the same as granting data access.** Data access is a separate decision, made per person on Google Drive. Someone can have full access to the code here and no right to the data — and that is often correct.

### Going public

Usually at publication, when a journal asks for an analysis code link, or when you want the work citable.

**This requires approval.** Work through [`before-going-public.md`](before-going-public.md) first. There is more to it than flipping a switch, because the switch exposes your entire history.

---

## 5. Cloning to your computer

Cloning means downloading the repository so you can work on it.

1. In GitHub Desktop: **File → Clone repository**
2. Find your repository in the list (**GitHub.com** tab)
3. **Local path:** choose where it goes on your computer
4. **Clone**

### Where to put it — one important warning

**Do not put your repository inside a synced folder.** Not Google Drive, not
Dropbox, not OneDrive, not iCloud Desktop.

Two programs that both continuously sync the same files will fight each other. The sync client tries to upload files while Git rewrites them, and the failures look like Git corruption without ever announcing what actually happened. It is one of the hardest problems to diagnose in this whole system and it is entirely avoidable.

Make a plain folder:

- **Mac:** `/Users/yourname/Documents/GitHub/`
- **Windows:** `C:\Users\yourname\Documents\GitHub\`

Note that this means your repository is **not backed up by your usual sync service** — which is fine, because pushing to GitHub is the backup. Push often.

### Now open the project

Open the `.Rproj` file — **not** the individual scripts. Opening the `.Rproj` sets R's working directory to the project root, which is what makes every file path in the code work on every machine.

---

## 6. The daily loop

The whole routine, every working session:

```
PULL  →  work  →  COMMIT  →  PUSH
```

### Pull first — always

Open GitHub Desktop and click **Fetch origin**, then **Pull origin** if it offers. This brings down anything collaborators changed since you last worked.

Pulling first is the single habit that prevents the most conflicts. Thirty seconds at the start of a session saves an unpleasant hour later.

If you work alone, pull anyway — it costs nothing and catches the case where you worked on a different computer.

### Work normally

Edit your scripts. Run your analysis. Save files as you always do.

### Commit

In GitHub Desktop, the left panel now lists every file you changed. Click one to see exactly what changed — green is added, red is removed.

**Look at this before committing.** Treat it like a proofread and catch that you left a `browser()` in a script or changed something you meant to revert.

Then:

1. Check the boxes next to the files you want to include
2. Write a **summary** in the box at the bottom left (see next section)
3. Click **Commit to main**

You do not have to commit every changed file at once. If you fixed two unrelated things, commit them separately — it makes the history much easier to read later.

### Push

Click **Push origin**.

Until you push, your work exists only on your laptop. A commit is not a backup; a push is.

**Push at least at the end of every working session.** More often is better.

### How often to commit?

More than you think. A good rule: commit whenever you finish something you
could describe in one sentence.

- Finished the cleaning script → commit
- Fixed a bug in a recode → commit
- About to try a risky restructuring → commit first, so you have a safe point

Commits are free. Being unable to get back to a working version is expensive. (Set a timer that goes off every 15 minutes -- each time, ask yourself, "Did I make a complete-enough change to warrant a commit?")

---

## 7. Writing commit messages

A commit message explains **why**, since the diff already shows what.

Write in the imperative, finishing the sentence *"This commit will…"*:

```
Good:  Add attention check exclusion to cleaning script
Good:  Fix reversed coding on items 4-7
Good:  Update Figure 2 with revised analytic sample
Good:  Drop 14 cases with missing outcome data

Poor:  updates
Poor:  asdf
Poor:  fixed stuff
Poor:  work in progress
```

The test: could a collaborator scan a list of these and understand how the project developed? That list is the project's real changelog, and you will read it far more often than you expect — most commonly when trying to work out when a number changed and why.

If a change needs more explanation, GitHub Desktop has a description field below the summary. Use it for the reasoning behind a substantive analytic choice, and put the decision itself in `docs/decisions.md`.

---

## 8. Undoing things

### I have not committed yet, and I want my changes gone

GitHub Desktop: right-click the file in the Changes list → **Discard changes**.

This is permanent and cannot be undone. It is the only genuinely dangerous button in normal use.

### I just committed and want to take it back

**History** tab → right-click the most recent commit → **Undo commit**.

Your changes come back as uncommitted edits. Works only if you have not pushed.

### I want to see what a file looked like last week

**History** tab → click through the commits. Each one shows exactly what changed. Find the version you want, and you can copy the old content out of it.

### I have made a complete mess and want to start over

Your last push is on GitHub and is safe. The nuclear option — always available, and genuinely fine to use:

1. Rename your local project folder to `my-project-BROKEN`
2. Clone the repository again from GitHub Desktop
3. Copy any files you still need out of the broken copy
4. Delete the broken copy

You lose only work you had not pushed. This is not a defeat; it is often faster than diagnosing the problem, and experienced people do it too.

### I committed something I should not have

**Stop. Do not push.** If you have already pushed, do not delete the file and assume that fixed it — it did not; the file remains in the history.

Contact the research admin (currently Amy Ly) immediately. Removing something from Git history is possible but requires rewriting the repository, and it must be done before anyone else pulls.

This applies to data files, participant information, and API keys.

---

## 9. Working with other people

### The golden rule

**Do not have two people editing the same file at the same time.**

Everything else in this section is about handling what happens when you break that rule. The rule itself is much cheaper. Split work by file — you take cleaning, I take the models — and coordinate in Slack, not in Git.

### The collaborative rhythm

1. **Pull before you start.** Every time.
2. **Say what you are working on.** A message saying "I'm in `02_analyze.R` this afternoon" prevents more problems than any Git feature.
3. **Commit and push when you stop.** Work sitting unpushed on your laptop is invisible to everyone else, and it is what turns a small conflict into a large one.
4. **Pull again before you resume.**

Long-running unpushed work is the root cause of nearly every painful conflict. Push early, push often.

---

## 10. Merge conflicts

A merge conflict happens when you and a collaborator changed **the same lines
of the same file** and Git cannot tell which version is right.

Git is not broken and you have not lost anything. Git is asking a question it
genuinely cannot answer.

### What it looks like

GitHub Desktop tells you a conflict is blocking the pull and names the files.
Open the file in RStudio and you will see:

```r
<<<<<<< HEAD
dat <- dat |> filter(age >= 13)
=======
dat <- dat |> filter(age >= 13, complete_survey == TRUE)
>>>>>>> origin/main
```

Reading it:

- Between `<<<<<<< HEAD` and `=======` — **your** version
- Between `=======` and `>>>>>>> origin/main` — **their** version

### How to resolve it

1. **Decide what the file should say.** This is a research question, not a
   technical one — often the answer is a combination, and often it needs a
   thirty-second conversation with the other person. Ask. Guessing at what a
   collaborator meant to do to an exclusion criterion is how errors enter a
   paper.

2. **Edit the file so it reads correctly.** Delete the `<<<<<<<`, `=======`,
   and `>>>>>>>` marker lines — all of them. The file should end up looking
   like normal code with no trace that a conflict happened:

   ```r
   dat <- dat |> filter(age >= 13, complete_survey == TRUE)
   ```

3. **Save the file.**

4. **Repeat for every conflicted file.** GitHub Desktop lists them and shows a
   checkmark as each is resolved.

5. **Commit.** GitHub Desktop pre-fills a message like "Merge branch main."
   That is fine.

6. **Push.**

### Things worth knowing

- **Run your code after resolving.** A resolved conflict can be syntactically
  valid and substantively wrong. Check that the result is what you intended.
- **Leftover markers cause confusing errors.** If R suddenly complains about
  unexpected `<` symbols, search the file for `<<<<<<<`.
- **You can always back out.** GitHub Desktop's **Abort merge** returns you to
  where you were before the pull, with nothing lost.
- **Ask for help.** A conflict in a cleaning script is a question about the
  study, and there is no credit for solving it alone.

### Conflicts in files Git cannot merge

Word documents, Excel files, and `.RData` files cannot be merged line by line —
they are binary, and Git can only offer you one version or the other. Choose
one and manually reapply the other's changes.

This is a good reason to keep manuscripts in Google Docs, which handles
simultaneous editing far better than Git ever will.

---

## 11. Branches

**You can skip this section.** For a solo analyst committing to `main`, branches
are overhead. Come back when one of the situations below applies.

A branch is a parallel copy of the project where you can work without affecting
the main version.

### When branches genuinely help

- **A risky restructuring.** Try it on a branch; if it fails, delete the branch
  and nothing was disturbed.
- **A reviewer's alternative analysis.** Keep it separate from the main
  results until you decide whether to adopt it.
- **Several people working simultaneously** on a project where `main` needs to
  stay runnable at all times.

### Using one in GitHub Desktop

1. **Current branch** dropdown → **New branch** → name it (`robustness-checks`)
2. Work and commit as normal — you are now committing to the branch
3. **Publish branch** to put it on GitHub
4. When it is ready: **Create pull request** (opens github.com), which lets
   collaborators review the change before it joins `main`
5. **Merge pull request** on github.com
6. Switch back to `main` and pull

### The main risk

Branches that live for weeks drift far from `main` and produce large, painful
conflicts when merged. If you use a branch, merge it within a few days.

---

## 12. When something goes wrong

### "Authentication failed" / repeated sign-in prompts

Usually your GitHub Desktop session expired. **File → Options → Accounts**,
sign out and back in.

### "Updates were rejected because the remote contains work you do not have"

Someone pushed while you were working. **Pull first**, resolve anything that
conflicts, then push. This message is Git preventing you from overwriting a
colleague's work.

### "This file is too large"

GitHub rejects files over 100 MB. It is almost always a data file that got
past the ignore rules.

Do not commit it. Check whether it belongs in `data/` (where it will be ignored
automatically) or on Google Drive. If you have already committed it but not
pushed, use **Undo commit**. If you have pushed, contact the research admin (currently Amy Ly).

### A data file is showing up in my Changes list

It should not be. Something is wrong with `.gitignore` — perhaps the file lives
outside `data/`, or has an unusual extension.

**Do not commit it.** Move it into `data/raw/` and it will be ignored. If it
still appears, ask for help before committing anything.

### My changes disappeared

Almost always one of:

- You are looking at a different branch (check the **Current branch** dropdown)
- You committed to a different folder — an old copy of the project
- You discarded changes

Check the **History** tab. If it was ever committed, it is recoverable, and
the research admin (currently Amy Ly) can help find it.

### Git says I have changes to files I never touched

Usually line endings — the invisible characters marking the end of each line,
which differ between Windows and Mac. The template's `.gitattributes` handles
this. If it happens anyway, mention it rather than committing thousands of
phantom changes.

### Something is wrong and none of this covers it

Ask. Every person using Git has been stuck, and the failure mode is not asking
and then doing something drastic. Your pushed work is safe on GitHub, so there
is no emergency — take a screenshot of the error and send it to [research
admin].

---

## 13. Glossary

| Term | Meaning |
|---|---|
| **branch** | A parallel version of the project for in-progress work |
| **clone** | Download a repository to your computer for the first time |
| **commit** | A saved snapshot with a message explaining it |
| **conflict** | Two people changed the same lines; Git needs you to choose |
| **diff** | The display of what changed between two versions |
| **fetch** | Check GitHub for new work without downloading it into your files |
| **fork** | Your own copy of someone else's repository (rarely what you want here) |
| **Git** | The version control program on your computer |
| **GitHub** | The website that hosts repositories |
| **`.gitignore`** | The file listing what Git should never track |
| **HEAD** | Git's name for "the version you currently have" |
| **main** | The default branch — the official version of the project |
| **merge** | Combine two lines of work |
| **origin** | Git's name for the copy on GitHub |
| **pull** | Download and apply changes from GitHub |
| **pull request** | A proposal to merge a branch, with room for review |
| **push** | Upload your commits to GitHub |
| **remote** | A copy of the repository somewhere else (usually GitHub) |
| **repository** | A project folder tracked by Git |
| **stage** | Mark a file for inclusion in the next commit (the checkboxes) |
| **`.Rproj`** | RStudio's project file; open this, not the scripts |

---

## 14. Appendix: the command line

Everything above works through GitHub Desktop, which is a complete way to work
and requires no terminal use. This appendix is for those who prefer the command
line or need something GitHub Desktop does not expose.

The one-time authentication setup is the part that trips people up. Install
[GitHub CLI](https://cli.github.com) and run `gh auth login` — it handles
credentials for you and is far less painful than configuring SSH keys by hand.

Daily use:

```bash
git pull                       # get the latest before starting
git status                     # what have I changed?
git diff                       # show me exactly what changed
git add code/01_clean.R        # stage one file
git add .                      # stage everything (check status first)
git commit -m "Add exclusion"  # commit staged changes
git push                       # send to GitHub
```

Looking around:

```bash
git log --oneline -20          # recent commits
git log --follow code/01_clean.R   # history of one file
git show abc1234               # what one commit changed
```

Undoing:

```bash
git restore code/01_clean.R    # discard uncommitted changes to a file
git restore --staged file.R    # unstage without discarding
git reset --soft HEAD~1        # undo last commit, keep the changes
```

Branches:

```bash
git switch -c robustness-checks   # create and switch
git switch main                   # switch back
git merge robustness-checks       # merge into current branch
git branch -d robustness-checks   # delete when done
```

Two commands to be careful with:

- `git reset --hard` permanently discards uncommitted work
- `git push --force` can overwrite a collaborator's commits on GitHub

Neither is needed in normal use. If a solution you found online starts with
either, that is a good moment to ask someone before running it.
