+++
title = "Let's apply dumb economics to the use of remote sensing data"
slug = "dumb-economics-remote-sensing"
date = 2024-09-26

[taxonomies]
tags = ["remote-sensing", "stac", "economics"]
categories = ["conferences"]
+++

## Preamble

I am not an economist.
I am a engineer and researcher, and like many folks, I have done plenty of time scouring the internet for remote sensing products as material for papers, posters, presentations, etc.

I don't think it's controversial to say that accessing open geospatial data is not easy, even at times for a highly technical person.
It _is_ controversial to say, as [Dr. Brianna Pagán's did at North51 this year](https://x.com/Brianna_R_Pagan/status/1783865890943238232), to say that commercial companies who have contracts with or otherwise are supported by the US Government _should_ provide at least some of their captured value back to the taxpayer in the form of open data.

As I said, I am not an economist.
But in this post, I'm going to attempt to use my dumb understanding of some economic concepts to explore how we can make open access to geospatial data better _including_ to that sweet sweet commercial data.

## A case study

Let's start by looking at the consumer side, specifically me in graduate school when I was studying [lidar](https://en.wikipedia.org/wiki/Lidar) and glaciers.
I had a dump truck of [terrestrial lidar data](https://www.hsfoundation.org/news-stories/mapping-greenlands-helheim-glacier/) of the [Helheim Glacier](https://en.wikipedia.org/wiki/Helheim_Glacier) in southeast Greenland, and I needed remote sensing products to build visualizations, compare terminus detection algorithms, and all matter of other [use-cases](@/posts/2017-12-15-AGU.md).
Let's bring this experiment forward today, and pretend that I'm doing this research, now, with the currently existing tooling and data.

I can write software, I know roughly what remote sensing products might be useful to me, and I have a slew of papers that I'm supposed to read to learn more, but let's face it — I'm an engineer, and I just want to build something.
So instead of carefully reviewing the literature to see what products people use for what, I turn to the internet (hello chatbots) to help:

![A ChatGPT response to a remote sensing question](/img/chatgpt-helheim.png)

Hey, that's not too bad!
I've got a good sense of the products available — now, how do I get the data?
Let's try that first link, the `MODIS Data Archive`:

![MODIS Data Archive](/img/modis-data-archive.png)

Uhh, ok it says "Data", but that's mostly just text.
I scroll down a bit, and find a link that says `MODIS cryosphere products`.
I'm working in the cryosphere, so that seems like a good place to look:

![MODIS cryosphere products](/img/modis-cryosphere-products.png)

🤦

Everyone who works in geospatial knows this story.
But what's the economic phenomenon at play here?
How did a system, designed (presumably) with good intentions, some thought, and no small amount of money, create something so obviously bad?

## Analyzing the problem

I am not an economist, but I am a millennial, which means I'm as likely to turn to Wikipedia for answers as I am ChatGPT.
From [Economics](https://en.wikipedia.org/wiki/Economics):

> There are a variety of modern definitions of economics; some reflect evolving views of the subject or different views among economists. Scottish philosopher Adam Smith (1776) defined what was then called political economy as "an inquiry into the nature and causes of the wealth of nations"

Okay, that's pretty circular — I'm looking to economics for answers, and it comes back at me with "I'm just asking questions."
I keep reading:

> Jean-Baptiste Say (1803), distinguishing the subject matter from its public-policy uses, defined it as the science of production, distribution, and consumption of wealth.

That's better — if you substitute "geospatial data" in for "wealth", then you're cooking with gas.
Later in the article, I find this gem:

> Expositions of economic reasoning often use two-dimensional graphs to illustrate theoretical relationships.

I _love_ graphs.
Let's make some.
I'd like to explore _why_ the government has made so many websites with lots of text, instead things that give me data.
So here's a graph:

![Government websites over time](/img/websites-over-time.png)

That might be accurate, but it's not very helpful.
Why are there so many websites, and why are they increasing over time?
Where does the demand come from?

- The people who get paid make the websites (engineers, designers, managers, CEOs, etc) clearly want more websites, and so increase demand ⬆️
- The people who spend the money to make the websites (uhh, someone in the government? how does the government work?) want more websites because it looks good on an annual review to say that you made a new thing, and so increase demand ️⬆️
- That leaves us, the taxpayer, whose money is being spent (me! and you! all of us! especially frustrated grad students!) as the only chance for downward demand pressure ⁉️

I'd argue that that constantly-increasing line in the above chart, the "Not Found" page for MODIS cryosphere data, all of it —  they're _our_ fault.
If there's one thing "the dismal science" believes it's that people make decisions in their own self-interest, and there's no reason to expect anything different here.
The people who get paid to make websites and the people who spend money to make websites want more websites, and that's not "bad" in the moral sense — they're just acting in their own interests.
If there's too many government websites, then it's _our_ (the taxpayers') fault for not exerting enough downward pressure on the demand.

To summarize:

| Party | Effect on websites |
| -- | -- |
| People who get paid to make website | Increase demand |
| People who pay to make websites | Increase demand |
| The taxpayer | Do better |

## Working the problem

So how do we exert that downward pressure?

First, we could try to convince the people who make websites to make fewer websites.
However, our argument boils down to "make less money", which isn't very good.

How about the people who pay for websites, what are their motivating factors?
We turn again to the internet for search and find <https://science.nasa.gov/earth/data/>, which states:

> NASA’s Earth Science Data Systems (ESDS) Program oversees the entire Earth science data life cycle and **facilitates unrestricted access to maximize the scientific return from NASA's missions and experiments.** [emphasis mine]

Now _there's_ something we can shove into a dumb economics model.
Does that broken maze of websites provide unrestricted access?
Maybe in a strict sense, but not to the spirit of the mission statement.
And it's _obvious_ that we aren't maximizing our scientific return if it's that hard to get data.

This means that its up to us, the taxpayer, to pressure the people who pay for websites to make sure that they're maximizing the scientific return (their words).
How do we do that?
The first clue comes from the beginning of our [case study](#a-case-study) in the form of that quite useful (it pains me to say[^1]) ChatGPT response to my original question.
I, the rushed and ignorant grad student, was doing _search and discovery_.
A wall of text does not enable search and discovery, so any link in the chain of websites that _doesn't_ enable search and discovery is a non-maximizing link.

Let's pull that out as a dumb economic theory, worth highlighting: **Every link in a website chain that does not facilitate search and discovery decreases the value of that chain.**[^2]

What was the most useful part of our search chain in the case study?
ChatGPT.
How will ChatGPT and its friends help us actually find the data, instead of only the government websites that have links to the data?
By making the data themselves searchable and discoverable in a machine-friendly way.
That's where specifications like the [SpatioTemporal Asset Catalog (STAC)](https://stacspec.org/) play a role.
If geospatial data are indexed by _some_ sort of crawlable metadata (doesn't have to be STAC) then they can be indexed into search tools and surfaced at the "search and discovery tool" layer, such as a chatbot.

This is where the government has a competitive advantage over the rest of the market.
They know best what data products exist and the nuances of those products, so they are best positioned to both organize those data _and_ index them with metadata.
So that's a second major advocacy point: **The government should leverage its competitive advantages by focusing on data storage and building searchable metadata indexes.**

## The commercial data provider

The case of the commercial data providers ([Planet](ttps://www.planet.com/), [Maxar](https://www.maxar.com/), [Umbra](https://umbra.space/), etc) is very obviously different to that of the government.
Their mission is to make money, and each of them has chosen one or more variations on a similar theme as their business model: "collect data, and build a blend of government and private customers to sell those data to."

In her keynote at North51[^3], Dr. Brianna Pagán argued that earth observation (EO) data should be considered a "common good" and be made free/accessible to all, regardless of who collects it:

<!-- markdownlint-disable MD033 -->
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">1/ Yesterday I gave a keynote at <a href="https://twitter.com/N51Conference?ref_src=twsrc%5Etfw">@N51Conference</a> making the case on why EO data should be considered a common good and made free/accessible to all. As all common goods before it - colonialism and capitalism, both the root causes of climate change, are entrenched in the industry. <a href="https://t.co/1WNZqRQ24D">pic.twitter.com/1WNZqRQ24D</a></p>&mdash; Dr. Brianna R. Pagán (@Brianna_R_Pagan) <a href="https://twitter.com/Brianna_R_Pagan/status/1783865890943238232?ref_src=twsrc%5Etfw">April 26, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
<!-- markdownlint-enable MD033 -->

What's a "common good"?
Back to Wikipedia!

> Common goods (also called common-pool resources) are defined in economics as goods that are rivalrous and non-excludable.

"Rivalrous and non-excludable" sounds like a frat bro trying to get into a party.
Anyways, what do those actually mean?

> a good is said to be rivalrous or a rival if its consumption by one consumer prevents simultaneous consumption by other consumers

🤔 So is Planet image rivalrous?
If the data are open, no, not really — you could argue that _heavy_ usage of an image (i.e. downloading it a lot) excludes others by consuming bandwidth and increasing costs on the provider, but the internet is made to have multiple people using the same asset.
Ironically, the only way that a Planet image is rivalrous is if its _not_ free and open — if a three-letter agency can use the image but I can't, then their consumption is preventing my consumption.
But I'm not quite sure that's actually rivalrous, so we'll give that one a "probably not."

How about "non-excludable"?

> Excludability is the degree to which a good, service or resource can be limited to only paying customers, or conversely, the degree to which a supplier, producer or other managing body (e.g. a government) can prevent consumption of a good.

Ok, that's what we wanted!
Planet data are for sure excludable, but probably not rivalrous.
That means that Planet data is _not_ a common good by both of the core components of the definition.
What else do we have?

| | | |
| -- | -- | -- |
| &mdash; | **Excludable** | **Non-excludable** |
| **Rivalrous** | Private | Common |
| **Non-rivalrous** | Club | Public |

When Planet keeps its imagery private but available for purchase, that looks like a "Club" — they can sell the same image to multiple folks without their use impacting each others'.
For the sake of this dumb-yet-pedantic economics post, I'm going to tweak Dr. Pagán's argument to be to consider EO data a "public" good.
That makes it a bit simpler — we just need to transition that Planet image from excludable to non-excludable.

## Public goods in the internet age

In Nadia Eghbal's excellent book, [_Working in Public: The Making and Maintenance of Open Source Software_](https://press.stripe.com/working-in-public), the author discusses how open source software functions a bit like a public good, albeit one that has little government influence.
EO data is similar but different.
Like open source software, distributing as single piece EO data is (relatively) inexpensive — the costs to store and serve a single image are negligibly small.
However, the amount of EO data is constantly growing and doing so at a scale that quickly moves bandwidth and storage costs from "doesn't matter" to "hooo boy".
This implies that, if EO data is to be a public good, the government may have a role in distributing those data.

It's obvious that it isn't appropriate to think of commercial EO data a public good all the time — if it were, the government would own all the satellies.
There must be some point at which those data should transition from "club" to "public".
To explore when that point is, let's look at the value of an EO image to a couple different use groups:

![The value of an image over time](/img/value-over-time.png)

- Three letter government agencies (CIA, NGA, etc) and their military counterparts place a huge value on the timeliness of data.
  The most important decisions they need to make are time-critical, and so the value of a given picture drops precipitously after it's created.
  It doesn't go to zero because there's still back research that needs to be done.
- For a researcher (e.g. a biologist or an earth scientist) the value (someone counter-intuitively) goes _up_ over time, though by no means to the levels that the three letter agencies were at.
  This is because (generally) research needs multiple coincident data sources, and the longer the data has been around, the more other data sources come online.
  Also, very little research is "real time" — usually you're studying something that happened months or years ago, not yesterday.
- The general public (i.e. most taxpayers) don't really have much interest in these pictures other than looking at them.

So if a commercial company is trying to extract the maximum value from a given picture, they're going to want to sell it quickly.
And this is in fact what they're doing, so much so that some companies don't see economic value in charging for their archive at all:

<!-- markdownlint-disable MD033 -->
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">10 deeply held beliefs about the Earth observation industry:<br><br>1. The optimal way to capture the value of archival data is to give it away for free.</p>&mdash; Joe Morrison (@mouthofmorrison) <a href="https://twitter.com/mouthofmorrison/status/1817571854489670038?ref_src=twsrc%5Etfw">July 28, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
<!-- markdownlint-enable MD033 -->

This obviously isn't a universal belief, as shown by the fact that none the archives of any of the big commercial collectors (inluding Umbra, Joe's employer) are totally open.
Here's some text from Umbra's [open data page on AWS](https://registry.opendata.aws/umbra-open-data/):

> The Open Data Program (ODP) features over twenty diverse time-series locations that are updated frequently, allowing users to experiment with SAR's capabilities.

It's not the complete archive, but it's better than nothing I guess.

## Working the (commercial) problem

So how do we bridge the gap between the commercial company's incentive to capture as much value as possible (by selling their data quickly then mostly forgetting about it) and Dr. Pagán's vision of earth observation data as a common good?
As argued above, the government probably has a role to play, since hosting and serving those data is expensive.
How do we convince the government to get involved?
Let's look at things from a scientist's perspective:

![Coincident, discoverable, and accessible](/img/cda.png)

The more coincident, discoverable, and accessible (CDA)[^4] datasets that are available, the more things you can do — sometimes, a new dataset will spark a new idea and a whole new area of research.
The government has a lot of datasets, and the commercial providers have more, meaning that in order to maximize the scientific return, **the government should spend time and resources more datasets available from the commercial archive**.

This doesn't have to be overly complex.
With the rise of [cloud-native geospatial](https://cloudnativegeo.org/), we have more formats and tools to store, index, search, and use data without having to stand up and maintain servers:

![Cloud-native geospatial](/img/cloud-native-geospatial.png)

The sell to commercial data producers might not be too hard — they aren't deriving much (if any) value from their archive, and the goodwill and exposure they receive from making their archive public (with government backing) _should_ outweigh any un-compensated costs.
And if they don't want to willingly, maybe the government can write in a "after X amount of time these data must be made public via Y means" clauses to their agreements with the commercials?
A person can dream.

Easy enough!

## Main points

- Every link in a website chain that does not facilitate search and discovery decreases the value of that chain, so governments need to ensure any systems they build have the minimum amount of low-value links.
- Governments should leverage their competitive advantage to create machine-readable metadata (indexes) for their data to enable search and discovery by external tools.
- We (taxpayers) should advocate for government support for hosting and serving cloud-native archives of commercial EO data.

_This post is a companion to an identically-named lightning talk I'll be giving at [SatCamp](https://satcamp.xyz/) 2024._

[^1]: I am a dyed-in-the-wool old-man-who-yells-at-the-AI-industry
[^2]: That's not to say that there isn't a place for long "about" pages, or deep dives into specific questions.  But these pages shouldn't be the first thing you see, they should be (wait for it) discoverable.
[^3]: Her keynote was titled "From Competition to Connection: Geospatial Technologies and the Path to Climate Justice"
[^4]: I just googled this term and nothing obvious popped up, so this might be made up? But I like it, I think.
