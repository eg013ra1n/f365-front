<script setup lang="ts">
  import { useF365Store } from "../stores/f365";

  import {ref, onMounted, computed, watch} from "vue";
  const props = defineProps(['day'])
  console.log(props.day)
  const store = useF365Store();
  const getEntries = computed(() => {
    return store.getEntriesForDay;
  });


  const images = computed(() => {
    console.log(store.getImagesFromEntries)
    return store.getImagesFromEntries
  });
  const entries = computed(() => {
    return store.currentDay;
  });
  const dateObject = computed(() => {
    console.log(dateObject)
    if (!getEntries.value.length) return {"day":'', "date":''};
    let firstElement = getEntries.value.find(x=>x!==undefined);
    return {
      'day':  firstElement.day_number,
      'date': firstElement.date.substring(0,10)
    };
  });
  const voteFinished = computed( () => {
    if (!getEntries.value.length) return true;
    for (let item of getEntries.value) {
        if (item.place) {
          return true;
        }
      }
      return false;
  });
  function setTitle() {
    document.title = 'F365 - Day ' + props.day
  }
  onMounted(() => {
    store.getForDay(props.day);
    setTitle()
  });
  watch(
      () => props.day,
      async newId => {
        store.getForDay(props.day);
        setTitle()
      }
  )

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


</style>
<template>
  <main>
    <h3><router-link :to="`/day/${dateObject.day-1}`" v-if="dateObject.day>1">&lt;</router-link><span v-else>&lt;</span> Day {{dateObject.day}} (<router-link :to="`/year/${parseInt(dateObject.date.split('-')[0])}`">{{dateObject.date.split('-')[0]}}</router-link>-<router-link :to="`/month/${parseInt(dateObject.date.split('-')[0])}-${(dateObject.date.split('-')[1])}`">{{dateObject.date.split('-')[1]}}</router-link>-{{dateObject.date.split('-')[2]}}) <router-link :to="`/day/${parseInt(dateObject.day)+1}`" v-if="voteFinished || dateObject.day<3">&gt;</router-link><span v-else>&gt;</span> <span v-if="!voteFinished && dateObject.day > 2"> - Voting not finished yet</span><span v-else-if="!voteFinished"> - Voting was not conducted</span></h3>
    <div class='boxContainer' uk-lightbox="animation: slide; toggle: .lightbox-link" >
      <div v-for="silentboxItem in images" :key="silentboxItem.original.message_id">
        <p><span v-if="voteFinished"><span v-if="silentboxItem.original.place">{{ silentboxItem.original.place  }}. </span><span v-else>- </span></span><span v-if="silentboxItem.original.username[0]!=='@'">{{ silentboxItem.original.username }}</span><span v-else><a style="    display: inline-block;" :href="`https://t.me/${silentboxItem.original.username.substring(1)}`" target="_blank">{{silentboxItem.original.username}}</a></span> <router-link :to="`/user/${silentboxItem.original.username}`" style="    display: inline-block;" class="uk-icon-link" uk-icon="album"></router-link> <span v-if="silentboxItem.original.upvotes">{{silentboxItem.original.upvotes}}👍 </span><span v-if="silentboxItem.original.upvotes && silentboxItem.original.downvotes"> / </span><span v-if="silentboxItem.original.downvotes">{{silentboxItem.original.downvotes}}💩</span> <a :href="`https://t.me/factory365/${silentboxItem.original.message_id}`" target="_blank">Post in channel</a></p>
          <a class="lightbox-link" :href="silentboxItem.src" :data-type="(silentboxItem.original.is_video)?'video':'image'" :data-caption="`<span>Day ${silentboxItem.original.day_number} - </span><span>${silentboxItem.original.username}</span>, <a href='https://t.me/factory365/${silentboxItem.original.message_id}' >Post in channel</a>`">
            <video v-if="silentboxItem.original.is_video" :src="silentboxItem.src" :width="500" controls="true"></video>
            <img v-else
            loading='lazy'
            :src="silentboxItem.src"
            :width="500"
          >

          </a>
<hr>
          </div>
    </div>
  </main>
</template>
