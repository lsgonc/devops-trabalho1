import { Component, OnDestroy } from '@angular/core';

@Component({
  standalone: false,
  selector: 'app-tenant-dashboard',
  templateUrl: './tenant-dashboard.component.html',
  styleUrls: ['./tenant-dashboard.component.scss'],
})
export class TenantDashboardComponent implements OnDestroy {

  ngOnDestroy(): void {}
}
