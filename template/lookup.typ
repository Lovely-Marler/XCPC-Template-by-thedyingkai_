// Resolve page numbers from final locations in each edition, never hard-code them.
#let algorithm-lookup(entries) = context {
  set text(size: if text.size < 10pt { 7.5pt } else { 9pt })
  let cells = ()
  for entry in entries {
    let target = query(entry.target).first()
    let page-number = counter(page).at(target.location()).first()
    cells.push(link(entry.target)[#entry.name])
    cells.push([#entry.chapter · #link(entry.target)[#entry.function]])
    cells.push(link(entry.target)[#page-number])
  }
  table(
    columns: (1fr, 1.6fr, auto),
    inset: 4pt,
    stroke: 0.4pt + rgb("#aaa"),
    table.header([算法／常用别名], [功能与章节], [正文页]),
    ..cells,
  )
}
