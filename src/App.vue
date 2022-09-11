<script>
import { ref, watch } from "vue";
import createDeck from "./features/createDeck";
import createGame from "./features/createGame";
import { launchConfetti } from "./utilities/confetti";
import AppFooter from "./components/AppFooter";
import AppHero from "./components/AppHero";
import GameBoard from "./components/GameBoard";
import NewGameButton from "./components/NewGameButton";
import iconDeck from "./data/icon-deck.json";

export default {
  name: "App",
  components: {
    AppFooter,
    AppHero,
    GameBoard,
    NewGameButton,
  },
  setup() {
    const { cardList } = createDeck(iconDeck);
    const { newPlayer, startGame, restartGame, matchesFound, status } =
      createGame(cardList);
    const userSelection = ref([]);
    const userCanFlipCard = ref(true);

    const startNewGame = () => {
      if (newPlayer) {
        startGame();
      } else {
        restartGame();
      }
    };

    const flipCard = (payload) => {
      if (userCanFlipCard.value) {
        cardList.value[payload.position].visible = true;

        if (userSelection.value[0]) {
          if (
            userSelection.value[0].position === payload.position &&
            userSelection.value[0].faceValue === payload.faceValue
          ) {
            return;
          } else {
            userSelection.value[1] = payload;
          }
        } else {
          userSelection.value[0] = payload;
        }
      } else {
        return;
      }
    };

    watch(matchesFound, (currentValue) => {
      if (currentValue === 8) {
        launchConfetti();
      }
    });

    watch(
      userSelection,
      (currentValue) => {
        if (currentValue.length === 2) {
          const cardOne = currentValue[0];
          const cardTwo = currentValue[1];
          // Disable ability to flip cards
          userCanFlipCard.value = false;

          if (cardOne.faceValue === cardTwo.faceValue) {
            cardList.value[cardOne.position].matched = true;
            cardList.value[cardTwo.position].matched = true;
            userCanFlipCard.value = true;
          } else {
            setTimeout(() => {
              cardList.value[cardOne.position].visible = false;
              cardList.value[cardTwo.position].visible = false;
              // Allow user to flip a new card
              userCanFlipCard.value = true;
            }, 1000);
          }

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
      startNewGame,
      newPlayer,
    };
  },
};
</script>

<template>
  <AppHero />
  <NewGameButton :newPlayer="newPlayer" @start-new-game="startNewGame" />
  <GameBoard :cardList="cardList" :status="status" @flipcard="flipCard" />
  <AppFooter />
</template>

<style>
@import "./styles/variables.css";
html,
body {
  margin: 0;
  padding: 0;
  height: 100%;
}

html {
  background-color: #00070c;
}

h1 {
  margin-top: 0;
}

a {
  color: white;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

#app {
  padding: 2rem 0;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  background-color: white;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.status {
  font-family: "Titillium Web", sans-serif;
  font-size: 1.125rem;
  width: 12em;
  height: 3rem;
  border-radius: 10px;
  margin-inline: auto;
  display: flex;
  margin-top: 2rem;
  font-size: 1rem;
  justify-content: center;
  align-items: center;
  color: var(--matched-text);
  background-color: var(--flipped-bg);
  border: 2px solid var(--border-matched);
}

.game-board {
  display: grid;
  grid-template-columns: repeat(4, 60px);
  grid-template-rows: repeat(4, 60px);
  grid-column-gap: 0.75rem;
  grid-row-gap: 0.75rem;
  justify-content: center;
}

@media screen and (min-width: 500px) {
  .game-board {
    grid-template-columns: repeat(4, 5.625rem);
    grid-template-rows: repeat(4, 5.625rem);
  }
}

@media screen and (min-width: 600px) {
  .game-board {
    grid-template-columns: repeat(4, 6.5rem);
    grid-template-rows: repeat(4, 6.5rem);
  }
}

.sr-only {
  text-transform: uppercase;
  margin-bottom: 0.5rem;
  clip: rect(0, 0, 0, 0);
  border: 0;
}

.shuffle-card-move {
  transition: transform 0.8s ease-in;
}
</style>
