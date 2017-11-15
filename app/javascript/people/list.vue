<template>
<div>
  <h1>People</h1>

  {{ people.length.toString() }}

  <table>
    <tbody>
      <tr v-for="person in people">
        <td>{{ person.first_name }}</td>
        <td>{{ person.middle_name }}</td>
        <td>{{ person.last_name }}</td>
      </tr>
    </tbody>
  </table>
</div>
</template>

<script>
import store from './store'

export default {
  methods: {
    fetch: function () {
      store.dispatch('fetch').then(() => {
        console.log('fetch people')
      })
    }
  },

  created: function () {
    this.fetch()
  },

  computed: {
    people () {
      return store.state.people
    }
  }
}
</script>
