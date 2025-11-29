<template>
  <div class="about">
    <h3>About</h3>
    <div class="uk-text-default">
      <p>Frontend for Telegram Channel - <a href="https://t.me/photo_cyprus" target="_blank">@photo_cyprus</a></p>
      <p>@photo_cyprus is a channel for participants of the <a href="https://t.me/cyprus_photo" target="_blank">Cyprus Photo Chat</a>, where photos of the 365 project are published with the following rules:</p>
      <ul>
        <li>You can only submit one photo per day</li>
        <li>You need to send a photo taken on the same day (give or take, read more details in the bot)</li>
        <li>The best photos are selected by voting in the channel</li>
        <li>Voting lasts one day and the next day</li>
      </ul>
      <p>This frontend was created for more convenient viewing of works by different authors. All rights to photos belong to their authors, links to original messages and author accounts (when possible) are provided.</p>
      <p><router-link to="/stats">Statistics</router-link></p>

      <p>Send all complaints to <a href="https://t.me/VilenSharifov" target="_blank">@VilenSharifov</a></p>
      <p>Original Frontend and API is written by <a href="https://t.me/zyuhel" target="_blank">@zyuhel</a></p>
      
      <hr>
      <h4>How to participate?</h4>
      <ol>
        <li>Join the <a href="https://t.me/cyprus_photo" target="_blank">Cyprus Photo Chat</a>. Come in, introduce yourself, show your photos.</li>
        <li>Write to the bot - <a href="https://t.me/CyprusPhotoBot" target="_blank">@CyprusPhotoBot</a></li>
        <li>Send a photo taken on the exact day</li>
        <li>Frustrate</li>
        <li>Get better</li>
        <li>Enjoy</li>
      </ol>
    </div>
  </div>
</template>

<style>

</style>
<script setup>
import {onMounted} from "vue";
function setTitle() {
  document.title = 'CY365 - About'
}
onMounted(async () => {

  setTitle()
});
</script>
