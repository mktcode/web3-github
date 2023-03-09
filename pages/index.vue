<template>
  <div class="mx-auto max-w-md">
    <div class="divide-y divide-gray-300/50">
      <div class="space-y-3">
        <div class="relative">
          <button class="absolute left-2 top-[9px] rounded-xl bg-sky-100 py-2 px-4 font-bold text-sky-400 hover:bg-sky-400 hover:text-sky-50">USDC</button>
          <button class="absolute right-14 top-[9px] flex flex-col rounded-xl py-1 px-3 text-xs font-bold leading-4 text-sky-400 hover:bg-sky-100 hover:text-sky-400">
            <span>Balance</span>
            <span class="font-normal">2.345 ETH</span>
          </button>
          <input type="number" class="w-full rounded-2xl border bg-gray-50 py-3 pl-24 pr-5 text-2xl shadow-inner" placeholder="1.0" />
        </div>
        <div class="relative">
          <button class="absolute right-2 top-[9px] rounded-xl bg-sky-100 py-2 px-4 font-bold text-sky-400 hover:bg-sky-400 hover:text-sky-50">paste</button>
          <input type="text" class="w-full rounded-2xl border bg-gray-50 px-5 py-3 text-2xl shadow-inner" placeholder="Recipient address" />
        </div>
        <div class="flex space-x-3">
          <input type="date" class="rounded-2xl border bg-gray-50 px-5 py-3 text-2xl shadow-inner" />
          <input type="date" class="rounded-2xl border bg-gray-50 px-5 py-3 text-2xl shadow-inner" />
        </div>
        <div class="flex items-center justify-center space-x-3 text-center text-xs text-gray-400">
          <div>~25 wei/sec</div>
          <div>~0.025 gwei/min</div>
          <div>~0.0025 eth/h</div>
          <div>~0.050 eth/day</div>
        </div>
        <button class="w-full rounded-2xl bg-sky-400 px-5 py-2 text-2xl text-sky-50 shadow-md">Start stream</button>
      </div>
      <div class="mt-8 pt-3 text-right text-sm text-gray-500">
        <NuxtLink
          href="/verify"
          class="text-sky-500 hover:text-sky-600"
        >
          Verify your GitHub account &rarr;
        </NuxtLink>
      </div>
    </div>
  </div>
</template>