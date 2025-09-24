# @kebalicious/vue3-daterange-picker

A modern Vue 3 date range picker component with full TypeScript support and Sass styling.

[![npm version](https://badge.fury.io/js/@kebalicious%2Fvue3-daterange-picker.svg)](https://badge.fury.io/js/@kebalicious%2Fvue3-daterange-picker)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/kebalicious/vue3-daterange-picker/blob/main/LICENSE)

## Features

- 📅 Fully compatible with Vue 3
- 🎨 Customizable with Sass/SCSS variables  
- 📱 Responsive design
- 🌐 Internationalization support
- ⌨️ Keyboard navigation
- 📦 TypeScript definitions included
- 🎯 Tree-shakable ES modules
- 🔧 Modern build system with Vite
- ✨ Zero Sass deprecation warnings
- 🚀 Modern @use syntax for future-proof styling

## Installation

```bash
# npm
npm install @kebalicious/vue3-daterange-picker

# yarn
yarn add @kebalicious/vue3-daterange-picker

# pnpm
pnpm add @kebalicious/vue3-daterange-picker
```

## Usage

### Global Registration

```javascript
import { createApp } from 'vue'
import DateRangePicker from '@kebalicious/vue3-daterange-picker'
import '@kebalicious/vue3-daterange-picker/dist/style.css'

const app = createApp(App)
app.use(DateRangePicker)
```

### Local Registration

```vue
<template>
  <div>
    <DateRangePicker 
      v-model="dateRange"
      :options="pickerOptions"
      @update="handleDateUpdate"
    />
  </div>
</template>

<script>
import { ref } from 'vue'
import { DateRangePicker } from '@kebalicious/vue3-daterange-picker'
import '@kebalicious/vue3-daterange-picker/dist/style.css'

export default {
  components: {
    DateRangePicker
  },
  setup() {
    const dateRange = ref({
      startDate: new Date(),
      endDate: new Date()
    })
    
    const pickerOptions = {
      timePicker: true,
      timePickerIncrement: 30,
      locale: {
        format: 'DD/MM/YYYY HH:mm:ss'
      }
    }
    
    const handleDateUpdate = (value) => {
      console.log('Date range updated:', value)
    }
    
    return {
      dateRange,
      pickerOptions,
      handleDateUpdate
    }
  }
}
</script>
```

### Composition API with TypeScript

```typescript
import { ref } from 'vue'
import type { DateRangePickerOptions } from '@kebalicious/vue3-daterange-picker'

const dateRange = ref({
  startDate: new Date(),
  endDate: new Date()
})

const options: DateRangePickerOptions = {
  timePicker: true,
  autoApply: true,
  locale: {
    format: 'YYYY-MM-DD'
  }
}
```

## Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `startDate` | `Date\|string` | `new Date()` | Initial start date |
| `endDate` | `Date\|string` | `new Date()` | Initial end date |
| `minDate` | `Date\|string` | `null` | Minimum selectable date |
| `maxDate` | `Date\|string` | `null` | Maximum selectable date |
| `timePicker` | `boolean` | `false` | Enable time selection |
| `timePickerIncrement` | `number` | `1` | Time picker minute increment |
| `timePicker24Hour` | `boolean` | `false` | Use 24-hour format |
| `autoApply` | `boolean` | `false` | Auto-apply selection without confirm button |
| `singleDatePicker` | `boolean` | `false` | Single date picker mode |
| `showDropdowns` | `boolean` | `false` | Show month/year dropdowns |
| `linkedCalendars` | `boolean` | `true` | Link calendar months |
| `appendToBody` | `boolean` | `false` | Append picker to body |
| `opens` | `string` | `'right'` | Picker opening direction: 'left', 'right', 'center' |
| `drops` | `string` | `'down'` | Picker dropping direction: 'up', 'down' |

## Events

| Event | Payload | Description |
|-------|---------|-------------|
| `update` | `{startDate, endDate}` | Fired when date range is updated |
| `select` | `{startDate, endDate}` | Fired when date range is selected |
| `apply` | `{startDate, endDate}` | Fired when apply button is clicked |
| `cancel` | - | Fired when cancel button is clicked |

## Styling

The component comes with default styling, but you can customize it using CSS/SCSS variables:

```scss
// Override default variables
$primary-button-bg: #007bff;
$primary-button-color: #fff;
$ranges-hover-bg-color: #f8f9fa;

@import '@kebalicious/vue3-daterange-picker/dist/style.css';
```

## Browser Support

- Chrome >= 60
- Firefox >= 55
- Safari >= 11
- Edge >= 79

## Development

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Run tests
npm run test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

Based on the original [vue2-daterange-picker](https://github.com/Innologica/vue2-daterange-picker) by Innologica, and [vue3-daterange-picker
](https://github.com/joshuaeasy/vue3-daterange-picker.git).
