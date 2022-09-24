<script>
import GameCard from "./GameCard";

export default {
  emits: ["flipcard"],
  components: {
    GameCard,
  },

  props: {
    cardList: {
      type: Array,
      required: true,
    },
    status: {
      type: String,
      required: true,
    },
    moves: {
      type: Number,
      required: true,
    },
  },
  setup(props, { emit }) {
    const selectCard = (payload) => {
      emit("flipcard", payload);
    };

    return {
      selectCard,
    };
  },
  methods: {},
};
</script>

<template>
  <transition-group tag="section" class="game-board" name="shuffle-card">
    <GameCard
      v-for="card in cardList"
      :key="`${card.value}-${card.variant}`"
      :matched="card.matched"
      :value="card.value"
      :visible="card.visible"
      :position="card.position"
      @select-card="selectCard"
    />
  </transition-group>
  <div class="status">
    <h3>Moves: {{ moves }}</h3>
    <h3>{{ status }}</h3>
  </div>
</template>

<style></style>
