# WARNING: THIS TOOL WAS MADE FOR KEPADS PRIOR TO THE 2022 REDESIGN. IF YOU USE THIS ON A 2022 KEYPAD, IT WILL RESULT IN A SOFT-BRICK THAT REQUIRES DISASSEMBLY TO FIX.

# Unified uploader

This is a basic shell utility to help upload the latest (beta) firmware to your keypad with bre-built binaries. It's made to be as portable as possible and cross platform, so it should work on Windows, Mac, and Linux without the need for any external dependencies.

## How to use (Windows)

1. Download this repository by clicking the green "↓ Code" button in the top right and then select "Download ZIP". If prompted, save to your Downloads folder.

2. Extract the zip by going to your Downloads folder, right clicking, and selecting "Extract all..."

3. Click the "Extract" button to extract the archive. Leave the "Show extracted files when complete" checkbox ticked.

4. In the new window that pops up, click on the folder "unified-uploader-master". You can then click on the file called upload/upload.bat.

5. Windows will tell your that SmartScreen prevented an unrecognized app from starting. Click "More info" and then "Run anyway".

6. The script should now be running and asking for a number corresponding to your keypad model. Enter the number and you should be done!

## How to use (Mac, M1 not supported)

1. Download this repository by clicking the green "↓ Code" button in the top right and then select "Download ZIP". If prompted, save to your Downloads folder.

2. Open the download to extract it. This will open a finder window with the newly extracted folder highlighted. If you're using Safari, you can open it by clicking on your downloads and hold control while click on the download to select "Show in Finder".

3. Open a terminal and enter `cd `(including the space at the end), then drag and drop the folder from the previous step into the terminal. The command should look something like `cd unified-uploader-master` (with a number at the end if you've downloaded it multiple times). Press return to execute the command.

4. Run the updater script by entering `./upload.sh`

5. Enter the number for your model and you're done!

## How to use (*Linux)

1. Download and extract the repository.

2. Make the shell script executable with chmod +x upload.sh

3. Run the script.
