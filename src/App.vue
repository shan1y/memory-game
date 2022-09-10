<template>
  <section class="game-board">
    <Card
      v-for="(card, index) in cardList"
      :key="`card-${index}`"
      :value="card"
    />
  </section>
</template>

<script>
import Home from "./components/Home.vue";
import Card from "./components/Card.vue";

export default {
  name: "App",
  components: {
    Card,
  },
  setup() {
    const cardList = [];
    for (let i = 0; i < 16; i++) {
      cardList.push(i);
    }
    return { cardList };
  },
};
</script>

<style>
#app {
  font-family: Arial, Helvetica, sans-serif;
}

.card {
  border: 5px solid #ccc;
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
