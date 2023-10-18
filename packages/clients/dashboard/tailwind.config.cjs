const defaultTheme = require("tailwindcss/defaultTheme");

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    screens: {
      ...defaultTheme.screens,
    },
    fontSize: {
      ...defaultTheme.fontSize,
    },
    extend: {},
  },
  plugins: [require("daisyui")],
};
