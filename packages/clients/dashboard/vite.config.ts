/// <reference types="vite/client" />
/// <reference types="vitest" />

import { defineConfig } from "vite";

import svgr from "vite-plugin-svgr";
import react from "@vitejs/plugin-react";
import mkcert from "vite-plugin-mkcert";
import { VitePWA } from "vite-plugin-pwa";
import { nodePolyfills } from "vite-plugin-node-polyfills";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react({
      jsxImportSource: "@emotion/react",
      babel: {
        plugins: ["@emotion/babel-plugin"],
      },
    }),
    mkcert(),
    svgr({
      svgrOptions: {
        namedExport: "RC",
      },
    }),
    VitePWA({
      includeAssets: [
        "assets/favicon.ico",
        "assets/logo.svg",
        "assets/logo-64.png",
        "assets/logo-310.png",
        "assets/dashboards.png",
        "assets/world.png",
        "assets/profile.png",
      ],
      injectRegister: "auto",
      registerType: "autoUpdate",
      devOptions: {
        enabled: true,
      },
      workbox: {
        globPatterns: ["**/*.{js,css,html,ico,png,svg}"],
      },
      manifest: {
        name: "Art House Dashboard",
        short_name: "Art House Dashboard",
        icons: [
          {
            src: "assets/logo-64.png",
            sizes: "64x64",
            type: "image/png",
          },
          {
            src: "assets/logo-310.png",
            sizes: "192X192",
            type: "image/png",
          },
          {
            src: "assets/logo-310.png",
            sizes: "512x512",
            type: "image/png",
          },
        ],
        start_url: "/",
        scope: "/",
        display: "fullscreen",
        orientation: "portrait-primary",
        theme_color: "#e9e3dd",
        background_color: "#191c1c",
        shortcuts: [
          {
            name: "Dashboards",
            description: "Manage your Synths and Waves",
            url: "/dashboards",
            icons: [
              {
                src: "assets/dashboards.png",
                sizes: "64x64",
                type: "image/png",
              },
            ],
          },
          {
            name: "World",
            description: "View nearby Synths and Waves",
            url: "/world",
            icons: [
              {
                src: "assets/world.png",
                sizes: "64x64",
                type: "image/png",
              },
            ],
          },
          {
            name: "Profile",
            description: "View accomplishments and stats",
            url: "/profile",
            icons: [
              {
                src: "assets/profile.png",
                sizes: "64x64",
                type: "image/png",
              },
            ],
          },
        ],
        related_applications: [
          {
            platform: "webapp",
            url: "https://dashboard.waves.app/manifest.webmanifest",
          },
        ],
        categories: ["entertainment", "music", "social"],
      },
    }),
    nodePolyfills({
      // To exclude specific polyfills, add them to this list.
      exclude: [
        "fs", // Excludes the polyfill for `fs` and `node:fs`.
      ],
      // Whether to polyfill specific globals.
      globals: {
        Buffer: true, // can also be 'build', 'dev', or false
        global: true,
        process: true,
      },
      // Whether to polyfill `node:` protocol imports.
      protocolImports: true,
    }),
  ],
  server: {
    port: 3002,
  },
});
