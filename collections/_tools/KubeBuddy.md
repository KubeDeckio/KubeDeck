---
title: KubeBuddy powered by KubeDeck
description: Run deep health checks, RBAC audits, and AKS validation across your Kubernetes clusters—all from your terminal.
layout: tool
tags:
  - kubernetes
  - diagnostics
  - powershell
  - health-check
  - aks
---

# Kubernetes Looks Healthy. It’s Not.

**KubeBuddy powered by KubeDeck** runs full-cluster diagnostics from your terminal—health checks, RBAC audits, AKS config validation—without installing anything inside your cluster.

## What You Get

- **Cluster Health Checks**  
  Check node status, resource pressure, and crashing pods. Identify taints, unready nodes, and misbehaving workloads.

- **Security and RBAC Analysis**  
  Find risky roles, missing resource limits, and insecure configurations.

- **Workload and Resource Monitoring**  
  Spot failing Jobs, stuck CronJobs, broken volumes, and unreachable services.

- **AKS Best Practice Validation**  
  Use built-in Azure CLI integration to scan for Microsoft-recommended settings.

- **One-Click Reports**  
  Run all checks from a PowerShell menu. Get HTML and plain-text outputs for audits, debugging, or compliance reviews.

## Why Use KubeBuddy?

- No agents, no sidecars, no dashboards  
- Simple CLI setup (PowerShell 7+)  
- Works from CI runners, local shells, or secure admin environments  
- Output in under 2 minutes  
- Ideal for audits, incident reviews, or daily check-ins

## Run KubeBuddy in Seconds

```powershell
Install-Module -Name KubeBuddy -Repository PSGallery -Scope CurrentUser
```

KubeBuddy

Works on Windows, macOS, and Linux with PowerShell 7+.


**KubeBuddy powered by KubeDeck** helps you catch what probes and dashboards miss.  
No noise. Just answers.

[View Documentation →](https://kubebuddy.kubedeck.io/docs/)