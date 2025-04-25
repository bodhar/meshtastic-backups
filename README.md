# Meshtastic Backups

A simple Bash utility to back up your Meshtastic device configuration as YAML files. The script invokes the Meshtastic CLI to export your device config, names the backup by device owner and date, and stores it under a `meshtastic-backups` directory in your current working directory.

## Repository

  https://github.com/bodhar/meshtastic-backups.git

## Requirements

- A Unix-compatible shell (bash)
- [Meshtastic CLI](https://github.com/meshtastic/Meshtastic-python) installed and in your `PATH`
- `git` (for cloning the repository)

## Installation

1. Clone the repository  
   ```bash
   git clone https://github.com/bodhar/meshtastic-backups.git
   cd meshtastic-backups
   ```
2. Install the Meshtastic CLI  
   Choose the method appropriate for your OS:

   macOS  
   ```bash
   brew install meshtastic
   ```

   Ubuntu  
   ```bash
   sudo apt update
   sudo apt install python3-pip
   pip3 install meshtastic
   ```

   Windows (PowerShell)  
   ```powershell
   pip install meshtastic
   ```

3. Verify installation  
   ```bash
   meshtastic --version
   ```

## Usage

Run the backup script to export your Meshtastic device configuration:

```bash
./scripts/backup-config-serial.sh
```

The script will:

1. Check that `meshtastic` is available in your `PATH`.
2. Export the device configuration to a temporary file.
3. Read the `owner:` field from the config for naming.
4. Move the YAML file into `./meshtastic-backups/` with a filename of the form:
   ```
   config-<owner>-YYYY-MM-DD.yaml
   ```
5. Print the path of the saved backup.

If no `owner:` field is found, the script aborts to allow you to inspect the raw export.

### Environment Variables & Flags

- No command-line flags are supported.
- The backup directory defaults to `$(pwd)/meshtastic-backups`. You may change the script if a different location is required.

## License

This project is licensed under the MIT License.
