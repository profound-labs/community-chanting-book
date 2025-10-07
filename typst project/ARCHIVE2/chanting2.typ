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
  margin: (top: 2in, bottom: 1in, left: 1in, right: 1in),
  header-ascent: 0.5in,
  numbering: "1", // Enable automatic numbering
  header: context {
    let page-num = counter(page).get().first()
    let section-name = current-section.get()
    
    if page-num > 1 { // Changed from > 0 to > 1 to skip first page
      // Page number in margin
      place(
        if calc.odd(page-num) { top + right } else { top + left },
        dx: if calc.odd(page-num) { 1in } else { -1in },
        dy: -0.3in, // Adjusted positioning
        rect(
          fill: gray.darken(20%),
          width: 4em,
          height: 2em,
          radius: 2pt
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
          #if section-name != "" {
            upper(section-name)
          } else {
            upper("EVENING CHANTING")
          }
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

// Document begins - start directly with content
#counter(page).update(1)

// Content sections
#section("Dedication of Offerings")

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

#pagebreak()

To the Blessed One, the Lord, who fully attained perfect enlightenment,

To the Teaching, which he expounded so well,

And to the Blessed One's disciples who have practised well,

To these — the Buddha, the Dhamma, and the Saṅgha —

We render with offerings our rightful homage.

It is well for us that the Blessed One, having attained liberation,

Still had compassion for later generations.

May these simple offerings be accepted

For our long-lasting benefit and for the happiness it gives us.

The Lord, the Perfectly Enlightened and Blessed One —

I render homage to the Buddha, the Blessed One.
#bow()

The Teaching, so completely explained by him —

I bow to the Dhamma.
#bow()

The Blessed One's disciples, who have practised well —

I bow to the Saṅgha.
#bow()

#pagebreak()

#section("Evening Chanting")

Namo tassa bhagavato arahato sammāsambuddhassa. _(3 times)_

Buddhaṃ saraṇaṃ gacchāmi

Dhammaṃ saraṇaṃ gacchāmi

Saṅghaṃ saraṇaṃ gacchāmi

Dutiyampi buddhaṃ saraṇaṃ gacchāmi

Dutiyampi dhammaṃ saraṇaṃ gacchāmi

Dutiyampi saṅghaṃ saraṇaṃ gacchāmi

Tatiyampi buddhaṃ saraṇaṃ gacchāmi

Tatiyampi dhammaṃ saraṇaṃ gacchāmi

Tatiyampi saṅghaṃ saraṇaṃ gacchāmi
#bow()

#pagebreak()

I go to the Buddha for refuge.

I go to the Dhamma for refuge.

I go to the Saṅgha for refuge.

For the second time, I go to the Buddha for refuge.

For the second time, I go to the Dhamma for refuge.

For the second time, I go to the Saṅgha for refuge.

For the third time, I go to the Buddha for refuge.

For the third time, I go to the Dhamma for refuge.

For the third time, I go to the Saṅgha for refuge.
#bow()

#pagebreak()

#section("Reflection on the Buddha")

Iti pi so bhagavā arahaṃ sammāsambuddho

Vijjācaraṇasampanno sugato lokavidū

Anuttaro purisadammasārathi

Satthā devamanussānaṃ buddho bhagavāti
#bow()

Indeed, the Blessed One is worthy and rightly self-awakened,

Consummate in clear-knowing and conduct, well-gone,

An expert with regard to the cosmos, unexcelled trainer of people fit to be tamed,

Teacher of devas and human beings, awakened, blessed.
#bow()

#pagebreak()

#section("Reflection on the Dhamma")

Svākkhāto bhagavatā dhammo

Sandiṭṭhiko akāliko ehipassiko

Opaneyyiko paccattaṃ veditabbo viññūhīti
#bow()

The Dhamma is well-expounded by the Blessed One,

Apparent here and now, timeless, encouraging investigation,

Pertinent, to be realized by the wise for themselves.
#bow()

#pagebreak()

#section("Reflection on the Sangha")

Supaṭipanno bhagavato sāvakasaṅgho

Ujupaṭipanno bhagavato sāvakasaṅgho

Ñāyapaṭipanno bhagavato sāvakasaṅgho

Sāmīcipaṭipanno bhagavato sāvakasaṅgho

Yadidaṃ cattāri purisayugāni aṭṭha purisapuggalā

Esa bhagavato sāvakasaṅgho

Āhuneyyo pāhuneyyo dakkhiṇeyyo añjalikaraṇīyo

Anuttaraṃ puññakkhettaṃ lokassāti
#bow()

The Saṅgha of the Blessed One's disciples who have practiced well,

The Saṅgha of the Blessed One's disciples who have practiced straight-forwardly,

The Saṅgha of the Blessed One's disciples who have practiced methodically,

The Saṅgha of the Blessed One's disciples who have practiced masterfully,

That is, the four pairs — the eight types — of noble ones:

That is the Saṅgha of the Blessed One's disciples:

Worthy of gifts, worthy of hospitality, worthy of offerings, worthy of respect,

The incomparable field of merit for the world.
#bow()

#pagebreak()

#section("Closing Dedication")

Iminā puññakammena upajjhāyā guṇuttarā

Ācariyūpakārā ca mātāpitā ca ñātakā

Suriyo candimā rājā guṇavantā narāpi ca

Brahma-mārā ca indā ca lokapālā ca devatā

Yamo mittā manussā ca majjhattā verikāpi ca

Sabbe sattā sukhī hontu puññāni pakatāni me

Sukhañ ca tividhaṃ dentu khippaṃ pāpetu vo mama

Iminā puññakammena iminā uddisena ca

Khippāhaṃ sulabhe c'eva taṇhūpādānachedanaṃ

Ye santāne hīnā dhammā yāva nibbānato mamaṃ

Nassantu sabbadā yeva yattha jāto bhave bhave

Ujucittaṃ satipaññā sallekho viriyamhinā

Mārā labhantu nokāsaṃ kātuñ ca viriyesu me

Buddhādhipavaro nātho dhammo nātho varuttamo

Nātho paccekabuddho ca saṅgho nāthottaro mamaṃ

Tesottamānubhāvena mārokāsaṃ labhantu mā
#bow()

Through the goodness that arises from my practice,

May my spiritual teachers and guides of great virtue,

My mother, my father, and my relatives,

The sun and moon, and all virtuous leaders of the world,

May the highest gods and evil forces,

Celestial beings, guardian spirits of the earth, and the Lord of Death,

May those who are friendly, indifferent, or hostile,

May all beings receive the blessings of my life.

May they soon attain the threefold bliss and realize the Deathless.

Through the goodness that arises from my practice,

And through this dedication,

May I quickly attain the end of all cravings and attachments.

May all harmful states of mind,

Until I realize Nibbāna,

Come to an end in me forever, wherever I may be reborn.

May I have an upright mind, mindfulness and wisdom,

Austerity and vigor.

May the forces of delusion not take hold or weaken my resolve.

The Buddha is my excellent refuge, the Dhamma is my noble protection,

The Solitary Buddha is my noble guide, the Saṅgha is my supreme support.

Through the supreme power of all these,

May darkness and delusion be dispelled.
#bow()