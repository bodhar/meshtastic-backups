# Meshtastic Backups

A simple Bash utility to back up your Meshtastic device configuration as YAML files. The script invokes the Meshtastic CLI to export your device config, names the backup by device owner and date, and stores it under a `meshtastic-backups` directory in your current working directory.

## Requirements

- A Unix-compatible shell (bash)
- [Meshtastic CLI](https://github.com/meshtastic/Meshtastic-python) installed and in your `PATH`
- `git` (for cloning the repository)
- Python 3 (recommended 3.11 or newer)
- [uv](https://docs.astral.sh/uv/) (a fast Python package installer and resolver) or a Python virtual environment manager

*I've only tested this on MacOS Sequoia and Ubuntu 24.04, however this should work with other Linux distributions, including via the use of WSL.*

## Installation

1. Clone the repository
   
   ```shell
   git clone https://github.com/bodhar/meshtastic-backups.git
   cd meshtastic-backups
   ```
2. Install Meshtastic CLI

I use `uv` for managing python virtual environments, however `venv` will also work fine here.

**Using `uv`**

Assuming that `uv` is already installed, you can use the project in this repository to setup the environment:

```shell
uv sync
```

**Using `venv`**

Assuming that `venv` is already installed:

```shell
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install "meshtastic[cli]"
```

3. Verify installation

If working, the below command will output the installed version of Meshtastic CLI:

```shell
source .venv/bin/activate
meshtastic --version
```

## Usage

1. Activate the virtual environment:

```shell
source .venv/bin/activate
```

You'll then be able to run the backup script to export your Meshtastic device configuration:

```shell
./scripts/backup-config-serial.sh
```

The script will:

1. Check that `meshtastic` is in `PATH`
2. Export the device configuration to a temporary file
3. Read the `owner` field from the config
4. Move the temporary file contents into `./meshtastic-backups/` with a filename in the form of `config-<owner>-YYYY-MM-DD.yaml`
6. Print the path of the saved backup

If no `owner` field is found, the script aborts, allowing you to inspect the raw export.

**Note** that any previous backups taken on the same date will currently be overwritten if you run the script multiple times. I should probably add the current time to the file as well to limit any loss.

### Environment Variables & Flags

Nothing currently supported.

## License

This project is licensed under the MIT License.