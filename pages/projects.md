---
layout: list
collection: "projects"
title: "Tools"
description: "Explore the tools available under KubeDeck to simplify and enhance your Kubernetes management."
permalink: "/projects/"
header_transparent: false

hero:
  enabled: true
  heading: "KubeDeck Tools"
  sub_heading: "Discover the powerful tools that make Kubernetes management easier. From automatic resource cleanup with KubeTidy to snapshot management with the upcoming KubeSnapIt."
  text_color: "#FFFFFF"
  background_color: false
  background_gradient: false
  background_image: "/assets/images/gen/home/home.png"
  background_image_blend_mode: overlay # "overlay", "multiply", "screen"
  fullscreen_mobile: false
  fullscreen_desktop: false
  height: "600px"
  buttons:
    enabled: true
    list:
      - text: "View on GitHub"
        url: "https://github.com/kubedeck"
        external: true
        fa_icon: "fab fa-github"
        size: large
        outline: true
        style: "light"

grid:
  collection: "projects"
  sort_by: "weight" # "date", "weight"
  columns: 2
  prevent_click: false

intro:
  enabled: true
  align: left
  image: false
  heading: "Powerful Kubernetes Tools"
  sub_heading: "KubeDeck offers tools designed to make Kubernetes management easier, more efficient, and reliable. Whether it’s cleaning up old resources or managing snapshots, we have the tools to keep your clusters optimized."
  features:
    enabled: false
    list:
      - text: "All tools are open source and available on GitHub"
        fa_icon: "fab fa-github"
  buttons:
    enabled: true
    list:
      - text: "Explore Our GitHub"
        url: "https://github.com/kubedeck"
        external: true
        fa_icon: "fab fa-github"
        size: "large"
        outline: false
        style: "primary"

outro:
  enabled: false
  align: left
  image: false
  heading: "Ready to get started?"
  sub_heading: "Join the KubeDeck community and start optimizing your Kubernetes environment today."
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
