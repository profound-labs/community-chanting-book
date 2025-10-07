// Diacritic functions for pronunciation marks
#let a(it) = {
  box[
    #it
    #place(center+top, dy:-4pt)[#image("up2.svg", width: 8pt)]
  ]
}

#let b(it) = {
  box[
    #it
    #place(center+bottom, dy:5pt, rotate(180deg)[#image("up2.svg", width: 8pt)])
  ]
}

// State for tracking sections
#let current-section = state("current-section", "")

// Page setup with automatic page numbering
#set page(
  paper: "a4",
  margin: (top: 0.4in, bottom: 1in, left: 1in, right: 1in),
  header-ascent: 0.5in,
  numbering: "1", // Enable automatic numbering
  header: context {
    let page-num = counter(page).get().first()
    let section-name = current-section.get()
    
    if page-num > 0 {
      // Page number in margin
      place(
        if calc.odd(page-num) { top + right } else { top + left },
        dx: if calc.odd(page-num) { 1in } else { -1in },
        dy: 0.5in,
        rect(
          fill: gray.darken(20%),
          width: 4em,
          height: 2em,
          radius: 0pt
        )[
          #align(center + horizon)[
            #text(font: "Ubuntu", fill: white, weight: "bold", size: 16pt)[#page-num]
          ]
        ]
      )
      
      // Header with section name
      let alignment = if calc.odd(page-num) { right } else { left }
      align(alignment)[
        #text(font: "Ubuntu", size: 10pt, weight: "bold", tracking: 0.2pt)[
          #upper("EVENING CHANTING")
        ]
      ]
    }
  }
)

// Font and text settings
#set text(
  font: "Gentium Plus",
  size: 15pt,
  fill: black,
)

// Paragraph settings
#set par(
  leading: 1em,
  spacing: 1em,
  justify: false,
  first-line-indent: 0pt
)

// Section heading function
#let section(title) = {
  current-section.update(title)
  v(1em)
  align(left)[
    #text(font: "Ubuntu", size: 20pt, weight: "bold")[
      #title
    ]
  ]
  v(-0.8em)
  line(length: 100%, stroke: 0.5pt + gray.darken(20%))
  v(1em)
}

// Verse block function
#let verse-block(content) = {
  block(
    spacing: 1em,
    inset: (left: 1em, right: 0em, top: 0em, bottom: 0em),
    width: 100%
  )[
    #content
  ]
}

// Bow instruction function
#let bow() = {
  v(0.3em)
  align(right)[
    #text(font: "Ubuntu", size: 11pt, style: "normal", fill: gray.darken(30%))[
      \[ *BOW* \]
    ]
  ]
  v(0.5em)
}