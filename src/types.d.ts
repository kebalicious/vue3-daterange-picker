import { App } from 'vue'

declare module 'vue3-daterange-picker' {
  export interface DateRangePickerOptions {
    startDate?: Date | string
    endDate?: Date | string
    minDate?: Date | string
    maxDate?: Date | string
    dateLimit?: number
    showWeekNumbers?: boolean
    showISOWeekNumbers?: boolean
    timePicker?: boolean
    timePickerIncrement?: number
    timePicker24Hour?: boolean
    timePickerSeconds?: boolean
    autoApply?: boolean
    autoUpdateInput?: boolean
    linkedCalendars?: boolean
    isInvalidDate?: (dateToCheck: Date) => boolean
    locale?: {
      direction?: string
      format?: string
      separator?: string
      applyLabel?: string
      cancelLabel?: string
      weekLabel?: string
      customRangeLabel?: string
      daysOfWeek?: string[]
      monthNames?: string[]
      firstDay?: number
    }
    ranges?: { [key: string]: [Date, Date] }
    opens?: 'left' | 'right' | 'center'
    drops?: 'down' | 'up'
    buttonClasses?: string
    applyButtonClasses?: string
    cancelButtonClasses?: string
    dateLimit?: number
    parentEl?: string
    appendToBody?: boolean
    controlContainerClass?: string
    alwaysShowCalendars?: boolean
    closeOnEsc?: boolean
    singleDatePicker?: boolean
    showDropdowns?: boolean
    showCustomRangeLabel?: boolean
  }

  export interface DateRangePickerInstance {
    startDate: Date
    endDate: Date
    locale: any
    ranges: any
    opens: string
    drops: string
  }

  declare const DateRangePicker: {
    install(vueApp: App): void
  }

  export default DateRangePicker
}