[![build](https://github.com/felangel/bloc/workflows/build/badge.svg)](https://github.com/felangel/bloc/actions)

# Spotted

Spotted is a private QA application for any organization. User requires an organzation's email address in order to be verified and placed in the organization's QA. As an verified member of an organization, a user has the ability to ask questions and answer other people's questions.
***
## Getting Setup Flutter App
### Installing Flutter
## For MacOS user:
To install and run Flutter, your development environment must meet these minimum requirements:

Operating Systems: macOS (64-bit)
Disk Space: 2.8 GB (does not include disk space for IDE/tools).

1: Get the Flutter SDK, Download:
https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.17.2-stable.zip

2: unzip the file. If you don’t want to install a fixed version, you can run 

    git clone https://github.com/flutter/flutter.git 

3: Add the flutter tool to your path:

    export PATH="$PATH:`pwd`/flutter/bin"

4:Optionally, pre-download development binaries:

    flutter precache

Run Flutter Doctor:
Run the following command to see if there are any dependencies you need to install to complete the setup (for verbose output, add the -v flag):

    flutter doctor

## For Windows user:
Operating Systems: Windows 7 SP1 or later (64-bit)
Disk Space: 400 MB (does not include disk space for IDE/tools).

1: Get the Flutter SDK, Download:
https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_1.17.2-stable.zip

2: unzip the file. If you don’t want to install a fixed version, you can run 

    git clone https://github.com/flutter/flutter.git -b stable

3: If you wish to run Flutter commands in the regular Windows console, take these steps to add Flutter to the PATH environment variable:

From the Start search bar, enter ‘env’ and select Edit environment variables for your account.
Under User variables check if there is an entry called Path:
If the entry exists, append the full path to flutter\bin using ; as a separator from existing values.
If the entry doesn’t exist, create a new user variable named Path with the full path to flutter\bin as its value

Run Flutter Doctor:

    C:\src\flutter>flutter doctor


### Setting up an editor:
## Install VS CODE 
https://code.visualstudio.com/

## Install the Flutter and Dart plugins
1. Start VS Code.
2. Invoke View > Command Palette….
3. Type “install”, and select Extensions: Install Extensions.
4. Type “flutter” in the extensions search field, select Flutter in the list, and click Install. This also installs the required Dart plugin.

After you done set up, simply run "flutter doctor" on your command line to check 

### Run the Spotted App via your command line

    cd Spotted-App/frontend 
 
### Now run the app 

    flutter run -d Chrome
   
## Note: if run into the error messages like "Exception: Failed to compile application for the Web." type:

    flutter build web
    

### For more info please visit: https://flutter.dev/
