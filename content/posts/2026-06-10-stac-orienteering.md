+++
title = "STAC orienteering"
slug = "stac-orienteering"
date = 2026-06-10
description = "Where STAC came from and where I think it's going"
draft = true

[taxonomies]
tags = ["stac"]
categories = ["presentations"]
+++

_This is a companion blog post to a identically-named talk I gave to the Microsoft Planetary Computer team on 2026-06-10._

The [Spatio-Temporal Asset Catalog (STAC)](https://stacspec.org) is an **open**, **community** metadata specification for indexing geospatial datasets.
Its [v1.0 release](https://github.com/radiantearth/stac-spec/releases/tag/v1.0.0) was in May 2021, and it had a non-breaking [v1.1 release](https://github.com/radiantearth/stac-spec/releases/tag/v1.1.0) in September 11, 2024.

## Why is STAC successful?

As outlined in Matt Hanson's excellent [_STAC: A Retrospective, Part 2_](https://element84.com/software-engineering/stac-a-retrospective-part-2-why-stac-was-successful/)), STAC's success is due to:

- "Inheriting" from [GeoJSON](https://geojson.org/) and aligning with [OGC API - Features](https://ogcapi.ogc.org/features/), instead of building from scratch
- Building tooling **at the same time** as the specification to stress-test the spec and enable demos ("show don't tell")
- A neutral convener ([Radiant Earth](https://radiant.earth/)) that gathered champions such as [Chris Holmes](https://github.com/cholmes/), [Matthias Mohr](https://github.com/m-mohr), [Matt](matthewhanson), and others
- Early adoption by significant players such as the [USGS](https://landsatlook.usgs.gov/stac-server), [AWS](https://earth-search.aws.element84.com/v1), and [Microsoft](https://planetarycomputer.microsoft.com/api/stac/v1)
- Radical transparency, i.e. working in the open via [Github issues](https://github.com/radiantearth/stac-spec/issues/), not in closed rooms

These factors worked together to create a [flywheel](https://en.wikipedia.org/wiki/Flywheel) effect to position STAC as the "sensible default" for geospatial metadata.

## How does STAC work?

STAC has three data specifications (language taken from the [STAC website](https://stacspec.org/)):

- [Item](https://github.com/radiantearth/stac-spec/blob/master/item-spec/item-spec.md): The core atomic unit, representing a single spatiotemporal asset as a GeoJSON feature plus datetime and links
- [Catalog](https://github.com/radiantearth/stac-spec/blob/master/catalog-spec/catalog-spec.md): A simple, flexible JSON file of links that provides a structure to organize and browse STAC Items
- [Collection](https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md): Similar to a Catalog, a Collection has additional information such as the extents, license, keywords, providers, etc that describe Items that fall within the Collection

STAC also defines an [API](https://github.com/radiantearth/stac-api-spec) that provides a RESTful endpoint that enables search of STAC Items, specified in OpenAPI, following OGC's WFS 3.

Both the core and the API specifications support "extensions" ([core](https://github.com/stac-extensions/), [api](https://github.com/stac-api-extensions/)), which provide additional fields that can be used to better describe the data.
Most tend to be about describing a particular domain or type of data, but some imply functionality.

Core STAC tooling lives in the [stac-utils](https://github.com/stac-utils/) Github organization, though other libraries and applications can (and do) live anywhere.
STAC libraries are written in a wide variety of languages, including Python, Javascript, Rust, Go, and more.

## Who owns STAC? Who manages STAC?

No-one owns STAC; it belongs to the community.

The STAC specifications and their extensions are overseen by the [STAC Project Steering Committee (PSC)](https://github.com/radiantearth/stac-psc/), a seven-person volunteer organization.
The PSC has remit to oversee and manage the specifications and their extensions, not the software tooling.
Individual software repositories are maintained by community members in an ad-hoc manner.
