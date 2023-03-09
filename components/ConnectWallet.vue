<script setup lang="ts">
import { BrowserProvider } from "ethers"

const walletAddress = useState('walletAddress', () => ref<string | null>(null))
const ensName = useState('ensName', () => ref<string | null>(null))
const avatarUrl = useState('avatarUrl', () => ref<string | null>(null))
const connecting = useState('connecting', () => ref(false))

function updateEns(walletAddress: string, provider: BrowserProvider) {
  provider.lookupAddress(walletAddress).then((result) => {
    ensName.value = result
  })

  provider.getAvatar(walletAddress).then((result) => {
    avatarUrl.value = result
  })
}

async function connectWallet() {
  if (process.client) {
    if (window.ethereum) {
      const provider = new BrowserProvider(window.ethereum)
      const signer = await provider.getSigner()
      walletAddress.value = await signer.getAddress()

      window.ethereum.on('accountsChanged', (accounts: string[]) => {
        walletAddress.value = accounts[0]
        updateEns(walletAddress.value, provider)
      })

      updateEns(walletAddress.value, provider)

      localStorage.setItem('connectedBefore', 'true')
    }
  }
}

onMounted(async () => {
  if (process.client) {
    connecting.value = true
    const connectedBefore = localStorage.getItem('connectedBefore')
    if (connectedBefore === 'true') {
      await connectWallet()
    }
    connecting.value = false
  }
})
</script>

<template>
  <div class="space-y-2">
    <div class="font-bold">Connect Wallet:</div>
    <button @click="connectWallet">
      <img src="https://snapshot.mypinata.cloud/ipfs/QmTE7VPXMhriKAobMWEiC5S3oG22p4G6AXGyGdNWQTQ3Fv" class="mr-3 w-8" alt="MetaMask Logo" />
      MetaMask
    </button>
    <button disabled>
      <img src="https://snapshot.mypinata.cloud/ipfs/QmZRVqHpgRemw13aoovP2EaQdVtjzXRaQGQZsCLXWaNn9x" class="mr-3 w-8" alt="WalletConnect Logo" />
      WalletConnect <span class="ml-auto font-light text-xs">(coming soon)</span>
    </button>
  </div>
</template>

<style scoped>
button {
  @apply flex w-full items-center rounded-md border py-2 px-4 font-bold transition-colors duration-300
}

button:not(:disabled) {
  @apply hover:bg-gray-100 focus:bg-gray-200
}

button:disabled {
  @apply opacity-50 cursor-not-allowed
}
</style>