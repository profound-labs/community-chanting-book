// Load fonts (assuming they are installed)
#set text(font: "Gentium Plus", size: 11pt, leading: 1.2em)

// Heading style for = Title
#set heading(
  level: 1,
  text: text(font: "Ubuntu", size: 14pt, weight: "bold"),
  before: 1em,
  after: 0.4em,
  numbering: none,
  separator: none,
  supplement: none,
  block: (content) => {
    text(font: "Ubuntu", size: 14pt, weight: "bold")[#content]
    line(length: 100%, stroke: 0.5pt + luma(70%))
  }
)

// Functions for pitch marks
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

// Function for [BOW] right-aligned in small text
#let bow = align(right, text(size: 8pt)["[BOW]"])

// Header style with page number
#let header = {
  align(right)[
    text(8pt, "EVENING CHANTING") \ 
    rect(fill: luma(90%), radius: 3pt, inset: (x: 4pt, y: 2pt))[
      text(10pt, strong(page()))
    ]
  ]
}

#page(header: header)

// Example usage
= Dedication of Offerings

[To the Blessed One,] the Lord, who fully attained  
perfect enlightenment,  
To the Teaching, which he expounded so well,  
And to the Blessed One’s disciples who have practised well,  
To these — the Buddha, the Dhamma, and the Sa#a[n]gha —  
We render with offerings our rightful ho#a[m]age.  
It is well for us that the Blessed One, having attained liberation,  
Still had compassion for later generations.  
May these simple offerings be ac#a[c]cepted  
For our long-lasting benefit and for the happiness it gives us.  
The Lord, the Perfectly Enlightened and Blessed One —  
I render homage to the Buddha, the Blessed One. \
#bow

[The Teaching,] so completely explained by him —  
I bow to the Dhamma. \
#bow

[The Blessed One’s disciples,] who have practised well —  
I bow to the Saṅgha. \
#bow
