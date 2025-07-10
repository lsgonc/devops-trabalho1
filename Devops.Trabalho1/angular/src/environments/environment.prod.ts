import { Environment } from '@abp/ng.core';

const baseUrl = 'https://k8s.local:31475';

const oAuthConfig = {
  issuer: 'https://k8s.local:31475/',
  redirectUri: window.location.origin + '/',
  clientId: 'Trabalho1_App',
  dummyClientSecret: '',
  scope: 'offline_access Trabalho1',
  strictDiscoveryDocumentValidation: false,
  requireHttps: true,
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
