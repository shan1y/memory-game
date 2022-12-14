<script>
import { computed } from "vue";

export default {
  props: {
    matched: {
      type: Boolean,
      default: false,
    },
    position: {
      type: Number,
      required: true,
    },
    value: {
      type: String,
      required: true,
    },
    visible: {
      type: Boolean,
      default: false,
    },
  },
  setup(props, context) {
    const flippedStyles = computed(() => {
      if (props.visible) {
        return "is-flipped";
      } else {
        return "";
      }
    });

    const selectCard = () => {
      context.emit("select-card", {
        position: props.position,
        faceValue: props.value,
      });
    };

    return {
      flippedStyles,
      selectCard,
    };
  },
};
</script>

<template>
  <div class="card" :class="flippedStyles" @click="selectCard">
    <div
      v-bind:class="{
        'card-face is-front': !matched,
        'card-face is-front-active': matched,
      }"
    >
      <img
        class="card-image"
        :srcset="`/images/${value}.svg`"
        :src="`/images/${value}.svg`"
        :alt="value"
      />
      <img v-if="matched" src="/images/checkmark.svg" class="icon-checkmark" />
    </div>
    <div class="card-face is-back"></div>
  </div>
</template>

<style>
.card {
  position: relative;
  transition: 0.5s transform ease-in;
  transform-style: preserve-3d;
}

.card.is-flipped {
  transform: rotateY(180deg);
}

.card-face {
  width: 100%;
  height: 100%;
  position: absolute;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  backface-visibility: hidden;
}

.card-face.is-front {
  background-color: var(--cta-color);
  color: white;
  transform: rotateY(180deg);
}

.card-face.is-front-active {
  background-color: var(--flipped-bg);
  color: white;
  transform: rotateY(180deg);
  transition: 1s;
}

.card-face.is-back {
  background-color: var(--unflipped-bg);
  color: white;
}

.card-image {
  max-width: 50%;
  filter: invert(1);
}

.icon-checkmark {
  position: absolute;
  right: 5px;
  bottom: 5px;
  display: none;
}
</style>
