<script setup lang="ts">
const { public: { clientId } } = useRuntimeConfig()

const router = useRouter()
const route = useRoute()

const accessToken = useState('accessToken', () => ref<string | null>(null))
const githubUser = useState('githubUser', () => ref<GithubUser | null>(null))
const gettingAccessToken = useState('gettingAccessToken', () => ref(false))
const gettingUserData = useState('gettingUserData', () => ref(false))

onMounted(async () => {
  if (route.query.code) {
    gettingAccessToken.value = true
    const accessTokenInfo = await $fetch<{ access_token: string }>(
      '/auth/get-access-token',
      { query :{ code: route.query.code }}
    )
    router.replace({ query: {} })
    
    await new Promise((resolve) => setTimeout(resolve, 1000))
    gettingAccessToken.value = false
  
    if (accessTokenInfo) {
      accessToken.value = accessTokenInfo.access_token

      gettingUserData.value = true
      await new Promise((resolve) => setTimeout(resolve, 1000))
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
        class="flex items-center text-xl w-full text-center rounded-md bg-green-500 mt-4 mb-1 py-4 px-6 font-bold text-white transition-colors duration-300 hover:bg-green-600 focus:bg-green-700"
        :class="{ 'opacity-50 hover:bg-green-500 cursor-not-allowed': gettingAccessToken || gettingUserData }"
      >
        <LoadingSpinner v-if="gettingAccessToken || gettingUserData" class="h-6 w-6" />
        <div class="grow text-center">
          <span v-if="gettingAccessToken">
            Obtaining Access Token...
          </span>
          <span v-else-if="gettingUserData">
            Fetching User Data...
          </span>
          <span v-else>
            Connect with GitHub
          </span>
        </div>
      </a>
    </Transition>
  </div>
</template>