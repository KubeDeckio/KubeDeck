---
layout: list
collection: "tools"
title: "Tools"
description: "Explore the tools available under KubeDeck to simplify and enhance your Kubernetes management."
permalink: "/tools/"
header_transparent: false

hero:
  enabled: true
  heading: "KubeDeck Tools"
  sub_heading: "Discover the tools that simplify Kubernetes management. From cleaning up your KubeConfig with KubeTidy to managing snapshots, restores, and comparisons with KubeSnapIt."
  text_color: "#FFFFFF"
  background_color: "#289dcd"
  background_gradient: false
  background_image: "/assets/images/gen/home/home.png"
  background_image_blend_mode: overlay # "overlay", "multiply", "screen"
  fullscreen_mobile: false
  fullscreen_desktop: false
  height: "600px"
  buttons:
    enabled: true
    list:
      - text: "View on GitHub "
        url: "https://github.com/kubedeckio"
        external: true
        fa_icon: "fab fa-github"
        size: large
        outline: true
        style: "light"

grid:
  collection: "tools"
  sort_by: "weight" # "date", "weight"
  columns: 2
  prevent_click: false

intro:
  enabled: true
  align: left
  image: false
  heading: "Making Kubernetes Easier"
  sub_heading: "At KubeDeck, our goal is to simplify Kubernetes management. Whether you’re cleaning up your KubeConfig file with KubeTidy or managing snapshots, restores, and comparisons with KubeSnapIt, we have the tools to help you stay organized and keep everything running smoothly."
  features:
    enabled: false
  buttons:
    enabled: true
    list:
      - text: "Explore Our GitHub "
        url: "https://github.com/kubedeckio"
        external: true
        fa_icon: "fab fa-github"
        size: "large"
        outline: false
        style: "primary"

outro:
  enabled: false
  align: left
  image: false
  heading: "Ready to simplify your workflow?"
  sub_heading: "Join the KubeDeck community today and start making your Kubernetes environment easier to manage."
  buttons:
    enabled: true
    list:
      - text: "Get Started"
        url: "/contact"
        external: false
        fa_icon: false
        size: "normal"
        outline: false
        style: "primary"
---