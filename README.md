# jdansak/homebrew-tap

Personal [Homebrew](https://brew.sh) tap for CLI and TUI tools built from `jdansak/*` repositories.

## Quick Start

```bash
brew tap jdansak/tap
```

## Available Formulas

| Formula | Repo | Install Type | Install Command |
| :--- | :--- | :--- | :--- |
| `canvas-scraper` | [Canvas-Scraper](https://github.com/jdansak/Canvas-Scraper) | Prebuilt (`v1.0.0`) + `--HEAD` | `brew install jdansak/tap/canvas-scraper` |
| `bab` | [VPS](https://github.com/jdansak/VPS) | Source (`--HEAD`) | `brew install --HEAD jdansak/tap/bab` |
| `market-tui` | [market-tui](https://github.com/jdansak/market-tui) | Source (`--HEAD`) | `brew install --HEAD jdansak/tap/market-tui` |
| `nettui` | [OSX_network_TUI](https://github.com/jdansak/OSX_network_TUI) | Source (`--HEAD`, macOS only) | `brew install --HEAD jdansak/tap/nettui` |
| `firewall-audit` | [firewall-audit](https://github.com/jdansak/firewall-audit) | Source (`--HEAD`) | `brew install --HEAD jdansak/tap/firewall-audit` |
| `orchestrator` | [orchestrator](https://github.com/jdansak/orchestrator) | Source (`--HEAD`) | `brew install --HEAD jdansak/tap/orchestrator` |

## Updating Formulas on Release

### Manual / Local

```bash
./scripts/bump-formula.sh canvas-scraper jdansak/Canvas-Scraper v1.0.1
```

### Automated via GitHub Actions

This tap listens for `repository_dispatch` (`bump-formula`) and `workflow_dispatch`. From an upstream repo's release workflow, trigger a PR in `jdansak/homebrew-tap`:

```yaml
- name: Notify Homebrew Tap
  uses: peter-evans/repository-dispatch@v3
  with:
    token: ${{ secrets.HOMEBREW_TAP_TOKEN }}
    repository: jdansak/homebrew-tap
    event-type: bump-formula
    client-payload: |
      {
        "formula": "canvas-scraper",
        "repo": "${{ github.repository }}",
        "tag": "${{ github.ref_name }}"
      }
```
