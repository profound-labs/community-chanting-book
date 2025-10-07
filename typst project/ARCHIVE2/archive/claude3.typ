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

// Page setup
#set page(
  paper: "a4",
  margin: (top: 1.5in, bottom: 1in, left: 1in, right: 1in)
)

// Font and text settings
#set text(
  font: "Gentium Plus",
  size: 13pt,
  fill: black
)

// Paragraph settings
#set par(
  leading: 1em,
  spacing: 1em,
  justify: false,
  first-line-indent: 0pt
)

// Header function that adapts to page number
#let header(title, page-num) = {
  let alignment = if calc.odd(page-num) { right } else { left }
  align(alignment)[
    #text(font: "Ubuntu", size: 12pt, weight: "bold", tracking: 2pt)[
      #upper(title)
    ]
  ]
  v(1em)
}



// Section title function for left pages (even page numbers)
#let section-title-left(title, number) = {
  grid(
    columns: (auto, 1fr),
    align: (left + horizon, left + horizon),
    column-gutter: 1em,
    [
      #rect(
        fill: gray.darken(40%),
        width: 1.5em,
        height: 1.5em,
        radius: 2pt
      )[
        #align(center + horizon)[
          #text(fill: white, weight: "bold", size: 13pt)[#number]
        ]
      ]
    ],
    [
      #text(font: "Ubuntu", size: 15pt, weight: "bold")[
        #title
      ]
    ]
  )
  v(0em)
  line(length: 100%, stroke: 0.5pt + gray.darken(20%))
  v(1em)
}

// Section title function for right pages (odd page numbers)
#let section-title-right(title, number) = {
  grid(
    columns: (1fr, auto),
    align: (right + horizon, right + horizon),
    column-gutter: 1em,
    [
      #align(left)[
        #text(font: "Ubuntu", size: 15pt, weight: "bold")[
          #title
        ]
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
          #text(fill: white, weight: "bold", size: 13pt)[#number]
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
    inset: (left: 1em, right: 0em, top: 0em, bottom: 0em),
    width: 100%
  )[
    #content
  ]
}

// Improved bow instruction function
#let bow() = {
  v(0.3em)
  align(right)[
    #text(font: "Ubuntu", size: 11pt, style: "normal", fill: gray.darken(30%))[
      \[ *BOW* \]
    ]
  ]
  v(0.5em)
}

// Main template function that automatically handles left/right page layout
#let chanting-page(
  title: "EVENING CHANTING",
  section-name: "",
  section-number: "",
  page-number: 1,
  content
) = {
  // Header aligned based on page number
  header(title, page-number)
  
  // Section title positioned based on page number
  if calc.odd(page-number) {
    section-title-right(section-name, section-number)
  } else {
    section-title-left(section-name, section-number)
  }
  
  content
}

// Example usage - Page 18 (left page)
#chanting-page(
  title: "EVENING CHANTING",
  section-name: "Dedication of Offerings", 
  section-number: "18",
  page-number: 18
)[
  #verse-block[
    Yo so bhagav#a[ā] arahaṃ samm#a[ā]sambuddho

    Sv#a[ā]kkh#a[ā]to yena bhagavat#a[ā] dhammo

    Supaṭipanno yassa bhagavato s#a[ā]vakasaṅgho

    Tam-mayaṃ bhagavantaṃ sa-dhammmaṃ sa-saṅghaṃ

    Imehi sakk#a[ā]rehi yath#a[ā]rahaṃ #a[ā]ropitehi abhip#b[ū]jay#a[ā]ma

    S#a[ā]dhu no bhante bhagav#a[ā] suc#b[i]ra-parinibbutopi

    Pacch#b[i]m#a[ā]-janat#a[ā]nukampa-m#a[ā]nas#a[ā]

    Ime sakk#a[ā]re duggata-paṇṇ#a[ā]k#a[ā]ra-bh#b[ū]te paṭiggaṇh#a[ā]tu

    Amh#a[ā]kaṃ d#b[ī]gharattaṃ hit#a[ā]ya sukh#a[ā]ya

    Arahaṃ samm#a[ā]sambuddho bhagav#a[ā]

    Buddhaṃ bhagavantaṃ abh#b[i]v#a[ā]demi
    #bow()
  ]

  #verse-block[
    Sv#a[ā]kkh#a[ā]to bhagavat#a[ā] dhammo

    Dhammaṃ namas#a[ā]mi
    #bow()
  ]

  #verse-block[
    Supaṭipanno bhagavato s#a[ā]vakasaṅgho

    Saṅghaṃ nam#a[ā]mi
    #bow()
  ]
]

#pagebreak()

// Example usage - Page 19 (right page)
#chanting-page(
  title: "EVENING CHANTING",
  section-name: "Dedication of Offerings", 
  section-number: "17",
  page-number: 19
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

    I render homage t#b[o] the Buddha, the Blessed One.
    #bow()
  ]

  #verse-block[
    The Teaching, so completely explained by him —

    I bow to the Dh#a[a]mma.
    #bow()
  ]

  #verse-block[
    The Blessed One's disciples, who have practised well —

    I bow to the S#a[a]ṅgha.
    #bow()
  ]
]