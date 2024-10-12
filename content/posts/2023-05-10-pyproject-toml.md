+++
title = "Dependency protection with pyproject.toml"
slug = "dependency-protection-pyproject-toml"
date = 2023-05-10

[taxonomies]
tags = ["python", "github", "github-actions", "dependency-protection", "out-of-date"]
categories = ["how-to"]
+++

![Iceberg](/img/iceberg.jpg)

**NOTE: This post is out-of-date.**
Or, as the dude would say

> New s*** has come to light

See [Just use uv](@/posts/2023-05-10-pyproject-toml.md) for my latest thinking on this topic (spoiler: you should just use [uv](https://docs.astral.sh/uv)).

---

This is a follow up post to ["Dependency protection with Python and Github actions"](@/posts/2022-02-18-dependency-protection-with-python-and-github-actions.md), where I describe a relatively complex setup that uses `setup.cfg` and external requirement files to test against our minimum set of dependencies.
With the rise of `pyproject.toml` as the standard way of specifying project metadata, and [**setuptools'** support for the standard](https://setuptools.pypa.io/en/latest/userguide/pyproject_config.html), we can simplify our CI system quite a bit.
See [the original post](@/posts/2022-02-18-dependency-protection-with-python-and-github-actions.md) for background and the rationale on why we want to test against our minimum dependencies.

## Project metadata

With `pyproject.toml`, our dependency definitions become a lot simpler:

```toml
[project]
name = "foo"
# --- 8< ---
dependencies = [
    "bar>=0.42"
]

[project.optional-dependencies]
dev = [
    "pytest~=7.3"
]
```

Note that the core dependencies are all `>=`; this is very intentional, see the [original post](@/posts/2022-02-18-dependency-protection-with-python-and-github-actions.md#define-dependencies) for more on that.

## Utility script

In the [original post](@/posts/2022-02-18-dependency-protection-with-python-and-github-actions.md#create-requirements-min-txt), we defined our minimum requirements in a `requirements-min.txt` file, and we had a CI to assert that the `requirements-min.txt` was in-sync with the actual project dependencies.
This was pretty clunky and fragile, not least because any dependabot updates had to be manually tweaked to update the value in `requirements-min.txt`.
Now that we've defined _all_ of our dependencies in `pyproject.toml`, we use a new script (I like it to live at `scripts/install-min-requirements`) that installs the minimum versions of those dependencies in whatever environment you're in:

```python
import subprocess
import sys
from pathlib import Path

from packaging.requirements import Requirement

assert sys.version_info[0] == 3
if sys.version_info[1] < 11:
    import tomli as toml
else:
    import tomllib as toml


root = Path(__file__).parents[1]
with open(root / "pyproject.toml", "rb") as f:
    pyproject_toml = toml.load(f)
requirements = []
for install_requires in filter(
    bool,
    (i.strip() for i in pyproject_toml["project"]["dependencies"]),
):
    requirement = Requirement(install_requires)
    assert len(requirement.specifier) == 1
    specifier = list(requirement.specifier)[0]
    assert specifier.operator == ">="
    install_requires = install_requires.replace(">=", "==")
    requirements.append(install_requires)

subprocess.run(["pip", "install", *requirements], check=True)
```

This depends on all core dependencies having a `>=` specifier, which they should.

## Github actions

The CI action becomes a lot simpler:

```yaml
min-versions:
name: min-versions
runs-on: ubuntu-latest
steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-python@v4
    with:
        python-version: 3.9
        cache: null
    - name: Install with dev requirements
    run: pip install .[dev]
    - name: Install minimum requirements
    run: ./scripts/install-min-requirements
    - name: Test
    run: pytest
```

## Conclusion

To see all this in action, check out [pystac-client](https://github.com/stac-utils/pystac-client), where we converted to this system in [this PR](https://github.com/stac-utils/pystac-client/pull/501).
