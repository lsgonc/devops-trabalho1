import { Environment } from '@abp/ng.core';

const baseUrl = 'https://localhost:4200';

const oAuthConfig = {
  issuer: 'https://localhost:4200/',
  clientId: 'Trabalho1_App',
  dummyClientSecret: '',
  scope: 'offline_access Trabalho1',
  strictDiscoveryDocumentValidation: false
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
  }
} as Environment;
