// Diacritic functions for pronunciation marks
#let a(it) = {
  box[
    #it
    #place(center+top, dy:-4pt)[#image("up2.svg", width: 5pt)]
  ]
}

#let b(it) = {
  box[
    #it
    #place(center+bottom, dy:5pt, rotate(180deg)[#image("up2.svg", width: 5pt)])
  ]
}

// Page setup
#set page(
  paper: "a4",
  margin: (top: 1.5in, bottom: 1in, left: 1in, right: 1in)
)

// Font and text settings
#set text(
  font: "Times New Roman",
  size: 11pt,
  fill: black
)

// Paragraph settings
#set par(
  leading: 0.65em,
  justify: false,
  first-line-indent: 0pt
)

// Header function
#let header(title) = {
  align(center)[
    #text(size: 10pt, weight: "bold", tracking: 2pt)[
      #upper(title)
    ]
  ]
  v(1em)
}

// Section title function
#let section-title(title, number) = {
  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [
      #text(size: 13pt, weight: "bold")[
        #title
      ]
    ],
    [
      #rect(
        fill: gray.darken(40%),
        width: 1.5em,
        height: 1.5em,
        radius: 2pt
      )[
        #align(center + horizon)[
          #text(fill: white, weight: "bold", size: 11pt)[#number]
        ]
      ]
    ]
  )
  v(0.5em)
  line(length: 100%, stroke: 0.5pt + gray.darken(20%))
  v(1em)
}

// Verse block function
#let verse-block(content) = {
  block(
    spacing: 1em,
    inset: (left: 1em, right: 0em, top: 0em, bottom: 0em)
  )[
    #content
  ]
}

// Bow instruction function
#let bow-instruction() = {
  align(right)[
    #text(size: 9pt, style: "italic", fill: gray.darken(30%))[
      \[ bow \]
    ]
  ]
}

// Main template function
#let chanting-page(
  title: "EVENING CHANTING",
  section-name: "Dedication of Offerings",
  section-number: "19",
  content
) = {
  header(title)
  section-title(section-name, section-number)
  content
}

// Usage example - replace this with your actual content
#chanting-page(
  title: "EVENING CHANTING",
  section-name: "Dedication of Offerings", 
  section-number: "19"
)[
  #verse-block[
    To the Blessed One, the Lord, who fully attained \
    #h(1em) perfect enlightenment,

    To the Teaching, which he expounded so well,

    And to the Blessed One's disciples who have practised well,

    To these — the Buddha, the Dh#a[a]mma, and the S#a[a]ṅgha —

    We render with offerings our rightful homage.

    It is well for us that the Blessed One, having attained lib#b[e]ration,

    Still had comp#a[a]ssion for later gen#b[e]rations.

    May these simple offerings be accepted

    For #b[o]ur long-lasting benefit and for the h#a[a]ppiness it gives us.

    The Lord, the Perfectly Enlightened and Blessed One —

    I render homage #b[o] the Buddha, the Blessed One.
    #bow-instruction()
  ]

  #verse-block[
    The Teaching, so completely explained by him —

    I bow to the Dh#a[a]mma.
    #bow-instruction()
  ]

  #verse-block[
    The Blessed One's disciples, who have practised well —

    I bow to the S#a[a]ṅgha.
    #bow-instruction()
  ]
]