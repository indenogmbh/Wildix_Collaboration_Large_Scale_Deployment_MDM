# Wildix Collaboration Large Scale Deployment with MDM

This repository provides a Bash script designed for large-scale deployment of Wildix Collaboration on macOS devices. The script is ideal for use with MDM solutions like Microsoft Intune and Jamf, and it automates the configuration of server addresses and other presets to ensure a smooth setup of Wildix Collaboration across multiple devices.

## Disclaimer

This script is provided "as-is" without any warranties or guarantees of any kind. Use it at your own risk. We are not responsible for any damages, data loss, or other issues that may arise from the use of this script. Always test in a development environment before using it in production.

## Script Overview

### `wildix_collab_deploy.sh`

- **Description:**  
  This Bash script configures the server address and various other presets for Wildix Collaboration on macOS devices. It is designed for large-scale deployments and integrates seamlessly with MDM solutions like Microsoft Intune and Jamf.

- **Key Features:**
  - Checks for the existence of the necessary configuration folder and creates it if missing.
  - Configures the `settings.json` file with the following settings:
    ```json
    {
      "host": "yourwildixinstance.wildixin.com",
      "callControlMode": false,
      "callBringToFrontMode": true,
      "allowInsecureConnections": false,
      "keepRunningOnClose": true,
      "launchAtStartup": true
    }
  - Cleans up unnecessary files, including `lastWindowStatesettings.json` and `failover.json`.
  - Restarts Wildix Collaboration and the Wildix Integration Service after applying the configuration.
  - Provides console output for progress tracking.
 
## PPPC (Privacy Preferences Policy Control) Configuration

For Wildix Integration Service (Identifier: `com.wildix.wiservice`), you need to configure the required Accessibility permission using a mobileconfig / Configuration Profile. This is necessary to allow the service to function properly on macOS devices.

- **Mobileconfig Deployment:**  
  You can deploy the Accessibility permission for `com.wildix.wiservice` via Microsoft Intune or another MDM solution by creating and distributing a mobileconfig profile. This will grant the Wildix Integration Service access to macOS accessibility features.

- **User-Granted Permissions:**  
  Please note that certain permissions, such as Microphone access, Camera access (for Kite), and Screen Recording permissions, **cannot be pre-configured** through MDM. Apple requires that these permissions be granted by the user on an ad-hoc basis during the use of Wildix Collaboration. Users will be prompted to allow these permissions when necessary.

## Prerequisites

- **MDM Solution:**  
  This script is designed for deployment through MDM solutions such as Microsoft Intune or Jamf. Ensure you have the necessary permissions to deploy scripts across macOS devices.

- **Wildix Collaboration App:**  
  The script assumes that Wildix Collaboration is installed on the target devices. If the app is not installed, the script will skip restarting the app but will still apply the configuration.

## Step-by-Step Instructions

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/indenogmbh/Wildix_Collaboration_Large_Scale_Deployment_MDM.git
   cd Wildix_Collaboration_Large_Scale_Deployment_MDM
   ```

2. **Edit the Script (Optional):**

   If you need to customize the script for a different server address or other presets, open the `wildix_collab_deploy.sh` file in a text editor and modify the relevant sections.

3. **Deploy the Script:**

   Use your MDM solution (e.g., Microsoft Intune or Jamf) to deploy the `wildix_collab_deploy.sh` script to your macOS devices.

   - The script will configure the Wildix Collaboration app, set up the necessary files, and restart the app if installed.

4. **Verify Deployment:**

   After the script has been deployed, check the target devices to ensure that Wildix Collaboration has been configured correctly and is working as expected.

## Error Handling

- **Folder and File Checks:**  
  The script checks for the existence of necessary folders and files before making any changes. If files are missing, it creates them with the required configuration.

- **Application Restart:**  
  If changes are made to the configuration, the script will terminate and restart the Wildix Collaboration app to apply the new settings. If the app is not installed, the script will skip this step.

## Contributing

If you would like to contribute to this project, feel free to fork the repository and submit a pull request with your improvements.

## Copyright

© 2024 Indeno GmbH. All rights reserved.
