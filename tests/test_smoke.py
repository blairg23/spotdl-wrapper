"""Smoke test for the initial scaffold.

With no real functionality yet, this just confirms the package imports
cleanly -- keeps `pytest`/coverage from failing on zero collected tests
until real modules and tests land.
"""

import spotdl_wrapper


def test_package_imports() -> None:
    assert spotdl_wrapper is not None
