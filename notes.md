# Meshtastic README

## Backing up

Create a directory for a venv to exist in and set up the environment:

```shell
% mkdir -p path/to/directory
% cd path/to/directory
% uv venv --python 3.11
% uv pip install "meshtastic[cli]"
Resolved 23 packages in 59ms
Installed 23 packages in 52ms
 ...
```

## Backing up device configuration and keys

There are two scripts in this directory:

  - `backup-config-serial.sh` - for backing up USB serial connected devices 
  - `backup-config-bluetooth.sh` - for backing up bluetooth devices (requires further testing)

### Using bluetooth connection

Scan for available Meshtastic devices using the below, taking note of the name returned from the command.

```shell
% meshtastic --ble-scan
```

e.g. the name `stnP_14b9` will be used.

```shell
% meshtastic --ble-scan
INFO file:ble_interface.py scan line:116 Scanning for BLE devices (takes 10 seconds)...
Found: name='stnP_14b9' address='F4BA2D0C-9564-3609-2A8D-8544AECCA68A'
BLE scan finished
```

Export device config with --export-config

```shell
d=$(date +%Y-%m-%d)
meshtastic --ble stnP_14b9 --export-config > "config-backup-stnP_14b9-$d.yaml"
```

You may be prompted to enter the bluetooth pairing code that appears on the screen of the device.

### Using serial connection

There's a 

Confirm the owner (name) of the device with:

```shell
$ meshtastic --export-config | grep -w "owner:" | awk '{print $2}'
```

e.g

```shell
meshtastic --export-config | grep -w "owner:" | awk '{print $2}'
stnPortable
```

```shell
% d=$(date +%Y-%m-%d)
% meshtastic --export-config > "config-backup-stnPortable-$d.yaml"
```

## Restoring from backup 

### Restoring using bluetooth connection

### Restoring using serial connection

```shell
% meshtastic --configure config-backup-foo.yaml
```

