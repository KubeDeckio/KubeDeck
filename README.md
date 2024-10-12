
# KubeDeck

**KubeDeck** is a growing collection of powerful, easy-to-use tools designed to simplify and streamline Kubernetes operations. It includes tools like **KubeTidy** and **KubeSnap**, with more tools planned to help Kubernetes administrators and developers manage their clusters with greater efficiency.

### Tools in the KubeDeck Collection

1. **KubeTidy**: 
   - A PowerShell tool to help clean up and organize Kubernetes configuration files (`kubeconfig`). KubeTidy helps you manage and maintain tidy configurations across multiple environments, making it easier to navigate and switch between them.

2. **KubeSnap**:
   - A lightweight PowerShell tool that allows users to take snapshots of their Kubernetes cluster configurations in **YAML** format, compare snapshots over time, and restore previous configurations if necessary. KubeSnap is great for detecting configuration drift, troubleshooting, or rolling back to known-good states.

### Upcoming Tools

KubeDeck is designed to be a comprehensive suite of tools, and more tools will be added in the future. Each tool is focused on solving specific Kubernetes challenges while maintaining ease of use and integration with Kubernetes workflows.

### Why KubeDeck?

KubeDeck's tools are built with a focus on:
- **Simplicity**: Each tool is designed to solve specific problems with minimal configuration and straightforward usage.
- **PowerShell-based**: Built with PowerShell, ensuring cross-platform support on Windows, macOS, and Linux.
- **Efficiency**: Streamline common Kubernetes operations, such as managing configuration files, capturing snapshots, and more, to save time and effort.
- **Modularity**: Pick and choose the tools you need from the KubeDeck suite, with each tool able to stand alone or work together as part of a broader toolset.

### Installation

Each KubeDeck tool will be available through the PowerShell Gallery and Krew (for Kubernetes plugins).

To install **KubeTidy**:
```powershell
Install-Module -Name KubeTidy
```

To install **KubeSnap**:
```powershell
Install-Module -Name KubeSnap
```

### Future Plans

KubeDeck will continue to evolve with more tools that cater to specific Kubernetes use cases. Stay tuned for updates as we release additional functionality to enhance your Kubernetes operations!

### Contributing

We welcome contributions to KubeDeck! If you have suggestions for improvements or new tools to add to the collection, feel free to fork the repo, make changes, and submit a pull request.

### License

This project is licensed under the MIT License.