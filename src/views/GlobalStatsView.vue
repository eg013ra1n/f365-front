
<script setup lang="ts">
  import { useF365Store } from "../stores/f365";

  import { ref, onMounted, computed } from "vue";
  import MasonryView from "@/components/MasonryView.vue";
  import PhotoCard from "@/components/PhotoCard.vue";
  const store = useF365Store();
  const getStats = computed(() => {
    return store.getGlobalStats;
  });
  let loading = ref(true);

  const getLoading = computed(() => {
    return loading.value;
  });

  const currentYear = new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).getFullYear()
  const startYear = 2019
  const years = Array.from(
      { length: currentYear - startYear + 1 },
      (_, index) => startYear + index
  )

  function setTitle() {
    document.title = 'F365 - Statistics'
  }
  onMounted(async () => {
    await store.getStats();
    setTitle();
    loading.value = false;
  });


</script>
<style>
.boxContainer {
  display: inline-flex;
  flex-direction: column;
  flex-wrap: nowrap;
  justify-content: flex-start;
  align-items: stretch;
  align-content: stretch;
}
.boxContainer a
{
  text-decoration: none;
  margin-bottom: 1rem;
}
.boxContainer a:nth-child(1) {
  display: block;
  flex-grow: 0;
  flex-shrink: 1;
  flex-basis: auto;
  align-self: auto;
  order: 0;
}

.boxContainer a:nth-child(2) {
  display: block;
  flex-grow: 0;
  flex-shrink: 1;
  flex-basis: auto;
  align-self: auto;
  order: 0;
}

.boxContainer > div
{
  text-decoration: none;
  margin-bottom: 1rem;
}
.boxContainer  > div:nth-child(1) {
  display: block;
  flex-grow: 0;
  flex-shrink: 1;
  flex-basis: auto;
  align-self: auto;
  order: 0;
}

.boxContainer  > div:nth-child(2) {
  display: block;
  flex-grow: 0;
  flex-shrink: 1;
  flex-basis: auto;
  align-self: auto;
  order: 0;
}
.css-1rato8u{
  position: absolute;
  display: flex;
  flex-direction: column;
  -webkit-box-align: center;
  align-items: center;
  -webkit-box-pack: center;
  justify-content: center;
  background-color: rgba(0, 0, 0, 0.1);
}
img {
  overflow-clip-margin: content-box;
  overflow: clip;
}
.lds-spinner {
   color: pink;
   display: inline-block;
   position: relative;
   width: 80px;
   height: 80px;
 }
.lds-spinner div {
  transform-origin: 40px 40px;
  animation: lds-spinner 1.2s linear infinite;
}
.lds-spinner div:after {
  content: " ";
  display: block;
  position: absolute;
  top: 3px;
  left: 37px;
  width: 6px;
  height: 18px;
  border-radius: 20%;
  background: #cef;
}
.lds-spinner div:nth-child(1) {
  transform: rotate(0deg);
  animation-delay: -1.1s;
}
.lds-spinner div:nth-child(2) {
  transform: rotate(30deg);
  animation-delay: -1s;
}
.lds-spinner div:nth-child(3) {
  transform: rotate(60deg);
  animation-delay: -0.9s;
}
.lds-spinner div:nth-child(4) {
  transform: rotate(90deg);
  animation-delay: -0.8s;
}
.lds-spinner div:nth-child(5) {
  transform: rotate(120deg);
  animation-delay: -0.7s;
}
.lds-spinner div:nth-child(6) {
  transform: rotate(150deg);
  animation-delay: -0.6s;
}
.lds-spinner div:nth-child(7) {
  transform: rotate(180deg);
  animation-delay: -0.5s;
}
.lds-spinner div:nth-child(8) {
  transform: rotate(210deg);
  animation-delay: -0.4s;
}
.lds-spinner div:nth-child(9) {
  transform: rotate(240deg);
  animation-delay: -0.3s;
}
.lds-spinner div:nth-child(10) {
  transform: rotate(270deg);
  animation-delay: -0.2s;
}
.lds-spinner div:nth-child(11) {
  transform: rotate(300deg);
  animation-delay: -0.1s;
}
.lds-spinner div:nth-child(12) {
  transform: rotate(330deg);
  animation-delay: 0s;
}
@keyframes lds-spinner {
  0% {
    opacity: 1;
  }
  100% {
    opacity: 0;
  }
}


</style>
<template>
  <main>
    <h3>Challenge Participants Statistics</h3>
    <div class="lds-spinner" v-if="getLoading"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>
    <div v-else>
      <p>Completed 365: <span v-for=" (item, index) in getStats.finishers" :key="`finishers_${item.username}`">
        <router-link :to="`/user/${item.username}`">{{ item.username }}</router-link> <router-link :to="`/user/${item.username}`" style="    display: inline-block;" class="uk-icon-link" uk-icon="album"></router-link><span v-if="index !== getStats.finishers.length - 1">, </span>
      </span> </p>
      <p>Days with maximum participants: <span v-for=" (item, index) in getStats.max_participants" :key="`mp_${item.day_number}`">
        <router-link :to="`/day/${item.day_number}`">Day {{item.day_number}}</router-link> ({{item.cnt}})<span v-if="index !== getStats.max_participants.length - 1">, </span>
      </span> </p>
      <p>Days with minimum participants: <span v-for=" (item, index) in getStats.least_participants" :key="`ml_${item.day_number}`">
        <router-link :to="`/day/${item.day_number}`">Day {{item.day_number}}</router-link> ({{item.cnt}})<span v-if="index !== getStats.least_participants.length - 1">, </span>
      </span> </p>
      <p>
        Winners by year:
        <template v-for="(year, index) in years" :key="year">
          <router-link :to="`/year/${year}`">{{ year }}</router-link>{{ index === years.length - 1 ? '' : ', ' }}
        </template>
      </p>
      <p>Longest streaks without skips: <span v-for=" (item, index) in getStats.longest_streaks" :key="`ls_${item.username}`">
        <router-link :to="`/user/${item.username}`">{{ item.username }}</router-link> <router-link :to="`/user/${item.username}`" style="    display: inline-block;" class="uk-icon-link" uk-icon="album"></router-link> ({{item.longest_sequence}})<span v-if="index !== getStats.longest_streaks.length - 1">, </span>
      </span> </p>
      <p>Longest top-3 streaks: <span v-for=" (item, index) in getStats.longest_leader" :key="`ll_${item.username}`">
        <router-link :to="`/user/${item.username}`">{{ item.username }}</router-link> <router-link :to="`/user/${item.username}`" style="    display: inline-block;" class="uk-icon-link" uk-icon="album"></router-link> ({{item.longest_sequence}})<span v-if="index !== getStats.longest_leader.length - 1">, </span>
      </span> </p>
      <p>Longest win streaks: <span v-for=" (item, index) in getStats.longest_win" :key="`lw_${item.username}`">
        <router-link :to="`/user/${item.username}`">{{ item.username }}</router-link> <router-link :to="`/user/${item.username}`" style="    display: inline-block;" class="uk-icon-link" uk-icon="album"></router-link> ({{item.longest_sequence}})<span v-if="index !== getStats.longest_win.length - 1">, </span>
      </span> </p>
      <p>Most wins: <span v-for=" (item, index) in getStats.most_win" :key="`mw_${item.username}`">
        <router-link :to="`/user/${item.username}`">{{ item.username }}</router-link> <router-link :to="`/user/${item.username}`" style="    display: inline-block;" class="uk-icon-link" uk-icon="album"></router-link> ({{item.cnt}})<span v-if="index !== getStats.most_win.length - 1">, </span>
      </span> </p>
      <p>Most top-3 finishes: <span v-for=" (item, index) in getStats.most_leader" :key="`mw_${item.username}`">
        <router-link :to="`/user/${item.username}`">{{ item.username }}</router-link> <router-link :to="`/user/${item.username}`" style="    display: inline-block;" class="uk-icon-link" uk-icon="album"></router-link> ({{item.cnt}})<span v-if="index !== getStats.most_leader.length - 1">, </span>
      </span></p>
      <p>Best upvotes ratio: <span v-for=" (item, index) in getStats.average_upvotes" :key="`mw_${item.username}`">
        <router-link :to="`/user/${item.username}`">{{ item.username }}</router-link> <router-link :to="`/user/${item.username}`" style="    display: inline-block;" class="uk-icon-link" uk-icon="album"></router-link> ({{item.cnt}})<span v-if="index !== getStats.average_upvotes.length - 1">, </span>
      </span></p>
      <p>Most photos: <span v-for=" (item, index) in getStats.most_photos" :key="`mw_${item.username}`">
        <router-link :to="`/user/${item.username}`">{{ item.username }}</router-link> <router-link :to="`/user/${item.username}`" style="    display: inline-block;" class="uk-icon-link" uk-icon="album"></router-link> ({{item.cnt}})<span v-if="index !== getStats.most_photos.length - 1">, </span>
      </span></p>
      <p>Average upvotes per photo - {{getStats.avgs.upvotes_avg}} (median {{getStats.avgs.upvotes_median}})</p>
      <p>Average downvotes per photo - {{getStats.avgs.downvotes_avg}} (median {{getStats.avgs.downvotes_median}})</p>
      <p>Average photos per day - {{getStats.avgs.count_avg}}</p>
      <p>Average photos per participant - {{getStats.avgs.count_user_avg}} (median {{getStats.avgs.count_user_median}})</p>
      <p>Total participants - {{getStats.avgs.count_user}}</p>
      <p>Total photos - {{getStats.avgs.total_count}}</p>
      <h4>Photos with most upvotes:</h4>
      <div class="uk-flex-row uk-flex" uk-lightbox="animation: slide; toggle: .lightbox-link">
      <div class="uk-width-1-3 uk-padding-small" v-for="item in getStats.best_works" >
        <PhotoCard :item="item" :key="item.message_id" :show_detail="true"></PhotoCard>
      </div>
      </div>
      <h4>Photos with most downvotes:</h4>
      <div class="uk-flex-row uk-flex" uk-lightbox="animation: slide; toggle: .lightbox-link">
        <div class="uk-width-1-3 uk-padding-small" v-for="item in getStats.worst_works" >
          <PhotoCard :item="item" :key="item.message_id" :show_detail="true"></PhotoCard>
        </div>
      </div>
      <h4>Most controversial photos:</h4>
      <div class="uk-flex-row uk-flex" uk-lightbox="animation: slide; toggle: .lightbox-link">
        <div class="uk-width-1-3 uk-padding-small" v-for="item in getStats.controversial_works" >
          <PhotoCard :item="item" :key="item.message_id" :show_detail="true"></PhotoCard>
        </div>
      </div>
    </div>
  </main>
</template>
