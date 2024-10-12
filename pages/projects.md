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
  sub_heading: "Discover the tools that make managing Kubernetes easier. From tidying up your KubeConfig with KubeTidy to handling snapshots with the upcoming KubeSnapIt."
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
  heading: "Making Kubernetes Easier"
  sub_heading: "At KubeDeck, our goal is to take the complexity out of Kubernetes management. Whether you’re cleaning up your messy KubeConfig file with KubeTidy or looking forward to snapshot management with KubeSnapIt, we’ve got the tools to help you keep things organized and running smoothly."
  features:
    enabled: false
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