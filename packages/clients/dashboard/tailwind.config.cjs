const defaultTheme = require("tailwindcss/defaultTheme");

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    screens: {
      xs: "475px",
      ...defaultTheme.screens,
    },
    fontSize: {
      xxxs: "0.4rem",
      xxs: "0.6rem",
      ...defaultTheme.fontSize,
    },
    extend: {},
  },
  plugins: [require("daisyui")],
};
