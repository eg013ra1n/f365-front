<script setup lang="ts">
import { useF365Store } from "@/stores/f365";
import { computed, onMounted, watch } from "vue";
import PhotoCard from "@/components/PhotoCard.vue";

const props = defineProps(['color'])
const store = useF365Store();

const getColored = computed(() => {
  return store.getColored;
});

onMounted(() => {
  store.getColor(props.color);
});

watch(
  () => props.color,
  async () => {
    store.getColor(props.color);
  }
);
</script>

<template>
  <div class="uk-container uk-margin-top">
    <h1>Color: {{ color }}</h1>
    <div class="uk-grid-small uk-child-width-1-2 uk-child-width-1-3@s uk-child-width-1-4@m" uk-grid>
      <div v-for="item in getColored" :key="item.id">
        <PhotoCard :item="item" :show_detail="true" :for_calendar="false" />
      </div>
    </div>
  </div>
</template>
