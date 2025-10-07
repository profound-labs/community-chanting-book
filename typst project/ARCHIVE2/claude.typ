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

// Page setup with page numbering in margins
#set page(
  paper: "a4",
  margin: (top: 0.4in, bottom: 1in, left: 1in, right: 1in),
  header-ascent: 0.5in,
  numbering: none, // Disable default numbering since we'll handle it manually
)

// Custom page numbering function with grey rectangle style
#let page-number-display(page-num) = {
  let alignment = if calc.odd(page-num) { right } else { left }
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
}

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

// Header function that adapts to page number (without page number)
#let header(title, page-num) = {
  let alignment = if calc.odd(page-num) { right } else { left }
  align(alignment)[
    #text(font: "Ubuntu", size: 10pt, weight: "bold", tracking: 0.2pt)[
      #upper(title)
    ]
  ]
  v(1em)
}

// Section title function for left pages (even page numbers)
#let section-title-left(title) = {
  align(left)[
    #text(font: "Ubuntu", size: 20pt, weight: "bold")[
      #title
    ]
  ]
  v(-0.8em)
  line(length: 100%, stroke: 0.5pt + gray.darken(20%))
  v(1em)
}

// Section title function for right pages (odd page numbers)
#let section-title-right(title) = {
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

// Full-size image page function
#let full-image-page(image-path: "cover0.png") = {
  page(
    margin: 0pt,
    numbering: none
  )[
    #image(image-path, width: 100%, height: 100%, fit: "cover")
  ]
}

// Cover page function (without image)
#let cover-page(
  main-title: "EVENING CHANTING",
  subtitle: "Buddhist Devotional Texts",
  monastery: "Monastery Name",
  year: "2024"
) = {
  page(
    margin: (top: 2in, bottom: 2in, left: 1.5in, right: 1.5in),
    numbering: none
  )[
    #v(2in)
    
    #align(center)[
      #text(font: "Ubuntu", size: 28pt, weight: "bold", tracking: 3pt)[
        #upper(main-title)
      ]
      
      #v(1em)
      
      #text(font: "Ubuntu", size: 16pt, weight: "regular", style: "italic")[
        #subtitle
      ]
      
      #v(4em)
      
      #text(font: "Gentium Plus", size: 14pt)[
        #monastery
      ]
      
      #v(0.5em)
      
      #text(font: "Gentium Plus", size: 12pt, fill: gray.darken(30%))[
        #year
      ]
    ]
  ]
}

// Table of contents function (without page number)
#let table-of-contents() = {
  page(
    margin: (top: 1.5in, bottom: 1in, left: 1in, right: 1in),
    numbering: none
  )[
    #v(1em)
    
    #align(left)[
      #text(font: "Ubuntu", size: 24pt, weight: "bold")[
        Contents
      ]
    ]
    
    #v(2em)
    
    // Part header function
    #let part-header(part-num, part-title, page-num) = {
      v(1.5em)
      grid(
        columns: (auto, auto, 1fr, auto),
        align: (left, left, left, right),
        column-gutter: 0.5em,
        [
          #text(font: "Ubuntu", size: 14pt, weight: "bold")[Part #part-num]
        ],
        [
          #text(font: "Ubuntu", size: 14pt, weight: "bold")[#part-title]
        ],
        [],
        [
          #text(font: "Ubuntu", size: 14pt, weight: "bold")[#page-num]
        ]
      )
      v(0.5em)
    }
    
    // Regular entry function with dotted line
    #let toc-entry(title, page-num, indent: 0em) = {
      block(
        spacing: 0.4em,
        inset: (left: indent, right: 0em)
      )[
        #grid(
          columns: (1fr, 2em, auto),
          align: (left, center, right),
          [
            #text(font: "Gentium Plus", size: 12pt)[#title]
          ],
          [
            #h(0.3em)
            #box(width: 2em, repeat[.])
            #h(0.3em)
          ],
          [
            #text(font: "Gentium Plus", size: 12pt)[#page-num]
          ]
        )
      ]
    }
  ]
}

// Main template function that automatically handles left/right page layout
#let chanting-page(
  title: "EVENING CHANTING",
  section-name: "",
  page-number: 1,
  content
) = {
  // Add page number in margin
  page-number-display(page-number)
  
  // Header aligned based on page number (no page number in header now)
  header(title, page-number)
  
  // Section title positioned based on page number
  if calc.odd(page-number) {
    section-title-right(section-name)
  } else {
    section-title-left(section-name)
  }
  
  content
}

// Document structure
// Full-size image page (no page number)
#full-image-page(image-path: "cover0.png")

#pagebreak()

// Cover page (no page number, no image)
#cover-page(
  main-title: "EVENING CHANTING",
  subtitle: "Buddhist Devotional Texts",
  monastery: "Wat Phra Dhammakaya",
  year: "2024"
)

#pagebreak()

// Table of contents (no page number)
#table-of-contents()

#pagebreak()
#pagebreak()

// Reset page counter to start from 1
#counter(page).update(1)

// Example usage - Page 1 (first content page with numbering)
#chanting-page(
  title: "EVENING CHANTING",
  section-name: "Dedication of Offerings",
  page-number: 2
)[
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

    Sv#a[ā]kkh#a[ā]to bhagavat#a[ā] dhammo

    Dhammaṃ namas#a[ā]mi
    #bow()

    Supaṭipanno bhagavato s#a[ā]vakasaṅgho

    Saṅghaṃ nam#a[ā]mi
    #bow()
]

#pagebreak()

// Example usage - Page 2 (right page)
#chanting-page(
  title: "EVENING CHANTING",
  section-name: "Dedication of Offerings",
  page-number: 3
)[
    To the Blessed One, the Lord, who fully attained \
    #h(1em) perfect enlightenment, test

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

    The Teaching, so completely explained by him —

    I bow to the Dh#a[a]mma.
    #bow()

    The Blessed One's disciples, who have practised well —

    I bow to the S#a[a]ṅgha.
    #bow()
]
#pagebreak()

#chanting-page(
  title: "test CHANTING",
  section-name: "test aksdfhaiksudfha",
  page-number: 2
)[
    asdfasdfav#a[ā] arahaṃ samm#a[ā]sambuddho

    Sv#a[ā]kkh#a[ā]to yenzxcvzxcv[ā] dhammo

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

    Sv#a[ā]kkh#a[ā]to bhagavat#a[ā] dhammo

    Dhammaṃ namas#a[ā]mi
    #bow()

    Supaṭipanno bhagavato s#a[ā]vakasaṅgho

    Saṅghaṃ nam#a[ā]mi
    #bow()
]