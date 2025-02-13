---
layout: home
permalink: "/"
title: "KubeDeck"
description: "KubeDeck helps you manage Kubernetes operations efficiently with tools like KubeTidy for resource cleanup and KubeSnapIt for snapshots."
header_transparent: false
meta_title: KubeDeck - Simplifying Kubernetes Management

hero:
  enabled: true
  heading: "KubeDeck"
  sub_heading: "The ultimate platform for simplifying Kubernetes management, featuring tools like KubeTidy and KubeSnapIt to automate resource cleanup and snapshots."
  text_color: "#FFFFFF"
  background_color: "#0071ff"
  background_gradient: false
  background_image: "/assets/images/gen/home/home.png"
  background_image_blend_mode: false # "overlay", "multiply", "screen"
  fullscreen_mobile: true
  fullscreen_desktop: false
  height: "660px"
  buttons:
    enabled: false
    list:
      - text: "Learn More"
        url: "#intro"
        external: false
        fa_icon: false
        size: large # "small", "normal", "large"
        outline: false
        style: "light" # "light", "dark", "primary"
      - text: "Get Started"
        url: "/contact"
        external: false
        fa_icon: false
        size: large
        outline: false
        style: "light"

services:
  enabled: false
  heading: "Our Core Tools"
  sub_heading: "KubeDeck streamlines Kubernetes management with powerful tools."
  limit: 2
  sort: "weight" # 'date'
  view_more_button_text: "View All Tools"
  view_more_button_link: "/services"
  prevent_click: false
  list:
    - title: "KubeTidy"
      desc: "Automatically clean up unused or outdated Kubernetes resources with KubeTidy, ensuring an efficient and optimized environment."
      icon: fas fa-broom
    - title: "KubeSnapIt"
      desc: "Easily create and manage snapshots of Kubernetes objects to safeguard your infrastructure with KubeSnapIt."
      icon: fas fa-camera

intro:
  enabled: true
  align: left
  image: "/assets/images/gen/home/KubeDeck.png"
  heading: "Effortless Kubernetes Management"
  sub_heading: "With KubeDeck, managing your Kubernetes environment is easier than ever. Use KubeTidy to automatically clean up your KubeConfig file, and leverage KubeSnapIt, our powerful tool for seamless snapshot, restore, and comparison management in your Kubernetes clusters. Now, with KubeDeck Launcher, you can access both KubeTidy and KubeSnapIt through a single, intuitive PowerShell-based UI, streamlining your Kubernetes operations even further."
  features:
    enabled: true
    list:
      - text: "Configure the homepage sections in front-matter."
        fa_icon: "fas fa-check"
  buttons:
    enabled: true
    list:
      - text: "More Info"
        url: "/about"
        external: false
        fa_icon: ""
        size: large
        outline: false
        style: "primary"

tools:
  enabled: true
  heading: "Our Tools"
  sub_heading: "Discover how KubeDeck simplifies Kubernetes management with powerful, easy-to-use tools for optimizing and maintaining your clusters."
  limit: 2
  columns: 2
  sort: "weight" # 'date'
  view_more_button_text: "View All Tools"
  view_more_button_link: "/tools"
  prevent_click: false

outro:
  enabled: true
  align: center
  image: false
  heading: Join the Deck
  sub_heading: "Join the KubeDeck community on GitHub and help us optimize and manage Kubernetes environments together. Contribute, collaborate, and make Kubernetes management easier for everyone."
  buttons:
    enabled: true
    list:
      - text: "Get Involved"
        url: "https://github.com/KubeDeckio"
        external: true
        fa_icon: "fas fa-rocket"
        size: "large"
---

