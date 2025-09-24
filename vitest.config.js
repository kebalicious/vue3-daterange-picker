import { defineConfig } from 'vite'; // Use 'vite' instead of 'vitest/config' for build
import vue from '@vitejs/plugin-vue';
import { resolve } from 'path';
import dts from 'vite-plugin-dts';

export default defineConfig({
  plugins: [
    vue(),
    dts({ rollupTypes: true }), // Generates TypeScript declarations
  ],
  test: {
    globals: true,
    environment: 'jsdom',
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  build: {
    lib: {
      entry: resolve(__dirname, 'src/index.js'), // Adjust to your entry file (e.g., src/index.ts or src/index.js)
      name: 'Vue3DateRangePicker', // Global name for UMD build
      fileName: (format) => `vue3-daterange-picker.${format}.js`, // Output file names
      formats: ['es', 'umd'], // ES module and UMD formats
    },
    rollupOptions: {
      external: ['vue'], // Mark Vue as external to avoid bundling it
      output: {
        globals: {
          vue: 'Vue', // Map Vue to global 'Vue' in UMD
        },
      },
    },
    css: {
      // Ensure CSS is emitted as a separate file
      preprocessorOptions: {
        scss: {
          // Optional: Add any Sass-specific options here
        },
      },
    },
    outDir: 'dist', // Ensure output goes to dist/
    sourcemap: true, // Optional: Generate sourcemaps
  },
});