import type { Config } from 'jest';

const config: Config = {
  preset: 'ts-jest/presets/default',
  testEnvironment: 'node',

  globalSetup: '<rootDir>/test/setup.ts',
  globalTeardown: '<rootDir>/test/teardown.ts',
  testTimeout: 20000,

  rootDir: './',
  testMatch: [
    '<rootDir>/src/**/*.spec.ts',
    '<rootDir>/src/**/*.unit.spec.ts',
    '<rootDir>/src/**/*.int.spec.ts',
    '<rootDir>/src/**/*.e2e.spec.ts',
    '<rootDir>/test/**/*.unit.spec.ts',
    '<rootDir>/test/**/*.int.spec.ts',
    '<rootDir>/test/**/*.e2e.spec.ts',
  ],

  transform: {
    '^.+\\.(t|j)s$': ['ts-jest', { tsconfig: 'tsconfig.json' }],
  },

  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1', // 👈 allows '@/...' imports
    '^src/(.*)$': '<rootDir>/src/$1', // 👈 for src aliases
    '^test/(.*)$': '<rootDir>/test/$1', // 👈 FIXED: add this to make 'test/...' work
  },

  moduleFileExtensions: ['js', 'json', 'ts'],
  testPathIgnorePatterns: ['/node_modules/', '/dist/'],
  collectCoverageFrom: ['src/**/*.ts'],
  coverageDirectory: './coverage',
  verbose: true,
};

export default config;
