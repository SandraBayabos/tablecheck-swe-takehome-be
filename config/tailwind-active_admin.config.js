const execSync = require('child_process').execSync
const activeAdminPath = execSync('bundle show activeadmin', { encoding: 'utf-8' }).trim()

module.exports = {
  extend: {
    screens: {
      print: { raw: 'print' },
    },
  },
  theme: {
    fontFamily: {
      inter: ['Inter', 'sans-serif'],
      // roboto: ['Roboto', 'sans-serif'],
    },
  },
  content: [
    `${activeAdminPath}/vendor/javascript/flowbite.js`,
    `${activeAdminPath}/plugin.js`,
    `${activeAdminPath}/app/views/**/*.{arb,erb,html,rb,slim}`,
    './app/admin/**/*.{arb,erb,html,rb,slim}',
    './app/views/active_admin/**/*.{arb,erb,html,rb,slim}',
    './app/views/admin/**/*.{arb,erb,html,rb,slim}',
    './app/views/layouts/active_admin*.{erb,html,slim}',
    './app/assets/javascript/**/*.{js,ts,jsx,tsx}',
    './config/initializers/active_admin_addons.rb',
  ],
  darkMode: 'selector',
  plugins: [
    require('@tailwindcss/forms'),
    require(`${activeAdminPath}/plugin.js`),
  ],
}
