---
name: plain-technical-writing
description: "Rules for all prose in a code project: README files, docs, design notes, code comments, docstrings, commit messages, pull request descriptions, issue and review comments, CLI help text, error and log messages, CHANGELOG entries. Use before writing or editing any of these. The reader is an engineer who reads English well but does not speak it daily, often a Japanese engineer, and who is reading with no other context. Complete sentences, complete nouns, literal verbs, no idiom, no em dashes."
---

# Plain technical writing

These rules apply to every piece of prose in a code project. The reader is an engineer who reads English well but does not speak it every day, and who may be reading one sentence out of context: a commit message in `git log`, a comment next to a function, an error message in a terminal, a paragraph forwarded by email. The rules make each sentence survive being read alone.

## The reader

- Reads English well. Does not speak it daily. Idiom, slang, and wordplay cost the reader time and can change the meaning.
- Arrives cold. A search result, a forwarded link, or `git blame` drops the reader into the middle of a document with no context.
- Wants context, detail, and the reasoning. A Japanese engineering team receiving a document prefers the full background first, then the specific point, then the specific question.
- Will act on what is written. An overstatement becomes a bug report. An inferred value stated as a fact becomes a wrong design.

## Rules

### 1. Complete every noun

Write so the reader never has to supply a missing word. Every noun phrase is complete, every pronoun has its noun in the same sentence or the previous one, and every verb has its object.

The test: read the sentence as if it were the only sentence on the page. If a reader with no other context would have to guess what "it", "this", "the card", "the service", or "the request" refers to, rewrite the sentence with the full name.

- "product" becomes "product management" or "the product team", whichever is meant.
- "the card" (when two cards are in play) becomes the card's name.
- "Send to the reviewer" becomes "Send the design note to the reviewer".
- "Confirm before release" becomes "Confirm the default port number before the release is tagged".
- Repeat the noun instead of reaching for a pronoun across sentences. "It" and "This" at the start of a sentence are the usual leak.
- No coined shorthand standing in for a thing: "the ask", "the story", "the workup", "the play". Say what the thing is.
- Expand each acronym on first use in each document. The reader may be arriving from a search or a translation.

### 2. Literal verbs

Use plain verbs with their literal meaning: has, contains, includes, requires, returns, sends, reads, writes, fails, stops. Avoid figurative verbs that carry an implied picture: carries, holds, lands, anchors, surfaces, unpacks, bolts on, drives, lives in.

The test: if a word has a concrete physical meaning and the sentence is not describing that physical thing, use the plain verb instead.

- A packet does not carry a timestamp. The packet includes the timestamp, or the timestamp is in the packet.
- A request does not land. A request arrives, or is received.
- A config file does not live in a directory. The config file is in the directory.
- A function does not surface an error. The function returns an error, raises an exception, or logs an error.

Do not personify technical elements. A module does not want, expect, or care about anything. State what the module requires, accepts, or rejects.

### 3. Complete sentences

Prose is complete sentences. Fragments belong in tables and in bullet lists of nouns, and nowhere else.

The fragment that keeps recurring is a bold label followed by a verbless phrase: "**Config loading.** Reads the file at startup, environment overrides." Convert it: "The config module reads the file at startup. Environment variables override the values in the file."

Also avoid rhythmic fragments for effect ("Same input, same output, every time.") and rule-of-three punch lists. State each fact in its own sentence.

### 4. One idea per sentence

Short sentences. If a sentence needs an em dash, a semicolon, or a second "which" clause to hold together, the sentence has two jobs. Split it.

Cut every word that is not necessary. Keep every word that is: the articles, the subject, the object. Terse means no filler. The articles, the subject, and the object stay.

### 5. State the fact and stop

Every sentence either carries a fact or carries the reader to the next fact. Nothing should make the reader notice the writing, and nothing should tell the reader how to feel about what was just read.

Delete these when they appear:

- Scaffolding that announces the next sentence: "Here is the part that matters." "Consider what the host is being asked to do." "Start with what has to be carried." The paragraph below the scaffolding is the content.
- Contrast with a position nobody held: "X is not a bigger version of Y." "The interesting part is not A. It is B." "Rather than a design flourish, the interface is the entry ticket." State the positive claim. If both halves are true, say both.
- Declarations of significance: "That is the whole point." "This is where the schedule goes." "The pattern is the point."
- Summary lines whose only content is that the preceding list was impressive.
- Overstatement adverbs and intensifiers: actually, genuinely, simply, really, just, very, clearly, obviously.
- Honesty rhetoric: "honestly", "to be honest", "the honest answer is". Open with the substance.
- Revision commentary: what a previous draft said, what was wrong before. State the current, verified claim only.

### 6. No idiom, slang, metaphor, or cleverness

Replace idiom with the literal statement, every time.

- "Where does density start to hurt?" becomes "Is channel density a concern?"
- "before these numbers travel" becomes "before these numbers are used outside the team"
- "the ground is firm" becomes "where each side is strong"
- "under the hood" becomes "in the implementation", or names the component
- "heavy lifting" becomes the name of the work being done
- "threading the needle", "moving the needle", "low-hanging fruit", "north of 64": delete, and state the literal fact.

Casual register reads as flippant to a senior technical reader and reads as noise to a second-language reader. Write flat, declarative, informational prose.

### 7. No em dashes

Never use an em dash. En dashes in numeric ranges (2026–2027, lines 40–52) are fine.

Restructure the sentence rather than substituting a spaced hyphen or an en dash as punctuation. Use a period and a second sentence, a comma, a colon when introducing a list or an explanation, or parentheses for a true aside.

### 8. Context first, then the point, then the question

Give the background before the detail. In a document or message that asks another engineer for something:

1. State the background: what is being built, what was observed, what was tried.
2. State the current understanding, as the writer's understanding and open to correction.
3. Ask the specific question, or make the specific request.

Say how deeply the writer has checked, and say that corrections are welcome. Some readers will not say that a design is a problem for them unless they are asked a direct, factual question that leaves room for an opinion.

### 9. Qualify where a flat statement would overstate

Add "typically", "usually", "in the tested configuration", "as of version 2.3", or "on Linux" when a sentence without the qualifier would claim more than is known. A qualifier is a fact about scope. Hedging words that carry no scope ("sort of", "fairly", "pretty much") are filler; delete those.

### 10. Separate measured from inferred

A number or a definition that was supplied is stated plainly with nothing added. A number or a definition that was derived is marked as derived, with the derivation next to it. Readers treat a spec table as authoritative and quote from it. An inference placed in a spec table will be quoted as a fact.

Write "Measured: 3.2 ms at 32 flows (test run 2026-10-02)." Write "Estimated: 6.4 ms at 64 flows, assuming linear scaling. Not yet measured."

### 11. Headings name the subject

A heading is a label a reader can find by scanning. Use "Configuration file format", "Known limitations", "Common errors". Avoid one-word headings that assume the subject is known ("Timing", "Money") and avoid headings written to be memorable.

### 12. Neutral voice in shared documents

In a design note, a proposal, a README, or any document more than one person will read, write in neutral third person. State decisions as decisions and open questions as open questions. Do not write "I am asking you to approve this" or "you need to decide". Write "This design needs a decision on X" or "Open question: X."

Procedures are the exception. Steps in a how-to use the imperative: "Run `make test`." "Set `PORT` to the listening port."

### 13. US spelling

behavior, color, initialize, license (noun and verb), analyze.

## Where each kind of prose differs

**README and how-to pages.** Open with what the project is and what it is for, in two or three sentences, before any installation step. Procedures are numbered steps in the imperative. Each step names the command, the file, and the expected result.

**Code comments.** A comment states the reason the code is the way it is, the constraint the code satisfies, or the thing a future reader would otherwise have to rediscover. The code itself states what the code does. Write complete sentences. Name the referent: "This loop retries the connection" rather than "retry".

**Docstrings and API reference.** State what the function does, each parameter with its type and valid range, what the function returns, and what it raises and when. Use the same noun for the same thing throughout the module.

**Commit messages.** The subject line is a complete statement of what changed, in the imperative, under 72 characters: "Add retry on connection timeout in the SDP fetcher". The body states why the change was made and what the reader should know that the diff does not show. Do not describe the diff line by line.

**Pull request descriptions.** Four parts, each labeled: the background and the problem, the change, how the change was tested, and the open questions or decisions the reviewer is being asked to make.

**Issue comments and review comments.** Follow rule 8. Background, current understanding, specific question.

**Error, log, and CLI help text.** Name the thing, the value seen, the value expected, and the next action. "Config key `port` is 70000; expected an integer from 1 to 65535. Edit `config.toml` and restart."

**CHANGELOG entries.** One complete sentence per change, naming the component. "Fixed the SDP parser rejecting `a=fmtp` lines with a trailing semicolon."

## Banned words and phrases

Never use these. Each one labels something as difficult, important, or true without adding a fact, and reads as machine-written.

- the hard part, the hardest part, the tricky part, the real challenge, hard problem
- load-bearing, and structural-engineering metaphor generally
- land, lands, landing (figurative)
- honestly, to be honest, the honest answer is
- here's the thing, it's worth noting, the key insight, under the hood, heavy lifting, that said, the whole point, at the end of the day
- actually, genuinely, simply (as intensifiers)
- story (meaning an argument or an angle), the ask, workup, the play
- leverage (as a verb), utilize, robust, seamless, powerful, elegant
- em dashes

Full list with replacements: [references/word-list.md](references/word-list.md). Before-and-after examples: [references/examples.md](references/examples.md).

## Checklist before handing over

Run this on every piece of prose, including a one-line commit message.

1. Search for "—". Remove every one by restructuring the sentence.
2. Read each sentence alone. Does every pronoun and every "the X" have a named referent within one sentence? Does every verb have its object?
3. Search for the banned words and phrases above.
4. Find every verb with a physical meaning (carry, hold, land, surface, drive, live, anchor). Replace it with the literal verb unless the sentence is about the physical thing.
5. Find every sentence that carries no fact: scaffolding, significance, summary of impressiveness, contrast with a position nobody held. Delete it.
6. Find every bold-label fragment in prose. Convert it to a sentence.
7. Check each flat claim for scope. Add the qualifier that makes it true, or mark it as inferred.
8. Check each acronym for expansion on first use.
9. Check each heading: does it name its subject?
10. Read the whole thing as an engineer who came for the information, in a second language, with no context. Cut whatever makes that reader stop.
