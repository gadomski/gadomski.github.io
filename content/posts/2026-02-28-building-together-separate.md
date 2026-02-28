+++
title = "Building, Together, Separate"
slug = "building-together-separate"
date = 2026-02-28
description = "Thoughts on building meaningful stuff in a remote-first world"

[taxonomies]
tags = ["coding", "remote"]
categories = ["opinion"]
+++

On Friday, we wrapped up Development Seed Team Week 2026 and [said goodbye to our Blagden Alley office](https://www.linkedin.com/posts/kcarini_a-toast-to-blagden-alley-community-social-activity-7428883315811635200-CK44?utm_source=share&utm_medium=member_desktop&rcm=ACoAAASYd7oB_OaSBB96AgUm6hV8x5d0HO-zMW8).
Our organization ("less of a company and more of a co-op", according to one) manages to bind sixty-odd people who are scattered all over the world into a mostly-self-organizing system.
The whys-and-wherefores of our operations are constantly evolving, but there's some common themes that we've kept over the years[^1].

I thought it could be useful to distill those down here, both to help clarify my own thinking and possibly help others who are trying to grow similar organizations.

## Write your ideas

It seems obvious but it's so often forgotten — **write your ideas down**.
Conservations (whether they're verbal, typed, or in some other mode) are wonderful for shaping ideas within a group of people.
Once the idea is shaped, or it's reached the point where it needs decisions or research, _write the idea down_ in a searchable, linkable, and shareable place.
This gives you a checkpoint in your own reasoning, and allows others to inspect how you're thinking about a problem.

LLM-based tools are _excellent_ at reading things that humans write, and are at their best when they're reading concise [Markdown](https://en.wikipedia.org/wiki/Markdown) documents.
Those checkpoints in thinking will be useful as inputs to LLM-based tools.

At Development Seed, we use Github repositories and issues for the vast majority of our communication-based writing.
You might use a different medium, but whatever it is, write your ideas down and share them.

## Public[^2] by default

I would bet that 99% of Slack users have heard (or said):

> I didn't put it in the public channel because it's too noisy.

Our hot take is that you should do it anyway.
Here's why:

- You never know who might get benefit from reading your messages.
- Use threads to reduce main channel noise.
  Don't like threads?
  Tough, learn to like them.
- When things feel awkward or too "meaningful" for a Slack thread, summarize the conversation as an [issue](#write-your-ideas) and move the conversation there.

Obviously, there's exceptions around personal communications, privileged client information, and HR-adjacent issues.
But in general, direct messages are an anti-pattern and multi-person DMs that are more than quick chats should be converted to public channels.
The same goes for your [ideas](#write-your-ideas); unless there's a very good reason for them to be private, make them public.

## Understand the difference between communication and creation

We don't do _everything_ in Github at Development Seed.
We use Google Drive for proposals and spreadsheets, and we use a huge suite of tools (Figma, Miro, etc...) for collaborative communication, design, and ideation.
These tools are designed to produce a single artifact (proposal, documentation, design); they might have a "change history", but that's not the key output.
For a proposals that's fine or maybe even good, but a conversation's history is as important as its final outcome.

Keep your communication in threaded mediums (e.g. Github, Slack) and keep them _out_ of "artifact creators" like Google Drive or wikis.

## Be flexible

We're constantly re-evaluating how we communicate and work at Development Seed.
We have a strong culture of sharing out learnings, whether that's as a GitHub issue on our internal `developmentseed/how` repository, through live demos, or via video.
However you design your system, make sure it has space to grow and change.
Spend some time thinking about your grounding philosophies and principles before you start designing process, and you'll be ready to adapt when the _next_ tech tooling revolution comes around.
I don't think it's purely by chance that our model of public, written communication pairs _extremely_ well with the LLM-based tooling revolution that's happening right now, and we've kept that model only because we've had a few core ideas that we can fall back on when it's time to make a change.

[^1]: I've been at Development Seed less than two years. I've done my best to chat with folks who have been at the company much longer, but some of my perceptions might not be quite right. If so, let me know and I'll update!
[^2]: By "public", I mean "public to your organization." It's great if you can publish your ideas and conversations to the entire world, and at Development Seed we try to do that as much as we can, but even we keep our organization-specific communication channels closed to those outside our company.
