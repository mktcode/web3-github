// https://v3.nuxtjs.org/api/configuration/nuxt.config
export default defineNuxtConfig({
  css: ['~/assets/css/main.css'],
  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },
  runtimeConfig: {
    clientSecret: process.env.NUXT_CLIENT_SECRET,
    public: {
      clientId: '75d8efe8c8f8c795e796',
    }
  }
})
