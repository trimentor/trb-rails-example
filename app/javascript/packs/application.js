/* eslint no-console: 0 */

import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router/dist/vue-router.esm'

import App from '../app'

Vue.use(VueRouter)

const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }

const routes = [
  { path: '/foo', component: Foo },
  { path: '/bar', component: Bar },
  { path: '/hello', component: App }
]

const router = new VueRouter({
  routes // short for `routes: routes`
})

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router
  }).$mount('#app')
})
