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

#set page(numbering: "19", margin: (top: 20mm, right: 20mm, bottom: 20mm, left: 20mm))

// Header
#align(right, text(8pt)[Evening Chanting] + h(1fr) + 
  rect(fill: luma(90%), radius: 3pt, inset: 2pt)[
    text(10pt, strong[19])
  ]
)

// Title
#v(4pt)
#set text(size: 14pt, weight: "bold")
Dedication of Offerings
#line(length: 100%, stroke: 0.5pt + luma(70%))
#set text(size: 11pt, weight: "regular")

#v(6pt)
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
#align(right, text(8pt)[BOW])

[The Teaching,] so completely explained by him —  
I bow to the Dhamma. \
#align(right, text(8pt)[BOW])

[The Blessed One’s disciples,] who have practised well —  
I bow to the Saṅgha. \
#align(right, text(8pt)[BOW])
