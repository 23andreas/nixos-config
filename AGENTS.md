# NixOS Configuration Agent Guidelines

## Build Commands
- Build all systems: `nix build --accept-flake-config --print-build-logs .#cachix-deploy-spec`
- Build specific host: `nix build .#top.home-desktop` (or work-laptop, server, iso)
- Check flake: `nix flake check`
- Update flake: `nix flake update`

## Code Style
- Use 2-space indentation consistently
- Function parameters on separate lines with proper alignment
- Use `let...in` blocks for complex expressions
- Prefer explicit imports over `with` statements when possible
- Use descriptive variable names (e.g., `hostname`, `gitIsEnabled`)
- Add TODO comments with # prefix for future improvements

## Structure
- Host configs in `hosts/[hostname]/default.nix`
- Modules in `modules/nix/` for system, `modules/home-manager/` for user configs
- Use imports for modular configuration
- Follow existing patterns for module organization

## Error Handling
- Use `lib.mkIf` for conditional configurations
- Prefer explicit option definitions over defaults
- Test configurations before committing changes