// todo.typ - A simple TODO package for Typst
// Place this in your project or in ~/.typst/packages/local/todo:0.1.0/init.typ
// Usage: #import "@local/todo:0.1.0": todo, todo-list


#let TodoState = (
  Pending: "Pending",
  Complete: "Complete",
  Abandoned: "Abandoned"
)

#let __todo-state(state) = {
  if not (state in TodoState.values()) {
    error("Invalid state: " + state)
  }
  state
}

#let __todo-list = state("todo-items", ())

// Function to add a TODO note
#let todo(
  text: "TODO: Implement this",
  show-in-list: true,
  state: TodoState.Pending
) = {
  // If show-in-list, add to global state for later listing
  if show-in-list {
    __todo-list.update(items => {
      items.push((txt: text, state: __todo-state(state)))
      items
    })
  }
}

// Function to display all collected TODOs as a list at the end of the document
#let todo-list(
  title: "Pending TODO Items",
  complete-title: "Completed TODO Items",
  abondon-title: "Abondoned TODO Ttems"
) = {
  context {
    let items = __todo-list.final()
    let complete = items.filter(item => item.state == TodoState.Complete)
    let pending = items.filter(item => item.state == TodoState.Pending)
    let abondon = items.filter(item => item.state == TodoState.Abandoned)

    heading(level: 1, title)
    if pending.len() == 0 {
        [No TODO items found.]
    } else {
        let texts = pending.map(item => item.txt)
        set enum(numbering: "1.a)")
        enum(..texts)
    }

    heading(level: 1, complete-title)
    if complete.len() == 0 {
        [No TODO items found.]
    } else {
        let texts = complete.map(item => item.txt)
        set enum(numbering: "1.a)")
        strike(enum(..texts))
    }

    heading(level: 1, abondon-title)
    if abondon.len() == 0 {
        [No TODO items found.]
    } else {
        let texts = abondon.map(item => item.txt)
        set enum(numbering: "1.a)")
        strike(enum(..texts))
    }
  }
}
