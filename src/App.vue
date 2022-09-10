<template>
  <section class="game-board">
    <Card
      v-for="card in cardList"
      :key="`card-${card.value}`"
      :value="card.value"
      :visible="card.visible"
      @select-card="flipCard"
      :matched="card.matched"
      :position="card.position"
    />
  </section>
  <h2>{{ status }}</h2>
</template>

<script>
import Home from "./components/Home.vue";
import Card from "./components/Card.vue";
import { ref, watch } from "vue";

export default {
  name: "App",
  components: {
    Card,
  },
  setup() {
    const cardList = ref([]);
    const userSelection = ref([]);
    const status = ref("");

    for (let i = 0; i < 16; i++) {
      cardList.value.push({
        value: i,
        visible: false,
        matched: false,
        position: i,
      });
    }
    const flipCard = (payload) => {
      cardList.value[payload.position].visible = true;
      if (userSelection.value[0]) {
        userSelection.value[1] = payload;
      } else {
        userSelection.value[0] = payload;
      }
    };

    watch(
      userSelection,
      (currentValue) => {
        if (currentValue.length === 2) {
          const cardOne = currentValue[0];
          const cardTwo = currentValue[1];

          if (cardOne.faceValue === cardTwo.faceValue) {
            status.value = "Matched!";
            cardList.value[(cardOne.position.matched = true)];
            cardList.value[(cardTwo.position.matched = true)];
          } else {
            status.value = "Mismsatch!";
          }

          cardList.value[cardOne.position].visible = false;
          cardList.value[cardTwo.position].visible = false;
          userSelection.value.length = 0;
        }
      },
      { deep: true }
    );
    return {
      cardList,
      flipCard,
      userSelection,
      status,
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
