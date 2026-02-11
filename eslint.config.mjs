// @ts-check
import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';
import eslintPluginAstro from 'eslint-plugin-astro';

export default [
  // Global ignores
  {
    ignores: ['dist/', 'node_modules/', '.astro/', 'public/'],
  },

  // Base JavaScript/TypeScript config
  eslint.configs.recommended,
  ...tseslint.configs.recommended,

  // Astro-specific config
  ...eslintPluginAstro.configs.recommended,

  // Custom rules
  {
    rules: {
      '@typescript-eslint/no-unused-vars': [
        'error',
        {
          argsIgnorePattern: '^_',
          varsIgnorePattern: '^_',
        },
      ],
      '@typescript-eslint/no-explicit-any': 'warn',
    },
  },

  // Astro file overrides
  {
    files: ['**/*.astro'],
    rules: {
      // Astro components can have unused props
      '@typescript-eslint/no-unused-vars': 'off',
    },
  },
];
