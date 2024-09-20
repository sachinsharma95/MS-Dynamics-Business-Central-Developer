Here's a simple **README** documentation that explains the configurations in your file:

---

# AL Development in Microsoft Dynamics 365 Business Central (Sandbox Setup)

This README explains the configuration file used to launch and debug AL extensions in a **Microsoft Dynamics 365 Business Central sandbox environment** using **Visual Studio Code**.

---

## Table of Contents
1. [Overview](#overview)
2. [Configuration Breakdown](#configuration-breakdown)
    - [Microsoft Cloud Sandbox](#microsoft-cloud-sandbox)
    - [AL: Generated Download Symbols Request](#al-generated-download-symbols-request)
3. [How to Use](#how-to-use)
4. [Additional Debugging Features](#additional-debugging-features)

---

## Overview

This project uses a `launch.json` file to configure and debug AL code within a sandbox environment in **Business Central**. The configuration supports debugging in a **sandbox**, launching a browser, and capturing SQL data.

### Key Features
- Launch and debug AL extensions in **Sandbox** environments.
- Automatically launch a browser window to display the sandbox.
- Capture and debug SQL-related issues.

---

## Configuration Breakdown

### 1. **Microsoft Cloud Sandbox**

This configuration is used to launch and debug your AL extension in a **cloud sandbox environment**.

```json
{
    "name": "Microsoft cloud sandbox",
    "request": "launch",
    "type": "al",
    "environmentType": "Sandbox",
    "environmentName": "SandboxTest",
    "startupObjectId": 22,
    "startupObjectType": "Page",
    "schemaUpdateMode": "ForceSync",
    "breakOnError": "All",
    "launchBrowser": true,
    "enableLongRunningSqlStatements": true,
    "enableSqlInformationDebugger": true
}
```

#### Key Fields:
- **name**: Descriptive name of the configuration, in this case, `Microsoft cloud sandbox`.
- **request**: Specifies the action; here, it's set to `launch` the sandbox.
- **type**: Defines that the configuration is for AL language development.
- **environmentType**: Set to `Sandbox`, indicating a test environment.
- **environmentName**: The name of the sandbox environment to connect to, in this case, `SandboxTest`.
- **startupObjectId**: Specifies the ID of the object that will open on startup (e.g., Page ID `22`).
- **startupObjectType**: The type of object to launch (in this case, a `Page`).
- **schemaUpdateMode**: `ForceSync` ensures that schema changes are synchronized without issues.
- **breakOnError**: When set to `All`, the debugger breaks on any error that occurs.
- **launchBrowser**: Set to `true`, it will automatically open a browser for the sandbox environment.
- **enableLongRunningSqlStatements**: Enables tracking of long-running SQL statements to optimize queries.
- **enableSqlInformationDebugger**: Allows debugging of SQL statements executed by the AL code.

### 2. **AL: Generated Download Symbols Request**

This configuration is generated automatically and is used to download the necessary symbols from the environment.

```json
{
    "name": "AL: Generated Download Symbols request",
    "request": "launch",
    "type": "al",
    "environmentType": "Sandbox",
    "environmentName": "SandboxTest",
    "tenant": "e04c56ea-acd1-4a65-b87d-a1eb9289afd4"
}
```

#### Key Fields:
- **name**: `AL: Generated Download Symbols request`, a system-generated request for symbol downloads.
- **request**: `launch` indicates that this configuration is for launching the process to download symbols.
- **environmentType**: The environment type is `Sandbox`.
- **environmentName**: The name of the sandbox environment, in this case, `SandboxTest`.
- **tenant**: Specifies the `tenant` identifier for the environment you're connected to.

---

## How to Use

1. **Open the `launch.json` file** in your AL project in Visual Studio Code.
2. Ensure that the sandbox environment name (`SandboxTest`) matches your sandbox's actual name.
3. To launch the debugger:
   - Click on the **Run and Debug** tab in VS Code (or press `Ctrl+Shift+D`).
   - Choose the **Microsoft cloud sandbox** configuration.
   - Click **Start Debugging** (`F5`).
4. A browser will automatically open with your sandbox, and debugging will be enabled.

---

## Additional Debugging Features

The configuration file offers additional features to enhance debugging:

- **Break on Error (`breakOnError: "All"`)**: The debugger will stop on any error encountered during execution, making it easier to track and fix issues.
- **SQL Debugging**: 
   - **Long-Running SQL Statements (`enableLongRunningSqlStatements: true`)**: This tracks SQL queries that take a long time to run, helping you optimize performance.
   - **SQL Information Debugger (`enableSqlInformationDebugger: true`)**: Helps capture detailed information about SQL queries executed during code execution.

---

## Conclusion

This setup allows for smooth development and debugging of AL extensions in a **Business Central sandbox environment**. It supports both cloud and sandbox testing, symbol downloading, and SQL performance tracking.

---

Feel free to adjust the configuration to match your environment and extension requirements.
