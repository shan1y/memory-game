<template>
  <h1 class="sr-only">Deja Vue</h1>
  <section :class="$style.description">
    <p :class="$style['powered-wrapper']">
      Powered by
      <a :class="$style['powered-link']" href="https://v3.vuejs.org/">
        <img
          :class="$style['powered-logo']"
          src="/images/vue-logo.svg"
          alt="Vue.js logo"
        />
        Vue.js 3
      </a>
    </p>
  </section>
</template>

<style module>
.description {
  font-family: "Titillium Web", sans-serif;
}

.description p {
  margin: 0;
  font-size: 1rem;
}

.description p:last-child {
  margin-bottom: 10px;
  font-size: 0.9rem;
}

.powered-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 15px;
  color: var(--active-card);
}

.powered-link {
  padding: 0 5px;
  color: var(--active-card);
}

.powered-link:first-child,
.powered-link:last-child {
  padding-right: 0;
}

.powered-logo {
  width: 18px;
}

.title {
  padding-bottom: 30px;
}
</style>
