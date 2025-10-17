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
  margin: (top: 1in, bottom: 1in, left: 1in, right: 1in),
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
          #upper("")
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
      \[ *INCHINO* \]
    ]
  ]
  v(0.5em)
}


#section("CANTI DEL MATTINO")
#pagebreak()

#section("Dedica delle Offerte")

[Al Beato] al Nobile e Perfettamente Risvegliato

Alla Verità, che ha così ben esposto

Ai discepoli del Beato, che hanno ben praticato

Al Buddha, al Dhamma e al Sangha

Offriamo i nostri onori e i nostri omaggi.

È bene per noi che il Beato, pur avendo ottenuto la Liberazione

Abbia avuto compassione, delle generazioni future.

Questi umili onori e doni siano accolti

A nostro duraturo beneficio, e per la felicità che questo ci dona.

Il Beato, il Nobile Perfettamente Risvegliato

Rendo omaggio al Buddha, al Beato.
#bow()

[L'Insegnamento] completamente esposto dal Beato

Mi inchino al Dhamma.
#bow()

[I discepoli del Beato] che hanno ben praticato

Mi inchino al Sangha.
#bow()
#pagebreak()

#section("Omaggio Preliminare")

[Rendiamo ora omaggio preliminare al Buddha]

Omaggio al Beato, al Nobile Perfettamente Risvegliato. (3 volte)

#section("Omaggio al Buddha")

[Cantiamo ora la lode del Buddha]

Il Tathagata è il Puro, Perfettamente Risvegliato

Impeccabile in condotta e conoscenza

Il Sereno, Conoscitore dei mondi

Abile insegnante per chi cerca educazione

Maestro di déi e di uomini

Risvegliato e Beato,

Ha rivelato la Verità, con profonda comprensione

In questo mondo con i suoi déi, demoni e Brahma, i suoi ricercatori e saggi, le guide e loro popoli.

Lui ha indicato il Dhamma

Bello all'inizio, nel mezzo e alla fine.

A insegnato la Vita Santa, completa e pura in lettera ed essenza

Rendo lode al Beato, mi inchino al Beato. 
#bow()
#pagebreak()

#section("Omaggio al Dhamma")

[Cantiamo ora la lode del Dhamma]

Il Dhamma è ben esposto dal Beato

Presente qui ed ora, senza-tempo, incoraggia la verifica diretta

Conduce oltre, va vissuto di persona da ciascun ricercatore.

Rendo lode all'Insegnamento, mi inchino alla Verità. 
#bow()

#section[Omaggio al Sangha]

[Cantiamo ora la lode del Sangha]

I discepoli del Beato che hanno ben praticato

Vivono rettamente

Vivono sapientemente

Vivono con integrità

Sono le quattro coppie, le otto specie di Nobili persone

Tali sono i discepoli del Beato

Sono degni di doni, degni di ospitalità, degni di offerte, degni di rispetto

Il più fertile terreno di meriti per il mondo. 

Rendo lode alle Nobili Persone, mi inchino al Sangha. 
#bow()
#pagebreak()

#section("Omaggio alla Triplice Gemma")

[Cantiamo ora la lode della Triplice Gemma e un passaggio che susciti urgenza]

Il Buddha, assolutamente puro, oceano di compassione

Colui che possiede l'occhio della saggezza purissima e sublime

Distruttore della corruzione interiore

Con devozione rendo omaggio al Buddha.

Il Dhamma, come una lampada, illumina il sentiero e il suo frutto

Il Senza-Morte, ciò che è al di là del mondo condizionato

Con devozione rendo omaggio al Dhamma. 

Il Sangha, eccellente campo di meriti, disciplinato e contenuto

Ha realizzato la Pace, composto dai Risvegliati dopo il Beato

Nobili e saggi, liberi da ogni brama

Con devozione rendo omaggio al Sangha.

Così è giusto offrire sincera adorazione

Possa il bene generato da questo buona azione dissipare ogni difficoltà.

[Il Tathagata] è sorto in questo mondo, è il Degno, Perfettamente Risvegliato

Il Dhamma, che conduce oltre l'illusione, portatore di pace, la nostra guida verso il Risveglio, 

Questo sentiero il Buddha ci ha indicato.

Avendo udito l'Insegnamento, noi sappiamo che

Nascere è dukkha, invecchiare è dukkha, morire è dukkha

Tristezza, lamento e dolore, 

afflizione e disperazione sono dukkha.

Stare con ciò che non piace è dukkha

Separarsi da ciò che piace è dukkha

Non ottenere il desiderato è dukkha.

In breve i cinque aggregati, soggetti d'attaccamento sono dukkha.

Essi sono:

Forma, sensazione, percezione, formazioni mentali, e coscienza sensoriale.

Per la loro completa comprensione, il Beato durante la sua vita insegnò spesso che:

La forma è impermanente,

la sensazione è impermanente,

la percezione è impermanente,

le formazioni mentali sono impermanenti,

la coscienza sensoriale è impermanente. 

La forma è non-Sé,

la sensazione è non-Sé,

la percezione è non-Sé,

le formazioni mentali son non-Sé, 

la coscienza sensoriale è non-Sé.

Ogni formazione è impermanente,

Non c'è un Sé nel creato e nell'Increato.

Tutti noi siam oppressi dalla nascita, dall'invecchiamento e la morte,

Tristezza, lamento e dolore, afflizione e disperazione,

Oppressi da dukkha e dominati da dukkha.

Rendiamo chiara la cessazione di questa intera massa di sofferenza.

[La parte seguente è recitata solo dai monaci e samanera]

Ispirati dal Beato, dal Nobile, Perfettamente Risvegliato che molto tempo fa ha raggiunto il Parinibbana

Con fede abbiamo abbracciato la vita del senza-dimora

E come il Beato conduciamo la Vita Santa

Avendo intrapreso pienamente l'addestramento monastico

Possa questa Vita condurci alla fine di questa intera massa di sofferenza.

[La parte seguente è recitata solo dai laici]

Il Beato che molto tempo fa ha raggiunto il Parinibbana è il nostro rifugio

Così anche il Dhamma e il Sangha.

Con presenza mentale e determinazione pratichiamo il suo Insegnamento

Possa quindi questa via

Condurci alla fine di questa intera massa di sofferenza.
#pagebreak()

#section("OMAGGIO FINALE")

Il Nobile, Perfettamente Risvegliato e Beato,

Rendo omaggio al Buddha, al Beato.
#bow()    

L'insegnamento da lui completamente esposto,

Mi inchino al Dhamma.
#bow()  

I discepoli del Beato, che hanno ben praticato,

Mi inchino al Sangha.
#bow()
#pagebreak()  

#section("CANTI DELLA SERA")

#pagebreak()

#section("DEDICA DELLE OFFERTE")


[Al Beato] al Nobile Perfettamente Risvegliato

Alla Verità che ha così ben esposto

Ai discepoli del Beato che hanno ben praticato

Al Buddha, al Dhamma e al Sangha

Offriamo i nostri onori e i nostri omaggi.

E' bene per noi che il Beato

Pur avendo ottenuto la liberazione,

abbia avuto compassione delle generazioni future.

Questi umili onori e doni siano accolti

A nostro duraturo beneficio

E per la felicità che questo ci dona.

Il Beato, il Nobile Perfettamente Risvegliato

Rendo omaggio al Buddha, al Beato.
#bow()

[L'Insegnamento] completamente esposto dal Beato

Mi inchino al Dhamma.
#bow()

[I discepoli del Beato] che hanno ben praticato

Mi inchino al Sangha.
#bow()
#pagebreak()

#section("OMAGGIO PRELIMINARE")


[Rendiamo ora omaggio preliminare al Buddha]

Omaggio al Beato, al Nobile Perfettamente Risvegliato (3 volte)


#section("RIFLESSIONE SUL BUDDHA")


[Ricordiamo ora le qualità del Buddha]

Così è stato detto del Beato con grande ammirazione:

Puro di cuore, Perfettamente Risvegliato e Beato

Impeccabile in condotta e conoscenza

il Sereno, Conoscitore dei mondi

Abile insegnante per chi cerca educazione

Maestro di dèi e di uomini

Risvegliato e Beato.


#section("LODE DEL BUDDHA")


[Cantiamo ora la lode del Buddha]

Il Buddha, dotato di eccellenti qualità

La sua natura è purezza, conoscenza diretta e compassione

Il Buddha sveglia i cuori come il sole risplende sul loto

Saluto rispettoso quel conquistatore di pace

Il Buddha è per tutti i viventi rifugio sicuro e supremo

A questo primo oggetto di ricordo offro la mia profonda devozione

Sono al servizio del Buddha, il Buddha mi ispira e mi guida

Il Buddha mette fine al dolore ed è fonte di ogni mia gioia

Al Buddha offro il mio corpo e la mia vita

E con devozione camminerò la sua via di Risveglio

Per me non c'è altro rifugio, il Buddha è il miglior rifugio

In forza della mia sincerità che io cresca nella via del maestro

Possa il bene generato da questa lode del Buddha

aiutarmi a superare ogni difficoltà.

#bow()

Se con il corpo, la parola o la mente 

Ho agito male nei confronti del Buddha

Si accetti il riconoscimento del mio errore 

E l'intenzione di correggermi nei riguardi del Buddha.


#section("RIFLESSIONE SUL DHAMMA")

[Ricordiamo ora le qualità del Dhamma]

Il Dhamma è ben esposto dal Beato

Presente qui ed ora, senza-tempo, incoraggia la verifica diretta

Conduce oltre, va vissuto di persona da ciascun ricercatore.


#section("LODE DEL DHAMMA")


[Cantiamo ora la lode del Dhamma]

È eccellente perché è ben esposto

Nei suoi diversi aspetti: Sentiero e Frutto, pratica e liberazione.

Coloro che lo sostengono, sono a loro volta protetti

Dal cadere nell'illusione.

Mi inchino alla Verità preziosa che disperde l'ignoranza.

Il Dhamma è per tutti i viventi rifugio sicuro e supremo.

A questo secondo oggetto di ricordo offro la mia profonda devozione

Sono al servizio del Dhamma, il Dhamma mi ispira e mi guida.

Il Dhamma mette fine al dolore ed è fonte di ogni mia gioia.

Al Dhamma offro il mio corpo e la mia vita

E con devozione camminerò l'eccellente via del Dhamma.

Per me non c'è altro rifugio, il Dhamma è il miglior rifugio.

In forza della mia sincerità che io cresca nella via del Maestro.

Possa il bene generato da questa lode del Dhamma

Aiutarmi a superare ogni difficoltà.
#bow()

Se con il corpo la parola o la mente

Ho agito male nei confronti del Dhamma

Si accetti il riconoscimento del mio errore 

E l'intenzione di correggermi nei riguardi del Dhamma.

#section("RIFLESSIONE SUL SANGHA")

[Ricordiamo ora le qualità del Sangha]

I discepoli del Beato che hanno ben praticato

Vivono rettamente

Vivono sapientemente

Vivono con integrità

Sono le quattro coppie, le otto specie di Nobili persone

Tali sono i discepoli del Beato

Sono degni di doni, degni di ospitalità, degni di offerte, degni di rispetto

Il più fertile terreno di meriti il mondo.


#section("LODE DEL SANGHA")

[Cantiamo ora la lode del Sangha]

Nato dal Dhamma, il Sangha che ha praticato bene

Quel Sangha che è composto da otto specie di Nobili persone.

Corpo e mente, guidati da saggezza e integrità morale.

Rendo omaggio alla purezza di questa Nobile assemblea.

Il Sangha è per tutti i viventi rifugio sicuro e supremo.

A questo terzo oggetto di ricordo offro la mia profonda devozione.

Sono al servizio del Sangha, il Sangha mi ispira e mi guida.

Il Sangha mette fine al dolore ed è fonte di ogni mia gioia.

Al Sangha offro il mio corpo e la mia vita

E con devozione seguirò la corretta condotta del Sangha

Per me non c'è altro rifugio, il Sangha è il miglior rifugio.

In forza della mia sincerità che io cresca nella via del Maestro.

Possa il bene generato da questa lode del Sangha

Aiutarmi a superare ogni difficoltà.
#bow()

Se con il corpo la parola o la mente

Ho agito male nei confronti del Sangha

Si accetti il riconoscimento del mio errore

E l'intenzione di correggermi nei riguardi del Sangha.


#section("OMAGGIO FINALE")


[Il Nobile] Perfettamente Risvegliato e Beato

Rendo omaggio al Buddha, al Beato
#bow()

[L'Insegnamento] completamente esposto dal Beato

Mi inchino al Dhamma
#bow()

[I discepoli del Beato] che hanno ben praticato

Mi inchino al Sangha
#bow()

#pagebreak()

#section("Metta Sutta")
[Cantiamo ora le parole del Buddha sulla Gentilezza Amorevole]

#v(1cm)

[Questo dovrebbe fare] chi pratica il bene e conosce il sentiero della pace:

Essere coraggioso, retto e onesto

Semplice da ammonire, gentile e non arrogante

Contento, facile da aiutare, 

Non oppresso da impegni e di modi frugali,

Calmo e prudente,

Non altero o esigente,

Incapace di fare ciò che il saggio poi disapprova.

#v(1cm)

Che tutti gli esseri vivano felici e sicuri:

Tutti, chiunque essi siano,

Risvegliati e non risvegliati,

Alti, medi e bassi, grandi e piccini

Visibili e non visibili,

Vicini e lontani,

Nati e non ancora nati.

Che tutti gli esseri vivano felici!

Che nessuno inganni l'altro né lo disprezzi

Nè per odio o irritazione

Desideri il suo male.

Come una madre proteggerebbe con la sua vita, suo figlio, il suo unico figlio

Allo stesso modo si coltivi un cuore illimitato, verso tutti gli esseri viventi,

Irradiando amore sull'universo intero;

In alto aldilà del cielo, in basso verso gli abissi,

Illimitatamente, in ogni direzione, liberi da odio e rancore.

Seduti, in piedi o camminando,

Distesi esenti da torpore,

Sostenendo la pratica di Metta;

Questa è la sublime dimora.

Non legato ad opinioni,

Il puro di cuore, dotato di retta visione,

Liberato da brame sensuali,

Non tornerà a nascere in questo mondo.

#pagebreak()

#section("Dedica dei meriti")


[Cantiamo ora i versi di dedica e aspirazione]

[Attraverso il bene] che nasce dalla mia pratica,

Che i miei maestri spirituali di insuperabile virtù,

Che tutti i miei insegnanti, mia madre, mio padre e i miei parenti,

Il Sole e la Luna, persone virtuose e guide del mondo

Possano gli dei supremi e le forze del male, gli spiriti guardiani della Terra e gli altri esseri celesti,

Il Signore della Morte, persone amichevoli, indifferenti e ostili,

Che tutti gli esseri ricevano i meriti della mia pratica.

Che presto giungano alla Triplice Felicità e realizzino il Senza-morte.

Attraverso il bene che nasce dalla mia pratica e da questa dedica,

Che possa io rapidamente e con facilità, estirpare ogni brama e attaccamento, 

Tutti gli stati mentali nocivi fino alla realizzazione del Nibbāna,

Possano dissolversi per sempre ovunque io rinasca in ogni esistenza

Possa mantenere una mente retta con consapevolezza e saggezza, austerità e vigore

che le forze dell'illusione non trovino mai varco per ostacolare i miei sforzi

Il Buddha è il mio sommo rifugio,

Insuperabile è la protezione del Dhamma,

Il Buddha solitario è il mio nobile esempio,

Il Saṅgha è il mio più grande sostegno.

Armato di questo supremo potere che Mara non trovi mai varco.
#pagebreak()

#section[Condivisione dei meriti]

[Ora cantiamo i versi di condivisione dei meriti]

[Il merito] che ora ho compiuto e quello che ho accumulato in passato 

Possa essere condiviso con tutte le creature, senza limiti in ogni direzione,

Persone care piene di bontà, a partire da mia madre e mio padre,

Esseri visti e non visti da me, indifferenti e ostili,

Esseri che dimorano nel mondo, nei tre piani di esistenza, dai quattro tipi di nascita,

Dotati di uno, quattro o cinque aggregati, vagando da un'esistenza all'altra,

Coloro che sono a conoscenza della mia dedica, possano gioire di essa,

E per chi ancora non ne è a conoscenza che gli déi gliela rendano nota,

E a causa del loro gioire per il merito donato da me,

Possano tutti gli esseri vivere sempre felici, liberi da ogni discordia

E possano loro realizzare il Nibbana e le loro nobili aspirazioni.

#pagebreak()

#section("Riflessione sul benessere universale")

[Cantiamo ora la riflessione sul benessere universale]

#v(1cm)

[Che io possa essere felice]

Libero da sofferenza,

Libero da ostilità,

Libero da malevolenza,

Libero da ansia,

E che possa mantenere il benessere in me stesso.

#v(1cm) 

Che tutti gli esseri siano felici,

Liberi da ostilità,

Liberi da malevolenza,

Liberi da ansia,

E che possano mantenere il benessere in loro stessi.

#v(1cm)

Che tutti gli esseri possano essere liberi dalla sofferenza.

#v(1cm)

E che non vengano separati dalla fortuna ottenuta.

#v(1cm)

Tutti gli esseri sono padroni del loro kamma, eredi del loro kamma, nati dal loro kamma, legati al loro kamma, qualunque kamma compiano buono o cattivo ne saranno gli eredi.
#pagebreak()

#section("Diffusione delle Dimore Divine")

[Facciamo ora risplendere i quattro Immensurabili]

#v(1cm) 

[Dimorerò] pervadendo una direzione con il cuore imbevuto di gentilezza amorevole,

Così la seconda, così la terza, così la quarta,

Così sopra e sotto, intorno e in ogni luogo, e a tutti come a me stesso.

Dimorerò pervadendo l'intero mondo con un cuore imbevuto di gentilezza amorevole, abbondante, sublime, immensurabile, senza ostilità e senza malevolenza.

#v(1cm)

Dimorerò pervadendo una direzione con il cuore imbevuto di compassione,

Così la seconda, così la terza, così la quarta,

Così sopra e sotto, intorno e in ogni luogo, e a tutti come a me stesso.

Dimorerò pervadendo l'intero mondo con un cuore imbevuto di compassione, abbondante, sublime, immensurabile, senza ostilità e senza malevolenza.

#v(1cm)

Dimorerò pervadendo una direzione con il cuore imbevuto di gioia empatica,

Così la seconda, così la terza, così la quarta,

Così sopra e sotto, intorno e in ogni luogo, e a tutti come a me stesso.

Dimorerò pervadendo l'intero mondo con un cuore imbevuto di gioia empatica, abbondante, sublime, immensurabile, senza ostilità e senza malevolenza.

#v(1cm) 

Dimorerò pervadendo una direzione con il cuore imbevuto di equanimità,

Così la seconda, così la terza, così la quarta,

Così sopra e sotto, intorno e in ogni luogo, e a tutti come a me stesso.

Dimorerò pervadendo l'intero mondo con un cuore imbevuto di equanimità, abbondante, sublime, immensurabile, senza ostilità e senza malevolenza.

#pagebreak()

#section("Le Più Alte Benedizioni")

[Cantiamo ora i versi delle più alte benedizioni]

#v(1cm) 

[Così ho udito] il Beato una volta soggiornava a Sāvatthī, nella foresta di Jeta, nel parco di Anāthapiṇḍika.

Poi nel buio della notte, una divinità radiante illuminò tutta la foresta di Jeta.

Si inchinò al cospetto del Beato, essendosi alzata si mise da un lato, e così gli disse:

Molti déi e uomini riflettono sulle massime benedizioni, desiderando felicità e sicurezza, quali sono dunque le più alte benedizioni?

#v(1cm)

Non associarsi agli stolti,

Associarsi ai saggi,

Venerare coloro che sono degni di lode,

Queste sono le più alte benedizioni.

#v(1cm)

Dimorare in luoghi adatti,

Avere creato meriti in passato,

Stabilire rettamente le proprie intenzioni,

Queste sono le più alte benedizioni.

#v(1cm)

Aver ampia conoscenza e molte abilità,

Disciplina ben studiata e osservata,

Parole ben dette, rette e armoniose,

Queste sono le più alte benedizioni.

#v(1cm)

Assistere madre e padre,

Prendersi cura di figli e consorte,

Svolgere un lavoro non stressante,

Queste sono le più alte benedizioni.

#v(1cm)

Essere generosi e vivere rettamente,

Aiutare i propri parenti,

Compiere azioni irreprensibili,

Queste sono le più alte benedizioni.

#v(1cm)

Astenersi dal praticare il male,

Evitare sostanze che offuscano la mente,

Essere vigili in ogni circostanza,

Queste sono le più alte benedizioni.

#v(1cm)

Essere rispettosi e umili,

Essere contenti e grati,

Ascoltare il Dhamma nei momenti opportuni,

Queste sono le più alte benedizioni.

#v(1cm)

Essere pazienti e facili da ammonire,

Incontrare venerabili rinuncianti,

Parlare del Dhamma nei momenti opportuni,

Queste sono le più alte benedizioni.

#v(1cm)

Bruciare le contaminazioni e condurre la Vita Santa,

Vedere la Quattro Nobili Verità,

Realizzare il Nibbana,

Queste sono le più alte benedizioni.

#v(1cm)

Non essere scossi dalle vicissitudini del mondo,

Liberi da sofferenza, immacolati e sicuri,

Queste sono le più alte benedizioni.

#v(1cm)

Coloro che hanno compiuto questi atti vivono ovunque non sconfitti,

Ovunque son felici e sicuri,

Queste sono le più alte benedizioni.

#pagebreak()

#section("Nibbana Sutta")

[Handa mayam Nibbana Sutta patham bhanamase]

[Cantiamo ora le parole del Buddha sul Nibbāna]

#v(1cm)

[C'è un Non-nato] Non-originato, Non-creato e Non-formato.

Se non ci fosse questo Non-nato, Non-originato, Non-creato e Non-formato,

la liberazione dal Non-nato, Non-originato, Non-creato e Non-formato non sarebbe possibile.

Ma dato che c'è un Non-nato, Non-originato, Non-creato e Non-formato,

allora è possibile la liberazione dal mondo del nato, originato, creato e formato.

#pagebreak()

#section("Riflessione sui quattro recquisiti")

[Cantiamo ora la riflessione sui quattro requisiti]

#v(1cm)

[Riflettendo saggiamente] uso le vesti, solo per difendermi dal freddo, difendermi dal caldo, difendermi dal contatto di mosche, zanzare, vento, sole e crature striscianti, e solo per coprire il corpo.

Rflettendo saggiamente uso il cibo offerto, non per piacere e divertimentimento, non per desiderio di euforia, non per ingrassare, non per ostentazione e vanità.

Lo uso solo per mantenere il corpo, per mantenerlo sano, per porre fine al disagio, per sostenere la Vita Santa,

alleviando la fame senza stramangiare continuerò a vivere senza colpa e mio agio.

Riflettendo saggiamente uso la dimora, solo per difendermi dal freddo, difendermi dal caldo, difendermi dal contatto di mosche, zanzare, vento, sole e crature striscianti, solo per proteggermi dalle intemperie e per vivere in solitudine.

Riflettendo saggiamente uso i rimedi curativi, solo per difendermi da sensazioni spiacevoli già sorte, per la massima libertà dalla malattia.

#pagebreak()

#section("Cinque temi per la frequente riflessione")

[Cantiamo ora i cinque temi per la frequente riflessione]

Sono soggetto alla vecchiaia, non sono esente dalla vecchiaia.

Sono soggetto alla malattia, non sono esente dalla malattia.

Sono soggetto alla morte, non sono esente dalla morte.

Tutto ciò che è mio, piacevole e amato, è soggetto al cambiamento, si separerà da me.

Sono padrone del mio kamma, erede del mio kamma, nato dal mio kamma, legato al mio kamma, qualunque kamma compio buono o cattivo ne sarò l'erede.

#pagebreak()

#section("Riflessione sull'impermanenza")

[Cantiamo ora la riflessione sull'impermanenza]

#v(1cm)

Tutte le formazioni sono impermanenti.

Tutte le formazioni sono dukkha.

Tutto è privo di un Sé.

Instabile è la vita,

Inevitabile è la morte.

Sicuramente morirò.

La morte è l'epilogo della mia vita.

La mia vita è incerta,

La mia morte è certe.

Sicuramente, questo corpo sarà presto privo di coscienza e gettato via giacerà a terra come un tronco marcio, completamente inutile.

Veramente tutte le formazioni non possono durare,

la loro natura è quella di sorgere e svanire,

Essendo sorte devono cessare,

Il loro estinguersi è felicità.

#pagebreak()

#section("Riflessione sulle 32 parti")

[Cantiamo ora la riflessione sulle 32 parti del corpo]

#v(1cm)

[Questo mio corpo] dalla punta dei piedi alla sommità del capo è una sacca di pelle piena di cose sporche,

In questo corpo ci sono:

Capelli

Peli 

Unghie 

denri 

Pelle

Muscoli

Tendini 

Ossa 

Midollo osseo 

Reni 

Cuore 

Fegato 

Membrane 

Milza 

Polmoni

Budella

Mesentere

Cibo non digerito

Escrementi

Bile

Catarro

Pus

Sangue

Sudore

Grasso solido

Lacrime

Grasso fluido 

Saliva

Muco 

Licquido sinoviale

Urina

Cervello

Così, questo mio corpo, dalla punta dei piedi alla sommità del capo è una sacca di pelle piena di cose sporche. 

#pagebreak()

#section("Riflessione sulle qualità ripugnanti dei recquisiti")

[Cantiamo ora la riflessione sulle qualità ripugnanti dei requisiti]

#v(1cm)

Composte da soli elementi in accordo con cause e condizioni

sono queste vesti e così la persona che le indossa.

Soltanto elementi,

Non un essere,

Senza vita autonoma,

E vuoti di un Sé.

Nessuna di queste vesti è per sua natura disgustosa

ma toccando questo corpo sporco

diventano di certo ripugnanti.

#v(1cm)

Composto da soli elementi in accordo con cause e condizioni

è questo cibo offerto e così la persona che lo consuma.

Soltanto elementi,

Non un essere,

Senza vita autonoma,

E vuoti di un Sé.

Niente di questo cibo è per sua natura disgustosa

ma toccando questo corpo sporco

diventa di certo ripugnante.

#v(1cm)

Composta da soli elementi in accordo con cause e condizioni

è questa dimora e così la persona che la abita.

Soltanto elementi,

Non un essere,

Senza vita autonoma,

E vuoti di un Sé.

Niente di questa dimora è per sua natura disgustosa

ma toccando questo corpo sporco

diventa di certo ripugnante.

#v(1cm)

Composti da soli elementi in accordo con cause e condizioni

sono questi rimedi curativi e così la persona che lo consuma.

Soltanto elementi,

Non un essere,

Senza vita autonoma,

E vuoti di un Sé.

Niente di questi rimedi curativi sono per loro natura disgustosa

ma toccando questo corpo sporco

diventano di certo ripugnanti.

#pagebreak()

#section("Dieci temi di frequente riflessione per un rinunciante")

[Cantiamo ora i dieci temi di frequente riflessione per un rinunciante]

#v(1cm)

[Bhikkhu] ci sono dieci temi su cui dovrebbe riflettere spesso un rinunciante

Quali sono questi dieci?

#v(1cm)

Non vivo più seguendo valori e scopi mondani, questo è ciò su cui dovrebbe riflettere spesso un rinunciante.

#v(1cm)

La mia vita è sostenuta attraverso i doni degli altri, questo è ciò su cui dovrebbe riflettere spesso un rinunciante.

#v(1cm)

C'è ancora altra pratica da compiere, questo è ciò su cui dovrebbe riflettere spesso un rinunciante.

#v(1cm)







