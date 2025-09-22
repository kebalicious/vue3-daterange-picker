import DateRangePicker from './components/DateRangePicker.vue'

// Auto-install when Vue is found (e.g. in browser via <script> tag)
let GlobalVue = null
if (typeof window !== 'undefined') {
  GlobalVue = window.Vue
} else if (typeof global !== 'undefined') {
  GlobalVue = global.Vue
}

if (GlobalVue) {
  GlobalVue.use(install)
}

// To allow individual component use
export { DateRangePicker }

// To allow use as a plugin and individual component use
function install(Vue) {
  if (install.installed) return
  install.installed = true
  Vue.component('DateRangePicker', DateRangePicker)
}

// Create module definition for Vue.use()
const plugin = {
  install
}

// Default export is install function with component attached
export default plugin

// It's possible to expose named exports when writing components that can
// also be used as directives, etc. - eg. import { RollupDemoDirective } from 'rollup-demo';
// export const RollupDemoDirective = directive;
