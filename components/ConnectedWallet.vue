<script setup lang="ts">
const walletAddress = useState('walletAddress', () => ref<string | null>(null))
const ensName = useState('ensName', () => ref<string | null>(null))
const avatarUrl = useState('avatarUrl', () => ref<string | null>(null))
</script>

<template>
  <div>
    <div class="font-bold">Connected Wallet:</div>
    {{ walletAddress }} {{ ensName }} {{ avatarUrl }}
  </div>
</template>
