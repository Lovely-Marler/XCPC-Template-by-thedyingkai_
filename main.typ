#import "template/frame.typ": *

#set document(
  title: "XCPC 算法模板 by thedyingkai_",
  author: "thedyingkai_",
  date: auto
)

#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 2.5cm)
)

#set text(
  font: ("Times New Roman", "Microsoft YaHei"), 
  size: 10.5pt
)

#show heading.where(level: 1): set heading(numbering: "第一章")
#set heading(numbering: "1.1")
#show heading.where(level: 4): set heading(numbering: none)
#show heading.where(level: 5): set heading(numbering: none)

#include "template/cover.typ"


#let old_page = context {
  counter(page).get().first()
}
#context counter(page).update(1);

#set page(
  numbering: "1",
  header: context(header(here().page())),
  footer: footer
)

#import "content.typ": book
#book(code)
