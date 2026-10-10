// One primary location per note; retain stable anchors when moving it.
#let render-topic(topics, id, level: 4, outlined: false) = {
  let topic = topics.at(id)
  [
    #heading(level: level, outlined: outlined)[#topic.title]#label(id)
    #topic.body
  ]
}
