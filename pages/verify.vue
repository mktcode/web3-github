<script setup lang="ts">
import { ArrowSmallLeftIcon } from "@heroicons/vue/24/outline";

const walletAddress = useState('walletAddress', () => ref<string | null>(null))
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
        <ConnectGithub />
        <ConnectedWallet v-if="walletAddress" />
        <ConnectWallet v-else />
      </div>
      <Disclaimer />
    </div>
  </div>
</template>
