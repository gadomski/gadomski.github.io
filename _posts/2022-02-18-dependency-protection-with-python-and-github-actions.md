---
layout: post
date: 2022-02-18
title: Dependency protection with Python and Github actions
tags: python github github-actions dependencies
---

> Many thanks to Tom Augsburger for inspiring this post with [this issue](https://github.com/stac-utils/stactools/issues/227) and providing additional background on the problem space.

Dependency management is a notoriously hard problem, and it is significantly harder if you are working in an interpreted language that has unconstrained imports from all dependent projects, e.g. Python.
There have been gallons of digital ink spilled discussing the pros and cons of various dependency management schemes and tools (e.g. [poetry](https://python-poetry.org/)).
This post does not aim to try to solve dependency management; instead, it outlines one approach to protect against dependency breakages using Github actions for your Python library.

The "correct" approach to dependency management depends heavily on the scope of your software and its intended use.
If you’re building an executable or executable-ish (e.g. a command line utility), it is unquestionably the best practice to lock your dependency tree with a Pipfile.lock, `pip freeze > requirements.txt`, or something similar.
The same almost certainty holds for API endpoints (e.g. Lambdas); these are often implicitly locked by executing from a (frozen) Docker image.
The picture changes quickly if you’re building a library that is used by downstream projects, because if you freeze dependencies you almost certainly break downstream dependency resolution.
So, if you’re building a library, you need a more flexible model.

[This post](https://iscinumpy.dev/post/bound-version-constraints/) outlines a wonderful case for not using upper bound version constraints in Python, and is worth your time to read in full.
To summarize, the article begins with SemVer skepticism and awareness of the complexities of large Python environments, and concludes that upper bounds will more often break your code unnecessarily rather than protecting you from API changes.
It recommends two actions to protect against dependency breakage:
- Provide lower bounds but not upper bounds
- Test three (or four) cases in CI:
    - Standard: `pip install -U my-package`
    - Minimum requirements: provide the minimum supported version for each dependency and test against that
    - Pre-release: identify key upstream packages and test against pre-release versions, e.g. installed with `pip install --pre`
    - (optional) Extra requires: `pip install -U 'my-package[all]'`, where [all] installs all possibly cases of extra_requires

While straightforward in concept, executing this strategy on Github actions requires some workflow setup that can be a little fiddly. 
These following examples are specific to Github actions, but the general concepts can be ported to other CI systems.

## Assumptions

There are a multitude of tools available for testing, dependency management, and more.
We are not here to make tooling recommendations or evaluations, and so will stick to an almost-vanilla setup with default Python.
The only exception is [pytest](https://docs.pytest.org/en/7.0.x/), which is useful enough (in my opinion) to warrant inclusion in this post.

## Define dependencies

The first step is defining your requirements in `setup.cfg` properly.

> You’ll notice we use `setup.cfg` instead of `setup.py`. `setup.cfg` is a modern addition to Python, and in my opinion should be preferred whenever possible.
> Configuration should be static and simply defined, and not require Python code to create.

Define your dependencies with lower bounds only, e.g.:

```cfg
[options]
install_requires =
    foo >= 1.2
```

Finding the lower bounds of your dependencies might be tricky. The best way we’ve found so far is the following:
- (in a virtual environment) Install a version of a dependency
- Run tests
- If they pass, try a lower dependency
- If they fail, try a higher dependency

This is obviously clunky, but hopefully you only have to do it once.

## What is a dependency?

Great question. To me,

> a dependency is any package that is explicitly imported in your package.

## Create requirements-min.txt

Once you’ve defined your dependencies, create a requirements-min.txt file in the root of your repository, with each dependency listed but with `>=` replaced with `==`, e.g.:

```
foo == 1.2
```

## The atomic unit of test

Assuming the simplest Python package possible, with dependencies specified in setup.cfg and development dependencies specified in `requirements-dev.txt`, the most basic Github action would look something like this:

```yaml
name: CI
on:
  push:
    branches:
      - main
  pull_request:
jobs:
  test:
    name: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
        with:
          python-version: '3.9'
      - name: Install
        run: pip install .
      - name: Install development requirements
        run: pip install -r requirements-dev.txt
      - name: Test
        run: pytest
```

We will use this framework to define improvements to help test the use-cases outlined in the first section.

## Test standard, min, and pre-release

The standard case stays the same as the atomic unit of test.

The minimum version looks like this (snipped to the relevant bits):

```
<snip>
      - name: Install minimum versions
        run: pip install -r requirements-min.txt
      - name: Install
        run: pip install .
<snip>
```

Notice that the minimum versions need to be installed before the package.

> It can be tricky to ensure that the `requirements-min.txt` file stays in-sync with `setup.cfg`.
> While you could generate the `requirements-min.txt` file automatically, we find it better to keep it explicit, and instead check to ensure consistency using a script, e.g. [this one](https://github.com/stac-utils/stactools/blob/d1e084f8df6c43626d76c6a2a33559c4ce8fe33e/scripts/check_minimum_requirements).

Finally, the pre-release looks something like this:

```
<snip>
      - name: Install
        run: pip install .
      - name: Install pre-release versions
        run: pip install -U --pre my-critical-dependency
<snip>
```

## Bonus: Refactor using composite Github actions

If you’re repeating the same boilerplate setup over many Github actions jobs, it can be handy to refactor the boilerplate to a custom composite action.
Github composite actions are exactly what they sound like: Github actions that are made up of other Github actions.
I didn’t find a quick walkthrough of using a own-repository Github action, so here’s the steps:
- Create a directory in your `.github` directory for your action, e.g. `.github/setup`
- Create an `.github/setup/action.yml`
- Set up your composite action.
  For a simple example, set up your pip cache and update pip:

```yaml
name: Setup
description: Set up the pip cache
inputs:
  pip-cache-hash:
    description: The hash used for the pip cache
    required: False
    default: ${{ '{{' }} hashFiles('setup.cfg', 'requirements-dev.txt') }}
runs:
  using: composite
  steps:
    - uses: actions/setup-python@v2
      with:
        python-version: '3.9'
    - name: Set up pip cache
      uses: actions/cache@v2
      with:
        path: ~/.cache/pip
        key: ${{ runner.os }}-pip-${{ inputs.pip-cache-hash }}
        restore-keys: ${{ runner.os }}-pip-
    - name: Update pip
      run: python -m pip install --upgrade pip
```

Now you can use the action in your workflow.

## Complete example

```yaml
name: CI
on:
  push:
    branches:
      - main
  pull_request:
jobs:
  test:
    name: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: ./.github/setup
      - name: Install
        run: pip install .
      - name: Install development requirements
        run: pip install -r requirements-dev.txt
      - name: Test
        run: pytest
  min-version:
    name: min-version
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: ./.github/setup
      - name: Install minimum versions
        run: pip install -r requirements-min.txt
      - name: Install
        run: pip install .
      - name: Install development requirements
        run: pip install -r requirements-dev.txt
      - name: Test
        run: pytest
  pre-release:
    name: pre-release
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: ./.github/setup
      - name: Install
        run: pip install .
      - name: Install pre-release versions
        run: pip install -U --pre my-critical-dependency
      - name: Install development requirements
        run: pip install -r requirements-dev.txt
      - name: Test
        run: pytest
```

## In conclusion

For a complete example of this implementation, with some extra bells and whistles (including a conda install and a Python version matrix), check out [this pull request](https://github.com/stac-utils/stactools/pull/228).
In particular, the Github actions DRY-ification using the local composite action felt especially tasty – I will be re-using that pattern often.

Here’s hoping this post helped explain how you might protect yourself from dependency breakages by using your CI as a defensive gate against your upstreams making changes that you haven’t expected.
Cheers!  

