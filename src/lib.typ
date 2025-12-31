// todo.typ - A simple TODO package for Typst
// Place this in your project or in ~/.typst/packages/local/todo:0.1.0/init.typ
// Usage: #import "@local/todo:0.1.0": todo, todo-list

#let __todo-state = state("todo-items", ())

// Function to add a TODO note
#let todo(
  text: "TODO: Implement this",
  color: red,
  show-in-list: true,
  complete: false
) = {
  // If show-in-list, add to global state for later listing
  if show-in-list {
    __todo-state.update(items => {
        items.push((txt: text, complete: complete))
      items
    })
  }
}

// Function to display all collected TODOs as a list at the end of the document
#let todo-list(
  title: "Pending TODO Items",
  complete-title: "Completed TODO Items"
) = {
  context {
    let items = __todo-state.final()
    let complete = items.filter(item => item.complete)
    let uncomplete = items.filter(item => not item.complete)
    if uncomplete.len() == 0 {
        [No TODO items found.]
    } else {
        let texts = uncomplete.map(item => item.txt)
        heading(level: 1, title)
        set enum(numbering: "1.a)")
        enum(..texts)
    }
    if complete.len() == 0 {
        [No TODO items found.]
    } else {
        let texts = complete.map(item => item.txt)
        heading(level: 1, complete-title)
        set enum(numbering: "1.a)")
        strike(enum(..texts))
    }
  }
}
