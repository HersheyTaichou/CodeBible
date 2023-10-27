# Audible-Cli

A utility to bulk download Audiobooks from Audible

## How to Install

1. Log into a Linux VM (Example is using a Debian VM and at least has to be on the Bookworm release)
1. Install Python 3 and pip, if needed

   ```bash
   apt install python3 python3-pip
   ```

1. Install audible-cli

   ```bash
   pip install audible-cli
   ```

1. Set up Audible

   ```bash
   audible quickstart
   ```

1. Proceed through the wizard to login to Audible

## How to Use

### Activation Bytes

This will give you the activation bytes for your account, which you will need to decrypt your books

```bash
audible activation-bytes
```

### Library Export

Export a list of all your audiobooks from audible to a CSV file

```bash
audible library export -f csv
```

### Download your audiobooks

#### Download all your books

Note, this will also download any podcasts or similar, such as a NYT subscription

```bash
audible download --all --aax-fallback
```

#### Download a specific book

See the exported list for the book to ASIN number mapping (Can also be found in the web URL for a book)

```bash
audible download --aax-fallback -a {ASIN Number}
```

### Remove DRM from Audiobooks

1. Install ffmpeg

   ```bash
   apt install ffmpeg
   ```

1. Check the version, it must be at least version 4.5

   ```bash
   ffmpeg -version
   ```

1. Create a folder to store decrypted books

   ```bash
   mkdir drm-free
   ```

1. Remove DRM from all aax books in the current directory, storing them in the above directory

   ```bash
   for i in *.aax; do ffmpeg -y -activation_bytes “Activation bytes here” -i "$i" -map_metadata 0 -id3v2_version 3 -codec:a copy -vn "./drm-free/${i%.*}.m4b"; done
   ```

1. AAXC files require a little more work to decrypt

   1. Open the file that starts with the book name, and ends with “.voucher”

      ```bash
      nano Book_Title-AAX_11_22.voucher
      ```

   1. Make a note of the IV and Key (You may have to scroll down, it is under license_response)
   1. Edit the following command, adding the IV, Key and AAXC file name

      ```bash
      ffmpeg -y -audible_iv "IV Here" -audible_key "KEY here" -i "AAXC file name" -map_metadata 0 -id3v2_version 3 -codec:a copy  -vn "./drm-free/Book name.m4b"
      ```

   1. Wait for the file to finish decrypting

### Organize the books into folders

1. Install a tool for examining file metadata

   ```bash
   apt install exiftool
   ```

1. Move into the DRM free folder

   ```bash
   cd drm-free
   ```

1. Run the following command to create artist and book folders from the m4b files, then move the books into them:

   ```bash
   for b in *.m4b; do mkdir -p "$(exiftool $b -Artist -s -s -s)/$(exiftool $b -Title -s -s -s)"; mv $b ./"$(exiftool $b -Artist -s -s -s)/$(exiftool $b -Title -s -s -s)"; done
   ```
