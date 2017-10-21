/* eslint no-console: 0 */

import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router/dist/vue-router.esm'
import VueResource from 'vue-resource/dist/vue-resource.es2015'

Vue.use(VueRouter)
Vue.use(VueResource)

import App from '../app'
import PeopleList from '../people/list'


const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }

const routes = [
  { path: '/foo', component: Foo },
  { path: '/bar', component: Bar },
  { path: '/hello', component: App },
  { path: '/people', component: PeopleList }
]

const router = new VueRouter({
  routes // short for `routes: routes`
})

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router
  }).$mount('#app')
})
