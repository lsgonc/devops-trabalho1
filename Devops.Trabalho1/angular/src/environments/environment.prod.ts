import { Environment } from '@abp/ng.core';

const baseUrl = 'http://localhost:4200';

const oAuthConfig = {
  issuer: 'http://localhost:8080/',
  clientId: 'Trabalho1_App',
  dummyClientSecret: '',
  scope: 'offline_access Trabalho1',
};

export const environment = {
  production: true,
  application: {
    baseUrl,
    name: 'Trabalho1',
  },
  oAuthConfig,
  apis: {
    default: {
      url: '',
      rootNamespace: 'Devops.Trabalho1',
    },
    AbpAccountPublic: {
      url: oAuthConfig.issuer,
      rootNamespace: 'AbpAccountPublic',
    },
  },
  remoteEnv: {
    url: '/getEnvConfig',
    mergeStrategy: 'deepmerge'
  }
} as Environment;
