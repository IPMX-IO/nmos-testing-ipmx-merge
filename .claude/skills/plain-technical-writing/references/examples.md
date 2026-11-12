# Examples

Each pair shows a sentence as first written and the rewrite. The rewrites come from edits made on real documents, with product and personal names replaced where they were specific to one project.

## Complete nouns

| First written | Rewrite |
|---|---|
| Send to the reviewer. | Send the design note to the reviewer. |
| Confirm before release. | Confirm the default port number before the release is tagged. |
| Product has not confirmed the limit. | Product management has not confirmed the channel limit. |
| The card handles both. | The capture card handles both the video flow and the audio flow. |
| It fails when this is set. | The parser fails when `strict_mode` is set. |
| Timing (as a heading) | Delivery dates |
| Money (as a heading) | Price |
| That would be noise. | A date on a blocked item is noise, because the date cannot be met until the blocker clears. |

## Literal verbs

| First written | Rewrite |
|---|---|
| The packet carries the timestamp. | The packet includes the timestamp. |
| Leads land in the CRM. | Leads come into the CRM. |
| The config lives in `/etc/app`. | The config file is in `/etc/app`. |
| The error surfaces in the log. | The error is written to the log. |
| The timer drives the main loop. | The timer triggers each iteration of the main loop. |
| The module expects a sorted list. | The module requires a sorted list. |

## Complete sentences

| First written | Rewrite |
|---|---|
| **Config loading.** Reads the file at startup, environment overrides. | The config module reads the file at startup. Environment variables override the values in the file. |
| Same input, same output, every time. | The function is deterministic. For a given input it returns the same output on every call. |
| Three parsers, one grammar, no post-pass. | The three parsers share one grammar. No post-processing in Lua is needed after the match. |

## State the fact and stop

| First written | Rewrite |
|---|---|
| Here is the part that decides whether any of this is practical. The host CPU is idle during capture. | The host CPU is idle during capture. |
| Not a stereo pair riding along beside the picture. The audio is its own flow. | The audio is a separate flow. |
| The interesting part is not the throughput. It is the jitter. | Jitter is the constraint. Throughput is within the limit. |
| Those are the two flows the workflow needs, on one card, on one clock. | (deleted; the list above the sentence already states the two flows) |
| That is the whole point. It turns the question into a qualifying question. | Then ask what the visitor is building. |
| What the library actually ships is version 1.1. | The library ships version 1.1. |
| The honest answer is that the limit is untested above 32 flows. | The limit is untested above 32 flows. |
| Earlier drafts of this document stated 64 flows; that was wrong. | The tested limit is 32 flows. |

## Idiom

| First written | Rewrite |
|---|---|
| Where does density start to hurt? | Is channel density a concern? |
| before these numbers travel | before these numbers are used outside the team |
| the room where presence buys influence | the venue where participation carries influence |
| the ground is firm | where each side is strong |
| north of 64 channels | more than 64 channels |
| Somebody has to define the clock domain. | The clock domain is undefined in the current configuration. |
| Traps, in the order they will happen | Common errors |

## Em dashes

| First written | Rewrite |
|---|---|
| The parser is anchored — it only tries the pattern at the start of the subject. | The parser is anchored. It only tries the pattern at the start of the subject. |
| Three values are accepted — 8, 10 and 12 — and anything else fails the match. | Three values are accepted: 8, 10 and 12. Any other value fails the match. |

## Qualifiers and inferred values

| First written | Rewrite |
|---|---|
| The card sustains 32 flows at line rate. | In the tested configuration (Linux, 100GbE, 1080p59.94), the card sustains 32 flows at nearly line rate. |
| Width is measured across the mounting flanges. | Width: 142.3 mm. (Measurement reference not supplied; the mounting flanges appear to be the widest point in the drawing. Confirm with the mechanical drawing.) |
| Latency at 64 flows is 6.4 ms. | Measured: 3.2 ms at 32 flows (test run 2026-10-02). Estimated: 6.4 ms at 64 flows, assuming linear scaling. Not yet measured. |

## Commit messages

First written:

```
fix stuff in parser
```

Rewrite:

```
Accept a trailing semicolon in a=fmtp lines

RFC 4566 does not permit a trailing semicolon, but three camera
vendors emit one. The parser now treats a final ";" as optional.
Strict mode still rejects it.
```

## Code comments

| First written | Rewrite |
|---|---|
| `-- retry` | `-- This loop retries the connection up to three times, because the switch drops the first SYN after a VLAN change.` |
| `-- hacky but works` | `-- The 50 ms sleep is a workaround for the driver returning before the buffer is ready. Remove it when driver 2.4 ships.` |
| `-- the hard part` | `-- Ordered choice: the "localmac" alternative must come before "ptp" because "ptp" is a prefix of neither, but "localmac=traceable" and "localmac=<mac>" share a prefix.` |

## Error messages

| First written | Rewrite |
|---|---|
| Invalid port. | Config key `port` is 70000; expected an integer from 1 to 65535. Edit `config.toml` and restart. |
| Something went wrong parsing the SDP. | SDP parse failed at line 12 (`a=fmtp:112 ...`): unknown key `exactframrate`. Expected one of: sampling, width, height, exactframerate, depth, TCS, colorimetry, PM, TP. |

## Pull request description

First written:

> Fixed the parser bug. Should be good now.

Rewrite:

> **Background.** Three camera vendors emit a trailing semicolon on `a=fmtp` lines. RFC 4566 does not permit this. The parser rejected those SDP files, so streams from those cameras could not be registered.
>
> **Change.** The `fmtp_list` pattern now treats a final `;` as optional. Strict mode is unchanged and still rejects the trailing semicolon.
>
> **Testing.** Added `sdp_test.lua` cases for each vendor's SDP file. All 168 tests pass on Lua 5.3 with LPeg 1.1.0.
>
> **Open question.** Should strict mode also accept the trailing semicolon, with a warning? The current behavior is to reject.

## Message to another engineering team

First written:

> You need to confirm whether the driver supports 64 flows. We think it does.

Rewrite:

> **Background.** The customer's design requires 64 concurrent ST 2110-20 flows on one card. Our tests to date cover 32 flows on Linux with driver 2.3 (test run 2026-10-02, results attached).
>
> **Our current understanding.** We believe driver 2.3 supports 64 flows, based on the configuration limit in `README-driver.md` section 3. We have not tested it. This understanding may be wrong, and corrections are welcome.
>
> **Question.** Does driver 2.3 support 64 concurrent flows in the configuration described above? If it does, is there a tested result we can cite?
