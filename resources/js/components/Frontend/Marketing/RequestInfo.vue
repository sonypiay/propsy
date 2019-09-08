<template>
  <div>

  </div>
</template>

<script>
export default {
  props: ['session_user'],
  data() {
    return {
      request_list: {
        total: 0,
        results: []
      },
      forms: {
        keywords: '',
        limit: 10
      }
    }
  },
  methods: {},
  mounted() {}
}
</script>
