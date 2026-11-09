# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

All rules are tool-agnostic and live in `AGENTS.md` and `.ai/` (shared with Cursor, Copilot, Windsurf,
opencode). Do not add rules here -- add them to the matching `.ai/domains/` file instead. The
`dotfiles-*` skills under `.claude/skills/` load those same domain files on demand.

@AGENTS.md

## Tests

```zsh
rspec                                     # whole suite (plain rspec, not bundle exec)
rspec spec/utilities/logging_spec.rb      # one file
rspec spec/utilities/logging_spec.rb:45   # one example by line
```

Spec layout, helpers (`with_env`, `NO_COLOR`) and other testing patterns: `.ai/context.md` § Testing Patterns.
