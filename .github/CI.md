# CI coverage and setup

Use `.github/workflows/ci.yml` to check a pull request or a push to `master`. Use the workflow's manual trigger to run the full set of checks.

## Coverage

The workflow retains all 13 active CircleCI jobs. A full run checks the same platforms, features, examples, and documentation.

| Previous CircleCI job | GitHub Actions coverage |
| --- | --- |
| `test-linux` | Run all workspace tests with nextest, the `ci` Cargo profile, `--locked`, and `only_testnet` on Linux. Include CLI integration tests. |
| `test-macos` | Run the same workspace tests on ARM macOS. Include CLI integration tests. |
| `test-windows` | Run the same workspace tests on Windows. Unix CLI integration tests remain inactive on Windows. |
| `code-style` | Check Rust format with nightly. Run the tree-sitter corpus with `tree-sitter-cli@0.25.10`. |
| `clippy` | Check the workspace with all targets and all features. Treat warnings as errors. |
| `fmt-validate` | Run `leo-fmt` tests with the `validate` feature and the filter `test(/validate_/) - test(validate_ast_equivalence_repos)`. |
| `cargo-doc` | Build workspace documentation, including private items, with the same Rustdoc flags. |
| `docs-lint` | Run `markdownlint-cli@0.47.0` and `markdown-link-check@3.14.2` on all documentation Markdown files. |
| `leo-executable` | Build one Leo executable with its default features and share it with the CLI checks. |
| `leo-new` | Check generated programs and libraries with the existing build, run, and test script. |
| `leo-clean` | Check that a generated program builds and that `leo clean` removes its build output. |
| `test-examples` | Run the existing example script against the checked-out `examples` submodule. |
| `build-doc-code-snippets` | Check every snippet program. Run `leo test` when the snippet has a `tests/` directory. Run `leo build` otherwise. Exclude generated `build/` and `imports/` directories. |

Retain `.config/nextest.toml`. It runs Unix CLI integration tests one at a time. Linux and macOS use snarkOS from `.resources/snarkos-version`, built with `test_network`, for the devnet tests. A standard snarkOS release executable cannot replace this build.

The existing WASM, benchmark, scheduled code coverage, documentation deployment, and release workflows remain in place. The old CircleCI code coverage job was inactive.

## Change scope

Documentation-only pull requests run the documentation checks. Changes to `documentation/code_snippets/` also build Leo and check the snippets. Changes outside `documentation/` run all checks. A push to `master` and a manual run always run all checks. An unknown or empty comparison also runs all checks.

The required check jobs report a result for each scope. They accept an intentional skip but fail when a selected check fails or is cancelled. Fork pull requests use GitHub-hosted Linux runners and run the same commands without organization secrets.

## Shared Linux runners

Configure these items before you run the workflow on a branch in this repository:

1. Give this repository access to the organization variable `RUNNER_APP_ID` and the organization secret `RUNNER_APP_KEY`. They identify the GitHub App that reads the shared fleet's runner status.
2. Set the organization or repository variable `RUNNER_ROLE_ARN` to the AWS role used to start the shared runner fleet. Give this repository access to the variable. The `runner-config` job fails if this value is absent.
3. Confirm that the runner census App is installed on the organization with read access to organization self-hosted runners. Add Leo to the shared runner group's repository allowlist. Do not give the census App repository or secret-management permissions.
4. Add Leo's workflow identity to the AWS role's GitHub OIDC trust policy. Use the `sts.amazonaws.com` audience and the shared `start-runner.yml@v2` workflow identity, as in snarkVM and snarkOS. Permit the intended pull request and branch identities. Keep the existing fleet permissions and restrict trust to the required repository and events.
5. Confirm that the fleet can start enough Linux runners for the parallel jobs. Keep the fleet's existing idle shutdown and disk management in place.

The app ID and key are available to this repository. `RUNNER_ROLE_ARN` must be supplied by the infrastructure maintainers. Fork pull requests do not use these credentials or the shared fleet. Linux builds and CLI consumers use the same runner selection. Keep the fleet's Linux images compatible so that the shared executable runs on each box.

## macOS and Windows runners

The default macOS label is `macos-26`. Keep an ARM runner to retain the previous macOS architecture. Set the repository variable `CI_MACOS_RUNNER` to the label of a larger ARM macOS runner when one is available.

The default Windows label is `windows-2025`. Set the repository variable `CI_WINDOWS_RUNNER` to the label of a larger Windows runner when one is available. Grant Leo access to each selected runner group. Fork pull requests always use standard GitHub-hosted runners on both platforms.

Default GitHub-hosted capacity is lower than the previous CircleCI capacity. The previous macOS runner had 12 CPU cores and 56 GB of memory. The standard ARM macOS runner has 3 CPU cores and 7 GB of memory. The previous Windows runner had 16 CPU cores and 64 GB of memory. The standard Windows runner has 4 CPU cores and 16 GB of memory. Use larger runners if these jobs set the total run time.

## Run time

Use the previous warm CircleCI runs as a reference. [Pipeline 14297](https://app.circleci.com/pipelines/github/aleo-labs-protocol/leo/14297), from October 8, took 16 minutes 36 seconds. Linux tests took 13 minutes 46 seconds, macOS tests took 9 minutes 36 seconds, and Windows tests took 14 minutes 26 seconds. The Leo executable build took 7 minutes 56 seconds, followed by 1 minute 50 seconds for the examples. [Pipeline 14294](https://app.circleci.com/pipelines/github/aleo-labs-protocol/leo/14294), from October 2, took 13 minutes 4 seconds.

The warm target is 12 to 17 minutes with sufficient runner capacity. This is a target, not a measured result for GitHub Actions. Compare at least one cold run and one warm run before you accept a run-time claim. Include runner queue time, cache transfer time, and the snarkOS build in that comparison.

## Required checks

Keep these exact required check names: `code-quality`, `leo-executable`, `test-linux`, `test-macos`, and `test-windows`.

The current `master` protection does not restrict these contexts to an app. After the first successful run, confirm that each required context comes from GitHub Actions. If an organization ruleset requires a check from CircleCI, change its source to GitHub Actions. Do not merge until all five required checks pass.
