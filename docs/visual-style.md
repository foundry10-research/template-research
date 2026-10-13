# Visual style rules

Derived from the foundry10 Visual Style Guide, Version 5.0 (February 2025),
pages 9-21. This file is the working version for figures and tables produced in
this repository. The guide itself is the authority; where this file is silent,
read the guide.

Questions about the brand go to Curtis Rogers, Director of Communications.

The ggplot implementation is `code/functions/theme_foundry10.R`. Changing a
colour here means changing it there too.

---

## Colours

### Primary palette

| Name | Hex | Use |
|---|---|---|
| foundry10 orange | `#D14E1D` | accent only — draws the eye |
| foundry10 dark cyan | `#01646F` | default colour for data marks |
| black | `#111111` | text |
| paper white | `#F9F9F9` | background |


### Secondary palette

Cyans, light to dark: `#078B9C` bright, `#077A8A` warm, `#007079` cool,
`#01646F` primary, `#0E2528` very dark.

Oranges: `#F9A65F` light, `#E77C53` soft, `#D14E1D` primary, `#CA4A1C` text,
`#BE5127` web-safe background.

### Tints

Use to widen the palette without reducing opacity.

Orange: 80% `#D96F50`, 20% `#EBC5B9`, 10% `#F4E6E2`.
Cyan: 80% `#326A72`, 20% `#AEC4C6`, 10% `#E0ECED`.

### Grayscale

`#000000`, `#575857` dark, `#939598` medium dark, `#E2E3E4` light,
`#F2F2F2` very light, `#FFFFFF`. Use sparingly. This is also the palette for
print materials that will not be printed in colour.

---

## Rules for charts

From p.17 of the guide, plus what follows from them for this project.

1. **Minimise the number of colours.** If position already encodes the
   category, do not also encode it with colour. Groups that sit on an axis are
   all one colour.
2. **Orange is an accent.** It pulls attention, so it marks the thing the
   reader should notice and nothing else.
3. **Secondary and unimportant elements go gray, black, or very light.**
   Gridlines, reference lines, and annotations are gray.
4. **Similar tints group related information.** Similar shades of cyan for
   related response options ("Very important" and "Important").
5. **Never repeat a colour in a chart key.**
6. **Orange means negative or bad; cyan means positive or good.** This applies
   when values carry a valence. Descriptive estimates usually carry none; they
   are cyan by default, and orange then means "look at this", not "this is
   bad". Decide which reading a figure uses and keep to it within a report.

## Accessibility

These are not optional.

7. **Never rely solely on colour** to categorise, emphasise, or prompt. Every
   colour distinction carries a second cue — shape, weight, or text. If a
   figure highlights a result in orange, print the result as text too, so the
   colour is supplementary.
8. **Suppressed and imprecise estimates are marked by shape, not colour.** For
   example, a hollow point for an estimate based on a small cell, and a
   missing point with its label kept for a cell that was suppressed. Say what
   the convention is in the caption.
9. **Contrast.** Do not set text smaller than 14pt/18px in `#D14E1D` on white —
   use `#CA4A1C` instead. White text on `#D14E1D` needs to be 14pt/18px or
   larger. Check solid backgrounds with a WCAG contrast checker.

---

## Typography

Helvetica Neue, in any weight. Arial where it is unavailable. Anything else
goes past Comms first.

- Minimum 9pt for print, 16px for web. Figure text in this project does not go
  below 9pt.
- Headings at least 150% the size of body copy, and visually distinct.
- Avoid italics for long passages.
- Never centre or justify long blocks of text.
- Use whitespace to separate sections.

---

## What `theme_foundry10()` gives you

`code/functions/theme_foundry10.R` is loaded by `00_setup.R`. Add
`theme_foundry10()` to a ggplot and these defaults apply:

- Helvetica Neue (or Arial), text no smaller than 9pt, headings 150% of body.
- Very light gray gridlines; no panel border, no background fill.
- No legend. Encode the category by position where you can; if a chart
  genuinely needs a colour key, use `scale_colour_foundry10()` or
  `scale_fill_foundry10()`, which stop you if you ask for more colours than
  the palette has.

Sensible defaults for the marks themselves:

- Estimates are dark cyan (`f10_cyan`). The one comparison the reader should
  notice is orange (`f10_orange`), with the result also printed as text.
- Confidence intervals are drawn from the stored lower and upper bounds, not
  as a symmetric margin around the point. Intervals on proportions are rarely
  symmetric.
- A reference value (an overall mean, a benchmark) is a gray dashed line.
