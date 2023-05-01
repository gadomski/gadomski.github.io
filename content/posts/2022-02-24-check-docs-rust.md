+++
title = "Check Rust docs with Github actions"
slug = "check-rust-docs"
date = 2022-02-24
alises = [
    "2022/02/24/check-docs-rust.html"
]

[taxonomies]
tags = ["rust", "github", "github-actions", "docs"]
categories = ["how-to"]
+++

Because I am imperfect, I don't always build my Rust docs before opening a PR.
I use a job to check for any documentation warnings via `-Dwarnings`:

```yaml
jobs:
    doc:
        runs-on: ubuntu-latest
        env:
            RUSTDOCFLAGS: -Dwarnings
        steps:
        - uses: actions/checkout@v2
        - uses: actions/cache@v2
            with:
            path: |
                ~/.cargo/bin/
                ~/.cargo/registry/index/
                ~/.cargo/registry/cache/
                ~/.cargo/git/db/
                target/
            key: ${{ '{{' }} runner.os }}-cargo-${{ '{{' }} hashFiles('Cargo.toml') }}
        - name: Doc
            run: cargo doc
```

If there are any warnings (e.g. a dangling link), CI will fail, prompting me to go back and fix my docs:

```text
Documenting stac v0.0.3 (/home/runner/work/stac-rs/stac-rs)
error: unresolved link to `Href`
  --> src/read.rs:39:34
   |
39 |     /// Reads an object from an [Href] as the actual structure.
   |                                  ^^^^ no item named `Href` in scope
   |
   = note: `-D rustdoc::broken-intra-doc-links` implied by `-D warnings`
   = help: to escape `[` and `]` characters, add '\' before them like `\[` or `\]`

error: could not document `stac`
```
