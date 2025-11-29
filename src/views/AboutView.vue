<template>
  <div class="about">
    <h3>About</h3>
    <div class="uk-text-default">
      <p>Unofficial frontend for Telegram Channel - <a href="https://t.me/factory365" target="_blank">@factory365</a></p>
      <p>@factory365 is a channel for participants of the <a href="https://t.me/factory_chat" target="_blank">Factory Chat</a>, where photos of the 365 project are published with the following rules:</p>
      <ul>
        <li>you can only submit one photo per day</li>
        <li>you need to send a photo taken on the same day (give or take, read more details in the bot)</li>
        <li>the best photos are selected by voting in the channel</li>
        <li>voting lasts one day and the next day</li>
      </ul>
      <p>This frontend was created for more convenient viewing of works by different authors. All rights to photos belong to their authors, links to original messages and author accounts (when possible) are provided.</p>
      <p><router-link to="/stats">Statistics</router-link></p>
      <p style="font-size:0.7em"><a href="/photo_book_anniversary5.pdf" target="_blank">Mini-book for the 5th anniversary</a> (<a href="https://online.fliphtml5.com/aenum/tcyv/" target="_blank">Flipbook</a>) </p>

      <p>Send all complaints to <a href="https://t.me/zyuhel" target="_blank">@zyuhel</a></p>
      <hr>
      <h4>How to participate?</h4>
      <ol>
        <li>Join the <a href="https://t.me/factory_chat" target="_blank">Factory Chat</a>. Come in, introduce yourself, show your photos.</li>
        <li>Write to the bot - <a href="https://t.me/f365bot" target="_blank">@f365bot</a></li>
        <li>Send a photo taken on this day</li>
        <li>....</li>
        <li>Get better</li>
      </ol>
    </div>
  </div>
</template>

<style>

</style>
<script setup>
import {onMounted} from "vue";
function setTitle() {
  document.title = 'F365 - About'
}
onMounted(async () => {

  setTitle()
});
</script>
