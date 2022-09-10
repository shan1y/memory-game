<template>
  <h1>Peek a vue</h1>
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
