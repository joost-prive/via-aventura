# Generates 13 project detail pages

$dir = "C:\dev\32-via-aventura-website\projects"
$utf8 = New-Object System.Text.UTF8Encoding $false

# Reusable SVG illustrations (from index.html)
$svgLetterDuel = @'
<svg viewBox="0 0 800 500" class="illustration" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="500" fill="#faf6ec"/>
  <g transform="translate(260 130) rotate(-6)">
    <rect x="0" y="0" width="170" height="200" rx="14" fill="#fff8e8" stroke="#7a4a1f" stroke-width="2.4"/>
    <text x="85" y="140" text-anchor="middle" fill="#7a4a1f" font-family="Fraunces, serif" font-size="108" font-weight="600">L</text>
    <text x="142" y="182" text-anchor="middle" fill="#7a4a1f" font-family="Fraunces, serif" font-size="22">3</text>
  </g>
  <g transform="translate(420 180) rotate(8)">
    <rect x="0" y="0" width="170" height="200" rx="14" fill="#fff8e8" stroke="#7a4a1f" stroke-width="2.4"/>
    <text x="85" y="140" text-anchor="middle" fill="#7a4a1f" font-family="Fraunces, serif" font-size="108" font-weight="600">D</text>
    <text x="142" y="182" text-anchor="middle" fill="#7a4a1f" font-family="Fraunces, serif" font-size="22">2</text>
  </g>
</svg>
'@

$svgOlivia = @'
<svg viewBox="0 0 800 500" class="illustration" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="500" fill="#faf6ec"/>
  <g stroke="#7a4a1f" fill="none" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
    <path d="M310 130 Q280 90 280 75 Q280 55 310 55" fill="#fff8e8"/>
    <path d="M490 130 Q520 90 520 75 Q520 55 490 55" fill="#fff8e8"/>
    <circle cx="400" cy="270" r="130" fill="#fff8e8"/>
    <circle cx="400" cy="270" r="115" stroke-dasharray="3 7"/>
    <line x1="400" y1="270" x2="400" y2="190"/>
    <line x1="400" y1="270" x2="465" y2="270"/>
    <circle cx="400" cy="270" r="6" fill="#7a4a1f"/>
    <line x1="400" y1="160" x2="400" y2="172"/>
    <line x1="400" y1="370" x2="400" y2="382"/>
    <line x1="290" y1="270" x2="302" y2="270"/>
    <line x1="498" y1="270" x2="510" y2="270"/>
    <text x="400" y="425" text-anchor="middle" fill="#c0492a" font-family="Fraunces, serif" font-size="32" font-style="italic" stroke="none">06:30</text>
    <line x1="320" y1="395" x2="298" y2="425"/>
    <line x1="480" y1="395" x2="502" y2="425"/>
  </g>
</svg>
'@

$svgFases = @'
<svg viewBox="0 0 800 500" class="illustration" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="500" fill="#faf6ec"/>
  <g stroke="#7a4a1f" fill="none" stroke-width="2.2">
    <rect x="260" y="80" width="280" height="340" rx="6" fill="#fff8e8"/>
    <rect x="260" y="80" width="280" height="70" fill="#ecdcb4"/>
    <line x1="290" y1="60" x2="290" y2="100" stroke-linecap="round"/>
    <line x1="330" y1="60" x2="330" y2="100" stroke-linecap="round"/>
    <line x1="370" y1="60" x2="370" y2="100" stroke-linecap="round"/>
    <line x1="410" y1="60" x2="410" y2="100" stroke-linecap="round"/>
    <line x1="450" y1="60" x2="450" y2="100" stroke-linecap="round"/>
    <line x1="490" y1="60" x2="490" y2="100" stroke-linecap="round"/>
    <line x1="510" y1="60" x2="510" y2="100" stroke-linecap="round"/>
    <text x="400" y="135" text-anchor="middle" fill="#7a4a1f" font-family="Fraunces, serif" font-size="34" font-style="italic" stroke="none">November</text>
    <line x1="290" y1="190" x2="510" y2="190" opacity=".5"/>
    <line x1="290" y1="220" x2="490" y2="220" opacity=".5"/>
    <line x1="290" y1="250" x2="505" y2="250" opacity=".5"/>
    <line x1="290" y1="280" x2="475" y2="280" opacity=".5"/>
    <line x1="290" y1="310" x2="500" y2="310" opacity=".5"/>
    <line x1="290" y1="340" x2="465" y2="340" opacity=".5"/>
    <line x1="290" y1="370" x2="495" y2="370" opacity=".5"/>
  </g>
</svg>
'@

$svgBingo = @'
<svg viewBox="0 0 800 500" class="illustration" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="500" fill="#faf6ec"/>
  <g stroke="#7a4a1f" stroke-width="2.2">
    <circle cx="220" cy="260" r="65" fill="#ecdcb4"/>
    <text x="220" y="275" text-anchor="middle" fill="#7a4a1f" font-family="Fraunces, serif" font-size="32" font-weight="500" stroke="none">B7</text>
    <circle cx="380" cy="170" r="72" fill="#fff8e8"/>
    <text x="380" y="185" text-anchor="middle" fill="#7a4a1f" font-family="Fraunces, serif" font-size="36" font-weight="500" stroke="none">I22</text>
    <circle cx="540" cy="240" r="62" fill="#ecdcb4"/>
    <text x="540" y="255" text-anchor="middle" fill="#7a4a1f" font-family="Fraunces, serif" font-size="32" font-weight="500" stroke="none">N15</text>
    <circle cx="290" cy="370" r="58" fill="#fff8e8"/>
    <text x="290" y="385" text-anchor="middle" fill="#7a4a1f" font-family="Fraunces, serif" font-size="30" font-weight="500" stroke="none">G44</text>
    <circle cx="470" cy="380" r="66" fill="#ecdcb4"/>
    <text x="470" y="395" text-anchor="middle" fill="#c0492a" font-family="Fraunces, serif" font-size="34" font-weight="500" stroke="none">O60</text>
  </g>
</svg>
'@

$svgVertrek = @'
<svg viewBox="0 0 800 500" class="illustration" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="500" fill="#faf6ec"/>
  <g stroke="#7a4a1f" fill="none" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
    <path d="M280 170 L280 410 Q280 445 320 445 L480 445 Q520 445 520 410 L520 170 Q520 110 460 110 L340 110 Q280 110 280 170 Z" fill="#ecdcb4"/>
    <path d="M360 110 Q360 60 400 60 Q440 60 440 110"/>
    <rect x="320" y="240" width="160" height="140" rx="10" fill="#fff8e8"/>
    <line x1="320" y1="305" x2="480" y2="305" stroke-dasharray="3 5"/>
    <circle cx="480" cy="305" r="6" fill="#c0492a"/>
    <line x1="318" y1="170" x2="318" y2="410"/>
    <line x1="482" y1="170" x2="482" y2="410"/>
  </g>
</svg>
'@

$svgTour = @'
<svg viewBox="0 0 800 500" class="illustration" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="500" fill="#faf6ec"/>
  <g stroke="#7a4a1f" fill="none" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
    <circle cx="220" cy="340" r="90" fill="#fff8e8"/>
    <circle cx="540" cy="340" r="90" fill="#fff8e8"/>
    <g opacity=".35">
      <line x1="220" y1="250" x2="220" y2="430"/>
      <line x1="130" y1="340" x2="310" y2="340"/>
      <line x1="540" y1="250" x2="540" y2="430"/>
      <line x1="450" y1="340" x2="630" y2="340"/>
    </g>
    <line x1="220" y1="340" x2="400" y2="190"/>
    <line x1="400" y1="190" x2="540" y2="340"/>
    <line x1="220" y1="340" x2="400" y2="340"/>
    <line x1="400" y1="190" x2="400" y2="340"/>
    <line x1="370" y1="190" x2="440" y2="190" stroke-width="5"/>
    <path d="M400 190 L460 130 L500 110"/>
    <line x1="480" y1="120" x2="520" y2="120"/>
    <rect x="380" y="240" width="26" height="56" rx="3" fill="#c0492a" stroke="#c0492a"/>
  </g>
</svg>
'@

$svgPluk = @'
<svg viewBox="0 0 800 500" class="illustration" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="500" fill="#faf6ec"/>
  <g stroke="#7a4a1f" fill="none" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
    <line x1="290" y1="90" x2="510" y2="90" stroke-width="5"/>
    <line x1="290" y1="410" x2="510" y2="410" stroke-width="5"/>
    <path d="M310 90 L310 170 L390 250 L310 330 L310 410" fill="#fff8e8"/>
    <path d="M490 90 L490 170 L410 250 L490 330 L490 410" fill="#fff8e8"/>
    <path d="M330 130 L330 170 L390 240 L410 240 L470 170 L470 130 Z" fill="#ecdcb4" stroke="none"/>
    <line x1="400" y1="250" x2="400" y2="340" stroke-dasharray="3 6"/>
    <path d="M340 380 Q400 340 460 380 L460 395 L340 395 Z" fill="#ecdcb4" stroke="none"/>
    <path d="M570 180 Q620 200 635 235 Q610 255 575 235 Q558 210 570 180 Z" fill="#c0492a" stroke="none" opacity=".75"/>
    <line x1="580" y1="235" x2="600" y2="295"/>
  </g>
</svg>
'@

$svgTuben = @'
<svg viewBox="0 0 800 500" class="illustration" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg">
  <rect width="800" height="500" fill="#faf6ec"/>
  <g stroke="#7a4a1f" fill="none" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round">
    <rect x="200" y="130" width="400" height="240" rx="12" fill="#fff8e8"/>
    <line x1="400" y1="130" x2="400" y2="370"/>
    <polygon points="280,220 280,290 350,255" fill="#c0492a" stroke="#c0492a"/>
    <line x1="430" y1="190" x2="570" y2="190" opacity=".6"/>
    <line x1="430" y1="215" x2="555" y2="215" opacity=".6"/>
    <line x1="430" y1="240" x2="565" y2="240" opacity=".6"/>
    <line x1="430" y1="265" x2="540" y2="265" opacity=".6"/>
    <line x1="430" y1="290" x2="560" y2="290" opacity=".6"/>
    <line x1="430" y1="315" x2="530" y2="315" opacity=".6"/>
    <line x1="340" y1="370" x2="340" y2="410"/>
    <line x1="460" y1="370" x2="460" y2="410"/>
    <line x1="300" y1="410" x2="500" y2="410" stroke-width="4"/>
  </g>
</svg>
'@

# Image blocks
$imgClashrooms = '<img src="/images/clashrooms.jpg" alt="Een ClashRooms-locatie tijdens een groepsavond — een team in actie tussen gekleurde verlichting" width="1400" height="933" loading="lazy"/>'
$imgEmodjeez  = '<img src="/images/emodjeez.jpg" alt="Screenshot van het startscherm van de Emodjeez emoji-quiz app" width="900" height="900" loading="lazy"/>'
$imgPSV       = '<img src="/images/psv.jpg" alt="Iconisch PSV-moment uit het Eindhovense voetbalarchief, jaargang 2016" width="1400" height="933" loading="lazy"/>'
$imgSnackbar  = '<img src="/images/snackbar.jpg" alt="De Snelle Hap — concept-impressie van een snackbar met voice-bestelling" width="1200" height="800" loading="lazy"/>'
$imgSchmink   = '<img src="/images/schmink.svg" alt="Carnaval-schmink illustratie: kindergezicht met paars-gele vlindervleugel-make-up" loading="lazy"/>'

# Projects in display order. Prev/next cycle through.
$projects = @(
  [ordered]@{ num="01"; slug="clashrooms"; title="ClashRooms"; h1="ClashRooms"; tagline="Social gaming locaties"; type="Site &amp; tools"; year="2022 — heden"; status="Live"; statusClass="status-live"; image=$imgClashrooms;
    story="ClashRooms is een nieuwe vorm van social gaming: groepen vrienden, collega's of families nemen het tegen elkaar op in fysieke ruimtes vol games, lichten en geluid. Wat begon als idee groeide door tot een ecosysteem met meerdere websites (Nederland en Belgi&euml;), en een familie aan interne tools voor reviews, advertenties, groepsfoto's, mail-flows en captcha-experimenten.";
    why="Social gaming buiten de gebaande escape-room-paden. Combineert het format van puzzelkamers met de energie van game shows en de toegankelijkheid van bowling — voor groepen die iets willen doen, niet alleen ergens zitten.";
    learned="Een fysieke locatie en een digitale stack runnen is een ander spel dan alleen software bouwen. Marketing, onderhoud, klantcontact en game design zijn allemaal eigen disciplines met eigen ritme.";
    chips=@("Next.js","TypeScript","Cloudflare","Tailwind","Marketing automation","AI tooling");
    cta='<a class="btn btn-primary" href="https://clashrooms.nl" target="_blank" rel="noopener">clashrooms.nl &rarr;</a><a class="btn btn-outline" href="https://clashrooms.eu" target="_blank" rel="noopener">clashrooms.eu</a><a class="btn btn-outline" href="https://socialgamingeindhoven.nl" target="_blank" rel="noopener">socialgamingeindhoven.nl</a>' }

  [ordered]@{ num="02"; slug="emodjeez"; title="Emodjeez"; h1="Emodjeez"; tagline="Emoji quiz"; type="Spel"; year="2025"; status="Live"; statusClass="status-live"; image=$imgEmodjeez;
    story="De ultieme emoji-quiz. Krijg een emoji te zien en raad in welke WhatsApp-categorie hij hoort. Voor de fanatici is er een 1v1-modus waarin je tegen vrienden speelt. Gebouwd als Android-app met een geautomatiseerde social-media pijplijn die elke dag een nieuwe ronde uitspuwt, plus bijbehorende posts.";
    why="Iedereen denkt dat hij emoji's begrijpt. Iedereen overschat dat begrip. Daar wilde ik een spel van maken — eentje dat in dertig seconden uitwijst wie er gelijk had.";
    learned="Een dagelijks ritme automatiseren (content &rarr; app &rarr; social) is veel ingewikkelder dan de feature zelf. De grootste tijd zit in operaties, niet code.";
    chips=@("Android","Kotlin","Node.js pipeline","Gemini","Social automation");
    cta='<a class="btn btn-primary" href="https://github.com/joost-prive/emodjeez" target="_blank" rel="noopener">Repo op GitHub &rarr;</a>' }

  [ordered]@{ num="03"; slug="letterduel"; title="LetterDuel"; h1="LetterDuel"; tagline="Dagelijks woordspel"; type="Spel"; year="2024"; status="Live"; statusClass="status-live"; image=$svgLetterDuel;
    story="Een dagelijks woordspelletje van precies de juiste lengte: kort genoeg voor een koffiepauze, lang genoeg om iets te bewijzen. Ge&iuml;nspireerd op klassieke letterspellen, teruggebracht tot de essentie. E&eacute;n woord, &eacute;&eacute;n dag, &eacute;&eacute;n kans — dezelfde puzzel voor jou en je vrienden, om daarna even na te kletsen wie wat als eerste zag.";
    why="Dezelfde puls als Wordle, maar dan in het Nederlands en met een eigen draai. Het werd geboren tijdens een lange treinrit waarin ik geen Wordle meer kon spelen omdat ik 'm voor die dag al had opgelost.";
    learned="Een goede woordenlijst opbouwen is verrassend lastig. De keuze tussen 'wel een woord' en 'niet algemeen genoeg' is een redactionele keuze, geen technische.";
    chips=@("Vanilla JS","Woordenboek-validatie","LocalStorage","Sharable streaks");
    cta='<a class="btn btn-primary" href="https://github.com/joost-prive/LetterDuel" target="_blank" rel="noopener">Repo op GitHub &rarr;</a>' }

  [ordered]@{ num="04"; slug="het-is-niet-te-geloven"; title="Het is niet te geloven"; h1="Het is niet te geloven"; tagline="PSV-verhalen"; type="Site"; year="2024"; status="Live"; statusClass="status-live"; image=$imgPSV;
    story="Een verzameling van de meest magische, legendarische, ongelooflijke PSV-momenten. Van het kampioenschap van 1963 tot vandaag, gerangschikt als een tijdreis die je rustig kunt doorscrollen — met foto's, datums en namen om de discussie te beslechten.";
    why="Als PSV-supporter merkte ik dat ik dezelfde verhalen elke borrel opnieuw vertelde. Daar is &eacute;&eacute;n gepolijst ankerpunt voor nodig dat de hele groep kan delen — en waar je 's ochtends nog eens in kunt verdwijnen.";
    learned="Verhalen vertellen op het web met enkel HTML kan rijker dan ik dacht — vooral als je structuur, typografie en ritme serieus neemt.";
    chips=@("Statisch","HTML/CSS","Scroll-driven animaties","Archieffoto's");
    cta='<a class="btn btn-primary" href="https://github.com/joost-prive/hetisniettegeloven" target="_blank" rel="noopener">Repo op GitHub &rarr;</a>' }

  [ordered]@{ num="05"; slug="de-snelle-hap"; title="De Snelle Hap"; h1="De Snelle Hap"; tagline="Voice-bestelling"; type="Tool"; year="2025"; status="Prototype"; statusClass="status-wip"; image=$imgSnackbar;
    story="Snackbar waar je met je stem bestelt. Geen menu doorscrollen, geen toetsen — gewoon zeggen wat je wil en seconden later staat je bestelling klaar. Een experiment in voice-first interfaces voor het kortst denkbare beslissings­moment: hap-honger.";
    why="Bestellen is een UX-probleem dat al jaren niet wezenlijk veranderd is. Voice + LLM's maken een nieuwe poging eindelijk haalbaar — vooral op een plek waar mensen sowieso vooral met hun mond bezig zijn.";
    learned="Voice werkt verrassend goed in stille omgevingen en breekt direct in drukke. De UX-uitdaging is niet de stem, maar de noise floor.";
    chips=@("Web Speech API","LLM-parsing","TTS","PWA");
    cta='<a class="btn btn-primary" href="https://github.com/joost-prive/desnellehap" target="_blank" rel="noopener">Repo op GitHub &rarr;</a>' }

  [ordered]@{ num="06"; slug="olivialarm"; title="OliviAlarm"; h1="OliviAlarm"; tagline="Wakker-wanneer-mag"; type="Tool"; year="2025"; status="In gebruik"; statusClass="status-live"; image=$svgOlivia;
    story="Een wekker die helpt mijn dochter Olivia te leren dat ze om 06:30 uit bed mag — en niet eerder. Telt rustig af, geeft een zacht kindvriendelijk signaal zodra het zo ver is.";
    why="Toen Olivia uit haar babybox kwam, kwam ze om 05:45 vrolijk klaarwakker bij ons in bed. Een visuele 'het is nu tijd' hielp ouders en kind een wereld vooruit.";
    learned="Tools die je zelf gebruikt zijn de beste leerprojecten. Elke ochtend legt een ander UX-probleem bloot dat je anders nooit zou zien.";
    chips=@("Vanilla JS","Web Audio","PWA","Offline-first");
    cta='<a class="btn btn-primary" href="https://github.com/joost-prive/OliviAlarm" target="_blank" rel="noopener">Repo op GitHub &rarr;</a>' }

  [ordered]@{ num="07"; slug="fases"; title="Fases"; h1="Fases"; tagline="Maandboek voor je gezin"; type="Site"; year="2026"; status="In ontwikkeling"; statusClass="status-wip"; image=$svgFases;
    story="Geen dagboek, een maandboek. Tien vragen per maand over je gezin, je werk, je gedachten — bewust minimale inspanning, want anders houd je het toch niet vol. Jaren later zit je met een handvol pagina's per fase: een terugblik die niet bestaat als je nooit even tien minuutjes had genomen.";
    why="Ik wilde reflecteren maar haalde nooit het ritme van een dagboek vol. Door de drempel radicaal te verlagen tot 10 vragen per maand blijkt het w&eacute;l te lukken.";
    learned="Voor habit-products is 'hoe laag is de drempel' een belangrijker designkeuze dan welke features je toevoegt.";
    chips=@("React","Vite","Cloudflare Pages","Maandelijkse prompts");
    cta='<a class="btn btn-primary" href="mailto:joost@viaaventura.nl?subject=Houd%20me%20op%20de%20hoogte%3A%20Fases">Houd me op de hoogte &rarr;</a>' }

  [ordered]@{ num="08"; slug="ready-set-bingo"; title="Ready Set Bingo"; h1="Ready Set Bingo"; tagline="Bingo, maar leuk"; type="Spel"; year="2024"; status="Live"; statusClass="status-live"; image=$svgBingo;
    story="Digitale bingo-host voor feestjes, kinderpartijtjes en bedrijfsuitjes — sneller opgezet dan dat je de balletjes uit de zolder hebt gehaald. Trek de balletjes, draai het rad, roep nummers uit. Allemaal vanuit je broekzak, en met een halve minuut voorbereidingstijd.";
    why="De analoge bingo-set ligt altijd ergens en is altijd half kwijt. Een telefoon heeft iedereen. Een feestjes-app die in 30 seconden klaar staat is &eacute;&eacute;n minder reden om de avond uit te stellen.";
    learned="De magie van bingo zit niet in de nummers, maar in de pauzes ertussen. Pacing en stem zijn de game design.";
    chips=@("Vanilla JS","Web Speech","LocalStorage","PWA");
    cta='<a class="btn btn-primary" href="https://github.com/joost-prive/ReadySetBingo" target="_blank" rel="noopener">Repo op GitHub &rarr;</a>' }

  [ordered]@{ num="09"; slug="vertrekcheck"; title="Vertrekcheck"; h1="Vertrekcheck"; tagline="Schoolkind-checklist"; type="Tool"; year="2026"; status="In ontwikkeling"; statusClass="status-wip"; image=$svgVertrek;
    story="Een gepersonaliseerde check voor elk schoolkind voordat het de deur uit gaat: de juiste outfit voor het weer van vandaag, de spullen die voor d&iacute;t rooster in de tas moeten, eventuele bijzondere afspraken. Drukt de mentale last van de ochtendspits omlaag.";
    why="De ochtendspits van een gezin is een mentaal-belasting-paradijs. Een tool die in 30 seconden zegt 'dit, dit en dit' heeft direct waarde voor ouders die nu nog zelf alles tussen koffie en sokken zoeken jongleren.";
    learned="Producten voor ouders moeten in 30 seconden iets opleveren of ze worden niet gebruikt. Geen tutorials, geen opzet — direct waarde.";
    chips=@("PWA","Weather API","Per-kind profielen","Snelle setup");
    cta='<a class="btn btn-primary" href="mailto:joost@viaaventura.nl?subject=Houd%20me%20op%20de%20hoogte%3A%20Vertrekcheck">Houd me op de hoogte &rarr;</a>' }

  [ordered]@{ num="10"; slug="schmink-station"; title="Schmink Station"; h1="Schmink Station"; tagline="Carnaval makeup"; type="Tool"; year="2026"; status="In ontwikkeling"; statusClass="status-wip"; image=$imgSchmink;
    story="Een schmink-app voor carnaval, voor wie geen zin heeft om op vrijdagavond half een eindeloos naar plaatjes te googelen. Honderden looks gerangschikt in categorie&euml;n, met zoekfunctie en favorieten — zodat je 's ochtends in de polonaise weet welke kant je op moet.";
    why="&Eacute;&eacute;n concreet probleem op &eacute;&eacute;n concreet weekend per jaar. Het soort use case waar tools verrassend goed in kunnen worden omdat de scope helder is en de gebruikers gemotiveerd zijn.";
    learned="E&eacute;n weekend per jaar is een prachtige scope voor een nano-product. Geen feature creep, geen onderhoudslast — daarna mag het rusten.";
    chips=@("Vanilla JS","IndexedDB","SVG illustraties","Offline-first");
    cta='<a class="btn btn-primary" href="mailto:joost@viaaventura.nl?subject=Houd%20me%20op%20de%20hoogte%3A%20Schmink%20Station">Houd me op de hoogte &rarr;</a>' }

  [ordered]@{ num="11"; slug="tour-de-boire"; title="Tour de Boire"; h1="Tour de Boire"; tagline="Vriendenklassement"; type="Experiment"; year="2024 — heden"; status="Editie 2026"; statusClass="status-wip"; image=$svgTour;
    story="Elk jaar opnieuw een klein, eigen klassement onder vrienden tijdens de Tour de France. Helft koers, helft kroeg — voorspellen, punten halen, spuwen op elkaars keuzes. De editie van 2026 zit in de pijplijn.";
    why="Een seizoensbinder voor een vriendengroep. Iets om elke etappe over te discussi&euml;ren in plaats van alleen op zondag op te merken dat er een tour was.";
    learned="Elk jaar voelt anders. Wat in 2023 perfect werkte voelt in 2025 gedateerd. Een klein product kan ook gewoon &eacute;&eacute;n seizoen leven en dan met pensioen.";
    chips=@("Statisch","Predictions","Scoring","Ouderwetse fun");
    cta='<a class="btn btn-primary" href="mailto:joost@viaaventura.nl?subject=Houd%20me%20op%20de%20hoogte%3A%20Tour%20de%20Boire">Houd me op de hoogte &rarr;</a>' }

  [ordered]@{ num="12"; slug="pluk-de-tijd"; title="Pluk de Tijd"; h1="Pluk de Tijd"; tagline="Bewuste momenten"; type="Experiment"; year="2025"; status="In ontwikkeling"; statusClass="status-wip"; image=$svgPluk;
    story="Een po&euml;tisch experiment over hoe we tijd ervaren en wat het waard is om vast te leggen. Minder software, meer reflectie. Gemaakt meer voor mij dan voor gebruikers — maar als jij hier ook al even stil naar zit te kijken, ben je waarschijnlijk precies de doelgroep.";
    why="Niet elk project hoeft een gebruiker te dienen. Sommige projecten dienen alleen het denken.";
    learned="Sites zonder doelgroep zijn een eerlijke manier om met design te experimenteren. Geen analytics, geen growth — alleen het werk.";
    chips=@("Statisch","Typografie","Po&euml;zie","Geen analytics");
    cta='<a class="btn btn-primary" href="mailto:joost@viaaventura.nl?subject=Houd%20me%20op%20de%20hoogte%3A%20Pluk%20de%20Tijd">Houd me op de hoogte &rarr;</a>' }

  [ordered]@{ num="13"; slug="begrijpend-tuben"; title="Begrijpend Tuben"; h1="Begrijpend Tuben"; tagline="Begrijpend lezen 2.0"; type="Site"; year="2024"; status="Live"; statusClass="status-live"; image=$svgTuben;
    story="Begrijpend lezen voor de YouTube-generatie. In plaats van een lap tekst krijgen leerlingen een korte clip, en daarna de vragen — zelfde vaardigheid, ander medium. Een Cloudflare-gehoste leeromgeving die docenten kunnen inzetten op de momenten dat een tekst voor deze klas toch echt geen optie is.";
    why="Begrijpend lezen oefenen met teksten waar leerlingen al voor zijn afgehaakt is een verloren strijd. Met video als input doet de oefening ineens mee aan hun realiteit.";
    learned="Voor onderwijs-tools is het minste dat je kunt doen: leerlingen niet in de weg zitten. De interface moet zo onzichtbaar mogelijk zijn.";
    chips=@("Cloudflare Pages","Workers","YouTube embed","Edu-UX");
    cta='<a class="btn btn-primary" href="https://github.com/joost-prive/begrijpendtuben-cloudflare" target="_blank" rel="noopener">Repo op GitHub &rarr;</a>' }
)

# Template
$tpl = @'
<!doctype html>
<html lang="nl">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>{{TITLE}} — Via Aventura</title>
  <meta name="description" content="{{TAGLINE}} — een project uit het portfolio van Joost van de Ven (Via Aventura)." />
  <link rel="canonical" href="https://viaaventura.nl/projects/{{SLUG}}.html" />
  <meta name="theme-color" content="#c0492a" />
  <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
  <link rel="alternate icon" href="/favicon-32.png" />
  <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
  <link rel="manifest" href="/site.webmanifest" />

  <meta property="og:type" content="article" />
  <meta property="og:title" content="{{TITLE}} — Via Aventura" />
  <meta property="og:description" content="{{TAGLINE}}" />
  <meta property="og:image" content="https://viaaventura.nl/og-image.jpg" />
  <meta property="og:locale" content="nl_NL" />
  <meta name="twitter:card" content="summary_large_image" />

  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,500;1,9..144,400;1,9..144,500&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="/styles.css" />
</head>
<body class="project-page">

  <a href="#main" class="skip-link">Direct naar de inhoud</a>

  <header class="site-header">
    <a class="brand" href="/" aria-label="Via Aventura — home">
      <img src="/logo.svg" alt="" class="brand-mark" />
      <span class="brand-name">Via Aventura</span>
    </a>
    <button class="nav-toggle" aria-label="Menu openen" aria-expanded="false" aria-controls="primary-nav">
      <span class="nav-toggle-bar"></span><span class="nav-toggle-bar"></span><span class="nav-toggle-bar"></span>
    </button>
    <nav class="site-nav" id="primary-nav" aria-label="Hoofdnavigatie">
      <a href="/#about">Over</a>
      <a href="/#code">Code</a>
      <a href="/#creatief">Creatief</a>
      <a href="mailto:joost@viaaventura.nl">Contact</a>
    </nav>
  </header>

  <main id="main" tabindex="-1">

    <p class="breadcrumb">
      <a href="/">Via Aventura</a><span class="sep">/</span><a href="/#code">Codeerprojecten</a><span class="sep">/</span>{{TITLE}}
    </p>

    <article>
      <header class="project-hero">
        <p class="project-num-big">{{NUM}}.</p>
        <h1>{{H1}}</h1>
        <p class="project-tagline"><em>{{TAGLINE}}</em></p>
        <div class="project-pills">
          <span class="project-pill">{{TYPE}}</span>
          <span class="project-pill">{{YEAR}}</span>
          <span class="project-pill {{STATUS_CLASS}}">{{STATUS}}</span>
        </div>
      </header>

      <figure class="project-image">
        {{IMAGE}}
      </figure>

      <div class="project-body">
        <h2>Het verhaal</h2>
        <p>{{STORY}}</p>

        <h2>Waarom</h2>
        <p>{{WHY}}</p>

        <h2>Onder de motorkap</h2>
        <div class="chips">{{CHIPS}}</div>

        <h2>Wat ik leerde</h2>
        <p>{{LEARNED}}</p>
      </div>

      <div class="project-cta">
        {{CTA}}
        <a class="btn btn-outline" href="/#code">&larr; Naar overzicht</a>
      </div>

      <nav class="project-nav" aria-label="Vorig en volgend project">
        <a href="/projects/{{PREV_SLUG}}.html" class="prev"><span>{{PREV_NUM}} · Vorige</span><strong>{{PREV_TITLE}}</strong></a>
        <a href="/projects/{{NEXT_SLUG}}.html" class="next"><span>{{NEXT_NUM}} · Volgende</span><strong>{{NEXT_TITLE}}</strong></a>
      </nav>
    </article>

  </main>

  <footer class="site-footer">
    <div class="footer-inner">
      <span><a href="mailto:joost@viaaventura.nl">joost@viaaventura.nl</a></span>
      <span><a href="/log.html">Build log</a></span>
      <span><a href="/privacy.html">Privacy &amp; colofon</a></span>
      <span class="muted">© <span id="year"></span> · Via Aventura B.V. · KvK 00000000</span>
    </div>
  </footer>

  <script src="/script.js"></script>
</body>
</html>
'@

for ($i = 0; $i -lt $projects.Count; $i++) {
  $p = $projects[$i]
  $prev = $projects[($i - 1 + $projects.Count) % $projects.Count]
  $next = $projects[($i + 1) % $projects.Count]
  $chipHtml = ($p.chips | ForEach-Object { '<span class="chip">' + $_ + '</span>' }) -join ""

  $html = $tpl
  $html = $html.Replace("{{TITLE}}",        $p.title)
  $html = $html.Replace("{{H1}}",           $p.h1)
  $html = $html.Replace("{{SLUG}}",         $p.slug)
  $html = $html.Replace("{{NUM}}",          $p.num)
  $html = $html.Replace("{{TAGLINE}}",      $p.tagline)
  $html = $html.Replace("{{TYPE}}",         $p.type)
  $html = $html.Replace("{{YEAR}}",         $p.year)
  $html = $html.Replace("{{STATUS_CLASS}}", $p.statusClass)
  $html = $html.Replace("{{STATUS}}",       $p.status)
  $html = $html.Replace("{{IMAGE}}",        $p.image)
  $html = $html.Replace("{{STORY}}",        $p.story)
  $html = $html.Replace("{{WHY}}",          $p.why)
  $html = $html.Replace("{{CHIPS}}",        $chipHtml)
  $html = $html.Replace("{{LEARNED}}",      $p.learned)
  $html = $html.Replace("{{CTA}}",          $p.cta)
  $html = $html.Replace("{{PREV_SLUG}}",    $prev.slug)
  $html = $html.Replace("{{PREV_TITLE}}",   $prev.title)
  $html = $html.Replace("{{PREV_NUM}}",     $prev.num)
  $html = $html.Replace("{{NEXT_SLUG}}",    $next.slug)
  $html = $html.Replace("{{NEXT_TITLE}}",   $next.title)
  $html = $html.Replace("{{NEXT_NUM}}",     $next.num)

  $path = Join-Path $dir ($p.slug + ".html")
  [IO.File]::WriteAllText($path, $html, $utf8)
  Write-Output "Wrote $($p.slug).html"
}

Write-Output "All 13 project pages generated."
