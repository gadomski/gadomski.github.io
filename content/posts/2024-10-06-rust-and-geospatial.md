+++
title = "Rust and geospatial"
slug = "rust-and-geospatial"
date = 2024-10-06
description = "Rust can be useful for building geospatial systems, but it's not a silver bullet."

[taxonomies]
tags = ["rust", "geospatial"]
categories = ["opinion"]
+++

I often get asked "What's the deal with Rust? Is it actually useful for geospatial? Should I bother learning it?"
Here's some high-level thoughts, based upon my roughly ten years of experience in writing Rust libraries and applications for geospatial.

## Use Rust for "geo-adjacent", not "geo-native"

The Python geospatial tooling stack is really strong because of mature, well-supported projects like [rasterio](https://rasterio.readthedocs.io), [xarray](https://docs.xarray.dev), [geopandas](https://geopandas.org), and many others.
If you're doing "geo-native" work where you're opening lots of files, doing analysis, creating visualizations, stick to Python.
Rust is better at "geo-adjacent" stuff, such as reading and writing formats, building servers, and the like.

## Bindings are great

The tooling to create bindings between Rust and other languages (e.g. Python, Javascript) have come a long way in the last few years.
It's now pretty trivial to expose parts of your Rust library via functions and data structures in other languages, and this will likely be a place where we'll see significant work in the next few years. 

## Just because it's written in Rust doesn't mean it's faster

A common trope is that you re-write something in Rust to make it faster.
This might be true in many cases, but it's not always the case.
In 2023 I did [some work](https://github.com/gadomski/json-hydrate-benchmark) with [Development Seed](https://developmentseed.org/) to explore the use of Rust to speed up "hydration" out of a [pgstac](https://github.com/stac-utils/pgstac) database.
At a high level, we found that converting Python dictionaries to Rust structures, working on them, then converting them back to Python dictionaries was slower than just doing all the work in pure Python.
We only saw speedups when we wrote Rust code to manipulate the Python dictionaries _from Rust_ (which you can do, and which is pretty cool).

![json-hydrate-benchmark diagram](/img/json-hydrate-benchmark.png)

## Focus on "feature complete" problems

Because Rust is stricter about types and interfaces, it tends to be best for well defined systems, such as specification and standards.
You can do dynamic, ever-changing development in Rust but it's my experience that you'll find yourself doing a lot of rewrites.
Take for example [STAC API](https://github.com/radiantearth/stac-api-spec) servers, most of which are written in Node or Python.
This made sense in the early days of the API specification where we were still figuring out how they would work and what features they needed.
Now that the problem space is better defined, it makes more sense to implement a [STAC API server in Rust](https://github.com/stac-utils/stac-rs/blob/main/server/README.md), since we know the specification won't be changing much if at all.

## Learning Rust makes you a better developer

I don't think it's controversial to say that every language you learn increases your "general" skill level as a developer.
I think Rust is better-than-most for leveling up.
Its strict ownership and mutability rules force you (the developer) to think hard about any data copies and any potential race conditions.
And because data and behavior are kept separate by traits, the systems you design in Rust tend to have better abstractions than a similar system you might design in Python by using/abusing inheritance.

## The US Government (might) like Rust

The White House released a [report](https://www.whitehouse.gov/wp-content/uploads/2024/02/Final-ONCD-Technical-Report.pdf) that advocated for the use of memory-safe programming languages, and included the following line:

> At this time, the most widely used languages that meet all three properties are C and
> C++, which are not memory safe programming languages. Rust, one example of a memory safe
> programming language, has the three requisite properties above[^1], but has not yet been proven in
> space systems.

It's still early doors, but there may come a day in the not-too-distant future where any high-performance components of systems delivered to the US Government can't be written in C or C++, leaving Rust as a strong alternative language.

![Uncle Sam](/img/uncle-sam.jpg)

## Resources

If you're interested in learning Rust for geospatial, here's some places to look to get started:

- [The Rust Book](https://doc.rust-lang.org/book/) doesn't have anything to do with geospatial, but it's free and _excellent_. I re-read it every year or two and I always learn something.
- [The GeoRust organization](https://georust.org/) brings together a lot of the core geospatial Rust projects, and they also have a [discord server](https://discord.com/channels/598002550221963289)
- [Awesome Geo Rust](https://github.com/pka/awesome-georust) is another curated list of repos and other resources

I'm always happy to chat Rust and geo, so hit me up [on Bluesky](https://bsky.app/profile/gadom.ski)!

[^1]: "First, the language must allow the code to be close to the kernel so that it can tightly interact with both software and hardware; second, the
language must support determinism so the timing of the outputs are consistent; and third, the
language must not have – or be able to override – the “garbage collector,” a function that
automatically reclaims memory allocated by the computer program that is no longer in use."