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
import Person from './person'

export default {
  data: function () {
    return {
      people: []
    }
  },

  methods: {
    fetch: function () {
      this.$http.get('/api/people').then(response => {
        this.people = response.body.map(data => {
          return new Person(data)
        })
      })
    }
  },

  created: function () {
    this.fetch()
  }
}
</script>
