 # Cleanup and Refactoring Plan

 ## Objectives
 - Make configurations modular and reusable across hosts
 - Pin Nix and package versions for reproducibility (Nix Flakes)
 - Consolidate shared code and remove duplication
 - Introduce automation for building, testing, and deploying
 - Improve documentation and onboarding for new hosts and contributors

 ## Current Pain Points
 - Flat directory structure mixing all hosts and custom modules
 - Duplicate service and package lists across host configs
 - No explicit version pinning for Nixpkgs or inputs
 - Lack of automated tests or CI to validate changes
 - Sparse documentation on adding new hosts or services

 ## Proposed Actions

 #### 1. Adopt Nix Flakes
 - Create a top-level `flake.nix` that defines inputs:
   - Pin `nixpkgs`, `home-manager`, and other Nix modules
   - Expose `nixosConfigurations` for each host
   - Optionally define `devShells` for local development environments
 - Run `nix flake update` to generate `flake.lock` and freeze versions
 - Update `nixos-rebuild` commands to use `--flake .#<hostname>`

 #### 2. Restructure Repository Layout
 - Create a `hosts/` directory and move each host config into it:
     - `hosts/work-laptop.nix`
     - `hosts/home-desktop.nix`
     - `hosts/home-server.nix`
 - Create a `modules/` directory for shared Nix modules
 - (Optional) Create an `overlays/` directory for Nixpkgs overlays
 - Keep top-level files focused on repository management (e.g., `flake.nix`, `README.md`)

 #### 3. Extract and Consolidate Common Modules
 - In `modules/`, define clear-purpose Nix modules:
     - `users.nix`            — common user accounts and SSH keys
     - `packages.nix`         — shared package lists and utilities
     - `services.nix`         — standard service enablement (docker, firewall, etc.)
     - `networking.nix`       — shared network settings and hostnames
     - `hardware-configuration.nix` — input devices, graphics, audio
     - `firewall.nix`         — global firewall rules
 - Import these modules in each host config and override or extend as needed

 #### 4. Consolidate Package Definitions
 - Centralize repeated package lists in `modules/packages.nix`
 - Provide host-specific augmentations with a keyed list or function parameter

 #### 5. Automate Build and Test
 - Add a GitHub Actions workflow (`.github/workflows/nixos.yml`):
   - Run `nix flake check` to validate all `nixosConfigurations`
   - Optionally perform `nixos-rebuild build --flake .#<host>` for each
 - Optionally integrate with Hydra or other CI/CD for continuous validation

 #### 6. Improve Documentation
 - Update `README.md` with:
   - Prerequisites (Nix version, flakes support)
   - How to rebuild or switch a host config (`nixos-rebuild switch --flake .#<host>`)
   - How to add a new host: copy template, update `flake.nix`, and create host entry
 - Add `docs/` folder if needed for longer tutorials or service recipes

 #### 7. Remove Deprecated or Unused Code
 - Audit the repo for commented-out snippets or removed features
 - Delete obsolete modules, scripts, and configurations

 #### 8. Provide Helper Scripts or Makefile
 - Create a `Makefile` or `scripts/` directory with wrappers:
     - `make switch HOST=<hostname>`
     - `make build HOST=<hostname>`
     - `make test` to run CI checks locally

 ## Migration Strategy and Timeline
 1. **Week 1**: Scaffold `flake.nix`, reorganize directory structure
 2. **Week 2**: Extract common modules, migrate one host at a time, validate locally
 3. **Week 3**: Implement CI workflows, finalize documentation
 4. **Week 4**: Remove deprecated code, onboard any remaining hosts

 ## Risk Mitigation
 - Create branch backups before major refactors
 - Migrate one host at a time and validate with `nixos-rebuild build`
 - Keep `flake.lock` committed to revert input versions if needed

 ---
 This plan should serve as a roadmap to maintain a clean, modular, and scalable NixOS configuration repository.
