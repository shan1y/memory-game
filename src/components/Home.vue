<template>
  <div class="">
    <img :src="vueImg" class="" alt="logo" />
    <h1 class="title">{{ msg }}</h1>
  </div>
</template>

<script>
import vueImg from "../assets/logo.png";

export default {
  name: "HelloWorld",
  props: {
    msg: String,
  },
  data: () => {
    return vueImg;
  },
};
</script>
