<template>
  <section class="game-board">
    <Card
      v-for="(card, index) in cardList"
      :key="`card-${index}`"
      :value="card.value"
      :visible="card.visible"
      @select-card="flipCard"
      :position="card.position"
    />
  </section>
</template>

<script>
import Home from "./components/Home.vue";
import Card from "./components/Card.vue";
import { ref } from "vue";

export default {
  name: "App",
  components: {
    Card,
  },
  setup() {
    const cardList = ref([]);
    for (let i = 0; i < 16; i++) {
      cardList.value.push({ value: i, visible: false, position: i });
    }
    const flipCard = (payload) => {
      cardList.value[payload.position].visible = true;
    };
    return {
      cardList,
      flipCard,
    };
  },
};
</script>

<style>
#app {
  font-family: Arial, Helvetica, sans-serif;
}

.game-board {
  display: grid;
  grid-template-columns: 100px 100px 100px 100px;
  grid-template-rows: 100px 100px 100px 100px;
  grid-column-gap: 30px;
  grid-row-gap: 30px;
  justify-content: center;
}
</style>
