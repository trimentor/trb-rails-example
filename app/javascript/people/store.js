import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex/dist/vuex.esm'
import axios from 'axios'
Vue.use(Vuex)

import Person from './person'

const store = new Vuex.Store({
  state: {
    people: []
  },

  actions: {
    fetch (context) {
      axios.get('/api/people').then((response) => {
        context.commit('updatePeople', { people: response.data })
      })
    }
  },

  mutations: {
    updatePeople (state, payload) {
      state.people = payload.people.map(data => {
        return new Person(data)
      })
    }
  }
})

export default store
