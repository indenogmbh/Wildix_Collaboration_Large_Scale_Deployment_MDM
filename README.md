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
  - Configures the `settings.json` file with the required server address and other settings.
  - Cleans up unnecessary files, including `lastWindowStatesettings.json` and `failover.json`.
  - Restarts Wildix Collaboration and the Wildix Integration Service after applying the configuration.
  - Provides console output for progress tracking.

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
