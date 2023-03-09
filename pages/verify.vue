<script setup lang="ts">
import { ArrowSmallLeftIcon } from "@heroicons/vue/24/outline";

const { public: { clientId } } = useRuntimeConfig()
const route = useRoute()

type GithubUser = {
  login: string
  avatar_url: string
  name: string
  node_id: string
}

const accessToken = ref<string | null>(null)
const githubUser = ref<GithubUser | null>(null)
const gettingAccessToken = ref(false)
const gettingUserData = ref(false)

onMounted(async () => {
  if (route.query.code) {
    gettingAccessToken.value = true
    const accessTokenInfo = await $fetch<{ access_token: string }>(
      '/auth/get-access-token',
      { query :{ code: route.query.code }}
    )
    
    await new Promise((resolve) => setTimeout(resolve, 2000))
    gettingAccessToken.value = false
  
    if (accessTokenInfo) {
      accessToken.value = accessTokenInfo.access_token

      gettingUserData.value = true
      await new Promise((resolve) => setTimeout(resolve, 2000))
      githubUser.value = await $fetch<GithubUser>(`https://api.github.com/user`, {
        headers: {
          Authorization: `bearer ${accessToken.value}`
        }
      })
      gettingUserData.value = false
    }
  }
})
</script>

<template>
  <div class="mx-auto max-w-md">
    <div class="divide-y divide-gray-300/50">
      <div class="pb-8 text-base leading-7 text-gray-600">
        <div class="flex items-center space-x-2 mb-3">
          <NuxtLink to="/" class="hover:bg-gray-50 transition-colors p-2 rounded-full inline-block">
            <ArrowSmallLeftIcon class="h-6 w-6 text-gray-500" />
          </NuxtLink>
          <h1 class="text-2xl font-bold">
            Verify your GitHub account.
          </h1>
        </div>
        <p class="text-lg">Connect with your GitHub account and an Ethereum wallet and confirm the transaction.</p>
        <div class="py-5">
          <Transition mode="out-in">
            <div v-if="githubUser" class="flex items-center justify-center">
              <img :src="githubUser.avatar_url" class="mr-5 w-20 rounded-full border-4 p-1" :alt="githubUser.login" />
              <div>
                <div class="text-4xl font-bold text-gray-800">{{ githubUser.name || githubUser.login }}</div>
                <div class="text-gray-500">{{ githubUser.node_id }}</div>
              </div>
            </div>
            <a
              v-else
              :href="`https://github.com/login/oauth/authorize?client_id=${clientId}`"
              class="block text-xl w-full text-center rounded-md bg-green-500 mt-4 mb-1 p-4 font-bold text-white transition-colors duration-300 hover:bg-green-600 focus:bg-green-700"
              :class="{ 'opacity-50 hover:bg-green-500 cursor-not-allowed': gettingAccessToken || gettingUserData }"
            >
              <span v-if="gettingAccessToken">
                Obtaining Access Token...
              </span>
              <span v-else-if="gettingUserData">
                Fetching User Data...
              </span>
              <span v-else>
                Connect with GitHub
              </span>
            </a>
          </Transition>
        </div>
        <div class="space-y-2">
          <div class="font-bold">Connect Wallet:</div>
          <button class="flex w-full items-center rounded-md border py-2 px-4 font-bold transition-colors duration-300 hover:bg-gray-100 focus:bg-gray-200">
            <img src="https://snapshot.mypinata.cloud/ipfs/QmTE7VPXMhriKAobMWEiC5S3oG22p4G6AXGyGdNWQTQ3Fv" class="mr-3 w-8" alt="MetaMask Logo" />
            MetaMask
          </button>
          <button class="flex w-full items-center rounded-md border py-2 px-4 font-bold transition-colors duration-300 hover:bg-gray-100 focus:bg-gray-200">
            <img src="https://snapshot.mypinata.cloud/ipfs/QmZRVqHpgRemw13aoovP2EaQdVtjzXRaQGQZsCLXWaNn9x" class="mr-3 w-8" alt="WalletConnect Logo" />
            WalletConnect
          </button>
        </div>
      </div>
      <div class="pt-8 space-y-3 text-sm text-gray-500 ">
        <p>
          By using this service you trust <a href="#" class="text-sky-500">me</a> as the oracle provider. The verification will be processed by <a href="#" class="text-sky-500">this workflow</a>. Feel free to double-check everything before proceeding.
        </p>
        <p>
          <a
            href="https://tailwindcss.com/docs"
            class="text-sky-500 hover:text-sky-600"
          >
            Learn more
          </a>
          about interacting with Ethereum and other Blockchains in your GitHub workflows.
        </p>
        <p class="text-right">
          <a
            href="https://twitter.com/intent/tweet?text=@thecodelander Wow! This project is amazing!"
            target="_blank"
            class="text-sky-500 hover:text-sky-600"
          >
            Give feedback &rarr;
          </a>
        </p>
      </div>
    </div>
  </div>
</template>
