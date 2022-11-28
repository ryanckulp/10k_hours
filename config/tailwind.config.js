const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Noto Sans Display', ...defaultTheme.fontFamily.sans],
        title: ['WC ROUGHTRAD Bta', 'Walter Turncoat', ...defaultTheme.fontFamily.sans]
      },
      colors: { // custom color palette for branding
        'primary': 'rgb(79, 70, 229)',
        'primary-hover': {
          '700': '#a4411c',
          '500': '#EA9A72'
        },
        'brand-yellow': '#f7eb73',
        'brand-yellow-light': '#fff8af',
        'brand-blue': '#93caf0',
        'brand-blue-light': '#d1eafe',
        'brand-orange': '#efa75d',
        'brand-orange-light': '#f4c8a1',
      },
      screens: {
        'sm': '800px' // turns posts#index to single column sooner than usual
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
