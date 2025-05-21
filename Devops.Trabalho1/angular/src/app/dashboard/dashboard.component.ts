import { Component } from '@angular/core';

@Component({
  standalone: false,
  selector: 'app-dashboard',
  template: `
    <app-host-dashboard *abpPermission="'Trabalho1.Dashboard.Host'"></app-host-dashboard>
    <app-tenant-dashboard *abpPermission="'Trabalho1.Dashboard.Tenant'"></app-tenant-dashboard>
  `,
})
export class DashboardComponent {}
