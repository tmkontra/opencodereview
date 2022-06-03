// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: ['./js/**/*.js', '../lib/*_web.ex', '../lib/*_web/**/*.*ex'],
  theme: {
    extend: {
      colors: {
        purple: {DEFAULT: "#706fd3"},
        swan: {DEFAULT: "#f7f1e3"},
        stone: {DEFAULT: "#aaa69d"},
        devilblue: {DEFAULT: "#227093"},
        desert: {DEFAULT: "#ccae62"},
        pumpkin: {DEFAULT: "#ff793f"},
        luckypoint: {DEFAULT: '#2c2c54'},
        newt: {DEFAULT: "#b33939"},
        green: {DEFAULT: "#33d9b2"},
        mandarin: {DEFAULT: "#ffb142"}  
      }
    }
  },
  plugins: [require('@tailwindcss/forms')]
};
