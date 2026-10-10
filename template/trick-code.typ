// Pseudocode uses the existing code-box style with natural line spacing.
// Choose the same 8pt / 6pt sizes as frame.typ / frame_plus.typ.
#let trick-code(source) = context {
  let font-size = if text.size < 10pt { 6pt } else { 8pt }
  let cells = ()
  for (i, line) in source.split("\n").enumerate() {
    cells.push(text(fill: rgb("#888"))[#str(i + 1)])
    cells.push(raw(line))
  }
  block(
    breakable: true,
    stroke: 0.6pt + rgb("#777"),
    radius: 3pt,
    inset: 6pt,
    width: 100%,
  )[
    #set text(font: "JetBrains Mono", size: font-size)
    #grid(
      columns: (auto, 1fr),
      column-gutter: 1em,
      row-gutter: 1pt,
      align: (right, left),
      ..cells,
    )
  ]
}
